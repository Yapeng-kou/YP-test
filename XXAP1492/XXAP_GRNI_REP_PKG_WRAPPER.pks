CREATE OR REPLACE PACKAGE XXAP_GRNI_REP_PKG_WRAPPER AUTHID DEFINER AS

  /*********************************************************
  ** Title:     Demonstrate creating a custom package header
  ** File:      XXAP_GRNI_REP_PKG_WRAPPER.pks 
  ** Description: This script creates a package header
  ** Parameters:  {None.}
  ** Run as:     APPS
  ** Keyword Tracking:
  **   
  **   $Header: xxap/12.0.0/patch/115/sql/XXAP_GRNI_REP_PKG_WRAPPER.pks 1.1 29-MAY-2019 10:54:30 CCCGCW$
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.1 (COMPLETE)
  **     Created:  29-MAY-2019 10:54:30      CCCGCW (Harshil Shah)
  **       Updated pks to add a new table type for CR8035
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  10-APR-2019 12:10:35      CCBNLW (Raju Patel)
  **       CR#8035-Multiple chnages
  **   
  **
  ** History:
  ** Date          Who           	  Description
  ** -----------   ------------------ -----------------------------------------------------------
  ** 05-Sep-2012   Raju Patel         Create CR#8035 -Multiple Changes
  ** 23-May-2019   Harshil Shah		  Changes for CR8035 for ensuring that parent/master program 
  **								  completes only after all the child programs are completed
  ***********************************************************************************************/

  PROCEDURE Start_Process(errbuf                        OUT NOCOPY VARCHAR2,
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
                          p_run_data_fix                IN VARCHAR2);
						  
------ Changes starts for CR8035 for ensuring that parent/master program completes only after all the child programs are completed
	TYPE t_child_request IS RECORD
	(
		child_request_id	NUMBER
	);

	TYPE t_child_request_tab IS TABLE OF t_child_request INDEX BY BINARY_INTEGER;

	gv_child_request	  t_child_request_tab;
------ Changes ends for CR8035 for ensuring that parent/master program completes only after all the child programs are completed	

END XXAP_GRNI_REP_PKG_WRAPPER;
/
Show errors package XXAP_GRNI_REP_PKG_WRAPPER

--desc XXAP_GRNI_REP_PKG_WRAPPER
/