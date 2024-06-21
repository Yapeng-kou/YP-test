SET serveroutput on size 1000000 lines 132 trimout on tab off pages 100
WHENEVER sqlerror exit failure rollback

create or replace PACKAGE BODY xxpa4432_project_attach_pkg
IS
 /*************************************************************************
   ** Title:       XXPA.XXPA Project Attachments Conversion
   ** File:        xxpa4432_project_attach_pkg.pkb
   ** Description: This script creates a package body
   ** Parameters:  Default
   ** Run as:      APPS
   ** 12_2_compliant:YES
   ** Keyword Tracking:
   ** History:
   ** Date          Who                Description
   ** -----------   ------------------ -------------------------
   ** 01-Nov-2023   Sowmya shetty       CR25375 - Load Attachments for Project And Agreement
  **********************************************************************************/

 gv_ctq_data_set       VARCHAR2 (50)  := 'Project-Attachments';   
 gn_ttl_err_rec_cnt    NUMBER :=0;
 gn_ttl_val_rec_cnt    NUMBER :=0;
 gn_ttl_rec_cnt        NUMBER :=0;
 gn_ttl_sucess_rec_cnt NUMBER :=0;

 gv_package            VARCHAR2(40):='xxpa4432_proj_attach_pkg.';
 g_debug_flag          VARCHAR2(3) :='N';
 g_batch_id            NUMBER;
 gv_conv_name          VARCHAR2(50) := 'Project-Attachments'; 
 gn_request_id         NUMBER; --Added for 31900

 PROCEDURE debug_log(p_errbuf VARCHAR2)
 IS
 BEGIN
  xx_pk_fnd_file.put_line(fnd_file.log,SYSDATE||' => '||P_ERRBUF);
 END;

 /*PROCEDURE load_data (p_file_path    IN VARCHAR2,
                      p_file_name    IN VARCHAR2,
                      p_email       IN VARCHAR2,
                      x_err_msg     OUT VARCHAR2,
                      x_err_code    OUT NUMBER
                     )IS

  ln_request_id       NUMBER;
  lv_proc             VARCHAR2(25):= 'load_data';
  lv_phase            VARCHAR2(50);
  lv_status           VARCHAR2(50);
  lv_dev_phase        VARCHAR2(50);
  lv_dev_status       VARCHAR2(50);
  lv_message          VARCHAR2(50);
  l_req_return_status BOOLEAN;
 BEGIN
    debug_log('0.0.1 Inside load_data procedure, Submit XXCTQ PA Credit Receivers Loader ');
    ln_request_id := fnd_request.submit_request (    application   => 'XXCTQ',
                                                     program       => 'XXCTQ_PA4023_CREDIT_LOAD',
                                                     description   => 'XXCTQ PA Credit Receivers Loader',
                                                     start_time    => SYSDATE,
                                                     sub_request   => FALSE,
                                                     argument1     => p_file_path,
                                                     argument2     => p_file_name,
                                                     argument3     => p_email
                                                );
    COMMIT;

    IF ln_request_id = 0 THEN
     lv_message := 'XXCTQ PA Credit Receivers Loader Program Not Submitted';
     x_err_code := 1;
     debug_log ('0.0.2 XXCTQ PA Credit Receivers Loader Program Not Submitted due to ' || fnd_message.get || '".');
     debug_log( '0.0.2 XXCTQ PA Credit Receivers Loader Program Not Submitted ');
    ELSE
     debug_log ( 'The Program XXCTQ PA Credit Receivers Loader Program submitted successfully – Request id :' || ln_request_id);
    END IF;

    g_batch_id := ln_request_id;

    IF ln_request_id > 0
     THEN
       LOOP

         l_req_return_status :=  fnd_concurrent.wait_for_request ( request_id      => ln_request_id
                                                                  ,INTERVAL        => 5 --interval Number of seconds to wait between checks
                                                                --,max_wait      => 60 --Maximum number of seconds to wait for the request completion
                                                                  ,phase           => lv_phase
                                                                  ,status          => lv_status
                                                                  ,dev_phase       => lv_dev_phase
                                                                  ,dev_status      => lv_dev_status
                                                                  ,message         => lv_message
                                                                  );
       EXIT
         WHEN UPPER (lv_phase) = 'COMPLETED' OR UPPER (lv_status) IN ('CANCELLED', 'ERROR', 'TERMINATED');
       END LOOP;

       IF UPPER (lv_phase) = 'COMPLETED' AND UPPER (lv_status) = 'ERROR' THEN
         debug_log ( '0.0.3 The XXCTQ PA Credit Receivers Loader Program completed in error. Oracle request id: '||ln_request_id ||' '||SQLERRM);
         debug_log( '0.0.3 The XXCTQ PA Credit Receivers Loader Program completed in error. Oracle request id: '||ln_request_id ||' '||SQLERRM);
       ELSIF UPPER (lv_phase) = 'COMPLETED' AND UPPER (lv_status) = 'NORMAL' THEN
         debug_log ( 'The XXCTQ PA Credit Receivers Loader Program request successful for request id: ' || ln_request_id);
       END IF;
    END IF;
 EXCEPTION
  WHEN OTHERS THEN
   x_err_code   := 2;
   x_err_msg    := SQLERRM;
   --xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, x_err_msg);--Added for 31900
   debug_log('0.0.4 OTHERS exception in '||gv_package||lv_proc||' while submitting XXCTQ PA Credit Receivers Loader Program: ' || sqlerrm);
 END load_data;*/
 --Validate the data from file
 PROCEDURE xx_process_attachments_data(p_batch_id   IN NUMBER,
                                       x_err_code   OUT VARCHAR2,
                                       x_err_msg    OUT VARCHAR2
                                       )
 IS
 -- +============================================================================================+
 -- |                                                                                           |
 -- +============================================================================================+
 -- | Procedure Name : xx_process_attachments_data                                           |
 -- | Purpose: It will validate all the records in staging table which are having status E/N     |
 -- |Change Record:                                                                              |
 -- |===============                                                                             |
 -- |Version   Date         Author            Remarks                                            |
 -- |=======   ==========   =============     ===================================================|
 -- |1.0       03-Oct-2023  Sowmya            Initial draft version                                         |
 -- +============================================================================================+
    CURSOR cur_project_attachments
    IS
    SELECT xpas.rowid rid
         , xpas.*
      FROM XXPA.XXPA_PROJECT_ATTACHMENTS_STG xpas
     WHERE 1=1
       AND xpas.status = 'NEW'  
       AND NVL (batch_id, 0) = NVL (p_batch_id, NVL (batch_id, 0));		
     TYPE lt_project_attachments_type IS TABLE OF cur_project_attachments%ROWTYPE INDEX BY BINARY_INTEGER;
     lt_project_attachments_tab lt_project_attachments_type;

    idx                NUMBER := 0;
    Ln_Exception_Count Number :=0;
    lv_err_msg         VARCHAR2(4500);
    lv_error           VARCHAR2(10):='ERROR'; 
    lv_validate        VARCHAR2(10):='VALID';  
    lv_Invalid         VARCHAR2(10):='INVALID'; 
    ln_proj_id         NUMBER;
    ln_org_id          NUMBER;
    ln_agreement_id    NUMBER;
    ln_organization_id NUMBER;
    ln_error_count     NUMBER;
    ln_err_idx         NUMBER;
    ln_err_code        NUMBER;
    failure_in_forall  EXCEPTION;
    lv_dup_count       NUMBER;
    lv_proc            VARCHAR2(40):='xx_process_attachments_data';
    ln_request_id      NUMBER      := fnd_global.conc_request_id;
    lv_category_name   fnd_document_categories_tl.name%type;
	ln_category_id     fnd_document_categories_tl.category_id%type;
    ln_prj_start_date DATE;
    ln_prj_end_date  DATE;

    PRAGMA EXCEPTION_INIT (failure_in_forall, -24381);

 BEGIN

  debug_log(   '0.0 Inside xx_process_attachments_data procedure.');

  FOR rec_project_attachments IN cur_project_attachments
  LOOP
    BEGIN
      lv_err_msg          := NULL;
      ln_Exception_Count  := 0;
      ln_proj_id          := null;
      ln_org_id           := null;
      idx                 := idx+1;
      lv_dup_count        := 0;

    debug_log('0.1 Attachment Level : '||rec_project_attachments.ATTACHMENT_LEVEL);    
    debug_log('0.1 Project/Agreement Reference : '||rec_project_attachments.ATT_PROJ_AG_REFERENCE);
	debug_log('0.1 Attachment Category : '||rec_project_attachments.ATTACH_CATEGORY);
	debug_log('0.1 Attachment Source : '||rec_project_attachments.ATTACH_SOURCE);

    debug_log('0.1 lv_dup_count : '||lv_dup_count);
    debug_log('0.1 ln_Exception_Count : '||ln_Exception_Count);


    IF rec_project_attachments.ATT_PROJ_AG_REFERENCE IS NOT NULL
      THEN
     --Validate ATT_PROJ_AG_REFERENCE is not null
     BEGIN
            --Get Project Id and Org_id for the project Number
            BEGIN
			SELECT project_id, Org_id,start_date,completion_date
              INTO ln_proj_id, ln_org_id,ln_prj_start_date,ln_prj_end_date
              FROM pa_projects_all
             WHERE segment1 = TRIM(rec_project_attachments.ATT_PROJ_AG_REFERENCE);
			 debug_log('0.2 Project Id, Org Id, Proj Start Date,Proj End Date Derived : '||ln_proj_id||','||ln_org_id||','||ln_prj_start_date||','||ln_prj_end_date);
			EXCEPTION
			 WHEN OTHERS THEN 			
			   ln_proj_id := NULL; 
			   ln_org_id  := NULL;
			   ln_prj_start_date := NULL;
			   ln_prj_end_date   := NULL;
			   debug_log('0.2 Project Number Validation Error : '||SQLERRM);
			   ln_Exception_Count:=ln_Exception_Count+1;  --123
               lv_err_msg := lv_err_msg || '1.1 Project Number is Blank in flat file. | ';
               xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);
               debug_log('Project Reference Number is Blank in flat file');  		   	   
			END;   
			IF ln_proj_id IS NULL AND rec_project_attachments.attachment_level = 'PA_AGREEMENTS' THEN
              --Get Agreement Id and Org_id for the project Number
              BEGIN			 
			    SELECT AGREEMENT_ID,ORG_ID 
			      INTO ln_agreement_id,ln_org_id
			     FROM pa_agreements_all
			    WHERE AGREEMENT_NUM = rec_project_attachments.ATT_PROJ_AG_REFERENCE; 
				debug_log('0.3 Agreement Id, Org Id Derived : '||ln_agreement_id||','||ln_org_id);
              EXCEPTION
			   WHEN NO_DATA_FOUND then
			    BEGIN
				   SELECT b.agreement_id,Org_id  
				    INTO ln_agreement_id,ln_org_id
                    FROM pa_projects_all a, 
					     pa_project_fundings b 
                   WHERE a.project_id = b.project_id
                     AND a.segment1 = rec_project_attachments.ATT_PROJ_AG_REFERENCE
                     AND rownum < 2
					;
				   debug_log('0.3.0 Agreement Id, Org Id Derived : '||ln_agreement_id||','||ln_org_id);	
				EXCEPTION
				 WHEN OTHERS THEN
			      ln_agreement_id:= NULL;
			      ln_org_id:= NULL;
			      lv_err_msg := lv_err_msg || '0.3 Agreement Number Validation Error : '||SUBSTR(SQLERRM,1,500);
			      debug_log('0.3.0 Agreement Number Validation Error : '||SQLERRM);
			    END;
			   WHEN OTHERS THEN
			   ln_agreement_id:= NULL;
			   ln_org_id:= NULL;
			   lv_err_msg := lv_err_msg || '0.3 Agreement Number Validation Error : '||SUBSTR(SQLERRM,1,500);
			   debug_log('0.3.1 Agreement Number Validation Error : '||SQLERRM);
			  END; 
			  IF ln_agreement_id IS NULL 
			   THEN
                 ln_Exception_Count:=ln_Exception_Count+1;
				 lv_err_msg := lv_err_msg || '1.0 Agreement Number is Blank in flat file. | ';
                 xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);
                 debug_log('Agreement Reference Number is Blank in flat file');			   
			  ELSIF ln_proj_id IS NULL THEN
                 ln_Exception_Count:=ln_Exception_Count+1;
                 lv_err_msg := lv_err_msg || '1.1 Project Number is Blank in flat file. | ';
                 xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);
                 debug_log('Project Reference Number is Blank in flat file'); 
			  END IF; 

            END IF;

         IF rec_project_attachments.attach_category IS NOT NULL 
		  THEN
		    -- Getting the category_name and Category ID
		  BEGIN
		    SELECT name,category_id 
			 INTO lv_category_name,ln_category_id
		     FROM fnd_document_categories_tl 
			WHERE user_name = rec_project_attachments.attach_category
              AND language = USERENV('LANG');
		  EXCEPTION
		   WHEN OTHERS THEN
		     lv_err_msg := lv_err_msg || '1.2 Error In getting the Category namea and ID : '||SUBSTR(SQLERRM,1,500);
			 ln_Exception_Count:=ln_Exception_Count+1;
		     debug_log('1.2 Error In getting the Category namea and ID : '||SQLERRM);			
		  END;

         ELSE
          ln_Exception_Count:= ln_Exception_Count+1;
                                 lv_err_msg :=  lv_err_msg
                                 ||'1.3 Attachment Category : '
                                 ||rec_project_attachments.attach_category
                                 ||' DOC CATEGORY IS NOT POPULATED: '                                 
                                 ||' | '    ;
                                 xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);
          debug_log(   '1.3 DOC CATEGORY IS NOT POPULATED');
         END IF;
         IF rec_project_attachments.attachment_level NOT IN ('PA_PROJECTS','PA_AGREEMENTS') THEN
            ln_Exception_Count:= ln_Exception_Count+1;
                                             lv_err_msg :=  lv_err_msg
                                             ||'1.4 Attachment Level : '
                                             ||rec_project_attachments.attach_category
                                             ||' ATTACHMENT LEVEL IS NOT PA_PROJECTS or PA_AGREEMENTS: '                                 
                                             ||' | '    ;
                                             xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);
          debug_log(   '1.4 ATTACHMENT LEVEL IS NOT PA_PROJECTS or PA_AGREEMENTS');
		 END IF; 
        debug_log('1.5 ln_Exception_Count : '||ln_Exception_Count);

     EXCEPTION
      WHEN NO_DATA_FOUND THEN
		ln_Exception_Count:=ln_Exception_Count+1;
		 lv_err_msg :=  lv_err_msg
		 ||'1.6 Project/Agreement Number: '
		 ||rec_project_attachments.ATT_PROJ_AG_REFERENCE
		 ||' does not Exist in Oracle. | ';
		xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);--Added for 31900
        debug_log(   '1.6 no data found-project number-');
        debug_log(   '1.6 lv_err_msg-'||lv_err_msg);
      WHEN OTHERS THEN
        ln_Exception_Count:=ln_Exception_Count+1;
         lv_err_msg := lv_err_msg || '1.7 Exception while validating the Project/Agreement Number: '
         || rec_project_attachments.ATT_PROJ_AG_REFERENCE
         || ' '
         || SQLERRM ||' | ';
        xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);--Added for 31900
     END;
      debug_log('1.7 ln_Exception_Count : '||ln_Exception_Count);
    ELSE
      ln_Exception_Count:=ln_Exception_Count+1;
      lv_err_msg := '1.8 Project/Agreement Ref Number is Blank in flate file. | ';
      debug_log(   '1.7 -project number blank-');
    END IF;
    debug_log('1.8 ln_Exception_Count : '||ln_Exception_Count);

    debug_log('1.8 Record Id : '||rec_project_attachments.record_id);

    --Check the exception count
    debug_log(   '1.8.0 -ln_Exception_Count-');
       IF ln_Exception_Count > 0 THEN
          lt_project_attachments_tab(idx).record_id             := rec_project_attachments.record_id; 
          lt_project_attachments_tab(idx).rid                   := rec_project_attachments.rid;
          lt_project_attachments_tab(idx).ATTACHMENT_LEVEL      := rec_project_attachments.ATTACHMENT_LEVEL;
          lt_project_attachments_tab(idx).ATT_PROJ_AG_REFERENCE := rec_project_attachments.ATT_PROJ_AG_REFERENCE;
          lt_project_attachments_tab(idx).ATTACH_NOTES          := rec_project_attachments.ATTACH_NOTES;
          lt_project_attachments_tab(idx).ATTACH_CATEGORY       := rec_project_attachments.ATTACH_CATEGORY;
          lt_project_attachments_tab(idx).ATTACH_SOURCE         := rec_project_attachments.ATTACH_SOURCE;
          lt_project_attachments_tab(idx).ATTACH_TITLE          := rec_project_attachments.ATTACH_TITLE;
          lt_project_attachments_tab(idx).ATTACH_SEQ_NUMBER     := rec_project_attachments.ATTACH_SEQ_NUMBER;
		  lt_project_attachments_tab(idx).ATTACH_DESCRIPTION    := rec_project_attachments.ATTACH_DESCRIPTION;
		  lt_project_attachments_tab(idx).PROJECT_ID            := ln_proj_id;
		  lt_project_attachments_tab(idx).AGREEMENT_ID          := ln_agreement_id;
		  lt_project_attachments_tab(idx).ORG_ID                := ln_org_id;		  
          lt_project_attachments_tab(idx).message               := lv_err_msg;--SUBSTR(lv_err_msg,1,4000);
          lt_project_attachments_tab(idx).status                := lv_Invalid;
          gn_ttl_err_rec_cnt                                    := gn_ttl_err_rec_cnt+1;

       ELSE
          debug_log(   '1.8.1 -ELSE-');
          lt_project_attachments_tab(idx).record_id             := rec_project_attachments.record_id; 
          lt_project_attachments_tab(idx).rid                   := rec_project_attachments.rid;
          lt_project_attachments_tab(idx).ATTACHMENT_LEVEL      := rec_project_attachments.ATTACHMENT_LEVEL;
          lt_project_attachments_tab(idx).ATT_PROJ_AG_REFERENCE := rec_project_attachments.ATT_PROJ_AG_REFERENCE;
          lt_project_attachments_tab(idx).ATTACH_NOTES          := rec_project_attachments.ATTACH_NOTES;
          lt_project_attachments_tab(idx).ATTACH_CATEGORY       := rec_project_attachments.ATTACH_CATEGORY;
          lt_project_attachments_tab(idx).ATTACH_SOURCE         := rec_project_attachments.ATTACH_SOURCE;
          lt_project_attachments_tab(idx).ATTACH_TITLE          := rec_project_attachments.ATTACH_TITLE;
          lt_project_attachments_tab(idx).ATTACH_SEQ_NUMBER     := rec_project_attachments.ATTACH_SEQ_NUMBER;
		  lt_project_attachments_tab(idx).ATTACH_DESCRIPTION    := rec_project_attachments.ATTACH_DESCRIPTION;
		  lt_project_attachments_tab(idx).PROJECT_ID            := ln_proj_id;
		  lt_project_attachments_tab(idx).AGREEMENT_ID          := ln_agreement_id;
		  lt_project_attachments_tab(idx).ORG_ID                := ln_org_id;
          lt_project_attachments_tab(idx).status                := lv_validate;
          gn_ttl_val_rec_cnt                                    := gn_ttl_val_rec_cnt+1;

       END IF;
    EXCEPTION
      WHEN OTHERS THEN
       lv_err_msg := lv_err_msg || '1.9 Exception in Main loop and exception is '
                  ||SQLERRM
                  ||' | ';
        lt_project_attachments_tab(idx).record_id             := rec_project_attachments.record_id; 
        lt_project_attachments_tab(idx).rid                   := rec_project_attachments.rid;
        lt_project_attachments_tab(idx).ATTACHMENT_LEVEL      := rec_project_attachments.ATTACHMENT_LEVEL;
        lt_project_attachments_tab(idx).ATT_PROJ_AG_REFERENCE := rec_project_attachments.ATT_PROJ_AG_REFERENCE;
        lt_project_attachments_tab(idx).ATTACH_NOTES          := rec_project_attachments.ATTACH_NOTES;
        lt_project_attachments_tab(idx).ATTACH_CATEGORY       := rec_project_attachments.ATTACH_CATEGORY;
        lt_project_attachments_tab(idx).ATTACH_SOURCE         := rec_project_attachments.ATTACH_SOURCE;
        lt_project_attachments_tab(idx).ATTACH_TITLE          := rec_project_attachments.ATTACH_TITLE;
        lt_project_attachments_tab(idx).ATTACH_SEQ_NUMBER     := rec_project_attachments.ATTACH_SEQ_NUMBER;
		lt_project_attachments_tab(idx).ATTACH_DESCRIPTION    := rec_project_attachments.ATTACH_DESCRIPTION;
		lt_project_attachments_tab(idx).PROJECT_ID            := ln_proj_id;
		lt_project_attachments_tab(idx).AGREEMENT_ID          := ln_agreement_id;
		lt_project_attachments_tab(idx).ORG_ID                := ln_org_id;
        lt_project_attachments_tab(idx).message               := lv_err_msg;
        lt_project_attachments_tab(idx).status                := lv_error;
        gn_ttl_err_rec_cnt                                    := gn_ttl_err_rec_cnt+1;
        xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);--Added for 31900
    END;

  END LOOP;

  gn_ttl_rec_cnt := lt_project_attachments_tab.COUNT;

    IF lt_project_attachments_tab.COUNT > 0 THEN

       BEGIN

        FORALL ln_ins_cnt IN 1 .. lt_project_attachments_tab.COUNT SAVE EXCEPTIONS
           UPDATE XXPA.XXPA_PROJECT_ATTACHMENTS_STG
              SET message    = message||' '||SUBSTR(lt_project_attachments_tab(ln_ins_cnt).message,1
                              ,LENGTH(lt_project_attachments_tab(ln_ins_cnt).message)-2) ,
                  status     = lt_project_attachments_tab(ln_ins_cnt).status,
                  ATTACHMENT_LEVEL      = lt_project_attachments_tab(ln_ins_cnt).ATTACHMENT_LEVEL,
                  ATT_PROJ_AG_REFERENCE = lt_project_attachments_tab(ln_ins_cnt).ATT_PROJ_AG_REFERENCE,
                  org_id     = lt_project_attachments_tab(ln_ins_cnt).org_id,
                  ATTACH_CATEGORY = lt_project_attachments_tab(ln_ins_cnt).ATTACH_CATEGORY,
                  PROJECT_ID = lt_project_attachments_tab(ln_ins_cnt).PROJECT_ID,
				  AGREEMENT_ID = lt_project_attachments_tab(ln_ins_cnt).AGREEMENT_ID
                 --batch_id  = ln_request_id
            WHERE record_id = lt_project_attachments_tab(ln_ins_cnt).record_id --ROWID      = lt_task_comm_split_tmp_tab(ln_ins_cnt).rid --Added on 14-Jan-2021 by iriqwm
            ;

         IF SQL%ROWCOUNT > 0 THEN
          debug_log(   '1.9.0 No.of Records updated: '||SQL%ROWCOUNT);
          COMMIT;
         ELSE
          debug_log(   '1.9.1 No.of Records updated: '||SQL%ROWCOUNT);
         END IF;

       EXCEPTION
        WHEN failure_in_forall THEN
         debug_log('1.9.2 error '||SQLERRM);

         FOR I IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
             ln_err_idx   := SQL%BULK_EXCEPTIONS(i).error_index;
             ln_err_code  := SQL%BULK_EXCEPTIONS(i).error_code;
             lv_err_msg   := 'Oracle error is '  || SQLERRM ( -1 * SQL%BULK_EXCEPTIONS (i).ERROR_CODE);
         END LOOP;
        ROLLBACK;
       WHEN OTHERS THEN
         debug_log('1.9.5 error '||SQLERRM);
         RAISE;

       END;

    IF lv_err_msg is not null then --rahman
    x_err_msg   := lv_err_msg ;
    END IF;


    END IF;
 EXCEPTION
   WHEN OTHERS THEN
    debug_log('1.9.6 Exception occured in '||gv_package||lv_proc||' procedure : '||SQLERRM);
    x_err_code  := 1;
    x_err_msg   := lv_err_msg||'-'||SQLERRM;
    xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, x_err_msg);--Added for 31900
 END xx_process_attachments_data;
 --Procedure to dump data to temp
 PROCEDURE xx_create_short_text_attachments(p_batch_id IN NUMBER,
                                         x_err_code OUT VARCHAR2,
                                         x_err_msg  OUT VARCHAR2
                                        )
 IS
-- +============================================================================================+
-- |                                                                                            |
-- +============================================================================================+
-- | Procedure Name : xx_create_short_text_attachments                                             |                                                                           |
-- | Purpose: It will insert all the records in fnd_attached_documents with short text based on |
-- | entity name                                                                                |
-- |Change Record:                                                                              |
-- |===============                                                                             |
-- |Version   Date         Author            Remarks                                            |
-- |=======   ==========   =============     ===================================================|
-- |1.0       05-Nov-2020  Sowmya        Initial draft version                               |
-- +============================================================================================+
    CURSOR cur_project_attachments
    IS
    SELECT temp.rowid rid
         , temp.*
      FROM xxpa.xxpa_project_attachments_stg temp
     WHERE 1=1
       AND temp.status   = 'VALID' 
       AND temp.batch_id = p_batch_id;

	 TYPE lt_project_attach_type IS TABLE OF cur_project_attachments%ROWTYPE INDEX BY BINARY_INTEGER;
     lt_project_attach_tab lt_project_attach_type;

  idx                 NUMBER := 0;
  ln_error_count      NUMBER;
  ln_err_idx          NUMBER;
  ln_err_code         NUMBER;
  lv_err_msg          VARCHAR2(4500);
  lv_proc             VARCHAR2(40):='xx_create_short_text_attachments';
  lv_short_text       fnd_documents_short_text.short_text%type;
  X_request_id        NUMBER;
  X_program_application_id NUMBER;
  X_program_id             NUMBER;
  X_program_update_date    DATE;
  lv_category_name    fnd_document_categories.name%type;
  ln_datatype_id      NUMBER;
  ln_security_type    NUMBER:= 4;
  lv_rowid            VARCHAR2(100);
  ln_document_id      NUMBER;
  x_doc_attribute_category VARCHAR2 (200);
  x_doc_attribute1         VARCHAR2 (150);
  x_doc_attribute2         VARCHAR2 (150);
  x_doc_attribute3         VARCHAR2 (150);
  x_doc_attribute4         VARCHAR2 (150);
  x_doc_attribute5         VARCHAR2 (150);
  x_doc_attribute6         VARCHAR2 (150);
  x_doc_attribute7         VARCHAR2 (150);
  x_doc_attribute8         VARCHAR2 (150);
  x_doc_attribute9         VARCHAR2 (150);
  x_doc_attribute10        VARCHAR2 (150);
  x_doc_attribute11        VARCHAR2 (150);
  x_doc_attribute12        VARCHAR2 (150);
  x_doc_attribute13        VARCHAR2 (150);
  x_doc_attribute14        VARCHAR2 (150);
  x_doc_attribute15        VARCHAR2 (150);
  lv_attribute_category    VARCHAR2 (150);
  lv_attribute1            VARCHAR2 (150);
  lv_attribute2            VARCHAR2 (150);
  lv_attribute3            VARCHAR2 (150);
  lv_attribute4            VARCHAR2 (150);
  lv_attribute5            VARCHAR2 (150);
  lv_attribute6            VARCHAR2 (150);
  lv_attribute7            VARCHAR2 (150);
  lv_attribute8            VARCHAR2 (150);
  lv_attribute9            VARCHAR2 (150);
  lv_attribute10           VARCHAR2 (150);
  lv_attribute11           VARCHAR2 (150);
  lv_attribute12           VARCHAR2 (150);
  lv_attribute13           VARCHAR2 (150);
  lv_attribute14           VARCHAR2 (150);
  lv_attribute15           VARCHAR2 (150);
  lv_image_type            VARCHAR2(10) ;
  lv_success                    VARCHAR2(10):= 'SUCCESS';
  lv_error                        VARCHAR2(10):= 'ERROR';
  ln_storage_type          NUMBER;
  x_column1             VARCHAR2(200) := NULL;
  ln_attached_doc_id    NUMBER;
  ln_media_id           NUMBER;
  ln_user_id            NUMBER := fnd_global.user_id;
  ln_category_id        NUMBER;
  lv_description        fnd_documents_tl.description%TYPE := NULL;
  lv_title              fnd_documents_tl.title%TYPE := NULL;
  lv_entity_name        fnd_attached_documents.entity_name%TYPE ;
  lv_pk1_value          fnd_attached_documents.pk1_value%type;
  x_pk2_value           fnd_attached_documents.pk2_value%type;
  x_pk3_value           fnd_attached_documents.pk3_value%type;
  x_pk4_value           fnd_attached_documents.pk4_value%type;
  x_pk5_value           fnd_attached_documents.pk5_value%type;
  ln_seq_num            fnd_attached_documents.seq_num%TYPE;
  ln_existing_media_id  NUMBER := NULL;
  failure_in_forall     EXCEPTION;
  PRAGMA EXCEPTION_INIT (failure_in_forall, -24381);

 BEGIN
  debug_log('1.10 Begin process data in xxpa_project_attachments_stg, create short text attachments.');

  FOR rec_project_attachments IN cur_project_attachments
   LOOP
     BEGIN
         lv_err_msg := NULL;
         idx              := idx+1;

         lt_project_attach_tab(idx).record_id             := rec_project_attachments.record_id;
         lt_project_attach_tab(idx).ATTACHMENT_LEVEL      := rec_project_attachments.ATTACHMENT_LEVEL;
         lt_project_attach_tab(idx).ATT_PROJ_AG_REFERENCE := rec_project_attachments.ATT_PROJ_AG_REFERENCE;
         lt_project_attach_tab(idx).ATTACH_NOTES          := rec_project_attachments.ATTACH_NOTES;
         lt_project_attach_tab(idx).ATTACH_CATEGORY       := rec_project_attachments.ATTACH_CATEGORY;
         lt_project_attach_tab(idx).ATTACH_SOURCE         := rec_project_attachments.ATTACH_SOURCE;
         lt_project_attach_tab(idx).ATTACH_TITLE          := rec_project_attachments.ATTACH_TITLE;
         lt_project_attach_tab(idx).ATTACH_SEQ_NUMBER     := rec_project_attachments.ATTACH_SEQ_NUMBER;
         lt_project_attach_tab(idx).ATTACH_DESCRIPTION    := rec_project_attachments.ATTACH_DESCRIPTION;
         lt_project_attach_tab(idx).MESSAGE               := rec_project_attachments.MESSAGE;
        lt_project_attach_tab(idx).STATUS                := lv_success;             --123
 -- lt_project_attach_tab(idx).STATUS:= lv_error;
		 lt_project_attach_tab(idx).FILE_NAME             :=  rec_project_attachments.FILE_NAME;
		 lt_project_attach_tab(idx).BATCH_ID              :=  rec_project_attachments.BATCH_ID;
		 lt_project_attach_tab(idx).PROJECT_ID            :=  rec_project_attachments.PROJECT_ID;
		 lt_project_attach_tab(idx).AGREEMENT_ID          :=  rec_project_attachments.AGREEMENT_ID;
         lt_project_attach_tab(idx).creation_date         := sysdate;
         lt_project_attach_tab(idx).created_by            := fnd_global.user_id;
         lt_project_attach_tab(idx).last_update_date      := sysdate;
         lt_project_attach_tab(idx).last_updated_by       := fnd_global.user_id;

         debug_log('1.10.1 Record Id : '||lt_project_attach_tab(idx).record_id);
         --debug_log('1.10.1 ATTACHMENT_LEVEL       : '||lt_project_attach_tab(idx).ATTACHMENT_LEVEL);
         --debug_log('1.10.1 ATT_PROJ_AG_REFERENCE  : '||lt_project_attach_tab(idx).ATT_PROJ_AG_REFERENCE);
         --debug_log('1.10.1 ATTACH_NOTES           : '||lt_project_attach_tab(idx).ATTACH_NOTES);
         --debug_log('1.10.1 ATTACH_CATEGORY        : '||lt_project_attach_tab(idx).ATTACH_CATEGORY);
         --debug_log('1.10.1 ATTACH_SOURCE          : '||lt_project_attach_tab(idx).ATTACH_SOURCE);
         --debug_log('1.10.1 ATTACH_TITLE           : '||lt_project_attach_tab(idx).ATTACH_TITLE);
         --debug_log('1.10.1 ATTACH_SEQ_NUMBER      : '||lt_project_attach_tab(idx).ATTACH_SEQ_NUMBER);
         --debug_log('1.10.1 ATTACH_DESCRIPTION     : '||lt_project_attach_tab(idx).ATTACH_DESCRIPTION);
         --debug_log('1.10.1 PROJECT_ID             : '||lt_project_attach_tab(idx).PROJECT_ID);
		 --debug_log('1.10.1 AGREEMENT_ID           : '||lt_project_attach_tab(idx).AGREEMENT_ID);
         --debug_log('1.10.1 Creation Date          : '||lt_project_attach_tab(idx).creation_date);
         --debug_log('1.10.1 Created By             : '||lt_project_attach_tab(idx).created_by);
         --debug_log('1.10.1 Last Update Date       : '||lt_project_attach_tab(idx).last_update_date);
         --debug_log('1.10.1 Last Updated By        : '||lt_project_attach_tab(idx).last_updated_by);

     EXCEPTION
       WHEN OTHERS THEN
         lv_err_msg := lv_err_msg || '1.10.2 Exception in main loop and exception is '
                         ||SUBSTR(SQLERRM,1,4000);
         lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;               
         debug_log('lv_err_msg: '||lv_err_msg);
         xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);--Added for 31900
     END;
     BEGIN
	   lv_short_text := lt_project_attach_tab(idx).ATTACH_NOTES;
	   x_err_code := 0;
       debug_log('1.10.2 Creating document Start..'); 
       IF lt_project_attach_tab(idx).ATTACHMENT_LEVEL = 'PA_PROJECTS'
	    THEN
        BEGIN
           SELECT d.media_id 
	        INTO ln_existing_media_id
            FROM fnd_document_datatypes     dat,
                  fnd_document_entities_tl   det,
                  fnd_documents_tl           dt,
                  fnd_documents              d,
                  fnd_document_categories_tl dct,
                  fnd_attached_documents     ad
             WHERE d.document_id = ad.document_id
             AND dt.document_id = d.document_id
             AND dt.language = userenv('LANG')
             AND dct.category_id = d.category_id
             AND dct.language = userenv('LANG')
             AND d.datatype_id = dat.datatype_id
             AND dat.language = userenv('LANG')
             AND ad.entity_name = det.data_object_code
             AND det.language = userenv('LANG')
             AND ad.pk1_value =lt_project_attach_tab(idx).PROJECT_ID ---'45321087'
             AND dct.user_name = lt_project_attach_tab(idx).ATTACH_CATEGORY
             AND dat.user_name = 'Short Text'
             AND ad.entity_name =lt_project_attach_tab(idx).ATTACHMENT_LEVEL; --'PA_AGREEMENTS'; --lt_project_attach_tab(idx).ATTACHMENT_LEVEL;
		     debug_log('1.10.2.1 ln_existing_media_id: '||ln_existing_media_id); 
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
           ln_existing_media_id := NULL;
           lv_err_msg := lv_err_msg || '1.10.2 Attachament does not exist for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500);
           lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg; 
           lt_project_attach_tab(idx).STATUS := lv_error;
		   debug_log('1.10.2 Attachament does not exist for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500));
		  WHEN OTHERS THEN
            lv_err_msg := lv_err_msg || '1.10.2 Error in checking attachament existance for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500);
            lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;  
		    debug_log('1.10.2 Error in checking attachament existance for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500));
			x_err_code := 1;
       END;
	  ELSIF lt_project_attach_tab(idx).ATTACHMENT_LEVEL = 'PA_AGREEMENTS'
	   THEN
        BEGIN
		SELECT d.media_id 
	        INTO ln_existing_media_id
            FROM fnd_document_datatypes     dat,
                  fnd_document_entities_tl   det,
                  fnd_documents_tl           dt,
                  fnd_documents              d,
                  fnd_document_categories_tl dct,
                  fnd_attached_documents     ad
             WHERE d.document_id = ad.document_id
             AND dt.document_id = d.document_id
             AND dt.language = userenv('LANG')
             AND dct.category_id = d.category_id
             AND dct.language = userenv('LANG')
             AND d.datatype_id = dat.datatype_id
             AND dat.language = userenv('LANG')
             AND ad.entity_name = det.data_object_code
             AND det.language = userenv('LANG')
             AND ad.pk1_value = lt_project_attach_tab(idx).AGREEMENT_ID ----'45321087'
             AND dct.user_name = lt_project_attach_tab(idx).ATTACH_CATEGORY
             AND dat.user_name = 'Short Text'
             AND ad.entity_name =lt_project_attach_tab(idx).ATTACHMENT_LEVEL; --'PA_AGREEMENTS'; --lt_project_attach_tab(idx).ATTACHMENT_LEVEL;
		     debug_log('1.10.2.3 ln_existing_media_id: '||ln_existing_media_id);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
           lv_err_msg := lv_err_msg || '1.10.2.3.1 Attachament does not exist for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500);
           lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg; 
           lt_project_attach_tab(idx).STATUS := lv_error;
           ln_existing_media_id := NULL;
		   debug_log('1.10.2.3.1 Attachament does not exist for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500));
		  WHEN OTHERS THEN
            lv_err_msg := lv_err_msg || '1.10.2.3.2 Error in checking attachament existance for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500);
            lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg; 
            lt_project_attach_tab(idx).STATUS := lv_error;
		    debug_log('1.10.2.3.2 Error in checking attachament existance for given line id, '||'Error Message'||SUBSTR(SQLERRM,1,500));
			x_err_code := 1;
       END;			 
      END IF;
	  debug_log('Media ID Exists..:'||ln_existing_media_id);
      IF ln_existing_media_id IS NOT NULL THEN
            UPDATE fnd_documents_short_text
             SET short_text = lv_short_text
             WHERE media_id = ln_existing_media_id;
             COMMIT;
         --     lt_project_attach_tab(idx).STATUS := lv_success;
       ELSE         
	      debug_log('1.100.1   Getting the category_name and Category ID'); 
        -- Getting the category_name and Category ID
		BEGIN
		   SELECT name,category_id INTO lv_category_name,ln_category_id
		   FROM fnd_document_categories_tl 
		   WHERE user_name = lt_project_attach_tab(idx).ATTACH_CATEGORY
           AND language = USERENV('LANG');
		EXCEPTION
		   WHEN OTHERS THEN
		      debug_log('1.10.3 Error In getting the Category namea and ID, '||'Error Message'||SUBSTR(SQLERRM,1,500));
			  x_err_code := 1;
			  lv_err_msg := lv_err_msg || '1.10.3 Error In getting the Category namea and ID, '||'Error Message'||SUBSTR(SQLERRM,1,500);
              lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
              lt_project_attach_tab(idx).STATUS := lv_error;
		END; 
		debug_log('1.100.2   lv_category_name and ln_category_id: '||lv_category_name||'***'||ln_category_id); 
	   --Getting max Sequence Number for attached doc
	   IF lt_project_attach_tab(idx).ATTACH_SEQ_NUMBER IS NULL
        THEN
       BEGIN
	     SELECT NVL (MAX (seq_num), 0) + 10 INTO ln_seq_num
          FROM fnd_attached_documents
           WHERE pk1_value = nvl(lt_project_attach_tab(idx).PROJECT_ID,lt_project_attach_tab(idx).AGREEMENT_ID)
		   AND entity_name = lt_project_attach_tab(idx).ATTACHMENT_LEVEL
		   AND ROWNUM < 2;
		 EXCEPTION
		  WHEN OTHERS THEN
		    debug_log('1.10.4 Error in getting max Sequence Number for attached doc, '||'Error Message'||SUBSTR(SQLERRM,1,500));
			x_err_code := 1;
			lv_err_msg := lv_err_msg || '1.10.4 Error in getting max Sequence Number for attached doc, '||'Error Message'||SUBSTR(SQLERRM,1,500);
            lt_project_attach_tab(idx).STATUS := lv_error;
            lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
	   END; 
       ELSE
	     IF lt_project_attach_tab(idx).ATTACH_SEQ_NUMBER < 0 then
		    debug_log('1.10.4.0 Sequence Number cannot be negative..');
			x_err_code := 1;
			lv_err_msg := lv_err_msg || '1.10.4.0 Sequence Number cannot be negative..';
            lt_project_attach_tab(idx).STATUS := lv_error;
            lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
		 ELSE
         ln_seq_num := lt_project_attach_tab(idx).ATTACH_SEQ_NUMBER;
		 END IF;
       END IF;
	   debug_log('1.100.3   ln_seq_num: '||ln_seq_num); 
			   -- Getting the documnet data type Id
	   BEGIN
	    SELECT DATATYPE_ID INTO ln_datatype_id
		   FROM fnd_document_datatypes
		   WHERE user_name = 'Short Text'
		   and language = USERENV('LANG');
		EXCEPTION
		  WHEN OTHERS THEN
		    debug_log('1.10.4 Error in getting the doc data type id,'||'Error Message'||SUBSTR(SQLERRM,1,500));
			x_err_code := 1;
			lv_err_msg := lv_err_msg || '1.10.4 Error In getting the doc data type id, '||'Error Message'||SUBSTR(SQLERRM,1,500);
            lt_project_attach_tab(idx).STATUS := lv_error;
            lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
	   END;
	   debug_log('1.100.4   ln_datatype_id: '||ln_datatype_id);
		-- Getting the document_id from seq
        BEGIN
            SELECT fnd_documents_s.NEXTVAL 
			  INTO ln_document_id
            FROM dual; 
	     EXCEPTION
          WHEN OTHERS THEN
		    debug_log('1.10.5 Error In getting document id seq, '||'Error Message'||SUBSTR(SQLERRM,1,500));
			x_err_code := 1;
			lv_err_msg := lv_err_msg || '1.10.5 Error In getting the document id seq, '||'Error Message'||SUBSTR(SQLERRM,1,500);
            lt_project_attach_tab(idx).STATUS := lv_error;
            lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
         END;
		 debug_log('1.100.5   ln_document_id: '||ln_document_id);
		 -- Getting the getting the nedia_id from seq from seq
	    BEGIN
            SELECT fnd_documents_short_text_s.NEXTVAL
              INTO ln_media_id 
			FROM dual;
         EXCEPTION
           WHEN OTHERS THEN
             debug_log('1.10.6 Error In getting media id number seq'||'Error Message'||SUBSTR(SQLERRM,1,500));
			 x_err_code := 1;
			 lv_err_msg := lv_err_msg || '1.10.6 Error In getting the media id number seq, '||'Error Message'||SUBSTR(SQLERRM,1,500);
             lt_project_attach_tab(idx).STATUS := lv_error;
             lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
        END;
		debug_log('1.100.6   ln_media_id: '||ln_media_id);
		-- Getting the attached documents document_id from seq
		BEGIN
           SELECT fnd_attached_documents_s.NEXTVAL 
		     INTO ln_attached_doc_id 
		    FROM dual;
        EXCEPTION
         WHEN OTHERS THEN
             debug_log('1.10.7 Unable to get fnd attached documents next value'||'Error Message'||SUBSTR(SQLERRM,1,500));
			 x_err_code := 1;
			 lv_err_msg := lv_err_msg || '1.10.7 Error In getting the media id number seq, Error Message'||SUBSTR(SQLERRM,1,500);
             lt_project_attach_tab(idx).STATUS := lv_error;
             lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
        END;
		 debug_log('1.100.7   ln_attached_doc_id: '||ln_attached_doc_id);
         debug_log('1.10.8 Document_id Seq Number:'||ln_document_id||','||ln_seq_num);

         lv_entity_name:= lt_project_attach_tab(idx).ATTACHMENT_LEVEL;
         lv_description:= lt_project_attach_tab(idx).ATTACH_DESCRIPTION;
		 IF lt_project_attach_tab(idx).ATTACHMENT_LEVEL = 'PA_PROJECTS'
		  THEN
           lv_pk1_value:= lt_project_attach_tab(idx).PROJECT_ID;
		 ELSIF lt_project_attach_tab(idx).ATTACHMENT_LEVEL = 'PA_AGREEMENTS'
          THEN		 
		   lv_pk1_value:= lt_project_attach_tab(idx).AGREEMENT_ID;
         END IF;  		   
           lv_title:= lt_project_attach_tab(idx).ATTACH_TITLE;
        -- IF lt_project_attach_tab(idx).STATUS <> lv_error THEN
		 debug_log('Calling the API..');


           fnd_documents_pkg.insert_row(x_rowid            => lv_rowid,
                                        x_document_id       => ln_document_id,
                                        x_creation_date     => sysdate,
                                        x_created_by        => ln_user_id,
                                        x_last_update_date  => sysdate,
                                        x_last_updated_by   => ln_user_id,
                                        x_last_update_login => ln_user_id,
                                        x_datatype_id       => ln_datatype_id,
                                        x_category_id       => ln_category_id,
                                        x_security_type     => ln_security_type,
                                        x_publish_flag      => 'Y',
                                        x_usage_type        => 'O',
                                        x_language          => USERENV('LANG'),
                                        x_description       => LV_DESCRIPTION,
                                        x_file_name         => NULL,
                                        x_title             => lv_title,
                                        x_media_id          => ln_media_id);

             debug_log('End of fnd_documents_pkg.insert_row API..');

            fnd_documents_pkg.insert_tl_row(x_document_id       => ln_document_id,
                                           x_creation_date     => sysdate,
                                           x_created_by        => ln_user_id,
                                           x_last_update_date  => sysdate,
                                           x_last_updated_by   => ln_user_id,
                                           x_last_update_login => ln_user_id,
                                           x_language          => USERENV('LANG'),
                                           x_description       => LV_DESCRIPTION
            );


             debug_log('End of fnd_documents_pkg.insert_tl_row API..');
		    fnd_attached_documents_pkg.insert_row(lv_rowid,
                                                  ln_attached_doc_id,
                                                  ln_document_id,
                                                  SYSDATE,
                                                  ln_user_id,
                                                  SYSDATE,
                                                  ln_user_id,
                                                  fnd_profile.VALUE('LOGIN_ID'),
                                                  ln_seq_num,
                                                  lv_entity_name,
                                                  x_column1,
                                                  lv_pk1_value,
                                                  x_pk2_value,
                                                  x_pk3_value,
                                                  x_pk4_value,
                                                  x_pk5_value,
                                                  'N',
												  x_request_id,
												  X_program_application_id,
												  X_program_id,												  
												  SYSDATE,
												  lv_attribute_category,
												  lv_attribute1,
												  lv_attribute2,
												  lv_attribute3,
												  lv_attribute4,
												  lv_attribute5,
												  lv_attribute6,
												  lv_attribute7,
												  lv_attribute8,
												  lv_attribute9,
												  lv_attribute10,
												  lv_attribute11,
												  lv_attribute12,
												  lv_attribute13,
												  lv_attribute14,
												  lv_attribute15,
												   /*columns necessary for creating a document on the fly */
                                                  ln_datatype_id,
                                                  ln_category_id,
                                                  ln_security_type,
                                                  NULL,--X_security_id, 
                                                  'Y',
												  NULL,--X_image_type,
												  NULL,--X_storage_type,
												  NULL,--X_usage_type,
                                                  USERENV('LANG'),
                                                  lv_description,
                                                  NULL,
                                                  ln_media_id,
												  x_doc_attribute_category,
												  x_doc_attribute1,
												  x_doc_attribute2,
												  x_doc_attribute3,
												  x_doc_attribute4,
												  x_doc_attribute5,
												  x_doc_attribute6,
												  x_doc_attribute7,
												  x_doc_attribute8,
												  x_doc_attribute9,
												  x_doc_attribute10,
												  x_doc_attribute11,
												  x_doc_attribute12,
												  x_doc_attribute13,
												  x_doc_attribute14,
												  x_doc_attribute15,
												  'N',--X_create_doc
												   NULL,--X_url
                                                   NULL,--X_title
                                                   NULL,--X_dm_node
                                                   NULL,--X_dm_folder_path
                                                   NULL,--X_dm_type
                                                   NULL,--X_dm_document_id
                                                   NULL,--X_dm_version_number
                                                   NULL,--X_orig_doc_id
                                                   NULL--X_orig_attach_doc_id    
												  );
			debug_log('End of fnd_attached_documents_pkg.insert_row API');
			--debug_log('ALL API are executed');
            COMMIT;

            BEGIN
			    debug_log('Create Short Text..');
                INSERT INTO fnd_documents_short_text VALUES (ln_media_id,lv_short_text,NULL);
			    COMMIT;
				lt_project_attach_tab(idx).STATUS := lv_success; --ADDED BY SOWMYA 
            EXCEPTION
              WHEN OTHERS THEN
                debug_log('1.10.9 Error in inserting data into fnd_documents_short_text table, '||SUBSTR(SQLERRM,1,500));
				lv_err_msg := lv_err_msg || '1.10.9 Error in inserting data into fnd_documents_short_text table, '||SUBSTR(SQLERRM,1,500);
                lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
                lt_project_attach_tab(idx).STATUS := lv_error;
				x_err_code := 1;
            END;
		--  END IF; --lt_project_attach_tab(idx).STATUS	
        END IF;
        debug_log('End of Create Short text..');

     EXCEPTION
        WHEN OTHERS THEN
          debug_log('1.11.0 Error in starting begin, '||SUBSTR(SQLERRM,1,500));
		  lv_err_msg := lv_err_msg || '1.11.0 Error in starting begin, '||SUBSTR(SQLERRM,1,500);
          lt_project_attach_tab(idx).MESSAGE:=  lv_err_msg;
          lt_project_attach_tab(idx).STATUS := lv_error;
		  x_err_code := 1;
     END ;
   END LOOP;

   gn_ttl_sucess_rec_cnt := lt_project_attach_tab.COUNT;
   debug_log(   '529 gn_ttl_sucess_rec_cnt: '||gn_ttl_sucess_rec_cnt);
   IF lt_project_attach_tab.COUNT > 0 THEN

       BEGIN

        FORALL ln_ins_cnt IN 1 .. lt_project_attach_tab.COUNT SAVE EXCEPTIONS
           UPDATE XXPA.XXPA_PROJECT_ATTACHMENTS_STG
              SET message    = message||' '||SUBSTR(lt_project_attach_tab(ln_ins_cnt).message,1
                              ,LENGTH(lt_project_attach_tab(ln_ins_cnt).message)-2) ,
                  status     = lt_project_attach_tab(ln_ins_cnt).status                  
                 --batch_id  = ln_request_id
            WHERE record_id = lt_project_attach_tab(ln_ins_cnt).record_id --ROWID      = lt_task_comm_split_tmp_tab(ln_ins_cnt).rid --Added on 14-Jan-2021 by iriqwm
            ;

         IF SQL%ROWCOUNT > 0 THEN
          debug_log(   '1.9.0 No.of Records updated: '||SQL%ROWCOUNT);
          COMMIT;
         ELSE
          debug_log(   '1.9.1 No.of Records updated: '||SQL%ROWCOUNT);
         END IF;

       EXCEPTION
        WHEN failure_in_forall THEN
         debug_log('1.9.2 error '||SQLERRM);

         FOR I IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
             ln_err_idx   := SQL%BULK_EXCEPTIONS(i).error_index;
             ln_err_code  := SQL%BULK_EXCEPTIONS(i).error_code;
             lv_err_msg   := 'Oracle error is '  || SQLERRM ( -1 * SQL%BULK_EXCEPTIONS (i).ERROR_CODE);
         END LOOP;
        ROLLBACK;
       WHEN OTHERS THEN
         debug_log('1.9.5 error '||SQLERRM);
         RAISE;
		  IF lv_err_msg is not null then --rahman
    x_err_msg   := lv_err_msg ;
    END IF;

       END;

    END IF;       
 EXCEPTION
   WHEN OTHERS THEN
    debug_log('2.0 Exception in '||gv_package||lv_proc||' procedure.');
    x_err_code  := 1;
    x_err_msg   := SQLERRM;
    xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, x_err_msg);--Added for 31900
 END xx_create_short_text_attachments;

 --Procedure to put on output file
 PROCEDURE print_output(p_validate_import IN VARCHAR2)
 IS
  ln_ttl_rec_cnt     NUMBER;
  ln_ttl_val_rec_cnt NUMBER;
  ln_ttl_err_rec_cnt NUMBER;
  ln_ttl_sucess_rec_cnt NUMBER;
  ln_ttl_inv_rec_cnt  NUMBER;
 BEGIN
    SELECT count(1)
     INTO ln_ttl_rec_cnt
    FROM XXPA.XXPA_PROJECT_ATTACHMENTS_STG
    where batch_id = g_batch_id
    ;

    SELECT SUM(CASE WHEN status='VALID' THEN 1 ELSE 0 END) -- Changed V as VAILD as per CR24599
          ,SUM(CASE WHEN status='INVALID' THEN 1 ELSE 0 END) -- Changed E as INVAILD as per CR24599
          ,SUM(CASE WHEN status='SUCCESS' THEN 1 ELSE 0 END) -- Changed S as SUCESS as per CR2459
		  ,SUM(CASE WHEN status='ERROR' THEN 1 ELSE 0 END)
     INTO ln_ttl_val_rec_cnt,
	      ln_ttl_inv_rec_cnt,
          ln_ttl_sucess_rec_cnt,
		  ln_ttl_err_rec_cnt
    FROM XXPA.XXPA_PROJECT_ATTACHMENTS_STG
    where batch_id = g_batch_id
    ;
    IF UPPER(p_validate_import) <> 'VALIDATE AND IMPORT'
     THEN
	  ln_ttl_err_rec_cnt := 0;
      ln_ttl_sucess_rec_cnt := 0;
    ELSIF UPPER(p_validate_import) = 'VALIDATE AND IMPORT'
     THEN
      ln_ttl_val_rec_cnt := 0;
	-- ln_ttl_inv_rec_cnt := 0;
   --NULL ;
    END IF;

   xx_pk_fnd_file.put_line(fnd_File.output,'*******Convert/Load Project Attachment data in Custom Table - XXPA4432******');
   xx_pk_fnd_file.put_line(fnd_File.output,'Total Records           : '|| ln_ttl_rec_cnt);
   xx_pk_fnd_file.put_line(fnd_File.output,'Total Error Records     : '|| ln_ttl_err_rec_cnt); 
   xx_pk_fnd_file.put_line(fnd_File.output,'Total Valid Records     : '|| ln_ttl_val_rec_cnt);
   xx_pk_fnd_file.put_line(fnd_File.output,'Total Invalid Records   : '|| ln_ttl_inv_rec_cnt);
   xx_pk_fnd_file.put_line(fnd_File.output,'Total Success Records   : '|| ln_ttl_sucess_rec_cnt);
EXCEPTION
  WHEN OTHERS THEN
   xx_pk_fnd_file.put_line(fnd_File.output,'Exception in print_output procedure '|| SQLERRM);
 END print_output;

PROCEDURE Update_Duplicate_data(P_Batch_id in Number,p_mode in VARCHAR2)
IS
l_stmt VARCHAR2(10);
BEGIN
  l_stmt := '10.0';
	IF p_mode = 'DUPLICATE' THEN

		UPDATE (SELECT t.*
			FROM XXPA.xxpa_project_attachments_stg t
			WHERE  batch_id = p_batch_id
			AND ATT_PROJ_AG_REFERENCE in (SELECT ATT_PROJ_AG_REFERENCE
			FROM (SELECT ATT_PROJ_AG_REFERENCE, ATTACH_NOTES,ATTACH_CATEGORY, COUNT(*)
			FROM XXPA.xxpa_project_attachments_stg t2 WHERE t2.batch_id = t.batch_id
			GROUP BY ATT_PROJ_AG_REFERENCE, ATTACH_NOTES,ATTACH_CATEGORY
			HAVING COUNT(*) > 1) t3
		  )
		  )
		  t4
		SET status = 'INVALID',message = 'Duplicate records in file for combination of project/agreement ref, attachment notes, attachment category :'
		;
		debug_log(   l_stmt||' : '||'No of records Update  - '||sql%rowcount);
	END IF;
  l_stmt := '10.1';
	IF p_mode = 'REPROCESS'  THEN  
			UPDATE (SELECT t.*
				FROM XXPA.xxpa_project_attachments_stg t
				WHERE batch_id = p_batch_id
				AND t.status = 'INVALID'
				AND EXISTS (SELECT ATT_PROJ_AG_REFERENCE
				FROM (SELECT ATT_PROJ_AG_REFERENCE, ATTACH_NOTES,ATTACH_CATEGORY
				FROM XXPA.xxpa_project_attachments_stg t2 WHERE t2.ATT_PROJ_AG_REFERENCE = t.ATT_PROJ_AG_REFERENCE
				AND t2.ATTACH_NOTES = nvl(t.ATTACH_NOTES,t2.ATTACH_NOTES)
				AND t2.ATTACH_CATEGORY = t.ATTACH_CATEGORY
				AND t2.batch_id <> t.batch_id
				AND t2.status = 'INVALID'
			) t3
			)
			)
			t4
		SET status = 'INVALID',message = 'Combination of Project/Agreement Ref, Attachment Notes , Attachment Category already exists.';
		debug_log(   l_stmt||' : '||'No of records Update  - '||sql%rowcount);
	END IF;	
EXCEPTION
		WHEN OTHERS THEN
			 debug_log(   l_stmt ||' : '||'868 Inside Procedure Update_Duplicate_data|| SQLERRM.'||SQLERRM);

COMMIT;
END Update_Duplicate_data;

--ended to Defect ID : 31964 prevent Duplicate record with combination of project number,task number,prog org and sales person name

--Added to Defect ID : 31964 - This procedure is used to delete old records with the same batch from the exception table, it will be called at the begining of the program
/*
  **  Object Name:        delete_error_rec
  **  Description: This procedure is used to delete old records with the same batch from the exception table, it will be called at the begining of the program
  **  Parameters:  in_batch_id =Batch ID to run the program
  **  Run as:      APPS
  **  Keyword Tracking:
  */
 PROCEDURE delete_error_rec(in_batch_id IN NUMBER) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    DELETE FROM XXPA.XXPA_PROJECT_ATTACHMENTS_STG WHERE STATUS = 'INVALID' and batch_id <> in_batch_id;


    --  IF SQL%ROWCOUNT > 0 THEN
    xxctq_util_pkg.log_message('Deleted Error description details from Error table are: ' ||
                               SQL%ROWCOUNT);
    COMMIT;
    --  END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      xxctq_util_pkg.log_message('UnExpected Error Occured while Deleting Old Errors : . ' ||
                                 SQLERRM);
  END;

 --ENDED to Defect ID : 31964 - This procedure is used to delete old records with the same batch from the exception table, it will be called at the begining of the program

 PROCEDURE main (x_errbuf           OUT VARCHAR2,
                 x_retcode          OUT NUMBER,
                 p_org_id           IN NUMBER,
                 p_submit_loader    IN VARCHAR2,--Added for Defect 31900
                 p_is_submit_loader IN VARCHAR2,--Added for Defect 31900
                 p_file_path        IN VARCHAR2,
                 p_file             IN VARCHAR2,
                 p_batch_id         IN NUMBER,--Added for Defect 31900
                 p_validate_import  IN VARCHAR2,--Added for Defect 31900
                 p_email            IN VARCHAR2,
                 p_debug_flag       IN VARCHAR2
                )
   /*******************************************************************************
   ** Name:   main
   ** Description: Main procedure for Credit Receivers Load conversion
   ** Parameters:
   **            x_errbuf - To sent concurrent program error message
   **            x_retcode - To send the concurrent program status
   **            p_submit_loader - To Submit Loader
   **            p_batch_id - Batch id of the data to be processed
   **            p_validate_import - VALIDATE - Only validate/translate the data
                                     VALIDATE AND IMPORT - translate/validate the
                                     data and import into R12 tables
   **            p_email - Send CC email regarding the status
   **            p_debug_flag - TO print the log messages
   *******************************************************************************/
 IS

    lv_rep_retcode         NUMBER; -- Added as part of CR24599
    lv_mail_server         VARCHAR2(200);
    lv_msg_body            VARCHAR2(4000);
    ln_request_id          NUMBER :=fnd_profile.value('CONC_REQUEST_ID');
    ln_user_id             NUMBER :=fnd_profile.value('USER_ID');
    lv_email_address       VARCHAR2(240);
    ln_error               NUMBER;
    lv_err_mesg            VARCHAR2(500);
    lv_err_msg             VARCHAR2(4500);
    lv_attachment          ALL_DIRECTORIES.DIRECTORY_PATH%TYPE := NULL;
    lv_other_mesg          VARCHAR2(4000);
    lv_err_code            VARCHAR2(100);
    lv_rep_errorbuf        VARCHAR (2000);   -- Added as part of CR24599

 BEGIN

   g_debug_flag :=  p_debug_flag;

   --Added for Defect 31900 START
   g_batch_id := p_batch_id;
   gn_request_id      := fnd_global.conc_request_id;

   --p_batch_id := gn_request_id; -- Assigning request to batch id - since we are submitting the porgrams individually old batch id conecpt will not work

   debug_log('0.0.0 -p_batch_id-'||p_batch_id);
   debug_log('0.0.1 Concurrent Request : '||gn_request_id);
   debug_log('0.0.2 Process Mode       : '||p_validate_import);
   debug_log('0.0.3 Debug Flag         : '||p_debug_flag);
   debug_log('0.0.4 Email Address      : '||p_email);

  --debug_log('782 p_submit_loader : '||p_submit_loader);
  /*IF nvl(p_submit_loader,'N') = 'Y'
    THEN
    load_data (p_file_path,p_file,p_email,lv_other_mesg,lv_err_code);
   END IF;*/
   --debug_log('Batch Id           : '||g_batch_id);
   IF p_batch_id IS NULL
    THEN
    BEGIN
      SELECT DISTINCT batch_id
      INTO g_batch_id
      FROM XXCTQ.XXCTQ_FILE_LOAD_TRACKER
       WHERE batch_id = (SELECT MAX(request_id) FROM fnd_concurrent_requests a,fnd_concurrent_programs_vl b
                          WHERE a.concurrent_program_id = b.concurrent_program_id 
						    AND b.concurrent_program_name = 'XXCTQ_PA4432_LOADER');

-- g_batch_id := gn_request_id;
    EXCEPTION
    WHEN OTHERS THEN
     debug_log('Error getting batch_id..'||sqlerrm);
    END;
   END IF;
	   --Deleting invalid records
	delete_error_rec (g_batch_id);       --Added to Defect ID : 31964
	--Update_Duplicate_data procedure calling to update duplicate records
	Update_Duplicate_data(g_batch_id,'DUPLICATE');   --Added to Defect ID : 31964

   -- select max(batch_id) into g_batch_id from  XXPA_PROJECT_ATTACHMENTS_STG where status='NEW'; -- rahman
      debug_log('0.0.5 g_batch_id : '||g_batch_id);

   --Start Status Monitor procedure Initiates Status tracking.
   xxctq_util_pkg.start_status_monitor (g_batch_id ,gn_request_id,gv_conv_name);
   --Added for Defect 31900 END

   debug_log('0.0.6 gn_request_id : '||gn_request_id);
    IF lv_other_mesg IS NULL
     THEN
      debug_log('0.0.7 Calling :xx_process_attachments_data');
      xxctq_util_pkg.update_status_monitor (g_batch_id, gn_request_id, gv_conv_name, 'Validation Began');
      xx_process_attachments_data(g_batch_id,lv_err_code,lv_other_mesg);
      xxctq_util_pkg.update_status_monitor (g_batch_id, gn_request_id, gv_conv_name, 'Validation completed');
    END IF;

    debug_log ('0.0.8 xx_process_attachments_data :Error Code '||lv_err_code);
    debug_log ('0.0.9 xx_process_attachments_data :Error Message '||lv_other_mesg);
	--Update_Duplicate_data procedure calling to update duplicate records
	Update_Duplicate_data(g_batch_id,'REPROCESS');   --Added to Defect ID : 31964
    IF lv_other_mesg IS NULL
     THEN
      debug_log('0.1.0 Calling :xx_create_short_text_attachments');

      xxctq_util_pkg.update_status_monitor (g_batch_id, gn_request_id, gv_conv_name, 'R12 Insert Began');
      IF UPPER(p_validate_import) = 'VALIDATE AND IMPORT'
       THEN
      xx_create_short_text_attachments(g_batch_id,lv_err_code,lv_other_mesg);
      END IF;
      xxctq_util_pkg.update_status_monitor (g_batch_id, gn_request_id, gv_conv_name, 'R12 Insert Completed');

     debug_log ('828 xx_create_short_text_attachments :Error Code '||lv_err_code);
     debug_log ('829 xx_create_short_text_attachments :Error Message '||lv_other_mesg);

    END IF;

    print_output(p_validate_import);
    xxctq_util_pkg.end_status_monitor (g_batch_id, gn_request_id, gv_conv_name);

  BEGIN

   SELECT NVL (vals.parameter_value, param_b.default_parameter_value)
     INTO lv_mail_server
     FROM fnd_svc_components comp
        , fnd_svc_comp_params_b param_b
        , fnd_svc_comp_param_vals vals
    WHERE comp.component_type       = 'WF_MAILER'
      AND param_b.component_type    = comp.component_type
      AND parameter_name            = 'OUTBOUND_SERVER'
      AND COMPONENT_STATUS          = 'RUNNING'
      AND param_b.parameter_id      = vals.parameter_id
      AND comp.component_id         = vals.component_id;
  EXCEPTION
  WHEN OTHERS THEN
    lv_mail_server := NULL;
    debug_log ('852 Mail Server is not up and running, Unable to send the report to email');
    xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, '0.7 Mail Server is not up and running, Unable to send the report to email');--Added for 31900
  END;

 BEGIN
  IF p_email is not null then
  lv_email_address := p_email;
  ELSE
    SELECT email_address
  INTO lv_email_address
  FROM fnd_user
  WHERE user_id =ln_user_id;
  END IF;
  EXCEPTION
   WHEN OTHERS THEN
    lv_email_address := NULL;
    debug_log ('0.8 Application User does not have email address configured, Unable to send the report to email');
    xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, '0.8 Application User does not have email address configured, Unable to send the report to email');--Added for 31900
  END;

    SELECT count(1)
     INTO gn_ttl_rec_cnt
    FROM XXPA.XXPA_PROJECT_ATTACHMENTS_STG
    where batch_id = g_batch_id
    ;

    SELECT SUM(CASE WHEN status='VALID' THEN 1 ELSE 0 END)
          ,SUM(CASE WHEN status='INVALID' THEN 1 ELSE 0 END)
          ,SUM(CASE WHEN status='SUCCESS' THEN 1 ELSE 0 END)
     INTO gn_ttl_val_rec_cnt,
          gn_ttl_err_rec_cnt,
          gn_ttl_sucess_rec_cnt
    FROM XXPA.XXPA_PROJECT_ATTACHMENTS_STG
    where batch_id = g_batch_id
    ;

    IF UPPER(p_validate_import) <> 'VALIDATE AND IMPORT'
     THEN
      gn_ttl_sucess_rec_cnt := 0;

             lv_msg_body :='********************Credit Receiver Load********************'||
 chr(10)||'-------------------- VALIDATE MODE --------------------'||         --Added for CR24599
                              chr(10)||'Total Records                    '||':'||gn_ttl_rec_cnt||
                              chr(10)||'Total Error Records          '||':'||0||
                              chr(10)||'Total Valid Records          '||':'||gn_ttl_val_rec_cnt||
                              chr(10)||'Total Invalid Records       '||':'||gn_ttl_err_rec_cnt||
                              chr(10)||'Total Success Records     '||':'||0;


    ELSIF UPPER(p_validate_import) = 'VALIDATE AND IMPORT'
     THEN
      gn_ttl_val_rec_cnt := 0;

      lv_msg_body :='********************Credit Receiver Load********************'||

                              chr(10)||'--------------- VALIDATE AND IMPORT ----------------------'|| --Added for CR24599
                              chr(10)||'Total Records                    '||':'||gn_ttl_rec_cnt||
                              chr(10)||'Total Error Records          '||':'||gn_ttl_err_rec_cnt||
                              chr(10)||'Total Valid Records          '||':'||gn_ttl_val_rec_cnt||
                              chr(10)||'Total Invalid Records       '||':'||0||
                              chr(10)||'Total Success Records     '||':'||gn_ttl_sucess_rec_cnt;

    END IF;

   /* IF lv_mail_server IS NOT NULL or lv_email_address IS NOT NULL THEN  -- Commeneted As part Of CR24599

         /*   lv_msg_body :='********************Credit Receiver Load********************'||
                              chr(10)||'Total Records                    '||':'||gn_ttl_rec_cnt||
                              chr(10)||'Total Error Records          '||':'||gn_ttl_err_rec_cnt||
                              chr(10)||'Total Valid Records          '||':'||gn_ttl_val_rec_cnt||
                              chr(10)||'Total Success Records     '||':'||gn_ttl_sucess_rec_cnt; */ -- rahman

        /*send_mail(  p_to        => lv_email_address,
                    p_from      => 'no-replay@contractor.tranetechnologies.com',
                    p_subject   => 'Credit Receiver Loader Error / Success Report# for Request ID #'||ln_request_id||' Run Mode: Validate and Import',
                    p_message   => lv_msg_body,
                    p_smtp_host => lv_mail_server
                );
        */
        /* ln_error := xx_pk_email.f_send_email(   sender       => 'donotreply@tranetechnologies.com',
                                                recipient    => lv_email_address,
                                                ccrecipient  => null,
                                                subject      => 'XXPA Load Credit Receivers Program Success/Error Report# for Request ID #'||ln_request_id||' Run Mode: '||p_validate_import,
                                                BODY         => lv_msg_body,
                                                errormessage => lv_err_mesg,
                                                attachments  => lv_attachment
                                            );
    ELSE

        debug_log ('0.9 Mail Server is not up and running / EMAIL Not configured, Unable to send the status email!');

    END IF; */
    --Added as part of CR24599
    debug_log ('1063'||lv_rep_errorbuf);
    debug_log ('1064'||lv_rep_retcode);
    debug_log ('1065'||g_batch_id);
    debug_log ('1066'||gv_ctq_data_set);
    debug_log ('1067'||gn_request_id);
    debug_log ('1068'||lv_email_address);
      BEGIN
         debug_log
            ('*****************************Error Extraction for Projects....');
         debug_log ('');
         debug_log ('');
         debug_log ('');
         debug_log ('');
         debug_log ('');
         xxctq_util_pkg.xxctq_error_extract (lv_rep_errorbuf,
                                             lv_rep_retcode,
                                             g_batch_id,
                                             gv_ctq_data_set,
                                             gn_request_id,
                                             lv_email_address
                                            );
         debug_log
                ('*****************************Error Extraction Completed....');
      END; 

 EXCEPTION
  WHEN OTHERS THEN
     debug_log ('1090 EXCEPTION IN MAIN procedure. '||SQLERRM);
     lv_err_msg:= '1091 EXCEPTION IN MAIN procedure. '||SQLERRM;
     xxctq_util_pkg.error_insert_proc (gv_conv_name, g_batch_id, NULL, lv_err_msg);
 END main;
END xxpa4432_project_attach_pkg;
/
Show error