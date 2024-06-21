CREATE OR REPLACE PACKAGE BODY XXAP_MISSING_ACCRUAL_PKG IS
  /*********************************************************************************************
  ** Title:       XXAP1789 XXAP Missing Accrual Accounts Report
  ** File:        XXAP_MISSING_ACCRUAL_PKG.pkb
  ** Description: This script creates a package header for XXAP Missing Accrual Accounts Report
  ** Parameters:  {None.}
  ** Run as:      APPS
  ** Keyword Tracking:
  **
  **   $Header: xxap/patch/115/sql/XXAP_MISSING_ACCRUAL_PKG.pkb
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.0 (COMPLETE)
  **
  ** History:
  ** Date          Who                Description
  ** -----------   ------------------ --------------------------------------
  ** 03-Apr-2017   Soniya Doshi       Initial Creation
  ** 03-Jan-2020   Sumedh Balapure    Defect# 824 SEP-5733 - modified before_report
  ** 15-Jan-2020   Pankaj Karan       Defect# 824 SEP-5733 - Performance Improvements
  ** 25-Mar-2020   Pankaj Karan       RT8692240 - Report not showing CST data
  ********************************************************************************************/
  --- Strat of addition by Pankaj Karan for Defect# 824 SEP-5733
   /*-----------------------------------------------------------------------
  Procedure: insert_temp_table
  Purpose  : This procedure will insert the data in global temp table
  -------------------------------------------------------------------------*/
   
  PROCEDURE insert_temp_table ( p_ledger_id IN NUMBER , 
                                 p_org_id   IN NUMBER)
  IS
     TYPE XXAP_ACCR_ACCT_TAB IS TABLE OF xxap.XXAP1789_MISSING_ACCRUAL_GTT%ROWTYPE
        INDEX BY BINARY_INTEGER;
     XXAP_ACCR_ACCT_TAB1 XXAP_ACCR_ACCT_TAB;
     EX_DML_ERRORS EXCEPTION;
     PRAGMA exception_init(ex_dml_errors, -24381);
     l_errors NUMBER;
     l_errno  NUMBER;
     l_msg    VARCHAR2(3000):= NULL;
   
  BEGIN
     
	 -- Start of Addition RT8692240
  
      SELECT gcc.code_combination_id
      BULK COLLECT INTO XXAP_ACCR_ACCT_TAB1
      FROM gl_code_combinations gcc, gl_ledgers gl
      WHERE gcc.chart_of_accounts_id = gl.chart_of_accounts_id
      AND gl.ledger_id = p_ledger_id
      AND EXISTS ( 
      SELECT 1
       
      FROM xla_ae_lines xal
      WHERE 1=1
      AND xal.ledger_id = p_ledger_id
      AND (xal.application_id = 200 or xal.application_id = 707)
      AND xal.accounting_date > TRUNC(SYSDATE) - p_num_days  --RT8692240
      and xal.accounting_class_code = 'ACCRUAL'
      AND gcc.code_combination_id = xal.code_combination_id );
    
  
     -- End of Addition RT8692240 
     -- Old commented code removed RT8692240
	
    
     ---- Inserting Data In GTT
    FORALL i IN XXAP_ACCR_ACCT_TAB1.FIRST .. XXAP_ACCR_ACCT_TAB1.LAST SAVE EXCEPTIONS
    INSERT INTO xxap.XXAP1789_MISSING_ACCRUAL_GTT
    (code_combination_id)
    VALUES
    (XXAP_ACCR_ACCT_TAB1(i).code_combination_id);
    
    ----- Calling gather Tbale stats
     fnd_stats.gather_table_stats(ownname => 'XXAP',
                                 tabname => 'XXAP1789_MISSING_ACCRUAL_GTT',
                                 percent => 100);
  EXCEPTION
    WHEN EX_DML_ERRORS THEN
      
      l_errors := sql%bulk_exceptions.count;
      FOR i IN 1 .. l_errors
      LOOP
        l_errno := sql%bulk_exceptions(i).error_code;
        l_msg   :=SUBSTR(l_msg|| sqlerrm(-l_errno),1,300);
      END LOOP;
    
      XX_AU_DEBUG.P_DEBUG_ERROR(IV_DEBUG_KEY      => 'XXAP_MISSING_ACCRUAL_PKG', --Calling Procedure or Other Key
                                IN_DEBUG_LEVEL    => 'HIGH', --Debug Level
                                IV_CALLED_BY      => 'BEFORE_REPORT', --Calling Procedure
                                IV_INTERFACE_NAME => 'XXAP1789', --Interface or Enhancement RICE ID That is Logging the Error
                                IN_REQUEST_ID     => 'P_CONC_REQUEST_ID', --Request Id whenever applicable else NULL
                                IV_ENTITY_ID      => 'NULL', --Identifying Entity value (eg. Sales Order Number,etc)
                                IV_ENTITY_NAME    => 'XXAP MISSING ACCRUAL ACCOUNTS REPORT', --Entity Name
                                IV_SOURCE_SYSTEM  => 'NULL', --Source System
                                IV_DEST_SYSTEM    => 'NULL', --Dest System
                                IV_SEVERITY       => 'ERROR', --Severity ( ERROR / WARNING / EVENT etc)
                                IV_ERROR_CODE     => SQLCODE, --SQLCODE
                                IV_ERROR_MSG      => 'INSERT Error: '||l_msg, --SQLERRM
                                IV_ERROR_STEP     => 'NULL'); --Error Step ( Last successful debug step)
      RAISE;
  END insert_temp_table;
  --- End of addition by Pankaj Karan for Defect# 824 SEP-5733
  
  /*-----------------------------------------------------------------------
  Function: insert_temp_table
  Purpose  : This function will be called in before report to get the dynamic 
             sql strings and data in temp table.
  -------------------------------------------------------------------------*/
  FUNCTION before_report RETURN BOOLEAN IS
    l_mo_security_profile NUMBER;  -- commented RT8692240
    l_org_id  NUMBER := NULL;  -- commented RT8692240
  BEGIN
  
    --- Start of addition RT8692240
    P_WHERE_OU := ' (SELECT 1 FROM cst_accrual_accounts caa
             WHERE gcc.code_combination_id = caa.accrual_account_id)';  
    --- End Of Addition RT8692240
    --- Old commented code removed RT8692240
	
    --- Start of addition by Pankaj Karan for Defect# 824 SEP-5733
    ---- Procedure to insert records gtt
    insert_temp_table ( p_ledger_id => p_ledger_id,
                        p_org_id => 0 );
    --- End of addition by Pankaj Karan for Defect# 824 SEP-5733
    
    RETURN(TRUE);
  EXCEPTION
    WHEN OTHERS THEN
      XX_AU_DEBUG.P_DEBUG_ERROR(IV_DEBUG_KEY      => 'XXAP_MISSING_ACCRUAL_PKG', --Calling Procedure or Other Key
                                IN_DEBUG_LEVEL    => 'HIGH', --Debug Level
                                IV_CALLED_BY      => 'BEFORE_REPORT', --Calling Procedure
                                IV_INTERFACE_NAME => 'XXAP1789', --Interface or Enhancement RICE ID That is Logging the Error
                                IN_REQUEST_ID     => 'P_CONC_REQUEST_ID', --Request Id whenever applicable else NULL
                                IV_ENTITY_ID      => 'NULL', --Identifying Entity value (eg. Sales Order Number,etc)
                                IV_ENTITY_NAME    => 'XXAP MISSING ACCRUAL ACCOUNTS REPORT', --Entity Name
                                IV_SOURCE_SYSTEM  => 'NULL', --Source System
                                IV_DEST_SYSTEM    => 'NULL', --Dest System
                                IV_SEVERITY       => 'ERROR', --Severity ( ERROR / WARNING / EVENT etc)
                                IV_ERROR_CODE     => SQLCODE, --SQLCODE
                                IV_ERROR_MSG      => SQLERRM, --SQLERRM
                                IV_ERROR_STEP     => 'NULL'); --Error Step ( Last successful debug step)
      --defined as a global variable in the package with initial value 1.0 and
      ---should be incremented per DML or select query)
      RETURN(TRUE);
  END before_report;
  
END XXAP_MISSING_ACCRUAL_PKG;
/
