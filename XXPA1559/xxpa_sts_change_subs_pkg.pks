create or replace PACKAGE xxpa_sts_change_subs_pkg
  authid definer
AS
   /***********************************************************************
   ** Title:       XXPA Project Credit Approval Status Change Subscription Program
   ** File:        xxpa_sts_change_subs_pkg.pks
   ** Description: Package is called on Project Credit Approval Workflow Completion
   ** Run as:      APPS
   ** Keyword Tracking:
   **
   ** Keyword Tracking:
   **   
   **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_sts_change_subs_pkg.pks 1.0 20-JUL-2017 00:15:26 CCBSSJ $
   **   $Change History$ (*ALL VERSIONS*)
   **   Revision 1.0 (COMPLETE)
   **     Created:  20-JUL-2017 00:15:26      CCBSSJ (Vishnusimman Manivannan)
   **       Initial revision.
   **   
   **
   **
   ** History:
   ** Date           Who                Description
   ** -----------    ------------------ ------------------------------------
   ** 20-Jun-2017    Vishnusimman M     Initial Creation for CR5963
   ************************************************************************/
   FUNCTION process_request (p_subscription_guid IN RAW, p_event IN OUT wf_event_t)
      RETURN VARCHAR2;
   FUNCTION check_requisition_request(p_subscription_guid IN RAW,
                                     p_event             IN OUT wf_event_t)
    RETURN VARCHAR2;
END xxpa_sts_change_subs_pkg;
/
show errors