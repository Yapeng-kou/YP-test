SET serveroutput on size 1000000 lines 132 trimout on tab off pages 100

WHENEVER sqlerror exist failure rollback

CREATE OR REPLACE PACKAGE xxap_workflow_pkg AUTHID DEFINER AS
  /*********************************************************
  ** title:       AP approval workflows support package
  ** file:        xxap_workflow_pkg.pks
  ** description: contains various procedures to support AP Invoice Approval
  **              and AP Hold Notification workflows
  ** parameters:  {none.}
  ** run as:      apps
  ** keyword tracking:
  **
  **   $header: xxap/patch/115/sql/xxap_workflow_pkg.pks 1.0 24-OCT-2012 10:32:06 CCAYFY $
  **   $change history$ (*all versions*)
  **   Revision 1.0 (COMPLETE)
  **     Created:  24-OCT-2012 10:32:06      CCAYFY
  **       Initial revision.
  **
  **
  ** history:
  ** date          who                description
  ** -----------   ------------------ ------------------------------------
  ** 20-sep-2012   msamoylenko          initial creation
  ** 08-nov-2012   msamoilenko          redesign AP invoice approval to
  **                                    approve by everybody up to the first
  **                                    person with proper approval limit
  ** 22-OCT-2014   Muralidhar Ng        CR#3870 Escalation Changes
  ** 14-OCT-2015   Soniya Doshi(CCBWIL) CR#4586 wait period based on 'Need by date'
  ** 03-Nov-2015   Santhosh R (IRGIOP)  CR4574 - Preventing Incorrect Entity segment value in AP Invoice Distribution
  ** 17-MAY-2016   Soniya doshi         CR5505 Patch Retrofit Changes
  ** 21-Apr-2017   Soniya Doshi(CCBWIL) CR7198  - CR7198 - Personal AP Worklist View Creation : addition of invoice due date at invoice header level  
  ********************************************************/

  -- move to AP Hold workflow
  /*
    procedure is_first_timeout( itemtype in varchar2
                              , itemkey in varchar2
                              , actid   in number
                              , funcmode in varchar2
                              , resultout  out nocopy varchar2 );
  */
  PROCEDURE is_invoice_authority(itemtype  IN VARCHAR2,
                                 itemkey   IN VARCHAR2,
                                 actid     IN NUMBER,
                                 funcmode  IN VARCHAR2,
                                 resultout OUT NOCOPY VARCHAR2);

  PROCEDURE timeout_invoice_appr(itemtype  IN VARCHAR2,
                                 itemkey   IN VARCHAR2,
                                 actid     IN NUMBER,
                                 funcmode  IN VARCHAR2,
                                 resultout OUT NOCOPY VARCHAR2);

  -- Added function is_gl_entity_valid for CR4574
  FUNCTION is_gl_entity_valid(p_invoice_id IN NUMBER,
                              p_entity     IN VARCHAR2,
                              p_org_id     IN NUMBER) RETURN VARCHAR2;

  PROCEDURE is_invoice_valid(itemtype  IN VARCHAR2,
                             itemkey   IN VARCHAR2,
                             actid     IN NUMBER,
                             funcmode  IN VARCHAR2,
                             resultout OUT NOCOPY VARCHAR2);

  PROCEDURE is_requester_comp_inv(itemtype  IN VARCHAR2,
                                  itemkey   IN VARCHAR2,
                                  actid     IN NUMBER,
                                  funcmode  IN VARCHAR2,
                                  resultout OUT NOCOPY VARCHAR2);

  FUNCTION is_hierarchy_complete(p_invoice_id IN NUMBER) RETURN VARCHAR2;

  --Added By Soniya doshi for CR#4586 wait period based on 'Need by date'
  PROCEDURE exists_needbydate_wait(itemtype  IN VARCHAR2,
                                   itemkey   IN VARCHAR2,
                                   actid     IN NUMBER,
                                   funcmode  IN VARCHAR2,
                                   resultout OUT NOCOPY VARCHAR2);

  --Start of code changes By Soniya doshi for CR#CR5505 Patch Retrofit Changes
  PROCEDURE xxprocess_doc_approval(itemtype  IN VARCHAR2,
                                   itemkey   IN VARCHAR2,
                                   actid     IN NUMBER,
                                   funcmode  IN VARCHAR2,
                                   resultout OUT NOCOPY VARCHAR2);

  PROCEDURE xxprocess_doc_rejection(itemtype  IN VARCHAR2,
                                    itemkey   IN VARCHAR2,
                                    actid     IN NUMBER,
                                    funcmode  IN VARCHAR2,
                                    resultout OUT NOCOPY VARCHAR2);

  PROCEDURE xxprocess_doc_timeout(itemtype  IN VARCHAR2,
                                  itemkey   IN VARCHAR2,
                                  actid     IN NUMBER,
                                  funcmode  IN VARCHAR2,
                                  resultout OUT NOCOPY VARCHAR2);

  --Refered process_sub_approval_response from oracle AP_WORKFLOW_PKG
  PROCEDURE xxprocess_sub_approval_resp(itemtype  IN VARCHAR2,
                                        itemkey   IN VARCHAR2,
                                        actid     IN NUMBER,
                                        funcmode  IN VARCHAR2,
                                        resultout OUT NOCOPY VARCHAR2);

  -- base verion get_ame_sub_approval_resp from seeded AP_WORKFLOW_PKG
  PROCEDURE xxget_ame_sub_approval_resp(itemtype  IN VARCHAR2,
                                        itemkey   IN VARCHAR2,
                                        actid     IN NUMBER,
                                        funcmode  IN VARCHAR2,
                                        resultout OUT NOCOPY VARCHAR2);

  PROCEDURE is_invoice_reject(itemtype  IN VARCHAR2,
                              itemkey   IN VARCHAR2,
                              actid     IN NUMBER,
                              funcmode  IN VARCHAR2,
                              resultout OUT NOCOPY VARCHAR2);
  --End of code changes By Soniya doshi for CR#CR5505 Patch Retrofit Changes

  PROCEDURE set_attribute_values(itemtype  IN VARCHAR2,
                                 itemkey   IN VARCHAR2,
                                 actid     IN NUMBER,
                                 funcmode  IN VARCHAR2,
                                 resultout OUT NOCOPY VARCHAR2);

END xxap_workflow_pkg;
/
SHOW errors package XXAP_WORKFLOW_PKG

DESC xxap_workflow_pkg
