set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

Whenever sqlerror exit failure rollback

CREATE OR REPLACE PACKAGE XXAP_GRNI_REP_PKG AUTHID DEFINER AS
  /*********************************************************
  ** Title:     Demonstrate creating a custom package header
  ** File:      XXAP_GRNI_REP_PKG.pks
  ** Description: This script creates a package header
  ** Parameters:  {None.}
  ** Run as:     APPS
  ** Keyword Tracking:
  **   
  **   $Header: xxap/12.0.0/patch/115/sql/XXAP_GRNI_REP_PKG.pks 1.4 29-MAY-2019 10:35:37 CCCGCW$
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.4 (COMPLETE)
  **     Created:  29-MAY-2019 10:35:37      CCCGCW (Harshil Shah)
  **       Added a new function get_buyer_name in the specification for CR8035
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  10-APR-2019 12:11:31      CCBNLW (Raju Patel)
  **       CR#8035-Multiple chnages
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  27-MAR-2017 06:36:24      CCBWIL (Soniya Doshi)
  **       CR5655-Removal of matched lines to have correct Ageing data-Phase 2
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  02-MAR-2017 06:17:31      CCBWIL (Soniya Doshi)
  **       CR5655 Initial version by CCBWIL-Soniya Doshi
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  06-SEP-2012 06:19:23      CCAYSC (None)
  **       Initial revision.
  **   
  **
  ** History:
  ** Date           Who                Description
  ** -----------   ------------------ ----------------------------------------------------------------------
  ** 05-Sep-2012    Divya Agarwal      Create
  ** 02-Mar-2017    Soniya Doshi       CR5655-Removal of matched lines to have correct Ageing data-Phase 1
  ** 27-Mar-2017    Soniya Doshi       CR5655-Removal of matched lines to have correct Ageing data-Phase 2
  ** 09-Apr-2019    Raju Patel	   	   CR#8035-Multiple chnages	
  ** 28-May-2019    Harshil Shah	   Added a function get_buyer_name for CR8035 to get the buyer name
  **********************************************************************************************************/

  PROCEDURE Start_Process(errbuf                OUT NOCOPY VARCHAR2,
                          retcode               OUT NOCOPY NUMBER,
                          p_title               IN VARCHAR2,
						  p_org_name            IN VARCHAR2,---added by Raju For CR#8035
                          p_accrued_receipts    IN VARCHAR2,
                          p_inc_online_accruals IN VARCHAR2,
                          p_inc_closed_pos      IN VARCHAR2,
                          p_struct_num          IN NUMBER,
                          p_category_from       IN VARCHAR2,
                          p_category_to         IN VARCHAR2,
                          p_min_accrual_amount  IN NUMBER,
                          p_period_name         IN VARCHAR2,
						  p_location            IN VARCHAR2, ---added by Raju  For CR#8035 
                          p_vendor_from         IN VARCHAR2,
                          p_vendor_to           IN VARCHAR2,
                          p_orderby             IN NUMBER,
                          p_qty_precision       IN NUMBER,
                          --Added for CR5655-Removal of matched lines to have correct Ageing data
                          p_exclude_receipt_matched     IN VARCHAR2,
                          p_exclude_matched_consignment IN VARCHAR2,
                          p_exclude_po_matched          IN VARCHAR2,
						  p_run_data_fix                IN VARCHAR2 ---added by Raju  For CR#8035 
						  );
  --Commented for CR5655-Removal of matched lines to have correct Ageing data
  /*PROCEDURE Generate_XML(p_api_version      IN NUMBER,
                         p_init_msg_list    IN VARCHAR2,
                         p_validation_level IN NUMBER,
                         x_return_status    OUT NOCOPY VARCHAR2,
                         x_msg_count        OUT NOCOPY NUMBER,
                         x_msg_data         OUT NOCOPY VARCHAR2,
                         p_ref_cur          IN SYS_REFCURSOR,
                         p_row_tag          IN VARCHAR2,
                         p_row_set_tag      IN VARCHAR2,
                         x_xml_data         OUT NOCOPY CLOB);
  
  PROCEDURE Merge_XML(p_api_version      IN NUMBER,
                      p_init_msg_list    IN VARCHAR2,
                      p_validation_level IN NUMBER,
                      x_return_status    OUT NOCOPY VARCHAR2,
                      x_msg_count        OUT NOCOPY NUMBER,
                      x_msg_data         OUT NOCOPY VARCHAR2,
                      p_xml_src1         IN CLOB,
                      p_xml_src2         IN CLOB,
                      p_root_tag         IN VARCHAR2,
                      x_xml_doc          OUT NOCOPY CLOB);
  
  PROCEDURE Print_ClobOutput(p_api_version      IN NUMBER,
                             p_init_msg_list    IN VARCHAR2,
                             p_validation_level IN NUMBER,
                             x_return_status    OUT NOCOPY VARCHAR2,
                             x_msg_count        OUT NOCOPY NUMBER,
                             x_msg_data         OUT NOCOPY VARCHAR2,
                             p_xml_data         IN CLOB);*/

  --Added for CR5655-Removal of matched lines to have correct Ageing data
  FUNCTION remove_monthwise_zero(p_po_distribution_id IN NUMBER,
                                 p_accrual_account_id IN NUMBER)
    RETURN VARCHAR2;

	---added below procedure by Raju For CR#8035
	PROCEDURE Execute_datafix(errbuf  OUT NOCOPY VARCHAR2,
                            retcode OUT NOCOPY NUMBER);

	-- Added a new function get_buyer_name for CR8035 to get the buyer name						
	FUNCTION get_buyer_name(p_poh_agent_id IN NUMBER,
							p_po_release_id IN NUMBER)
	RETURN VARCHAR2;							
	
	
END XXAP_GRNI_REP_PKG;
/
Show errors package XXAP_GRNI_REP_PKG

--desc XXAP_GRNI_REP_PKG
