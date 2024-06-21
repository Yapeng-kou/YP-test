CREATE OR REPLACE PACKAGE BODY XXAP_GRNI_REP_PKG_WRAPPER AS
  /*********************************************************
  ** Title:     Demonstrate creating a custom package header
  ** File:      XXAP_GRNI_REP_PKG_WRAPPER.pkb
  ** Description: This script creates a package header
  ** Parameters:  {None.}
  ** Run as:     APPS
  ** Keyword Tracking:
  **   
  **   $Header: xxap/12.0.0/patch/115/sql/XXAP_GRNI_REP_PKG_WRAPPER.pkb 1.2 05-JUN-2019 07:38:51 CCCGCW$
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.2 (COMPLETE)
  **     Created:  05-JUN-2019 07:38:51      CCCGCW (Harshil Shah)
  **       Reverted the changes for the parent program to wait for child
  **       programs completion for CR8035.
  **       The parent program will complete immediately and in its log file it
  **       will display the 
  **       no. of child programs triggered and also their request ID's
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  29-MAY-2019 10:56:17      CCCGCW (Harshil Shah)
  **       Added the changes so that parent request completes only after all
  **       the child requests are completed for CR8035
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  10-APR-2019 12:11:04      CCBNLW (Raju Patel)
  **       CR#8035-Multiple chnages
  **   
  **
  ** History:
  ** Date        Who           Description
  ** -----------   ------------------ ------------------------------------------------------------
  ** 05-Sep-2012   Raju Patel         Create CR#8035
  ** 23-May-2019   Harshil Shah		  Changes for CR8035 for ensuring that parent/master program 
  **								  completes only after all the child programs are completed 
  ** 05-Jun-2019   Harshil Shah		  CR8035 - Removed the changes for the master program to wait for the child program,
									  as it may lead to resource contention issues
  ************************************************************************************************/
  g_gl_application_id CONSTANT NUMBER := 101;
  g_po_application_id CONSTANT NUMBER := 201;

  ------------------------------------------------------------------------------
  -- PROCEDURE  :  Start_Process
  -- DESCRIPTION  :  Program to call the XXAP GRNI Report program
  ------------------------------------------------------------------------------
  PROCEDURE start_process(errbuf                        OUT NOCOPY VARCHAR2,
                          retcode                       OUT NOCOPY NUMBER,
                          p_title                       IN VARCHAR2,
                          p_org_name                    IN VARCHAR2,
                          p_accrued_receipts            IN VARCHAR2,
                          p_inc_online_accruals         IN VARCHAR2,
                          p_inc_closed_pos              IN VARCHAR2,
                          p_struct_num                  IN NUMBER,
                          p_category_from               IN VARCHAR2,
                          p_category_to                 IN VARCHAR2,
                          p_min_accrual_amount          IN NUMBER,
                          p_period_name                 IN VARCHAR2,
                          P_location                    IN VARCHAR2,
                          p_vendor_from                 IN VARCHAR2,
                          p_vendor_to                   IN VARCHAR2,
                          p_orderby                     IN NUMBER,
                          p_qty_precision               IN NUMBER,
                          p_exclude_receipt_matched     IN VARCHAR2,
                          p_exclude_matched_consignment IN VARCHAR2,
                          p_exclude_po_matched          IN VARCHAR2,
                          p_run_data_fix                IN VARCHAR2) IS
  
    l_return_status VARCHAR2(1);
  
    l_return BOOLEAN;
  
    l_application_id        NUMBER;
    l_legal_entity          NUMBER;
    l_end_date              DATE;
    l_sob_id                NUMBER;
    l_current_org_id        NUMBER;
    l_order_by              VARCHAR2(15);
    l_row_count             NUMBER;
    l_accrual_currency_code fnd_currencies.currency_code%TYPE;
    l_extended_precision    fnd_currencies.extended_precision%TYPE;
    l_user_id               number := fnd_global.user_id;
    l_responsibility_id     number := FND_GLOBAL.RESP_ID;
    l_resp_appl_id          number := FND_GLOBAL.RESP_APPL_ID;
    l_access                varchar2(5);
    l_org_name              varchar2(1000); --added by Raju
    ln_new_request_id       NUMBER;
    lc_boolean2             BOOLEAN;

-- Added the below variables for CR8035 for ensuring that parent/master program completes only after all the child programs are completed	
	ln_counter				NUMBER := 0;
	lb_complete				BOOLEAN;	
	lc_phase				VARCHAR2(100);
	lc_status				VARCHAR2(100);
	lc_dev_phase			VARCHAR2(100);
	lc_dev_status			VARCHAR2(100);
	lc_message				VARCHAR2(100);	
  
  BEGIN
  
    -- EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
  
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_user_id : ' || l_user_id);
  
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_responsibility_id : ' || l_responsibility_id);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_resp_appl_id : ' || l_resp_appl_id);
  
    --  fnd_global.apps_initialize(6711, 54518, 200);
    IF p_org_name is NOT NULL THEN
    
      BEGIN
	  
		ln_counter := ln_counter + 1;		-- Added for CR8035 to ensure that parent/master program completes only after all the child programs are completed	  
      
        --Set Layout
        lc_boolean2 := fnd_request.add_layout(template_appl_name => 'XXAP',
                                              template_code      => 'XXAP1492',
                                              template_language  => 'en', --Use language from template definition
                                              template_territory => 'US', --Use territory from template definition
                                              output_format      => 'EXCEL' --Use output format from template definition
                                              );
      
        --calling XXAP GRNI Custom Report (XXAP GRNI Custom Report)
        ln_new_request_id := fnd_request.submit_request(application => 'XXAP',
                                                        program     => 'XXAP1492',
                                                        description => 'XXAP GRNI Custom Report',
                                                        start_time  => SYSDATE,
                                                        sub_request => FALSE,
                                                        argument1   => p_title,
                                                        argument2   => p_org_name,
                                                        argument3   => p_accrued_receipts,
                                                        argument4   => p_inc_online_accruals,
                                                        argument5   => p_inc_closed_pos,
                                                        argument6   => p_struct_num,
                                                        argument7   => p_category_from,
                                                        argument8   => p_category_to,
                                                        argument9   => p_min_accrual_amount,
                                                        argument10  => p_period_name,
                                                        argument11  => p_location,
                                                        argument12  => p_vendor_from,
                                                        argument13  => p_vendor_to,
                                                        argument14  => p_orderby,
                                                        argument15  => p_qty_precision,
                                                        argument16  => p_exclude_receipt_matched,
                                                        argument17  => p_exclude_matched_consignment,
                                                        argument18  => p_exclude_po_matched,
                                                        argument19  => p_run_data_fix);
														
		gv_child_request(ln_counter).child_request_id := ln_new_request_id;			-- Added for CR8035 to ensure that parent/master program completes only after all the child programs are completed
      
      EXCEPTION
        WHEN OTHERS THEN
          xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                                  'Exception occurred while calling the XXAP GRNI Custom Report)' ||
                                  SQLERRM);
      END;
    
    ELSE
    
      mo_global.init('M');
    
      for cur_org in (select distinct o.NAME, o.organization_id
                        from hr_operating_units o
                       where mo_global.check_access(O.ORGANIZATION_ID) = 'Y') LOOP
      
        l_access := mo_global.check_access(cur_org.organization_id);
      
        if l_access = 'Y' then
        
          l_org_name := cur_org.NAME;
        
          xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                                  'l_access : ' || l_access || ' for org ' ||
                                  l_org_name);
        END IF;
		
		ln_counter := ln_counter + 1;		-- Added for CR8035 to ensure that parent/master program completes only after all the child programs are completed
		
        BEGIN
        
          lc_boolean2 := fnd_request.add_layout(template_appl_name => 'XXAP',
                                                template_code      => 'XXAP1492',
                                                template_language  => 'en', --Use language from template definition
                                                template_territory => 'US', --Use territory from template definition
                                                output_format      => 'EXCEL' --Use output format from template definition
                                                );
        
          --calling XXAP GRNI Custom Report (XXAP GRNI Custom Report)
        
          ln_new_request_id := fnd_request.submit_request(application => 'XXAP',
                                                          program     => 'XXAP1492',
                                                          description => 'XXAP GRNI Custom Report',
                                                          start_time  => SYSDATE,
                                                          sub_request => FALSE,
                                                          argument1   => p_title,
                                                          argument2   => l_org_name,
                                                          argument3   => p_accrued_receipts,
                                                          argument4   => p_inc_online_accruals,
                                                          argument5   => p_inc_closed_pos,
                                                          argument6   => p_struct_num,
                                                          argument7   => p_category_from,
                                                          argument8   => p_category_to,
                                                          argument9   => p_min_accrual_amount,
                                                          argument10  => p_period_name,
                                                          argument11  => p_location,
                                                          argument12  => p_vendor_from,
                                                          argument13  => p_vendor_to,
                                                          argument14  => p_orderby,
                                                          argument15  => p_qty_precision,
                                                          argument16  => p_exclude_receipt_matched,
                                                          argument17  => p_exclude_matched_consignment,
                                                          argument18  => p_exclude_po_matched,
                                                          argument19  => p_run_data_fix);
														  
			gv_child_request(ln_counter).child_request_id := ln_new_request_id;			-- Added for CR8035 to ensure that parent/master program completes only after all the child programs are completed
        
        EXCEPTION
          WHEN OTHERS THEN
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                                    'Exception occurred while calling the XXAP GRNI Custom Report)' ||
                                    SQLERRM);
        END;
      
      END LOOP;	  
    
    END IF;
	
	xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'No. of child requests triggerred : '||ln_counter);
	
	-- Change starts for CR8035 to display all the child request ID's	
	FOR i in gv_child_request.FIRST .. gv_child_request.LAST 
	LOOP
		
		xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'Child request '||i||' is '||gv_child_request(i).child_request_id);
		
-- Commented the below logic for WAIT, as it may lead to resource contention issues in Prod		
/*		
		WHILE(lc_dev_phase <> 'COMPLETE')
		LOOP
			lb_complete :=  fnd_concurrent.wait_for_request 
														  (request_id      => gv_child_request(i).child_request_id
														  ,interval        => 5
														  ,max_wait        => 60
														  ,phase           => lc_phase	
														  ,status          => lc_status	
														  ,dev_phase       => lc_dev_phase
														  ,dev_status      => lc_dev_status
														  ,message         => lc_message);											  
														  
			COMMIT;	
			
			xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'lc_dev_phase for child request ID '||gv_child_request(i).child_request_id||' is '||lc_dev_phase);
		END LOOP;
*/		
	END LOOP;
	-- Change ends for CR8035 to display all the child request ID's	
  
  EXCEPTION
  
    WHEN OTHERS THEN
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'Exception in main occurred while calling the XXAP GRNI Custom Report)' ||
                              SQLERRM);
    
      errbuf  := SQLERRM;
      retcode := 2;
    
  END start_process;

END XXAP_GRNI_REP_PKG_WRAPPER;
/
Show errors package XXAP_GRNI_REP_PKG_WRAPPER

--desc XXAP_GRNI_REP_PKG_WRAPPER
/