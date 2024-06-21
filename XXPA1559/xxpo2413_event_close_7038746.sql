-- $Header: xxpo/datafix/xxpo2413_event_close_7038746.sql 1.1 01-DEC-2015 09:05:21 CCBRFG $

-- this $XXPO_TOP/datafix/xxpo2413_event_close_7038746.sql script 

-- Step 1.  edit the log_file_prefix to match the name of your script
DEF lv_log_file_prefix="xxpo2413_event_close_7038746"

-- Step 2.  edit the location to which the spool/log file should be written
DEF lv_log_dir="$XXPO_TOP/datafix"

-- dynamically generate the spool file name (do not edit this)
COLUMN log_file_name NEW_VALUE lv_log_file_name NOPRINT

SELECT    '&&lv_log_file_prefix._'
       || LOWER (vdb.NAME)
       || TO_CHAR (SYSDATE, '_YYYYMMDDHH24SSMI')
       || '.log' AS log_file_name
  FROM v$database vdb;

--prompt &lv_log_file_name

-- setup the sqlplus prompts and such
SET SERVEROUTPUT ON SIZE 1000000
SET LINES 1000 tab OFF TRIMOUT ON TRIMSPOOL ON
SET ECHO ON FEEDBACK ON TIME ON TIMING ON

-- start writing to the spool file
SPOOL &&lv_log_dir/&&lv_log_file_name.

-- turn off autocommit and handle OS and SQL errors
SET AUTOCOMMIT OFF
WHENEVER SQLERROR EXIT FAILURE ROLLBACK
WHENEVER OSERROR EXIT FAILURE ROLLBACK

-- echo the name of the current database

SELECT NAME AS db_name,
       TO_CHAR (SYSDATE, 'DD-MON-YYYY HH24:MI:SS') AS system_date_time
  FROM v$database;

-- Step 3. (strongly encouraged) create a backup copy of the data in a backup table using "create table as" or similar approach


-- Step 4. perform the needed update 

DECLARE
  l_success_cnt   NUMBER := 0;
  l_fail_cnt      NUMBER := 0;
BEGIN

  FOR rec IN (SELECT xe.*
                  FROM xxint_events xe , xxint_event_types xet
                 WHERE xe.event_type = xet.event_type 
                   AND xe.event_type = 'XXPO2413_REQUISITION_EVENT_IN'
                   AND current_status <> 'CLOSED'
                   AND xe.last_update_date < sysdate - (xet.RETENTION_DAYS + 1)
             ) 
  LOOP  
    BEGIN
    
      xxint_event_api_pub.force_event_to_close(p_guid => rec.guid,
                                               p_last_process_msg => 'Event Force Closed For RT#:7038746');
                                               
      --DBMS_OUTPUT.put_line('Event closed successfully ' ||rec.GUID);
      l_success_cnt := l_success_cnt + 1;
      
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('In Exception of calling the API event guid = ' ||rec.GUID||SQLERRM);
        l_fail_cnt := l_fail_cnt + 1;
        
    END;  
  END LOOP;
  
   DBMS_OUTPUT.put_line('l_success_cnt : '||l_success_cnt);
   DBMS_OUTPUT.put_line('l_fail_cnt : '||l_fail_cnt);

  COMMIT ;
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('In exception of the main loop' || SQLERRM);
    ROLLBACK;
END;
/