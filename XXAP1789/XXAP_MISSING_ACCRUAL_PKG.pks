CREATE OR REPLACE PACKAGE XXAP_MISSING_ACCRUAL_PKG IS
  /*********************************************************************************************
  ** Title:       XXAP1789 XXAP Missing Accrual Accounts Report
  ** File:        XXAP_MISSING_ACCRUAL_PKG.pks
  ** Description: This script creates a package header for XXAP Missing Accrual Accounts Report.
  ** Parameters:  {None.}
  ** Run as:      APPS
  ** Keyword Tracking:
  **
  **   $Header: xxap/patch/115/sql/XXAP_MISSING_ACCRUAL_PKG.pks
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.0 (COMPLETE)
  **
  ** History:
  ** Date          Who                Description
  ** -----------   ------------------ --------------------------------------
  ** 03-Apr-2017   Soniya Doshi       Initial Creation
  ** 25-Mar-2020   Pankaj Karan       RT8692240 - Report not showing CST data  
  ***************************************************************************/
  p_ledger_id      NUMBER;
  --p_operating_unit NUMBER;  -- Commented for RT8692240
  p_num_days       NUMBER; --- Added for RT8692240
  P_WHERE_OU       VARCHAR2(32767);
  FUNCTION before_report RETURN BOOLEAN;

END XXAP_MISSING_ACCRUAL_PKG;
/
