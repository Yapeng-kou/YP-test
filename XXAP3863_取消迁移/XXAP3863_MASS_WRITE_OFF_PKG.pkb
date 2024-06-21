set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

Whenever sqlerror exit failure rollback
CREATE OR REPLACE PACKAGE BODY XXAP3863_MASS_WRITE_OFF_PKG IS
 /*********************************************************
   ** Title:       XX GRNI Clearing Mass Write Off
   ** File:        XXAP3863_MASS_WRITE_OFF_PKG.pkb
   ** Description: This script creates a package Spec
   ** Parameters:  {None.}
   ** Run as:      APPS
   ** Keyword Tracking:
   **	
  **   $Header: xxap/12.0.0/patch/115/sql/XXAP3863_MASS_WRITE_OFF_PKG.pkb 1.1 13-MAY-2021 07:25:07 IRIMID $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.1 (COMPLETE)
  **     Created:  13-MAY-2021 07:25:07      IRIMID (Gaurav Gupta)
  **       SCTASK0153288 - Moved RICE table from XXBK to XXAP schema
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  16-OCT-2019 16:26:56      CCDZPQ (Raja Nandi)
  **       CR10912 Initial Development
  **   
   **   
   **   
   ** History:
   ** Date          Who                Description
   ** -----------   ------------------ ------------------------------------
   ** 03-OCT-19   Raja Nandi       Initial Creation
   ** 13-MAY-21   Gaurav Gupta     SCTASK0153288 - Moved RICE table from XXBK to XXAP schema
    ********************************************************/
	procedure p_write_off  (p_ou_id     IN NUMBER
              ,p_request_id   IN NUMBER
              ,p_sob_id    IN NUMBER
              ,p_reason_id  IN NUMBER
              ,p_comments    IN VARCHAR2
              ) IS
	--PRAGMA AUTONOMOUS_TRANSACTION; 		  
  CURSOR cur_updt_crs (p_req_id IN NUMBER) IS
      SELECT *
        from XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
       where process_flag = 'NEW'
		AND DF_REQUEST_ID = p_req_id;
  x_count number :=0;
  x_err_num number;
  x_err_code varchar2(30);
  x_err_msg varchar2(2000);
  lv_request_id NUMBER := p_request_id;  
  lv_error_message VARCHAR2(240);
  BEGIN
  -- Update the records
	FOR rec_updt_crs IN cur_updt_crs(lv_request_id) LOOP
    BEGIN
	
        UPDATE CST_RECONCILIATION_SUMMARY
           SET WRITE_OFF_SELECT_FLAG = 'Y'
         WHERE OPERATING_UNIT_ID = rec_updt_crs.OPERATING_UNIT_ID
     AND PO_DISTRIBUTION_ID = rec_updt_crs.PO_DISTRIBUTION_ID; --Need to add staging table;
	 
	
        -- Update Process Flag in Backup Table
        UPDATE XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
           set process_flag = 'S'
         where PO_DISTRIBUTION_ID = rec_updt_crs.PO_DISTRIBUTION_ID
            and DF_REQUEST_ID = lv_request_id;
      
    UPDATE XXAP.XXAP3863_APPO_RECON_BKP
           set process_flag = 'S'
         where PO_DISTRIBUTION_ID = rec_updt_crs.PO_DISTRIBUTION_ID
            and DF_REQUEST_ID = lv_request_id;  

      EXCEPTION
        WHEN OTHERS THEN
          lv_error_message := substr(sqlerrm, 1, 250);

          UPDATE XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
             set process_flag = 'E'
       ,error_message = lv_error_message
           where PO_DISTRIBUTION_ID = rec_updt_crs.PO_DISTRIBUTION_ID
             and DF_REQUEST_ID = lv_request_id;
       
      UPDATE XXAP.XXAP3863_APPO_RECON_BKP
             set process_flag = 'E'
       ,error_message = lv_error_message
           where PO_DISTRIBUTION_ID = rec_updt_crs.PO_DISTRIBUTION_ID
             and DF_REQUEST_ID = lv_request_id; 

          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                                  'Error encountered while attempting to update WRITE_OFF_SELECT_FLAG for PO Distribution Id(rec_updt_crs.PO_DISTRIBUTION_ID) : ' ||
                                  rec_updt_crs.PO_DISTRIBUTION_ID ||
                                  substr(sqlerrm, 1, 250));

      END;
  END LOOP;
  COMMIT;
  
              
  BEGIN
      CST_ACCRUAL_REC_PVT.insert_appo_data_all(
      p_wo_date => sysdate,
      p_rea_id => p_reason_id,
      p_comments => p_comments,
      p_sob_id => p_sob_id,
      p_ou_id => p_ou_id,
      x_count => x_count,
      x_err_num => x_err_num,
      x_err_code => x_err_code,
      x_err_msg => x_err_msg);
      
  XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Number of Records processed '||x_count);      
  XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error Number '||x_err_num);  
  XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error Code '||x_err_code);
  XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error Message '||x_err_msg);

  --Update Error message to BKP table
  IF x_err_msg IS NOT NULL THEN
  
    UPDATE XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
             set process_flag = 'E'
       ,error_message = SUBSTR(x_err_code||' - '||x_err_msg,1,250)
           where PO_DISTRIBUTION_ID IN 
                (SELECT crs.PO_DISTRIBUTION_ID 
                    FROM CST_RECONCILIATION_SUMMARY crs
                       ,XXAP.XXAP3863_CST_RECON_SUMMARY_BKP sum_bkp
                    WHERE   crs.PO_DISTRIBUTION_ID = sum_bkp.PO_DISTRIBUTION_ID
                      AND sum_bkp.DF_REQUEST_ID =  lv_request_id
                      AND sum_bkp.OPERATING_UNIT_ID = p_ou_id
                );
    UPDATE XXAP.XXAP3863_APPO_RECON_BKP
             set process_flag = 'E'
       ,error_message = SUBSTR(x_err_code||' - '||x_err_msg,1,250)
           where PO_DISTRIBUTION_ID IN 
                (SELECT car.PO_DISTRIBUTION_ID 
                    FROM CST_AP_PO_RECONCILIATION car
                       ,XXAP.XXAP3863_APPO_RECON_BKP appo_bkp
                    WHERE   car.PO_DISTRIBUTION_ID = appo_bkp.PO_DISTRIBUTION_ID
                      AND appo_bkp.DF_REQUEST_ID =  lv_request_id
                      AND appo_bkp.OPERATING_UNIT_ID = p_ou_id
                );
    UPDATE CST_RECONCILIATION_SUMMARY
             set WRITE_OFF_SELECT_FLAG = NULL
      where PO_DISTRIBUTION_ID IN 
                (SELECT crs.PO_DISTRIBUTION_ID 
                    FROM CST_RECONCILIATION_SUMMARY crs
                       ,XXAP.XXAP3863_CST_RECON_SUMMARY_BKP sum_bkp
                    WHERE   crs.PO_DISTRIBUTION_ID = sum_bkp.PO_DISTRIBUTION_ID
                      AND sum_bkp.DF_REQUEST_ID =  lv_request_id
                      AND sum_bkp.OPERATING_UNIT_ID = p_ou_id
                );            
  END IF;
  EXCEPTION
  WHEN OTHERS THEN
	lv_error_message := substr(sqlerrm, 1, 250);
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                                'Exception occured in API calling : SQLCODE- ' ||
                                SQLCODE || '   Error Message: ' || SQLERRM);
								
		UPDATE XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
             set process_flag = 'E'
			 ,error_message = lv_error_message
           where PO_DISTRIBUTION_ID IN 
								(SELECT crs.PO_DISTRIBUTION_ID 
										FROM CST_RECONCILIATION_SUMMARY crs
											 ,XXAP.XXAP3863_CST_RECON_SUMMARY_BKP sum_bkp
										WHERE 	crs.PO_DISTRIBUTION_ID = sum_bkp.PO_DISTRIBUTION_ID
											AND sum_bkp.DF_REQUEST_ID =	lv_request_id
											AND sum_bkp.OPERATING_UNIT_ID = p_ou_id
								);		
		UPDATE XXAP.XXAP3863_APPO_RECON_BKP
             set process_flag = 'E'
			 ,error_message = lv_error_message
           where PO_DISTRIBUTION_ID IN 
								(SELECT car.PO_DISTRIBUTION_ID 
										FROM CST_AP_PO_RECONCILIATION car
											 ,XXAP.XXAP3863_APPO_RECON_BKP appo_bkp
										WHERE 	car.PO_DISTRIBUTION_ID = appo_bkp.PO_DISTRIBUTION_ID
											AND appo_bkp.DF_REQUEST_ID =	lv_request_id
											AND appo_bkp.OPERATING_UNIT_ID = p_ou_id
								);
  END;
  COMMIT;
  EXCEPTION WHEN OTHERS THEN
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                              'Error encountered in update on backup ' ||
                              substr(SQLERRM, 1, 250));
  END p_write_off;
  PROCEDURE p_print_record (p_ou_id IN NUMBER) IS
  TYPE lv_cursor IS REF CURSOR;
	lv_ref_cursor      lv_cursor;
  lv_request_id NUMBER :=p_ou_id;
  
    lv_success_count number := 0;
    lv_error_count   number := 0;
	lv_summy_success_count	number := 0;
	lv_summy_error_count	number := 0;
	lv_result_clob     CLOB;
	lv_error_sql	VARCHAR2 (32767) := NULL;
	lv_success_sql	VARCHAR2 (32767) := NULL;
  BEGIN
	select count(1)
      into lv_summy_success_count
      from XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
     where process_flag = 'S'
       and df_request_id = lv_request_id;

    select count(1)
      into lv_summy_error_count
      from XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
     where process_flag = 'E'
       and df_request_id = lv_request_id;
	
	select count(1)
      into lv_success_count
      from XXAP.XXAP3863_APPO_RECON_BKP
     where process_flag = 'S'
       and df_request_id = lv_request_id;

    select count(1)
      into lv_error_count
      from XXAP.XXAP3863_APPO_RECON_BKP
     where process_flag = 'E'
       and df_request_id = lv_request_id;

    ---- Print Output
    
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,
                            'Records Error to update on CST_AP_PO_RECONCILIATION , Count:' ||
                            lv_error_count);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,
                            'Records Error to update on CST_RECONCILIATION_SUMMARY , Count:' ||
                            lv_summy_error_count);
	lv_error_sql:='SELECT DISTINCT	HOU.NAME AS OPERATING_UNIT
									,PHA.SEGMENT1 AS PO_NUMBER
									,PRA.RELEASE_NUM
									,PLA.LINE_NUM AS PO_LINE
									,PLLA.SHIPMENT_NUM
									,PDA.DISTRIBUTION_NUM
									,AP.VENDOR_NAME
							FROM XXAP.XXAP3863_CST_RECON_SUMMARY_BKP bkp
								,PO_DISTRIBUTIONS_ALL PDA
								,PO_LINE_LOCATIONS_ALL PLLA
								,PO_LINES_ALL PLA
								,PO_RELEASES_ALL PRA
								,PO_HEADERS_ALL PHA
								,AP_SUPPLIERS AP
								,HR_OPERATING_UNITS HOU
							WHERE PROCESS_FLAG = ''E''
							AND DF_REQUEST_ID = '||lv_request_id||'
							AND BKP.PO_DISTRIBUTION_ID = PDA.PO_DISTRIBUTION_ID
							AND PDA.LINE_LOCATION_ID = PLLA.LINE_LOCATION_ID
							AND PDA.PO_LINE_ID = PLA.PO_LINE_ID
							AND PDA.PO_HEADER_ID = PHA.PO_HEADER_ID
							AND PDA.PO_RELEASE_ID = PRA.PO_RELEASE_ID(+)
							AND PHA.VENDOR_ID = AP.VENDOR_ID
							AND PHA.ORG_ID = HOU.ORGANIZATION_ID';
	lv_success_sql:='SELECT DISTINCT HOU.NAME AS OPERATING_UNIT
									,PHA.SEGMENT1 AS PO_NUMBER
									,PRA.RELEASE_NUM
									,PLA.LINE_NUM AS PO_LINE
									,PLLA.SHIPMENT_NUM
									,PDA.DISTRIBUTION_NUM
									,AP.VENDOR_NAME
							FROM XXAP.XXAP3863_CST_RECON_SUMMARY_BKP bkp
								,PO_DISTRIBUTIONS_ALL PDA
								,PO_LINE_LOCATIONS_ALL PLLA
								,PO_LINES_ALL PLA
								,PO_RELEASES_ALL PRA
								,PO_HEADERS_ALL PHA
								,AP_SUPPLIERS AP
								,HR_OPERATING_UNITS HOU
							WHERE PROCESS_FLAG = ''S''
							AND DF_REQUEST_ID = '||lv_request_id||'
							AND BKP.PO_DISTRIBUTION_ID = PDA.PO_DISTRIBUTION_ID
							AND PDA.LINE_LOCATION_ID = PLLA.LINE_LOCATION_ID
							AND PDA.PO_LINE_ID = PLA.PO_LINE_ID
							AND PDA.PO_HEADER_ID = PHA.PO_HEADER_ID
							AND PDA.PO_RELEASE_ID = PRA.PO_RELEASE_ID(+)
							AND PHA.VENDOR_ID = AP.VENDOR_ID
							AND PHA.ORG_ID = HOU.ORGANIZATION_ID';						
	OPEN lv_ref_cursor FOR lv_error_sql;
							
	DBMS_LOB.createtemporary (lv_result_clob, TRUE);						
	xxint_outbound_util.refcur_to_csv (p_cursor               => lv_ref_cursor,
                                         p_field_delimiter      => '~',
                                         p_line_delimiter       => CHR (10),
                                         p_first_row_flag       => 'Y',
                                         x_clob                 => lv_result_clob
                                        );	
	xxint_xml_util.write_clob_to_cp_ofile (lv_result_clob);	
	 -- Free the temporary clob from temporary tablespace
    DBMS_LOB.freetemporary (lv_result_clob);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,
                            'Records Successfully Write off from CST_AP_PO_RECONCILIATION , Count:' ||
                            lv_success_count);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,
                            'Records Successfully Write off from CST_RECONCILIATION_SUMMARY , Count:' ||
                            lv_summy_success_count);						
	
							
	OPEN lv_ref_cursor FOR lv_success_sql;
							
	DBMS_LOB.createtemporary (lv_result_clob, TRUE);						
	xxint_outbound_util.refcur_to_csv (p_cursor               => lv_ref_cursor,
                                         p_field_delimiter      => '~',
                                         p_line_delimiter       => CHR (10),
                                         p_first_row_flag       => 'Y',
                                         x_clob                 => lv_result_clob
                                        );	
	xxint_xml_util.write_clob_to_cp_ofile (lv_result_clob);	
	 -- Free the temporary clob from temporary tablespace
    DBMS_LOB.freetemporary (lv_result_clob);
	EXCEPTION WHEN OTHERS THEN
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                              'Error encountered in printing the processed records ' ||
                              substr(SQLERRM, 1, 250));
  END p_print_record;
	procedure main(p_errbuff 		OUT VARCHAR2,
                 p_retcode 			OUT NUMBER,
                 p_ou_id    		IN NUMBER,
				 p_sob_id			IN NUMBER,
				 p_directory_path	IN VARCHAR2,
				 p_file_name		IN VARCHAR2,
				 p_reason_id		IN NUMBER,
				 p_comments			IN VARCHAR2) IS
	CURSOR cur_updt_crs IS
      SELECT *
        from XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
       where process_flag = 'NEW';
	   
	
	TYPE recon_sumry_tbl IS TABLE OF XXAP.XXAP3863_CST_RECON_SUMMARY_BKP%ROWTYPE;
    sumary_table recon_sumry_tbl;
	TYPE appo_recon_tbl IS TABLE OF XXAP.XXAP3863_APPO_RECON_BKP%ROWTYPE;
    appo_table appo_recon_tbl;
	
    lv_request_id    NUMBER;
    
	lv_directory	 VARCHAR2(240);
	lv_col			 xxau_clob_columns_type;
	lv_delimeter	 VARCHAR2(2) := '~';
	x_count number :=0;
	x_err_num number;
	x_err_code varchar2(30);
	x_err_msg varchar2(2000);
	usr_Exep_error EXCEPTION;
	
	
	BEGIN
	--- Print the parameter values
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log,
                            'In main Start');
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'Parameter Passed:');
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'OU id:' || p_ou_id);
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'Set of Books id:' || p_sob_id);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'Directory Path:' || p_directory_path);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'File Name:' || p_file_name);
	--XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'Write Off Date:' || p_wo_date);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'Write of Reason:' || p_reason_id);
	XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log, 'Write off Comment:' || p_comments);
	
	
    lv_request_id := fnd_global.conc_request_id;
	
	 BEGIN
      SELECT directory_name
        INTO lv_directory
        FROM dba_directories
       WHERE directory_path = p_directory_path
         and directory_name = 'XXDATA_IN';
    EXCEPTION
      WHEN OTHERS THEN
        fnd_file.put_line(fnd_file.LOG, 'Error in Directory: ' || SQLERRM);
		RAISE usr_Exep_error;
		 
		--p_retcode := 2;
		--p_errbuff := 'Error';
		--EXIT;
    END;
	
	BEGIN
    
      lv_col := xxau_clob_util_pkg.f_file_to_table(p_file_directory => lv_directory,
                                                  p_file_name      => p_file_name,
                                                  p_delimiter      => lv_delimeter);
    EXCEPTION
      WHEN OTHERS THEN
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log,
                                'Data parsing Failed from File. Error : ' ||
                                SQLERRM);
		RAISE usr_Exep_error;						
		--p_retcode := 2;
		--p_errbuff := 'Error';
		--EXIT;						
    END;
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log,
                            'Number of rows fetched from file: ' ||
                            lv_col.COUNT);
  
    IF lv_col.COUNT = 0 THEN
      XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.log,
                              'No data found to Process in File ' ||
                              p_directory_path || '/' || p_file_name);
		p_retcode := 1;
		p_errbuff := 'Warning: No Records in Data File';				  
    
    ELSE
    --- insert data in the backup table
	
	FOR tab_rec in 1 .. lv_col.COUNT LOOP
	begin
      --insert into XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
	
	IF lv_col(tab_rec).column4 <> ' ' THEN 
	SELECT CRS.*, 'NEW', lv_request_id, null BULK COLLECT
        INTO sumary_table
        FROM HR_OPERATING_UNITS HOU
		,PO_HEADERS_ALL PHA
		,PO_LINES_ALL PLA
		,PO_RELEASES_ALL PRA
		,PO_LINE_LOCATIONS_ALL PLLA
		,PO_DISTRIBUTIONS_ALL PDA
		,CST_RECONCILIATION_SUMMARY CRS
       WHERE hou.ORGANIZATION_ID = p_ou_id
	   AND PHA.ORG_ID = hou.ORGANIZATION_ID
	   AND PHA.PO_HEADER_ID = PLA.PO_HEADER_ID
	   AND PHA.PO_HEADER_ID = PRA.PO_HEADER_ID
	   AND PRA.PO_RELEASE_ID = PLLA.PO_RELEASE_ID
	   AND PLA.PO_LINE_ID = PLLA.PO_LINE_ID
	   AND PLLA.PO_RELEASE_ID = PDA.PO_RELEASE_ID
	   AND PLLA.LINE_LOCATION_ID = PDA.LINE_LOCATION_ID
	   AND PLLA.PO_LINE_ID = PDA.PO_LINE_ID
	   AND PDA.PO_DISTRIBUTION_ID = CRS.PO_DISTRIBUTION_ID
	   AND CRS.OPERATING_UNIT_ID = hou.ORGANIZATION_ID
	   AND hou.NAME = lv_col(tab_rec).column2 
	   AND PHA.SEGMENT1 = lv_col(tab_rec).column3
	   AND PRA.RELEASE_NUM = lv_col(tab_rec).column4
	   AND PLA.LINE_NUM = lv_col(tab_rec).column5
	   AND PLLA.SHIPMENT_NUM = lv_col(tab_rec).column6
	   AND PDA.DISTRIBUTION_NUM = lv_col(tab_rec).column7
	   AND NOT EXISTS 
	   (SELECT 1 FROM XXAP.XXAP3863_CST_RECON_SUMMARY_BKP bkp
		WHERE bkp.PO_DISTRIBUTION_ID = CRS.PO_DISTRIBUTION_ID
			AND process_flag = 'S');
			
	ELSE
	
		SELECT CRS.*, 'NEW', lv_request_id, null BULK COLLECT
        INTO sumary_table
        FROM HR_OPERATING_UNITS HOU
		,PO_HEADERS_ALL PHA
		,PO_LINES_ALL PLA
		,PO_LINE_LOCATIONS_ALL PLLA
		,PO_DISTRIBUTIONS_ALL PDA
		,CST_RECONCILIATION_SUMMARY CRS
       WHERE hou.ORGANIZATION_ID = p_ou_id
	   AND PHA.ORG_ID = hou.ORGANIZATION_ID
	   AND PHA.PO_HEADER_ID = PLA.PO_HEADER_ID
	   AND PLA.PO_LINE_ID = PLLA.PO_LINE_ID
	   AND PLLA.LINE_LOCATION_ID = PDA.LINE_LOCATION_ID
	   AND PLLA.PO_LINE_ID = PDA.PO_LINE_ID
	   AND PDA.PO_DISTRIBUTION_ID = CRS.PO_DISTRIBUTION_ID
	   AND CRS.OPERATING_UNIT_ID = hou.ORGANIZATION_ID
	   AND hou.NAME = lv_col(tab_rec).column2 
	   AND PHA.SEGMENT1 = lv_col(tab_rec).column3
	   AND PLA.LINE_NUM = lv_col(tab_rec).column5
	   AND PLLA.SHIPMENT_NUM = lv_col(tab_rec).column6
	   AND PDA.DISTRIBUTION_NUM = lv_col(tab_rec).column7
	   AND NOT EXISTS 
	   (SELECT 1 FROM XXAP.XXAP3863_CST_RECON_SUMMARY_BKP bkp
		WHERE bkp.PO_DISTRIBUTION_ID = CRS.PO_DISTRIBUTION_ID
			AND process_flag = 'S');
	END IF;
      FORALL rec_acct in sumary_table.First .. sumary_table.Last
        INSERT INTO XXAP.XXAP3863_CST_RECON_SUMMARY_BKP
        VALUES sumary_table
          (rec_acct);
	EXCEPTION

      WHEN OTHERS THEN
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                                'Exception occured in inserting data into Summary back up table : SQLCODE- ' ||
                                SQLCODE || '   Error Message: ' || SQLERRM);
	end;
	
	begin
      --insert into XXAP.XXAP3863_APPO_RECON_BKP
	
	IF lv_col(tab_rec).column4 <> ' ' THEN 						
      SELECT CAR.*, 'NEW', lv_request_id, null BULK COLLECT
        INTO appo_table
        FROM HR_OPERATING_UNITS HOU
		,PO_HEADERS_ALL PHA
		,PO_LINES_ALL PLA
		,PO_RELEASES_ALL PRA
		,PO_LINE_LOCATIONS_ALL PLLA
		,PO_DISTRIBUTIONS_ALL PDA
		,CST_AP_PO_RECONCILIATION CAR
       WHERE hou.ORGANIZATION_ID = p_ou_id
	   AND PHA.ORG_ID = hou.ORGANIZATION_ID
	   AND PHA.PO_HEADER_ID = PLA.PO_HEADER_ID
	   AND PHA.PO_HEADER_ID = PRA.PO_HEADER_ID
	   AND PRA.PO_RELEASE_ID = PLLA.PO_RELEASE_ID
	   AND PLA.PO_LINE_ID = PLLA.PO_LINE_ID
	   AND PLLA.PO_RELEASE_ID = PDA.PO_RELEASE_ID
	   AND PLLA.LINE_LOCATION_ID = PDA.LINE_LOCATION_ID
	   AND PLLA.PO_LINE_ID = PDA.PO_LINE_ID
	   AND PDA.PO_DISTRIBUTION_ID = CAR.PO_DISTRIBUTION_ID
	   AND CAR.OPERATING_UNIT_ID = hou.ORGANIZATION_ID
	   AND hou.NAME = lv_col(tab_rec).column2 
	   AND PHA.SEGMENT1 = lv_col(tab_rec).column3
	   AND PRA.RELEASE_NUM = lv_col(tab_rec).column4
	   AND PLA.LINE_NUM = lv_col(tab_rec).column5
	   AND PLLA.SHIPMENT_NUM = lv_col(tab_rec).column6
	   AND PDA.DISTRIBUTION_NUM = lv_col(tab_rec).column7
	   AND NOT EXISTS 
	   (SELECT 1 FROM XXAP.XXAP3863_APPO_RECON_BKP bkp
		WHERE bkp.PO_DISTRIBUTION_ID = CAR.PO_DISTRIBUTION_ID
			AND process_flag = 'S');
	ELSE
		
		SELECT CAR.*, 'NEW', lv_request_id, null BULK COLLECT
        INTO appo_table
        FROM HR_OPERATING_UNITS HOU
		,PO_HEADERS_ALL PHA
		,PO_LINES_ALL PLA
		,PO_LINE_LOCATIONS_ALL PLLA
		,PO_DISTRIBUTIONS_ALL PDA
		,CST_AP_PO_RECONCILIATION CAR
       WHERE hou.ORGANIZATION_ID = p_ou_id
	   AND PHA.ORG_ID = hou.ORGANIZATION_ID
	   AND PHA.PO_HEADER_ID = PLA.PO_HEADER_ID
	   AND PLA.PO_LINE_ID = PLLA.PO_LINE_ID
	   AND PLLA.LINE_LOCATION_ID = PDA.LINE_LOCATION_ID
	   AND PLLA.PO_LINE_ID = PDA.PO_LINE_ID
	   AND PDA.PO_DISTRIBUTION_ID = CAR.PO_DISTRIBUTION_ID
	   AND CAR.OPERATING_UNIT_ID = hou.ORGANIZATION_ID
	   AND hou.NAME = lv_col(tab_rec).column2 
	   AND PHA.SEGMENT1 = lv_col(tab_rec).column3
	   AND PLA.LINE_NUM = lv_col(tab_rec).column5
	   AND PLLA.SHIPMENT_NUM = lv_col(tab_rec).column6
	   AND PDA.DISTRIBUTION_NUM = lv_col(tab_rec).column7
	   AND NOT EXISTS 
	   (SELECT 1 FROM XXAP.XXAP3863_APPO_RECON_BKP bkp
		WHERE bkp.PO_DISTRIBUTION_ID = CAR.PO_DISTRIBUTION_ID
			AND process_flag = 'S');
	END IF;
      FORALL rec_appo in appo_table.First .. appo_table.Last
        INSERT INTO XXAP.XXAP3863_APPO_RECON_BKP
        VALUES appo_table
          (rec_appo);
	EXCEPTION

      WHEN OTHERS THEN
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                                'Exception occured in inserting data into AP PO back up table : SQLCODE- ' ||
                                SQLCODE || '   Error Message: ' || SQLERRM);
	end;
	END LOOP;
	-- Update the records and do write off
	
	 p_write_off        (p_ou_id     => p_ou_id
              ,p_request_id   => lv_request_id
              ,p_sob_id    => p_sob_id
              ,p_reason_id  => p_reason_id
              ,p_comments    => p_comments
              );
    --Print the Records to Request output
	p_print_record(lv_request_id);
	
	END IF;
	
	EXCEPTION
	WHEN usr_Exep_error THEN
		p_retcode := 2;
		p_errbuff := 'Error';
		--EXIT; 
    WHEN OTHERS THEN
	
	--RAISE usr_Exep_error;
      p_retcode := 2;
      p_errbuff := 'Error';
      XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,
                              'Error encountered in Accrual write off ' ||
                              substr(SQLERRM, 1, 250));
    ROLLBACK;  
	 
	END main;			 
END XXAP3863_MASS_WRITE_OFF_PKG;
/
Show errors package XXAP3863_MASS_WRITE_OFF_PKG
	