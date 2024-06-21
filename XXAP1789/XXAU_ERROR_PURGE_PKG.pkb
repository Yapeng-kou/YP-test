set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

Whenever sqlerror exit failure rollback

create or replace PACKAGE BODY XXAU_ERROR_PURGE_PKG AS
  /******************************************************************************
  ** Title:       Custom package for purging XXAU Common Error Log
  ** File:        XXAU_ERROR_PURGE_PKG.pkb
  ** Description: A custom package to Purge XXAU Common Error Log
  ** Parameters:  {None.}
  **
  **
  ** Run as:      APPS
  ** Keyword Tracking:
  **   
  **   $Header: xxau/12.0.0/patch/115/sql/XXAU_ERROR_PURGE_PKG.pkb 1.10 22-MAR-2018 06:19:03 CCCCPZ $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.10 (COMPLETE)
  **     Created:  22-MAR-2018 06:19:03      CCCCPZ (Satyendra Dangi)
  **       RT7670013 - REMOVE DELETE CONSTRAINT
  **   
  **   Revision 1.9 (COMPLETE)
  **     Created:  21-MAR-2017 07:47:14      CCCCPZ (Satyendra Dangi)
  **       Parallel syntax revised
  **   
  **   Revision 1.8 (COMPLETE)
  **     Created:  14-MAR-2017 03:38:43      CCCCPZ (Satyendra Dangi)
  **       PARALLEL on INDEX added
  **   
  **   Revision 1.7 (COMPLETE)
  **     Created:  08-MAR-2017 00:27:18      CCCCPZ (Satyendra Dangi)
  **       INDEX rebuild after truncating partition. 
  **   
  **   Revision 1.6 (COMPLETE)
  **     Created:  07-MAR-2017 00:44:04      CCCCPZ (Satyendra Dangi)
  **       Reporting SQL changed
  **   
  **   Revision 1.5 (COMPLETE)
  **     Created:  17-FEB-2017 08:14:35      CCCCPZ (Satyendra Dangi)
  **       Code review recovery
  **   
  **   Revision 1.4 (COMPLETE)
  **     Created:  07-FEB-2017 06:01:43      CCCCPZ (Satyendra Dangi)
  **       Purge based on partition added
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  10-OCT-2014 16:36:04      IRFZSQ (None)
  **       RT#5615615
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  06-MAY-2013 11:13:32      CCBBQP (None)
  **       Cleanup
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  01-MAY-2013 13:15:06      CCBBQP (None)
  **       commits after 10000 kills.
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  01-MAY-2013 12:12:13      RSAWANT (None)
  **       Initial revision.
  **   
  **
  ** History:
  ** Date          Who                        Description
  ** -----------   ------------------------   ------------------------------------
  ** 15-04-2013    AMRITA DAS                 Initial Creation
  ** 10-10-2014    Surabhi C                  RT#5615615 - Purge Header-less lines
  ** 07-Feb-2017   Satyendra                  Purge based on partition added 
  ** 21-Mar-2018   CCCCPZ                     RT7670013 - REMOVE DELETE CONSTRAINT
  *******************************************************************************/

  g_commit_threshold CONSTANT NUMBER := 10000;

  --RT#5615615
  procedure purge_header_less_lines IS
   TYPE ID_TAB IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
   ids id_tab;
   
   cursor lines IS
      SELECT XEL.ERROR_LINE_ID
      FROM XXAU_ERROR_LINES XEL
      WHERE NOT EXISTS (SELECT 1
                        from xxau_error_headers h
                        WHERE XEL.ERROR_HEADER_ID = H.ERROR_HEADER_ID);
   
  BEGIN
     open lines;
     LOOP
       FETCH LINES  BULK COLLECT INTO IDS LIMIT g_commit_threshold;
       EXIT WHEN IDS.COUNT = 0;
       FORALL i in 1 .. ids.count 
         DELETE FROM XXAU_ERROR_LINES WHERE ERROR_LINE_ID = IDS(I); 
       commit;
    end loop;
  end purge_header_less_lines;

  PROCEDURE truncate_partition(p_partition_name VARCHAR2)
  IS
  BEGIN
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Truncating Partition '||p_partition_name);
--    EXECUTE IMMEDIATE 'ALTER SESSION FORCE PARALLEL DDL PARALLEL 32';
	  EXECUTE IMMEDIATE 'ALTER TABLE xxau.xxau_error_lines TRUNCATE PARTITION '||p_partition_name||' UPDATE INDEXES PARALLEL (DEGREE 32)';
    EXECUTE IMMEDIATE 'ALTER TABLE xxau.xxau_error_headers TRUNCATE PARTITION '||p_partition_name||' UPDATE INDEXES PARALLEL (DEGREE 32)';
  END truncate_partition;
  
  /****************************************************************************
  ** Function Name: XXAU_ERROR_PURGE_PRC
  **
  ** Purpose:  Concurrent program to Purge XXAU Common Error Log
  **
  **
  ** Procedure History:
  ** Date       Who             Description
  ** ---------  --------------- ----------------------------------------
  ** 15-04-2013   AMRITA DAS                         Initial Creation
  *****************************************************************************/

  PROCEDURE XXAU_ERROR_PURGE_PRC(errbuf            		OUT VARCHAR2,
                                 retcode           		OUT NUMBER,
                                 p_error_date_from 		IN VARCHAR2,
                                 p_error_date_to   		IN VARCHAR2,
                                 p_error_source    		IN VARCHAR2,
                                 p_object_type     		IN VARCHAR2,
                                 p_object_name     		IN VARCHAR2,
                                 p_severity        		IN VARCHAR2,
                                 p_purge_no_hdr_line    in VARCHAR2 DEFAULT 'N',
                                 p_restrict_delete      IN VARCHAR2 DEFAULT 'Y'--RT7670013
                                 ) 
  IS
    l_email_subj VARCHAR2(200);
    l_email_body VARCHAR2(1000);
    l_email_to   VARCHAR2(1000);
    l_email_cc   VARCHAR2(1000) := null;
    l_header_cnt NUMBER := 0;

    -- Added by Divya on 20-Apr-2013
    lv_errmsg        VARCHAR2(32767);
    ln_retval        NUMBER;
    lx_data_xml      XMLTYPE;
    lx_xslt          XMLTYPE;
    l_file_clob      CLOB;
    l_directory_name VARCHAR2(20) := 'XXDATA_OUT';
    lv_datetime      VARCHAR2(60);
    TYPE l_cursor IS REF CURSOR;
    l_ref_cursor l_cursor;
    l_filename   VARCHAR2(150);

    CURSOR cur_email_cc IS
      SELECT xxau_doc_delctrl_pkg.get_override_email_to_address(email_address) email_address
        FROM fnd_user
       WHERE user_name LIKE 'XX_IT_OPS%';

    l_counter         NUMBER := 0;
    l_error_from_date DATE;
    l_error_to_date   DATE;

    l_main_cursor VARCHAR2(2000) := '
           SELECT error_header_id
       , to_char(xeh.creation_date, ''MON-YYYY'') month
       , xeh.severity
        FROM xxau_error_headers xeh
       WHERE trunc(xeh.creation_date) between :p_error_from_date and :p_error_to_date
         AND nvl(xeh.error_source,''EBS'') = coalesce(:p_error_source , xeh.error_source, ''EBS'')
         AND xeh.object_type = nvl(:p_object_type, xeh.object_type)
         AND xeh.severity = nvl(:p_severity, xeh.severity)

         AND ( xeh.object_name = :p_object_name or
               ( :p_object_name is null and

                 not exists ( select lookup_code
                              from fnd_lookup_values flv
                              where flv.lookup_type = ''XXAU_ERROR_LOG_PURGE_EXCLUSION''
                              and flv.lookup_code = xeh.object_name
                              and flv.language = userenv(''LANG'')
                              and flv.security_group_id = 0
                              and flv.view_application_id = 20044
                              and flv.enabled_flag = ''Y''
                              and sysdate between flv.start_date_active and  nvl(flv.end_date_active, sysdate))
                            )
             )
    ';
    l_reporting_cursor VARCHAR2(4000);
    l_header_id        NUMBER;
    l_month            VARCHAR2(32);
    l_severity         VARCHAR2(32);
    l_partition_name   VARCHAR2(32);
    l_partition_clause   VARCHAR2(100);
  BEGIN

    l_error_from_date := TRUNC(fnd_date.canonical_to_date(p_error_date_from));
    l_error_to_date   := TRUNC(fnd_date.canonical_to_date(p_error_date_to));

    --#Purge Only if data deleted is older than two months
    IF MONTHS_BETWEEN(SYSDATE,l_error_to_date) < 2 --#Purge Only if data deleted is older than two months
    AND NVL(p_restrict_delete,'Y') ='Y' --RT7670013
    THEN
       xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,'Warning: Can not purge data for given range. Purging is only allowed for data older than two months' );
       RETURN;
    END IF;
    

    SELECT  xxau_doc_delctrl_pkg.get_override_email_to_address(email_address)
      INTO l_email_to
      FROM fnd_user
     WHERE user_name = 'XX_IT_OPS_GLOBAL';

    FOR rec_email_cc in cur_email_cc LOOP
      l_email_cc := l_email_cc || ',' || rec_email_cc.email_address;
    END LOOP;

    l_email_cc := SUBSTR(l_email_cc, 2, LENGTH(l_email_cc) - 1);

    --#Added:Logic for Purge based on Partition- Satyendra- Feb-2017
    --#If given date range falls within same month and cover whole month(day from 1-30) then purge/fetch based on partition
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,'l_error_from_date '||l_error_from_date);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,'l_error_to_date '||l_error_to_date);
    IF COALESCE(p_error_source,p_object_type,p_object_name,p_severity) IS NULL
      AND l_error_from_date=TRUNC(l_error_from_date,'MM') --#First Day of Month
      AND l_error_to_date=LAST_DAY(l_error_to_date) --#Last Day of Month
      AND TRUNC(l_error_from_date,'MM')=TRUNC(l_error_to_date,'MM') --#Within same month
    THEN
      l_partition_name  :='P_'||TO_CHAR(l_error_from_date,'MON');
      l_partition_clause:=' PARTITION ('||l_partition_name||')';
      l_reporting_cursor:='SELECT to_char(xeh.creation_date, ''MON-YYYY'') month,
                                   xeh.severity,
                                   COUNT(DISTINCT xeh.error_header_id) header_count,
                                   COUNT(xel.error_line_id) line_count
                              FROM xxau_error_headers '||l_partition_clause||' xeh,
                                   xxau_error_lines   '||l_partition_clause||' xel
                            WHERE xeh.error_header_id = xel.error_header_id
                            GROUP BY to_char(xeh.creation_date, ''MON-YYYY''), xeh.severity';
      OPEN l_ref_cursor FOR l_reporting_cursor ;
    ELSE
      l_reporting_cursor := '
      SELECT xeh.MONTH
         , xeh.severity
         , COUNT(DISTINCT xeh.error_header_id) header_count
         , COUNT(xel.error_line_id) line_count
         FROM (' || l_main_cursor || ') xeh
          , xxau_error_lines xel
        WHERE xeh.error_header_id  = xel.error_header_id
        GROUP BY xeh.month
        , xeh.severity';
      OPEN l_ref_cursor FOR l_reporting_cursor
        USING l_error_from_date, l_error_to_date, p_error_source, p_object_type, p_severity, p_object_name, p_object_name;
    END IF;

    xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Reporting SQL '|| l_reporting_cursor);
    BEGIN

      l_email_subj := 'XXAU Common Error Log Purge Program ';
      l_email_body := 'Program Name         : XXAU Common Error Log Purge Concurrent Program: ' || CHR(10)||
                      'Request ID: ' || fnd_global.conc_request_id ||
                      CHR(10) ||
                      '=============================================================================' ||
                      CHR(10) || 'Input Parameters     : ' || CHR(10) ||
                      '-----------------------------------------------------------------------------' ||
                      CHR(10) || '  Error date from  : ' ||
                      p_error_date_from || CHR(10) || '  Error date to  : ' ||
                      p_error_date_to || CHR(10) || '  Error source  : ' ||
                      p_error_source || CHR(10) || '  Object Type : ' ||
                      p_object_type || CHR(10) || '  Object Name  : ' ||
                      p_object_name || CHR(10) || '  Severity  : ' ||
                      p_severity || CHR(10) ||
                      '=============================================================================' ||
                      CHR(10);

      SELECT TO_CHAR(systimestamp, 'YYYYMMDDHH24MISS')
        INTO lv_datetime
        FROM dual;

      l_filename := 'XXAU_ERROR_LOG_PURGE_REPORT_' || lv_datetime || '.xls';

      xx_pk_xml_util. p_ref_cur_to_file(ov_errmsg                  => lv_errmsg,
                                        on_retval                  => ln_retval,
                                        ox_xmldata                 => lx_data_xml,
                                        ox_xslt                    => lx_xslt,
                                        ol_clob                    => l_file_clob,
                                        ic_data_cursor             => l_ref_cursor,
                                        iv_dir                     => l_directory_name,
                                        iv_file_name               => l_filename,
                                        iv_no_data_msg             => fnd_message.
                                                                      get_string('SQLAP',
                                                                                 'AP_APPRVL_NO_DATA'),
                                        iv_delim                   => ',',
                                        ib_encl_quotes             => FALSE,
                                        iv_copy_to_fnd_file_output => 'Y',
                                        iv_email_from              => xxau_name_value_pkg.get_value('XXAU_WORKFLOW_MAILER_ADDRESS'),
                                        iv_email_to                => l_email_to,
                                        iv_email_cc                => l_email_cc,
                                        iv_email_sub               => l_email_subj,
                                        iv_email_body              => l_email_body);

    EXCEPTION
      WHEN OTHERS THEN
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,
                                'Error while sending email ' || SQLERRM);
        RAISE;
    END;
    CLOSE l_ref_cursor;
    -- done with reporting

    --#Added truncate_partition: Satyendra- Feb-2017
    IF l_partition_name IS NOT NULL
    THEN
      truncate_partition(l_partition_name);
    ELSE
      OPEN l_ref_cursor FOR(l_main_cursor)
        USING l_error_from_date
      , l_error_to_date, p_error_source, p_object_type, p_severity, p_object_name, p_object_name;
  
      LOOP
        FETCH l_ref_cursor
          INTO l_header_id, l_month, l_severity;
        EXIT WHEN l_ref_cursor%NOTFOUND;
  
        l_header_cnt := l_header_cnt + 1;
  
        DELETE  xxau_error_lines WHERE error_header_id = l_header_id;
        DELETE  xxau_error_headers WHERE error_header_id = l_header_id;      
  
        l_counter := l_counter + SQL%ROWCOUNT;
  
        IF l_counter > g_commit_threshold THEN
          COMMIT;
          l_counter := 0;
        END IF;
  
      END LOOP;
      CLOSE l_ref_cursor;
  
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,
                              '  Total Number of Error header count  :' ||
                              l_header_cnt);
  
      IF l_header_cnt = 0 THEN
  
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,
                                ' No records exists for the following parameter :' ||
                                '  Error date from  : ' || p_error_date_from ||
                                '  Error date to  : ' || p_error_date_to ||
                                '  Error source  : ' || p_error_source ||
                                '  Object Type : ' || p_object_type ||
                                '  Object Name  : ' || p_object_name ||
                                '  Severity  : ' || p_severity);
  
      END IF;
  
      --  RT#5615615
      IF p_purge_no_hdr_line = 'Y' THEN
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,'Deleting Header-Less Lines...');
      purge_header_less_lines;
      end if;
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      IF l_ref_cursor%ISOPEN THEN
        CLOSE l_ref_cursor;
      END IF;
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,
                              'Error  :' || SQLERRM ||
                              ' while purging XXAU Common Error Log ');
  END;

END XXAU_ERROR_PURGE_PKG;
/
Show errors package body XXAU_ERROR_PURGE_PKG
