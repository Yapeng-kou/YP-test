CREATE OR REPLACE PACKAGE BODY apps.xxap_workflow_pkg AS
  /*********************************************************
  ** title:       AP approval workflows support package
  ** file:        xxap_workflow_pkg.pkb
  ** description: contains various procedures to support AP Invoice Approval
  **              and AP Hold Notification workflows
  ** parameters:  {none.}
  ** run as:      apps
  ** keyword tracking:
  **   
  **   $Header: xxap/12.0.0/patch/115/sql/xxap_workflow_pkg.pkb 1.32 27-SEP-2019 16:43:29 IRHZXS $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.32 (COMPLETE)
  **     Created:  27-SEP-2019 16:43:29      IRHZXS (Ravi Alapati)
  **       Changes for RT#8503133
  **   
  **   Revision 1.31 (COMPLETE)
  **     Created:  30-APR-2019 07:15:06      IRIIEB (Harivardhan Gonchi)
  **       RT#8307021 -- Invoice validation is failing for AWT line look up
  **       type invoice lines
  **   
  **   Revision 1.30 (COMPLETE)
  **     Created:  08-NOV-2017 02:25:57      CCBWIL (Soniya Doshi)
  **       CR5559 --Failure in invoice approval after it is imported
  **   
  **   Revision 1.29 (COMPLETE)
  **     Created:  24-JUL-2017 09:24:16      C-STONDON (Somil Tondon)
  **       RT7257032 - changed getitemattrnumber to getitemattrtext
  **   
  **   Revision 1.28 (COMPLETE)
  **     Created:  25-APR-2017 09:44:08      CCBWIL (Soniya Doshi)
  **       CR7198 - Personal AP Worklist View Creation : addition of invoice
  **       due date at notification header level   
  **   
  **   Revision 1.27 (COMPLETE)
  **     Created:  24-APR-2017 05:22:28      CCBWIL (Soniya Doshi)
  **       CR7198 - Personal AP Worklist View Creation : addition of invoice
  **       due date at notification header level 
  **   
  **   Revision 1.26 (COMPLETE)
  **     Created:  06-APR-2017 09:42:15      CCBWIL (Soniya Doshi)
  **       RT#7084072 --Approver group changes for Blanket Purchase Agreement
  **   
  **   Revision 1.25 (COMPLETE)
  **     Created:  14-SEP-2016 10:08:22      CCBWIL (Soniya Doshi)
  **       RT#6769433 --In-Flight AP invoice records which are initiate before
  **       21st aug due to RUP4 
  **   
  **   Revision 1.24 (COMPLETE)
  **     Created:  14-JUL-2016 04:34:28      CCBWIL (Soniya Doshi)
  **       CR 5505 Patch retrofit changes and RT#6672359
  **   
  **   Revision 1.23 (COMPLETE)
  **     Created:  11-JUL-2016 09:13:27      CCBWIL (Soniya Doshi)
  **       Defect 237 fixes , CR 5505 Patch retrofit changes and RT#6672359
  **   
  **   Revision 1.22 (COMPLETE)
  **     Created:  18-MAY-2016 05:09:53      CCBWIL (Soniya Doshi)
  **       CR5505 Patch Retrofit Changes
  **   
  **   Revision 1.21 (COMPLETE)
  **     Created:  16-DEC-2015 02:16:15      CCBWIL (Soniya Doshi)
  **       added distinct for 6358917
  **   
  **   Revision 1.20 (COMPLETE)
  **     Created:  03-DEC-2015 02:02:21      CCBWIL (Soniya Doshi)
  **       6310441-THIS NOTIFICATION HAS BEEN APPROVED SEVERAL TIMES, AND
  **       AFTER TIME OUT IT WAS ESCALATED
  **   
  **   Revision 1.19 (COMPLETE)
  **     Created:  03-NOV-2015 15:43:06      IRGIOP (Santhosh Ramakrishnan)
  **       For CR4574 Changes
  **   
  **   Revision 1.18 (COMPLETE)
  **     Created:  20-OCT-2015 09:03:31      CCBWIL (Soniya Doshi)
  **       CR#4586 wait period based on 'Need by date'
  **   
  **   Revision 1.17 (COMPLETE)
  **     Created:  24-OCT-2014 18:09:18      CCAYSB (None)
  **       Updated
  **   
  **   Revision 1.16 (COMPLETE)
  **     Created:  24-OCT-2014 17:48:16      CCAYSB (None)
  **       Updated the package to include a check not to escalate the invocie
  **       to next level if the invoce is not complete
  **   
  **   Revision 1.15 (COMPLETE)
  **     Created:  23-OCT-2014 15:48:58      CCAYSB (None)
  **       Updated
  **   
  **   Revision 1.14 (COMPLETE)
  **     Created:  22-OCT-2014 14:42:23      CCAYSB (None)
  **       Updated
  **   
  **   Revision 1.13 (COMPLETE)
  **     Created:  22-OCT-2014 14:34:33      CCAYSB (None)
  **       updated
  **   
  **   Revision 1.12 (COMPLETE)
  **     Created:  22-OCT-2014 14:26:54      CCAYSB (None)
  **       updated
  **   
  **   Revision 1.11 (COMPLETE)
  **     Created:  28-MAY-2013 16:45:12      CCBBQP (None)
  **       Remedy 4728645
  **   
  **   Revision 1.10 (COMPLETE)
  **     Created:  25-APR-2013 16:11:38      CCBBQP (None)
  **       000000004695858
  **   
  **   Revision 1.9 (COMPLETE)
  **     Created:  15-APR-2013 10:41:16      CCBBQP (None)
  **       remedy 4668853
  **   
  **   Revision 1.8 (COMPLETE)
  **     Created:  20-FEB-2013 09:51:55      CCBBQP (None)
  **       7007
  **   
  **   Revision 1.7 (COMPLETE)
  **     Created:  15-FEB-2013 11:45:34      CCBBQP (None)
  **       defect 7192
  **   
  **   Revision 1.6 (COMPLETE)
  **     Created:  08-FEB-2013 13:24:46      CCBBQP (None)
  **       Control whether ship to address/purchasing category is required
  **   
  **   Revision 1.5 (COMPLETE)
  **     Created:  17-DEC-2012 11:37:04      CCBBQP (None)
  **       Redesigned based on updated FD
  **   
  **   Revision 1.4 (COMPLETE)
  **     Created:  27-NOV-2012 15:24:52      CCBBQP (None)
  **       WFAPPROVED for non-PO matched invoices
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  09-NOV-2012 16:06:36      CCBBQP (None)
  **       Fix to invoice amount function
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  09-NOV-2012 15:32:25      CCBBQP (None)
  **       Added code from AP_WORKFLOW_PKG to change the status of the invoice
  **       upon approval. Development should have created this as a separate
  **       procedure, really.
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  08-NOV-2012 14:35:44      CCBBQP (None)
  **       Rework to consider complete hierarchy
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  24-OCT-2012 10:32:41      CCAYFY (None)
  **       Initial revision.
  **
  ** history:
  ** date          who                description
  ** -----------   ------------------ ------------------------------------
  ** 20-sep-2012   msamoylenko          initial creation
  ** 08-nov-2012   msamoylenko          redesign AP invoice approval to
  **                                    approve by everybody up to the first
  **                                    person with proper approval limit
  ** 27-nov-2012   msamoylenko          WFAPPROVED even for non-matched invoices
  ** 02-FEB-2013   msamoylenko          control whether ship to/po category required
  ** 15-FEB-2013   msamoylenko          defect 7192
  ** 15-APR-2013   msamoylenko          remedy 4668853. Allow only one level of approval for PO matched invoices
  ** 25-APR-2013   msamoylenko          remedy 4695858
  ** 28-MAY-2013   Rupali Sawant        Changed for Remedy Ticket# 4728645
  ** 22-OCT-2014   Muralidhar Ng        CR#3870 Escalation Changes
  ** 14-OCT-2015   Soniya Doshi(CCBWIL) CR#4586 wait period based on 'Need by date'
  ** 03-Nov-2015   Santhosh R (IRGIOP)  CR4574 - Preventing Incorrect Entity segment value in AP Invoice Distribution
  ** 01-Dec-2015   Soniya Doshi (CCBWIL)  6310441-THIS NOTIFICATION HAS BEEN APPROVED SEVERAL TIMES, AND AFTER TIME OUT IT WAS ESCALATED
  ** 15-Dec-2015   Soniya Doshi (CCBWIL)  6358917 -On PO has multiple distribution lines, exists need by goes into exception
  ** 17-MAY-2016   Soniya doshi         CR5505 Patch Retrofit Changes
  ** 11-Jul-2016   Soniya Doshi (CCBWIL) RT#6672359 --WORKFLOW APPROVAL ISSUE WHEN PREPAYMENT APPLIED TO AN INVOICE
  ** 06-Apr-2017   Soniya Doshi (CCBWIL) RT#7084072 --Approver group changes for Blanket Purchase Agreement
  ** 21-Apr-2017   CCBWIL CR7198  - CR7198 - Personal AP Worklist View Creation : addition of invoice due date at invoice header level
  ** 24-JUL-2017   c-stondon		RT#7257032 - 	changed getitemattrnumber to getitemattrtext
  ** 03-Nov-2017   Soniya Doshi (CCBWIL) CR5559 --Failure in invoice approval after it is imported
  ** 29-Apr-2019   Harivardhan G (IRIIEB) RT#8307021 -- Invoice validation is failing for AWT line look up type invoice lines 
  ** 27-Sep-2019   Ravi Alapati          RT8503133 - XXAP1516 - AP Invoice Approval Workflow - Investigate character string buffer too small error
  ********************************************************/

  --------------------------------------------------------------
  --                    Global Variables                      --
  --------------------------------------------------------------
  g_current_runtime_level CONSTANT NUMBER := fnd_log.g_current_runtime_level;
  g_level_statement       CONSTANT NUMBER := fnd_log.level_statement;
  g_module_name           CONSTANT VARCHAR2(100) := 'XXAP_WORKFLOW_PKG';
  g_level_procedure       CONSTANT NUMBER := fnd_log.level_procedure;
  g_timeout_attribute     CONSTANT VARCHAR2(30) := 'XX_TIMEOUT_COUNT';
  --Added By Soniya doshi for CR#CR5505 Patch Retrofit Changes
  g_ame_sub_approval_response VARCHAR2(50);
  g_approver_id               NUMBER;

  /*
    procedure is_first_timeout( itemtype in varchar2
                              , itemkey in varchar2
                              , actid   in number
                              , funcmode in varchar2
                              , resultout  out nocopy varchar2 ) as
      l_timeout_count number;
    begin
      IF (funcmode = wf_engine.eng_run) THEN
        -- flip timeout
        l_timeout_count := nvl( wf_engine.getitemattrnumber(itemtype, itemkey, G_TIMEOUT_ATTRIBUTE), 0);
        wf_engine.SetItemAttrNumber(itemtype, itemkey, G_TIMEOUT_ATTRIBUTE, 1 - l_timeout_count);
        -- make sure update has happened
        l_timeout_count := wf_engine.getitemattrnumber(itemtype, itemkey, G_TIMEOUT_ATTRIBUTE);
  
        if l_timeout_count <> 1 then
          if wf_engine.getitemattrtext(itemtype, itemkey, 'NOTF_CONTEXT') = 'HOLDNEGOTIABLE' then
            ap_workflow_pkg.process_ack_pomatched(itemtype, itemkey, actid, funcmode, resultout);
          else
            ap_workflow_pkg.process_ack_pounmatched(itemtype, itemkey, actid, funcmode, resultout);
          end if;
        end if;
  
        select wf_engine.eng_completed||':'|| decode(l_timeout_count, 1, 'Y', 'N')
        into resultout
        from dual;
  
        return;
      end if;
  
        --
        -- CANCEL mode
        --
        IF (funcmode = wf_engine.eng_cancel) THEN
          --
          resultout :=  wf_engine.eng_completed|| ':';
          RETURN;
          --
        END IF;
        --
        -- TIMEOUT mode
        --
        IF (funcmode = wf_engine.eng_timeout) THEN
          --
          resultout := wf_engine.eng_completed|| ':';
          RETURN;
          --
        END IF;
  
    EXCEPTION
  
    WHEN OTHERS THEN
          WF_CORE.CONTEXT(itemtype,'is_first_timeout',itemtype, itemkey,
                          to_char(actid), funcmode);
          RAISE;
    END is_first_timeout;
  */
  /*
    procedure reescalate_inv_approval( itemtype in varchar2
                                      , itemkey in varchar2
                                      , actid   in number
                                      , funcmode in varchar2
                                      , resultout  out nocopy varchar2 ) is
      l_esc_approver          AME_UTIL.approverRecord2;
      l_org_id NUMBER;
      l_invoice_id number;
      l_curr_esc_approver_name     VARCHAR2(150);
      l_curr_esc_approver_id       NUMBER(15);
      l_curr_esc_role              VARCHAR2(50);
  
      l_esc_approver_name     VARCHAR2(150);
      l_esc_approver_id       NUMBER(15);
      l_esc_role              VARCHAR2(50);
      l_esc_role_display      VARCHAR2(150);
  
      l_name                  wf_users.name%TYPE; --bug 8620671
     l_api_name              CONSTANT VARCHAR2(200) :=
                                     'reescalate_inv_approval';
     l_debug_info            VARCHAR2(2000);
     l_iteration             NUMBER;
     l_invoice_total         NUMBER;
     l_hist_rec              AP_INV_APRVL_HIST%ROWTYPE;
     l_notf_iteration        NUMBER;
  -- bug 8450681 begin
        l_display_name           VARCHAR2(150);
        l_next_approvers  ame_util.approversTable2;
        l_next_approver   ame_util.approverRecord2;
        l_index           ame_util.idList;
        l_ids             ame_util.stringList;
        l_class           ame_util.stringList;
        l_source          ame_util.longStringList;
        l_complete        VARCHAR2(1);
  -- bug 8450681 end
    begin
      IF (funcmode = wf_engine.eng_run) THEN
        l_invoice_id := WF_ENGINE.GetItemAttrNumber(itemtype, itemkey, 'INVOICE_ID');
  
        l_org_id := WF_ENGINE.GetItemAttrNumber(itemtype, itemkey, 'ORG_ID');
  
        l_invoice_total := WF_ENGINE.GetItemAttrNumber(itemtype, itemkey, 'INVOICE_TOTAL');
  
        l_iteration := WF_ENGINE.GetItemAttrNumber(itemtype, itemkey, 'ITERATION');
  
        l_notf_iteration := WF_ENGINE.GETITEMATTRNumber(itemtype, itemkey, 'NOTF_ITERATION');
  
     --Set WF attributes
        l_curr_esc_approver_name := WF_ENGINE.GetItemAttrText(itemtype,
                     itemkey,
                     'ESC_APPROVER_NAME');
  
       l_curr_esc_approver_id := WF_ENGINE.GetItemAttrText(itemtype,
                     itemkey,
                     'ESC_APPROVER_ID');
  
       l_curr_esc_role := WF_ENGINE.GetItemAttrText(itemtype,
                     itemkey,
                     'ESC_ROLE_NAME');
  
        --Now set the environment
        MO_GLOBAL.INIT ('SQLAP');
        MO_GLOBAL.set_policy_context('S',l_org_id);
  
     begin
       SELECT supervisor_id   INTO   l_esc_approver_id
         FROM   per_employees_current_x
         WHERE  employee_id = l_curr_esc_approver_id;
  
       if l_esc_approver_id is null then
         resultout := wf_engine.eng_completed|| ':' || 'N';
         RETURN;
       end if;
     exception when no_data_found then
       resultout := wf_engine.eng_completed|| ':' || 'N';
       RETURN;
     end;
  
     WF_DIRECTORY.GetUserName('PER',
                     l_esc_approver_id,
                     l_name,
                     l_esc_approver_name);
     WF_DIRECTORY.GetRoleName('PER',
                     l_esc_approver_id,
                     l_esc_role,
                     l_esc_role_display);
  -- bug#6837841 Changes End
     l_esc_approver.name := l_esc_role;
     l_esc_approver.api_insertion := ame_util.apiInsertion;
     l_esc_approver.authority := ame_util.authorityApprover;
     l_esc_approver.approval_status := ame_util.forwardStatus;
  
     --update AME
     AME_API2.updateApprovalStatus2(applicationIdIn => 200,
                        transactionTypeIn =>  'APINV',
                        transactionIdIn     => to_char(l_invoice_id),
                        approvalStatusIn    => AME_UTIL.noResponseStatus,
                        approverNameIn  => l_curr_esc_role,
                        itemClassIn    => ame_util.headerItemClassName,
                        itemIdIn    => to_char(l_invoice_id),
                        forwardeeIn       => l_esc_approver);
  -- bug 8450681  begins
  --get the next layer (stage) of approvers
    AME_API2.getNextApprovers1
             (applicationIdIn               => 200,
              transactionTypeIn             => 'APINV',
              transactionIdIn               => to_char(l_invoice_id),
              flagApproversAsNotifiedIn     => ame_util.booleanFalse,
              approvalProcessCompleteYNOut  => l_complete,
              nextApproversOut              => l_next_approvers,
              itemIndexesOut                => l_index,
              itemIdsOut                    => l_ids,
              itemClassesOut                => l_class,
              itemSourcesOut                => l_source);
  -- bug 8450681 ends
  
     --Set WF attributes
     WF_ENGINE.SetItemAttrText(itemtype,
                     itemkey,
                     'ESC_APPROVER_NAME',
                     l_esc_approver_name);
  
     WF_ENGINE.SetItemAttrNumber(itemtype,
                     itemkey,
                     'ESC_APPROVER_ID',
                     l_esc_approver_id);
  
     WF_ENGINE.SetItemAttrText(itemtype,
                     itemkey,
                     'ESC_ROLE_NAME',
                     l_esc_role);
  -- bug 8450681 begins
     WF_ENGINE.SetItemAttrText(itemtype,
                     itemkey,
                     'ESC_ROLE_ACTUAL',
                     l_esc_role);
  -- bug 8450681  ends
     WF_ENGINE.SetItemAttrText(itemtype,
                     itemkey,
                     'ESCALATED',
                     'Y');
     l_hist_rec.HISTORY_TYPE := 'DOCUMENTAPPROVAL';
     l_hist_rec.INVOICE_ID   := l_invoice_id;
     l_hist_rec.ITERATION    := l_iteration;
     l_hist_rec.NOTIFICATION_ORDER := l_notf_iteration;
     l_hist_rec.RESPONSE     := 'ESCALATED';
     l_hist_rec.APPROVER_ID  := l_esc_approver_id;
     l_hist_rec.APPROVER_NAME:= l_esc_approver_name;
     l_hist_rec.CREATED_BY   := nvl(TO_NUMBER(FND_PROFILE.VALUE('USER_ID')),-1);
     l_hist_rec.CREATION_DATE:= sysdate;
     l_hist_rec.LAST_UPDATE_DATE := sysdate;
     l_hist_rec.LAST_UPDATED_BY  := nvl(TO_NUMBER(FND_PROFILE.VALUE('USER_ID')),-1);
     l_hist_rec.LAST_UPDATE_LOGIN := nvl(TO_NUMBER(FND_PROFILE.VALUE('LOGIN_ID')),-1);
     l_hist_rec.ORG_ID            := l_org_id;
     l_hist_rec.AMOUNT_APPROVED   := l_invoice_total;
  
     l_debug_info := 'Before insert_history_table';
     IF (G_LEVEL_STATEMENT >= G_CURRENT_RUNTIME_LEVEL) THEN
            FND_LOG.STRING(G_LEVEL_STATEMENT,G_MODULE_NAME||
                           l_api_name,l_debug_info);
     END IF;
     ap_workflow_pkg.insert_history_table(p_hist_rec => l_hist_rec);
  
        resultout := wf_engine.eng_completed|| ':' || 'Y';
        RETURN;
      end if;  -- RUN mode
        --
        -- CANCEL mode
        --
        IF (funcmode = wf_engine.eng_cancel) THEN
          --
          resultout :=  wf_engine.eng_completed|| ':';
          RETURN;
          --
        END IF;
        --
        -- TIMEOUT mode
        --
        IF (funcmode = wf_engine.eng_timeout) THEN
          --
          resultout := wf_engine.eng_completed|| ':';
          RETURN;
          --
        END IF;
  
    EXCEPTION
  
    WHEN OTHERS THEN
          WF_CORE.CONTEXT(itemtype,'reescalate_inv_approval',itemtype, itemkey,
                          to_char(actid), funcmode);
          RAISE;
    end reescalate_inv_approval;
  */
  FUNCTION get_approval_limit(p_person_id IN NUMBER, p_org_id IN NUMBER)
    RETURN NUMBER IS
    l_result NUMBER := 0;
  BEGIN
    SELECT pcr.amount_limit
      INTO l_result
      FROM po_control_rules         pcr,
           per_assignments_f        paf,
           po_position_controls_all ppca,
           po_control_groups_all    pcga
     WHERE pcr.object_code = 'DOCUMENT_TOTAL'
       AND TRUNC(SYSDATE) BETWEEN paf.effective_start_date AND
           paf.effective_end_date
       AND paf.job_id = ppca.job_id
       AND pcga.control_group_id = ppca.control_group_id
       AND pcr.control_group_id = pcga.control_group_id
       AND ppca.control_function_id = 8
       AND TRUNC(SYSDATE) BETWEEN ppca.start_date AND
           NVL(ppca.end_date, TRUNC(SYSDATE) + 1)
       AND pcga.org_id = ppca.org_id
       AND ppca.org_id = p_org_id
       AND paf.person_id = p_person_id;
  
    RETURN l_result;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

  FUNCTION get_invoice_amount(p_invoice_id IN NUMBER) RETURN NUMBER IS
    l_result NUMBER;
  BEGIN
    SELECT gl_currency_api.convert_amount_sql(x_set_of_books_id => ai.set_of_books_id,
                                              x_from_currency   => NVL(ai.invoice_currency_code,
                                                                       asp.invoice_currency_code),
                                              x_conversion_date => ai.invoice_date,
                                              x_conversion_type => NVL(ai.exchange_rate_type,
                                                                       asp.default_exchange_rate_type),
                                              x_amount          => ai.invoice_amount)
      INTO l_result
      FROM ap_invoices_all ai, ap_system_parameters_all asp
     WHERE ai.org_id = asp.org_id
       AND ai.invoice_id = p_invoice_id;
  
    RETURN l_result;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

  -- copy from the standard AP_WORKFLOW_PKG.get_header_approver procedure
  PROCEDURE complete_approval(itemtype     IN VARCHAR2,
                              itemkey      IN VARCHAR2,
                              p_invoice_id IN NUMBER) IS
    l_count          NUMBER;
    l_iteration      NUMBER;
    l_inv_match_type VARCHAR2(80);
  
    CURSOR c_invoice(p_invoice_id IN ap_invoices_all.invoice_id%TYPE) IS
      SELECT invoice_type_lookup_code,
             gl_date,
             ap_utilities_pkg.get_gl_period_name(gl_date, org_id),
             org_id
        FROM ap_invoices_all
       WHERE invoice_id = p_invoice_id;
  
    l_org_id                   NUMBER;
    l_invoice_type_lookup_code ap_invoices_all.invoice_type_lookup_code%TYPE;
    l_gl_date                  ap_invoices_all.gl_date%TYPE;
    l_new_gl_date              ap_invoices_all.gl_date%TYPE;
    l_period_name              ap_invoice_lines_all.period_name%TYPE;
    l_new_period_name          ap_invoice_lines_all.period_name%TYPE;
    l_terms_id                 ap_invoices_all.terms_id%TYPE;
    l_terms_date               ap_invoices_all.terms_date%TYPE;
    l_count_rejects            NUMBER;
  BEGIN
    l_iteration := SUBSTR(itemkey, INSTR(itemkey, '_') + 1, LENGTH(itemkey));
  
    --check for prior approvers
    SELECT COUNT(*)
      INTO l_count
      FROM ap_inv_aprvl_hist_all
    -- we are not setting up org context; defect 3964
     WHERE invoice_id = p_invoice_id
       AND iteration = l_iteration
       AND response <> 'MANUALLY APPROVED'
       AND history_type = 'DOCUMENTAPPROVAL';
  
    IF l_count > 0 THEN
      --update invoice header status
      UPDATE ap_invoices_all
         SET wfapproval_status = 'WFAPPROVED'
       WHERE invoice_id = p_invoice_id
         AND wfapproval_status <> 'MANUALLY APPROVED';
    ELSE
      UPDATE ap_invoices_all
         SET wfapproval_status = DECODE(invoice_type_lookup_code,
                                        'INVOICE REQUEST',
                                        'REJECTED',
                                        'CREDIT MEMO REQUEST',
                                        'REJECTED',
                                        'NOT REQUIRED')
       WHERE invoice_id = p_invoice_id
         AND wfapproval_status <> 'MANUALLY APPROVED';
    END IF;
  
    l_inv_match_type := wf_engine.getitemattrtext('APINVAPR',
                                                  itemkey,
                                                  'INV_MATCH_TYPE');
  
    /* commented for defect 3964
           IF l_inv_match_type = 'UNMATCHED' THEN
                  UPDATE AP_INVOICE_LINES_ALL
                  SET wfapproval_status = 'NOT REQUIRED'
                  WHERE invoice_id = p_invoice_id
                  AND wfapproval_status <> 'MANUALLY APPROVED';
           END IF;
    */
    /* Logic for Converting ISP requests into Invoices */
    OPEN c_invoice(p_invoice_id);
  
    FETCH c_invoice
      INTO l_invoice_type_lookup_code, l_gl_date, l_period_name, l_org_id;
  
    CLOSE c_invoice;
  
    IF l_invoice_type_lookup_code IN
       ('INVOICE REQUEST', 'CREDIT MEMO REQUEST') AND l_count > 0 THEN
      ap_utilities_pkg.get_open_gl_date(p_date        => l_gl_date,
                                        p_period_name => l_new_period_name,
                                        p_gl_date     => l_new_gl_date,
                                        p_org_id      => l_org_id);
      ap_isp_utilities_pkg.get_payment_terms(p_invoice_id       => p_invoice_id,
                                             p_terms_id         => l_terms_id,
                                             p_terms_date       => l_terms_date,
                                             p_calling_sequence => 'ap_workflow_pkg.get_header_approver');
    
      UPDATE ap_invoices_all
         SET invoice_type_lookup_code = DECODE(invoice_type_lookup_code,
                                               'INVOICE REQUEST',
                                               'STANDARD',
                                               'CREDIT MEMO REQUEST',
                                               'CREDIT',
                                               invoice_type_lookup_code),
             terms_id                 = l_terms_id,
             terms_date               = l_terms_date
       WHERE invoice_id = p_invoice_id;
    
      IF l_period_name <> l_new_period_name THEN
        UPDATE ap_invoices_all
           SET gl_date = l_new_gl_date
         WHERE invoice_id = p_invoice_id;
      
        UPDATE ap_invoice_lines_all
           SET accounting_date = l_new_gl_date,
               period_name     = l_new_period_name
         WHERE invoice_id = p_invoice_id;
      
        UPDATE ap_invoice_distributions_all
           SET accounting_date = l_new_gl_date,
               period_name     = l_new_period_name
         WHERE invoice_id = p_invoice_id;
      END IF;
    END IF;
  END;

  PROCEDURE is_invoice_authority(itemtype  IN VARCHAR2,
                                 itemkey   IN VARCHAR2,
                                 actid     IN NUMBER,
                                 funcmode  IN VARCHAR2,
                                 resultout OUT NOCOPY VARCHAR2) IS
    l_invoice_id NUMBER;
    l_org_id     NUMBER;
    l_person_id  NUMBER;
  BEGIN
    IF (funcmode = wf_engine.eng_run) THEN
      -- flip timeout
    
      --Added By Soniya doshi for CR#CR5505 Patch Retrofit Changes
      /*l_person_id  := wf_engine.getitemattrnumber(itemtype,itemkey,
      'APPROVER_ID');*/
      l_person_id  := g_approver_id;
      l_invoice_id := wf_engine.getitemattrnumber(itemtype,
                                                  itemkey,
                                                  'INVOICE_ID');
    
      SELECT org_id
        INTO l_org_id
        FROM ap_invoices_all
       WHERE invoice_id = l_invoice_id;
    
      -- remedy 4695858 start
      --Commented by CCBWIL for RT 6310441
      --mo_global.set_policy_context('S', l_org_id);
      --mo_global.init('SQLAP');
    
      --Added by CCBWIL for RT 6310441
      mo_global.init('SQLAP');
      mo_global.set_policy_context('S', l_org_id);
    
      -- remedy 4695858 end
    
      --      if  get_approval_limit(l_person_id, l_org_id) < get_invoice_amount(l_invoice_id) then
      -- remedy ticket 4668853 means that approval authority is required only for unmatched invoices
      -- matched invoices require only one approval
      --if ( get_approval_limit(l_person_id, l_org_id) < get_invoice_amount(l_invoice_id) ) and -- Commented on 28-May-2013 for Remedy Ticket# 4728645
      IF (get_approval_limit(l_person_id, l_org_id) <
         ABS(get_invoice_amount(l_invoice_id))) AND -- Added on 28-May-2013 for Remedy Ticket# 4728645
         ap_invoices_pkg.get_po_number(l_invoice_id) = 'UNMATCHED' THEN
        resultout := wf_engine.eng_completed || ':N';
      ELSE
        resultout := wf_engine.eng_completed || ':Y';
        complete_approval(itemtype, itemkey, l_invoice_id);
      END IF;
    
      RETURN;
    END IF;
  
    --
    -- CANCEL mode
    --
    IF (funcmode = wf_engine.eng_cancel) THEN
      --
      resultout := wf_engine.eng_completed || ':';
      RETURN;
      --
    END IF;
  
    --
    -- TIMEOUT mode
    --
    IF (funcmode = wf_engine.eng_timeout) THEN
      --
      resultout := wf_engine.eng_completed || ':';
      RETURN;
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT(itemtype,
                      'is_invoice_authority',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END is_invoice_authority;

  PROCEDURE timeout_invoice_appr(itemtype  IN VARCHAR2,
                                 itemkey   IN VARCHAR2,
                                 actid     IN NUMBER,
                                 funcmode  IN VARCHAR2,
                                 resultout OUT NOCOPY VARCHAR2) IS
    l_invoice_id    NUMBER;
    l_org_id        NUMBER;
    l_person_id     NUMBER;
    l_approver      ame_util.approverrecord2;
    l_approver_name VARCHAR2(150);
    l_role          VARCHAR2(50);
    l_role_display  VARCHAR2(150);
  BEGIN
    IF (funcmode = wf_engine.eng_run) THEN
      -- flip timeout
      l_person_id  := wf_engine.getitemattrnumber(itemtype,
                                                  itemkey,
                                                  'APPROVER_ID');
      l_invoice_id := wf_engine.getitemattrnumber(itemtype,
                                                  itemkey,
                                                  'INVOICE_ID');
    
      SELECT org_id
        INTO l_org_id
        FROM ap_invoices_all
       WHERE invoice_id = l_invoice_id;
    
      --Now set the environment
      mo_global.init('SQLAP');
      mo_global.set_policy_context('S', l_org_id);
      /*
            WF_DIRECTORY.GetUserName('PER',
                         l_person_id,
                         l_name,
                         l_approver_name);
      */
      wf_directory.getrolename('PER', l_person_id, l_role, l_role_display);
      -- bug#6837841 Changes End
      l_approver.NAME            := l_role;
      l_approver.api_insertion   := ame_util.apiinsertion;
      l_approver.authority       := ame_util.authorityapprover;
      l_approver.approval_status := ame_util.noresponsestatus;
      l_approver.item_class      := ame_util.headeritemclassname;
      l_approver.item_id         := TO_CHAR(l_invoice_id);
      --update AME
      ame_api2.updateapprovalstatus(applicationidin   => 200,
                                    transactiontypein => 'APINV',
                                    transactionidin   => TO_CHAR(l_invoice_id),
                                    approverin        => l_approver);
      resultout := wf_engine.eng_completed || ':';
    END IF;
  
    --
    -- CANCEL mode
    --
    IF (funcmode = wf_engine.eng_cancel) THEN
      --
      resultout := wf_engine.eng_completed || ':';
      RETURN;
      --
    END IF;
  
    --
    -- TIMEOUT mode
    --
    IF (funcmode = wf_engine.eng_timeout) THEN
      --
      resultout := wf_engine.eng_completed || ':';
      RETURN;
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT(itemtype,
                      'timeout_invoice_appr',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END timeout_invoice_appr;

  FUNCTION is_ship_po_required(p_invoice_id IN NUMBER) RETURN BOOLEAN IS
    l_result VARCHAR2(1);
  BEGIN
    SELECT fnd_profile.value_specific(NAME   => 'XXAP1516_DISTRB_APPROVAL',
                                      org_id => ai.org_id)
      INTO l_result
      FROM ap_invoices_all ai
     WHERE ai.invoice_id = p_invoice_id;
  
    RETURN NVL(l_result, 'N') = 'N';
  END;

  PROCEDURE is_distribution_balance(p_invoice_id    IN NUMBER,
                                    x_return_status OUT VARCHAR2,
                                    x_msg_data      OUT VARCHAR2) IS
    l_amount NUMBER;
  
    CURSOR l_data_csr(p_invoice_id NUMBER) IS
      SELECT ail.line_number,
             ail.amount,
             NVL(SUM(aid.amount), 0) distribution_amount
        FROM ap_invoice_lines_all ail, ap_invoice_distributions_all aid
       WHERE ail.invoice_id = p_invoice_id
         AND ail.line_type_lookup_code NOT IN ('TAX')
         AND ail.invoice_id = aid.invoice_id(+)
         AND ail.line_number = aid.invoice_line_number(+)
       GROUP BY ail.line_number, ail.amount
      HAVING ail.amount <> NVL(SUM(aid.amount), 0);
  BEGIN
    x_return_status := 'S';
  
    BEGIN
      SELECT ai.invoice_amount - NVL(SUM(aid.amount), 0)
        INTO l_amount
        FROM ap_invoice_lines_all aid, ap_invoices_all ai
       WHERE ai.invoice_id = aid.invoice_id(+)
         AND ai.invoice_id = p_invoice_id
       --  AND UPPER(aid.line_type_lookup_code) <> 'PREPAY' -- Commented w.r.to RT#8307021
	     AND UPPER(aid.line_type_lookup_code) NOT IN (SELECT UPPER(meaning) FROM FND_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'XXAP1516_LINE_TYPE_EXCLUSION' AND LANGUAGE = 'US') -- Added w.r.to RT#8307021
      --RT#6672359 --by soniya
       GROUP BY ai.invoice_amount
      HAVING ai.invoice_amount <> NVL(SUM(aid.amount), 0);
    
      x_return_status := 'E';
      x_msg_data      := 'Invoice lines do not add up to invoice total by ' ||
                         l_amount;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        x_return_status := 'S';
        x_msg_data      := NULL;
    END;
  
    -- defect 7192 -- disrtibutions need to add up to the line
    FOR l_data IN l_data_csr(p_invoice_id) LOOP
      x_return_status := 'E';
      x_msg_data      := 'Invoice line ' || l_data.line_number ||
                         ' amount is ' || l_data.amount ||
                         ' with distributions totalled to ' ||
                         l_data.distribution_amount || '.';
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status := 'E';
      x_msg_data      := SQLERRM;
  END is_distribution_balance;

  PROCEDURE is_ship_to_provided(p_invoice_id    IN NUMBER,
                                x_return_status OUT VARCHAR2,
                                x_msg_data      OUT VARCHAR2) IS
    l_amount NUMBER;
    l_lines  VARCHAR2(4000) := NULL;
  BEGIN
    x_return_status := 'S';
  
    IF NOT is_ship_po_required(p_invoice_id) THEN
      RETURN;
    END IF;
  
    FOR l_data IN (SELECT line_number
                     FROM ap_invoice_lines_all
                    WHERE NVL(cancelled_flag, 'N') = 'N'
                      AND NVL(discarded_flag, 'N') = 'N'
                      AND line_type_lookup_code = 'ITEM'
                      AND (ship_to_location_id IS NULL OR
                           ship_to_location_id = 4300) -- GLOBAL SHIP TO, remedy 4728645
                      AND invoice_id = p_invoice_id) LOOP
      x_return_status := 'E';
    
      IF l_lines IS NOT NULL THEN
        l_lines := l_lines || ', ';
      END IF;
    
      l_lines := l_lines || l_data.line_number;
    END LOOP;
  
    IF x_return_status <> 'S' THEN
      x_msg_data := 'Ship to location is not provided for the following lines ' ||
                    l_lines;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status := 'E';
      x_msg_data      := SQLERRM;
  END is_ship_to_provided;

  PROCEDURE is_po_category_provided(p_invoice_id    IN NUMBER,
                                    x_return_status OUT VARCHAR2,
                                    x_msg_data      OUT VARCHAR2) IS
    l_amount NUMBER;
    l_lines  VARCHAR2(4000) := NULL;
  BEGIN
    x_return_status := 'S';
  
    IF NOT is_ship_po_required(p_invoice_id) THEN
      RETURN;
    END IF;
  
    FOR l_data IN (SELECT line_number
                     FROM ap_invoice_lines_all
                    WHERE match_type = 'NOT_MATCHED'
                      AND NVL(cancelled_flag, 'N') = 'N'
                      AND NVL(discarded_flag, 'N') = 'N'
                      AND line_type_lookup_code = 'ITEM'
                      AND purchasing_category_id IS NULL
                      AND invoice_id = p_invoice_id) LOOP
      x_return_status := 'E';
    
      IF l_lines IS NOT NULL THEN
        l_lines := l_lines || ', ';
      END IF;
    
      l_lines := l_lines || l_data.line_number;
    END LOOP;
  
    IF x_return_status <> 'S' THEN
      x_msg_data := 'Purchasing category is not provided for the following lines ' ||
                    l_lines;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status := 'E';
      x_msg_data      := SQLERRM;
  END is_po_category_provided;

  /* This function is_gl_entity_valid is for Form Personalization (in AP Invoice Workbench form) to validate the Entity
  entered at the Distribution level under MOAC Responsibility during AP Approval process (CR4574- XXAP2137) */
  FUNCTION is_gl_entity_valid(p_invoice_id IN NUMBER,
                              p_entity     IN VARCHAR2,
                              p_org_id     IN NUMBER) RETURN VARCHAR2 IS
    l_entity         NUMBER;
    l_valid_count    NUMBER;
    l_operating_unit VARCHAR2(100);
    l_msg_data       VARCHAR2(200);
    l_count          NUMBER := 0;
  BEGIN
    l_entity := SUBSTR(p_entity, 1, INSTR(p_entity, '.', 1) - 1);
  
    SELECT NAME
      INTO l_operating_unit
      FROM hr_operating_units
     WHERE organization_id = p_org_id;
  
    SELECT COUNT(1)
      INTO l_valid_count
      FROM fnd_flex_value_rules_vl    ffvr,
           fnd_flex_value_rule_lines  ffvl,
           fnd_flex_value_rule_usages ffvu,
           fnd_responsibility_vl      fr,
           fnd_flex_value_sets        ffvs,
           fnd_profile_option_values  fp
     WHERE ffvr.flex_value_rule_id = ffvl.flex_value_rule_id
       AND ffvr.flex_value_rule_id = ffvu.flex_value_rule_id
       AND ffvr.flex_value_set_id = ffvu.flex_value_set_id
       AND ffvu.application_id = fr.application_id
       AND fr.application_id = 200
       AND fr.responsibility_id = ffvu.responsibility_id
       AND (fr.end_date >= TRUNC(SYSDATE) OR fr.end_date IS NULL)
       AND ffvs.flex_value_set_id = ffvr.flex_value_set_id
       AND ffvs.flex_value_set_name = 'XXIR_GL_ENTITY'
       AND fp.level_value = fr.responsibility_id
       AND fp.profile_option_id = '1991'
       AND fp.profile_option_value = p_org_id
       AND fp.level_value_application_id = fr.application_id
       AND l_entity BETWEEN flex_value_low AND flex_value_high
       AND UPPER(fr.responsibility_name) LIKE '%AP%MANAGER%';
  
    IF (l_valid_count = 0) THEN
      FOR rec_entity IN (SELECT DISTINCT ffvr.description
                           FROM fnd_flex_value_rules_vl    ffvr,
                                fnd_flex_value_rule_lines  ffvl,
                                fnd_flex_value_rule_usages ffvu,
                                fnd_responsibility_vl      fr,
                                fnd_flex_value_sets        ffvs,
                                fnd_profile_option_values  fp
                          WHERE ffvr.flex_value_rule_id =
                                ffvl.flex_value_rule_id
                            AND ffvr.flex_value_rule_id =
                                ffvu.flex_value_rule_id
                            AND ffvr.flex_value_set_id =
                                ffvu.flex_value_set_id
                            AND ffvu.application_id = fr.application_id
                            AND fr.application_id = 200
                            AND fr.responsibility_id =
                                ffvu.responsibility_id
                            AND (fr.end_date >= TRUNC(SYSDATE) OR
                                fr.end_date IS NULL)
                            AND ffvs.flex_value_set_id =
                                ffvr.flex_value_set_id
                            AND ffvs.flex_value_set_name = 'XXIR_GL_ENTITY'
                            AND fp.level_value = fr.responsibility_id
                            AND fp.profile_option_id = '1991'
                            AND fp.profile_option_value = p_org_id
                            AND fp.level_value_application_id =
                                fr.application_id
                            AND UPPER(fr.responsibility_name) LIKE
                                '%AP%MANAGER%') LOOP
        l_msg_data := l_msg_data || CHR(10) || rec_entity.description;
      END LOOP;
    
      l_msg_data := 'Error: Invalid Distribution Account entered. ' ||
                    CHR(10) || 'Entity ' || l_entity ||
                    ' is invalid for OU ' || l_operating_unit || CHR(10) ||
                    'Please choose any one Entity from below' || l_msg_data;
      RETURN l_msg_data;
    ELSE
      RETURN NULL;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      l_msg_data := SQLERRM;
  END is_gl_entity_valid;

  /* This procedure is_gl_entity_valid is for validating the Entity entered at the Distribution level
  under MOAC Responsibility during AP Approval process (CR4574-XXAP1516)*/
  PROCEDURE is_gl_entity_valid(p_invoice_id    IN NUMBER,
                               x_return_status OUT VARCHAR2,
                               x_msg_data      OUT VARCHAR2) IS
    l_entity         NUMBER;
    l_org_id         NUMBER;
    l_count          NUMBER := 0;
    l_operating_unit VARCHAR2(100);
    l_valid_count    NUMBER;
    -- increased the length of the column for RT#8503133
    l_line_num       VARCHAR2(32767);
  BEGIN
    x_return_status := 'S';
  
    FOR rec_dist IN (SELECT DISTINCT glc.segment1,--Added by ccbwil for CR5559 
                            org_id,
                            hou.NAME                     operating_unit,
                            aid.distribution_line_number line_num
                       FROM ap_invoice_distributions_all aid,
                            gl_code_combinations         glc,
                            hr_operating_units           hou
                      WHERE aid.invoice_id = p_invoice_id
                        AND aid.org_id = hou.organization_id
                        AND aid.line_type_lookup_code = 'ITEM'
                        AND aid.dist_code_combination_id =
                            glc.code_combination_id
                      ORDER BY aid.distribution_line_number) LOOP
      l_line_num       := l_line_num || ', ' || rec_dist.line_num;
      l_org_id         := rec_dist.org_id;
      l_operating_unit := rec_dist.operating_unit;
    
      SELECT COUNT(1)
        INTO l_valid_count
        FROM fnd_flex_value_rules_vl    ffvr,
             fnd_flex_value_rule_lines  ffvl,
             fnd_flex_value_rule_usages ffvu,
             fnd_responsibility_vl      fr,
             fnd_flex_value_sets        ffvs,
             fnd_profile_option_values  fp
       WHERE ffvr.flex_value_rule_id = ffvl.flex_value_rule_id
         AND ffvr.flex_value_rule_id = ffvu.flex_value_rule_id
         AND ffvr.flex_value_set_id = ffvu.flex_value_set_id
         AND ffvu.application_id = fr.application_id
         AND fr.application_id = 200
         AND fr.responsibility_id = ffvu.responsibility_id
         AND (fr.end_date >= TRUNC(SYSDATE) OR fr.end_date IS NULL)
         AND ffvs.flex_value_set_id = ffvr.flex_value_set_id
         AND ffvs.flex_value_set_name = 'XXIR_GL_ENTITY'
         AND fp.level_value = fr.responsibility_id
         AND fp.profile_option_id = '1991'
         AND fp.profile_option_value = rec_dist.org_id
         AND fp.level_value_application_id = fr.application_id
         AND rec_dist.segment1 BETWEEN flex_value_low AND flex_value_high
         AND UPPER(fr.responsibility_name) LIKE '%AP%MANAGER%';
    
      IF (l_valid_count = 0) THEN
        l_count         := 1;
        x_return_status := 'E';
      ELSE
        x_return_status := 'S';
      END IF;
    END LOOP;
  
    IF l_count = 1 THEN
      FOR rec_entity IN (SELECT DISTINCT ffvr.description
                           FROM fnd_flex_value_rules_vl    ffvr,
                                fnd_flex_value_rule_lines  ffvl,
                                fnd_flex_value_rule_usages ffvu,
                                fnd_responsibility_vl      fr,
                                fnd_flex_value_sets        ffvs,
                                fnd_profile_option_values  fp
                          WHERE ffvr.flex_value_rule_id =
                                ffvl.flex_value_rule_id
                            AND ffvr.flex_value_rule_id =
                                ffvu.flex_value_rule_id
                            AND ffvr.flex_value_set_id =
                                ffvu.flex_value_set_id
                            AND ffvu.application_id = fr.application_id
                            AND fr.application_id = 200
                            AND fr.responsibility_id =
                                ffvu.responsibility_id
                            AND (fr.end_date >= TRUNC(SYSDATE) OR
                                fr.end_date IS NULL)
                            AND ffvs.flex_value_set_id =
                                ffvr.flex_value_set_id
                            AND ffvs.flex_value_set_name = 'XXIR_GL_ENTITY'
                            AND fp.level_value = fr.responsibility_id
                            AND fp.profile_option_id = '1991'
                            AND fp.profile_option_value = l_org_id
                            AND fp.level_value_application_id =
                                fr.application_id
                            AND UPPER(fr.responsibility_name) LIKE
                                '%AP%MANAGER%') LOOP
        x_msg_data := x_msg_data || CHR(10) || rec_entity.description;
      END LOOP;
    
      l_line_num      := LTRIM(l_line_num, ', ');
      x_msg_data      := 'Error: Given Enity is invalid for OU ' ||
                         l_operating_unit || ' for Line Number(s) - ' ||
                         l_line_num || CHR(10) ||
                         'Please choose any one Entity from below' ||
                         x_msg_data;
      x_return_status := 'E';
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      x_return_status := 'E';
      x_msg_data      := 'No Data Found while deriving Entity: ' || SQLERRM;
    WHEN OTHERS THEN
      x_return_status := 'E';
      x_msg_data      := SQLERRM;
  END is_gl_entity_valid;

  PROCEDURE is_invoice_valid(p_invoice_id    IN NUMBER,
                             x_return_status OUT VARCHAR2,
                             x_msg_tbl       OUT ame_util.longeststringlist) IS
    l_return_status VARCHAR2(1);
    l_msg_data      VARCHAR2(4000);
  BEGIN
    x_return_status := 'S';
    is_distribution_balance(p_invoice_id, l_return_status, l_msg_data);
  
    IF l_return_status <> 'S' THEN
      x_msg_tbl(x_msg_tbl.COUNT + 1) := l_msg_data;
      x_return_status := 'E';
    END IF;
  
    is_ship_to_provided(p_invoice_id, l_return_status, l_msg_data);
  
    IF l_return_status <> 'S' THEN
      x_msg_tbl(x_msg_tbl.COUNT + 1) := l_msg_data;
      x_return_status := 'E';
    END IF;
  
    is_po_category_provided(p_invoice_id, l_return_status, l_msg_data);
  
    IF l_return_status <> 'S' THEN
      x_msg_tbl(x_msg_tbl.COUNT + 1) := l_msg_data;
      x_return_status := 'E';
    END IF;
  
    -- Added below code for CR4574
    is_gl_entity_valid(p_invoice_id, l_return_status, l_msg_data);
  
    IF l_return_status <> 'S' THEN
      x_msg_tbl(x_msg_tbl.COUNT + 1) := l_msg_data;
      x_return_status := 'E';
    END IF;
    -- Added above code for CR4574
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status := 'E';
      x_msg_tbl(x_msg_tbl.COUNT + 1) := SQLERRM;
  END is_invoice_valid;

  PROCEDURE is_invoice_valid(itemtype  IN VARCHAR2,
                             itemkey   IN VARCHAR2,
                             actid     IN NUMBER,
                             funcmode  IN VARCHAR2,
                             resultout OUT NOCOPY VARCHAR2) IS
    l_invoice_id    NUMBER;
    l_return_status VARCHAR2(1);
    l_msg_tbl       ame_util.longeststringlist;
    l_msg_data      VARCHAR2(4000);
  BEGIN
    IF (funcmode = wf_engine.eng_run) THEN
      l_invoice_id := wf_engine.getitemattrnumber(itemtype,
                                                  itemkey,
                                                  'INVOICE_ID');
      is_invoice_valid(l_invoice_id, l_return_status, l_msg_tbl);
    
      IF l_return_status = 'S' THEN
        resultout := wf_engine.eng_completed || ':Y';
      ELSE
        resultout := wf_engine.eng_completed || ':N';
      
        -- assign new errors, and clean up the old errors
        FOR i IN 1 .. 3 LOOP
          l_msg_data := NULL;
        
          IF i <= l_msg_tbl.COUNT THEN
            l_msg_data := l_msg_tbl(i);
          END IF;
        
          wf_engine.setitemattrtext(itemtype,
                                    itemkey,
                                    'XX_ERROR_MESSAGE' || i,
                                    l_msg_data);
        END LOOP;
      END IF;
    ELSE
      resultout := wf_engine.eng_completed || ':';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT(itemtype,
                      'is_invoice_valid',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END is_invoice_valid;

  /* CR#3870. Below FUNCTION added to check whether the invoice is valid or not before
  the escalating to next level approver from Requester.
  If the invoice requester and document approver is same after the first
  notification is timesout.  */
  PROCEDURE is_requester_comp_inv(itemtype  IN VARCHAR2,
                                  itemkey   IN VARCHAR2,
                                  actid     IN NUMBER,
                                  funcmode  IN VARCHAR2,
                                  resultout OUT NOCOPY VARCHAR2) IS
    l_invoice_id        NUMBER;
    l_requester_id      NUMBER;
    l_approver_id       NUMBER;
    l_return_status     VARCHAR2(1);
    l_msg_tbl           ame_util.longeststringlist;
    l_msg_data          VARCHAR2(4000);
    l_document_approver VARCHAR2(150);
  BEGIN
    IF (funcmode = wf_engine.eng_run) THEN
      resultout           := wf_engine.eng_completed || ':N';
      l_invoice_id        := wf_engine.getitemattrnumber(itemtype,
                                                         itemkey,
                                                         'INVOICE_ID');
      l_approver_id       := wf_engine.getitemattrnumber(itemtype,
                                                         itemkey,
                                                         'APPROVER_ID');
      l_document_approver := wf_engine.getitemattrtext(itemtype,			-- RT#7257032 - changed getitemattrnumber to getitemattrtext
                                                         itemkey,
                                                         'DOCUMENT_APPROVER');
    
      SELECT requester_id
        INTO l_requester_id
        FROM ap_invoices_all
       WHERE invoice_id = l_invoice_id;
    
      wf_engine.setitemattrtext(itemtype,
                                itemkey,
                                'ROLE_ACTUAL',
                                l_document_approver);
    
      IF l_requester_id = l_approver_id THEN
        is_invoice_valid(l_invoice_id, l_return_status, l_msg_tbl);
      
        IF l_return_status = 'S' THEN
          resultout := wf_engine.eng_completed || ':Y';
        ELSE
          -- assign new errors, and clean up the old errors
          FOR i IN 1 .. 3 LOOP
            l_msg_data := NULL;
          
            IF i <= l_msg_tbl.COUNT THEN
              l_msg_data := l_msg_tbl(i);
            END IF;
          
            wf_engine.setitemattrtext(itemtype,
                                      itemkey,
                                      'XX_ERROR_MESSAGE' || i,
                                      l_msg_data);
          END LOOP;
        
          resultout := wf_engine.eng_completed || ':N';
          RETURN;
        END IF;
      ELSE
        resultout := wf_engine.eng_completed || ':Y';
        RETURN;
      END IF;
    ELSE
      resultout := wf_engine.eng_completed || ':';
      RETURN;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT(itemtype,
                      'is_requester_comp_inv',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END is_requester_comp_inv;

  --end of the function
  FUNCTION is_hierarchy_complete(p_invoice_id IN NUMBER) RETURN VARCHAR2 IS
    CURSOR l_data_csr IS
      SELECT NVL(approver_id, 0) person_id
        FROM (SELECT /*NVL(ph.agent_id, ai.requester_id)*/ --Changes by CCBWIL RT#7084072
               COALESCE(pr.agent_id, ph.agent_id, ai.requester_id) approver_id
                FROM ap_invoices_all              ai,
                     ap_invoice_distributions_all aid,
                     po_distributions_all         pd,
                     po_headers_all               ph,
                     po_releases_all              pr --Changes by CCBWIL RT#7084072
               WHERE ai.invoice_id = aid.invoice_id(+)
                 AND aid.po_distribution_id = pd.po_distribution_id(+)
                 AND pd.po_header_id = ph.po_header_id(+)
                 AND pd.po_release_id = pr.po_release_id(+) --Changes by CCBWIL RT#7084072
                 AND ai.invoice_id = p_invoice_id
               ORDER BY 1)
       WHERE ROWNUM = 1
      UNION ALL
      SELECT pa.supervisor_id
        FROM per_assignments_x pa
       WHERE pa.assignment_type = 'E'
         AND pa.primary_flag = 'Y'
         AND SYSDATE BETWEEN pa.effective_start_date AND
             pa.effective_end_date
      CONNECT BY NOCYCLE PRIOR pa.supervisor_id = pa.person_id
             AND pa.assignment_type = 'E'
             AND pa.primary_flag = 'Y'
             AND SYSDATE BETWEEN pa.effective_start_date AND
                 pa.effective_end_date
       START WITH pa.person_id =
                  (SELECT NVL(approver_id, 0)
                     FROM (SELECT /*NVL(ph.agent_id, ai.requester_id)*/ --Changes by CCBWIL RT#7084072
                            COALESCE(pr.agent_id,
                                     ph.agent_id,
                                     ai.requester_id) approver_id
                             FROM ap_invoices_all              ai,
                                  ap_invoice_distributions_all aid,
                                  po_distributions_all         pd,
                                  po_headers_all               ph,
                                  po_releases_all              pr --Changes by CCBWIL RT#7084072
                            WHERE ai.invoice_id = aid.invoice_id(+)
                              AND aid.po_distribution_id =
                                  pd.po_distribution_id(+)
                              AND pd.po_header_id = ph.po_header_id(+)
                              AND pd.po_release_id = pr.po_release_id(+) --Changes by CCBWIL RT#7084072
                              AND ai.invoice_id = p_invoice_id
                            ORDER BY 1)
                    WHERE ROWNUM = 1);
  
    l_top_person_id NUMBER := NULL;
    l_org_id        NUMBER;
  BEGIN
    FOR l_data IN l_data_csr LOOP
      l_top_person_id := l_data.person_id;
    END LOOP;
  
    -- empty hierarchy
    IF l_top_person_id IS NULL THEN
      RETURN 'N';
    END IF;
  
    SELECT org_id
      INTO l_org_id
      FROM ap_invoices_all
     WHERE invoice_id = p_invoice_id;
  
    IF get_approval_limit(l_top_person_id, l_org_id) <
       get_invoice_amount(p_invoice_id) THEN
      RETURN 'N';
    END IF;
  
    RETURN 'Y';
  END;

  --added by soniya for CR#4586 wait period based on 'Need by date'
  PROCEDURE exists_needbydate_wait(itemtype  IN VARCHAR2,
                                   itemkey   IN VARCHAR2,
                                   actid     IN NUMBER,
                                   funcmode  IN VARCHAR2,
                                   resultout OUT NOCOPY VARCHAR2) IS
    l_org_id     NUMBER;
    l_invoice_id NUMBER;
    l_hold_id    NUMBER;
    l_num        NUMBER;
    l_wait_time  NUMBER;
    l_debug_info VARCHAR2(2000);
    l_po_type    VARCHAR2(200);
    l_api_name CONSTANT VARCHAR2(200) := 'exists_needbydate_wait';
  BEGIN
    l_org_id     := wf_engine.getitemattrnumber(itemtype, itemkey, 'ORG_ID');
    l_invoice_id := wf_engine.getitemattrnumber(itemtype,
                                                itemkey,
                                                'INVOICE_ID');
    l_hold_id    := wf_engine.getitemattrnumber(itemtype,
                                                itemkey,
                                                'HOLD_ID');
    l_debug_info := 'Before select';
  
    IF (g_level_statement >= g_current_runtime_level) THEN
      fnd_log.STRING(g_level_statement,
                     g_module_name || l_api_name,
                     l_debug_info);
    END IF;
  
    SELECT DISTINCT (ph.type_lookup_code) --added distinct for 6358917 by CCBWIL
      INTO l_po_type
      FROM ap_holds_all aph, po_distributions_all pd, po_headers_all ph
     WHERE pd.line_location_id(+) = aph.line_location_id
       AND pd.po_header_id = ph.po_header_id(+)
       AND aph.hold_id = l_hold_id
       AND aph.hold_lookup_code = 'QTY REC';
  
    IF UPPER(l_po_type) = 'BLANKET' THEN
      SELECT DISTINCT (NVL(TRUNC(pll.need_by_date) - TRUNC(SYSDATE), 0)) --added distinct for 6358917 by CCBWIL
        INTO l_wait_time
        FROM ap_holds_all          aph,
             po_distributions_all  pd,
             po_releases_all       po,
             po_headers_all        ph,
             po_line_locations_all pll,
             po_lines_all          pl
       WHERE pd.line_location_id = aph.line_location_id
         AND po.po_release_id = pd.po_release_id
         AND po.po_header_id = ph.po_header_id
         AND pll.po_release_id = po.po_release_id
         AND pl.po_line_id = pll.po_line_id
         AND pd.po_line_id = pl.po_line_id
         AND pd.line_location_id = pll.line_location_id
         AND ph.type_lookup_code = l_po_type
         AND pl.item_id IS NOT NULL
         AND UPPER(pd.destination_type_code) = 'INVENTORY'
         AND aph.hold_id = l_hold_id
         AND aph.invoice_id = l_invoice_id
         AND aph.org_id = l_org_id;
    ELSE
      SELECT DISTINCT (NVL(TRUNC(pll.need_by_date) - TRUNC(SYSDATE), 0)) --added distinct for 6358917 by CCBWIL
        INTO l_wait_time
        FROM ap_holds_all          aph,
             po_distributions_all  pd,
             po_headers_all        ph,
             po_line_locations_all pll,
             po_lines_all          pl
       WHERE pd.line_location_id = aph.line_location_id
         AND pd.po_header_id = ph.po_header_id
         AND pll.po_header_id = ph.po_header_id
         AND pl.po_line_id = pll.po_line_id
         AND pl.po_header_id = ph.po_header_id
         AND aph.hold_id = l_hold_id
         AND pd.po_line_id = pl.po_line_id
         AND pd.line_location_id = pll.line_location_id
         AND pl.item_id IS NOT NULL
         AND UPPER(pd.destination_type_code) = 'INVENTORY'
         AND aph.invoice_id = l_invoice_id
         AND aph.org_id = l_org_id;
    END IF;
  
    IF l_wait_time > 0 THEN
      wf_engine.setitemattrnumber(itemtype,
                                  itemkey,
                                  'NEEDBYDATE_WAIT_TIME',
                                  1); --wait for 1 day
      resultout := wf_engine.eng_completed || ':' || 'Y';
    ELSE
      resultout := wf_engine.eng_completed || ':' || 'N';
    END IF;
  
    l_debug_info := 'After select, reultout : ' || resultout;
  
    IF (g_level_statement >= g_current_runtime_level) THEN
      fnd_log.STRING(g_level_statement,
                     g_module_name || l_api_name,
                     l_debug_info);
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      resultout := wf_engine.eng_completed || ':' || 'N';
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVHDN',
                      'exists_needbydate_wait',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END exists_needbydate_wait;

  --Start of code changes By Soniya doshi for CR#CR5505 Patch Retrofit Changes
  PROCEDURE xxprocess_doc_approval(itemtype  IN VARCHAR2,
                                   itemkey   IN VARCHAR2,
                                   actid     IN NUMBER,
                                   funcmode  IN VARCHAR2,
                                   resultout OUT NOCOPY VARCHAR2) IS
  BEGIN
    g_ame_sub_approval_response := 'APPROVE';
    g_approver_id               := wf_engine.getitemattrnumber(itemtype,
                                                               itemkey,
                                                               'APPROVER_ID');
    resultout                   := wf_engine.eng_completed || ':' || 'Y';
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'xxprocess_doc_approval',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END xxprocess_doc_approval;

  --
  PROCEDURE xxprocess_doc_rejection(itemtype  IN VARCHAR2,
                                    itemkey   IN VARCHAR2,
                                    actid     IN NUMBER,
                                    funcmode  IN VARCHAR2,
                                    resultout OUT NOCOPY VARCHAR2) IS
  BEGIN
    g_ame_sub_approval_response := 'REJECT';
    resultout                   := wf_engine.eng_completed || ':' || 'Y';
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'xxprocess_doc_rejection',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END xxprocess_doc_rejection;

  --
  PROCEDURE xxprocess_doc_timeout(itemtype  IN VARCHAR2,
                                  itemkey   IN VARCHAR2,
                                  actid     IN NUMBER,
                                  funcmode  IN VARCHAR2,
                                  resultout OUT NOCOPY VARCHAR2) IS
  BEGIN
    g_ame_sub_approval_response := 'TIMEOUT';
    resultout                   := wf_engine.eng_completed || ':' || 'Y';
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'xxprocess_doc_timeout',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END xxprocess_doc_timeout;

  --Refered process_sub_approval_response from oracle AP_WORKFLOW_PKG
  PROCEDURE xxprocess_sub_approval_resp(itemtype  IN VARCHAR2,
                                        itemkey   IN VARCHAR2,
                                        actid     IN NUMBER,
                                        funcmode  IN VARCHAR2,
                                        resultout OUT NOCOPY VARCHAR2) IS
    l_parent_item_type wf_items.parent_item_type%TYPE;
    l_parent_item_key  wf_items.parent_item_key%TYPE;
    l_incomplete_child NUMBER;
    l_debug_info       VARCHAR2(2000); -- Bug 18382236
    l_invoice_id       NUMBER;
    l_cnt              PLS_INTEGER := 0;
    l_approver_name    VARCHAR2(150);
    l_role_name        VARCHAR2(150);
  BEGIN
    IF (funcmode <> wf_engine.eng_run) THEN
      resultout := wf_engine.eng_null;
      RETURN;
    END IF;
  
    BEGIN
      SELECT parent_item_type, parent_item_key
        INTO l_parent_item_type, l_parent_item_key
        FROM wf_items
       WHERE item_type = itemtype
         AND item_key = itemkey;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  
    IF (g_ame_sub_approval_response = 'TIMEOUT') THEN
      l_approver_name := wf_engine.getitemattrtext('APINVAPR',
                                                   itemkey,
                                                   'APPROVER_NAME');
      l_role_name     := wf_engine.getitemattrtext('APINVAPR',
                                                   itemkey,
                                                   'ROLE_NAME');
    
      --check added to handle delegate
      IF l_approver_name <> l_role_name THEN
        SELECT SUBSTR(itemkey, 1, INSTR(itemkey, '-') - 1)
          INTO l_invoice_id
          FROM DUAL;
      
        BEGIN
          SELECT COUNT(1)
            INTO l_cnt
            FROM ap_wfapproval_history_v /* AP_INV_APRVL_HIST_ALL */
           WHERE invoice_id = l_invoice_id
             AND response = 'DELEGATED';
        EXCEPTION
          WHEN OTHERS THEN
            l_cnt := 0;
        END;
      
        IF l_cnt > 0 THEN
          ame_api2.clearallapprovals(applicationidin   => 200,
                                     transactiontypein => 'APINV',
                                     transactionidin   => l_invoice_id);
        END IF;
      END IF;
    
      --
      BEGIN
        SELECT COUNT(*)
          INTO l_incomplete_child
          FROM wf_items                  wfi,
               wf_item_activity_statuses wfias,
               wf_notifications          wfn
         WHERE wfi.parent_item_key = l_parent_item_key
           AND wfi.item_type = l_parent_item_type
           AND wfias.item_type = wfi.item_type
           AND wfias.item_key = wfi.item_key
           AND wfias.activity_status <> 'COMPLETE'
           AND wfias.notification_id IS NOT NULL
           AND wfias.notification_id = wfn.notification_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
    
      IF l_incomplete_child < 1 THEN
        wf_engine.completeactivity(itemtype => l_parent_item_type,
                                   itemkey  => l_parent_item_key,
                                   activity => 'HEADER_BLOCK',
                                   RESULT   => NULL);
      END IF;
    END IF;
  
    resultout := wf_engine.eng_completed || ':' || 'ACTIVITY_PERFORMED';
    RETURN;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'xxprocess_sub_approval_resp',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END xxprocess_sub_approval_resp;

  -- base verion get_ame_sub_approval_resp from seeded AP_WORKFLOW_PKG
  PROCEDURE xxget_ame_sub_approval_resp(itemtype  IN VARCHAR2,
                                        itemkey   IN VARCHAR2,
                                        actid     IN NUMBER,
                                        funcmode  IN VARCHAR2,
                                        resultout OUT NOCOPY VARCHAR2) IS
  BEGIN
    IF (funcmode <> wf_engine.eng_run) THEN
      resultout := wf_engine.eng_null;
      RETURN;
    END IF;
  
    --
    IF (g_ame_sub_approval_response = 'APPROVE') THEN
      resultout := wf_engine.eng_completed || ':' || 'APPROVED';
    ELSIF (g_ame_sub_approval_response = 'REJECT') THEN
      resultout := wf_engine.eng_completed || ':' || 'REJECTED';
    ELSIF (g_ame_sub_approval_response = 'TIMEOUT') THEN
      resultout := wf_engine.eng_completed || ':' || 'TIMEOUT';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'xxget_ame_sub_approval_resp',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END xxget_ame_sub_approval_resp;

  PROCEDURE is_invoice_reject(itemtype  IN VARCHAR2,
                              itemkey   IN VARCHAR2,
                              actid     IN NUMBER,
                              funcmode  IN VARCHAR2,
                              resultout OUT NOCOPY VARCHAR2) IS
    v_item_key          VARCHAR2(240);
    v_approver_id       NUMBER;
    v_document_approver VARCHAR2(240);
  BEGIN
    IF (funcmode <> wf_engine.eng_run) THEN
      resultout := wf_engine.eng_null;
      RETURN;
    END IF;
  
    --
    IF g_ame_sub_approval_response IN ('APPROVE', 'REJECT', 'TIMEOUT') THEN
      BEGIN
        SELECT wi.item_key, wiav.number_value, ppf.local_name
          INTO v_item_key, v_approver_id, v_document_approver
          FROM wf_items                 wi,
               wf_item_attribute_values wiav,
               per_all_people_f         ppf
         WHERE wi.item_type = itemtype
           AND wi.ROWID = (SELECT MIN(ROWID)
                             FROM wf_items
                            WHERE parent_item_key = itemkey
                              AND item_type = itemtype)
           AND wi.item_key = wiav.item_key
           AND wiav.NAME = 'APPROVER_ID'
           AND wi.item_type = wiav.item_type
           AND wiav.number_value = ppf.person_id
           AND TRUNC(SYSDATE) BETWEEN ppf.effective_start_date AND
               ppf.effective_end_date;
      
        wf_engine.setitemattrnumber('APINVAPR',
                                    itemkey,
                                    'APPROVER_ID',
                                    v_approver_id);
        wf_engine.setitemattrtext(itemtype,
                                  itemkey,
                                  'DOCUMENT_APPROVER',
                                  v_document_approver);
      EXCEPTION
        WHEN OTHERS THEN
          wf_core.CONTEXT('APINVAPR',
                          'is_invoice_reject',
                          itemtype,
                          itemkey,
                          TO_CHAR(actid),
                          funcmode);
          RAISE;
      END;
    
      resultout := wf_engine.eng_completed || ':' || 'Y';
    ELSE
      resultout := wf_engine.eng_completed || ':' || 'N';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'is_invoice_reject',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END is_invoice_reject;
  --End of code changes By Soniya doshi for CR#CR5505 Patch Retrofit Changes
  --Start of code changes Added by CCBWIL for CR7198 - Personal AP Worklist View Creation  
  PROCEDURE set_attribute_values(itemtype  IN VARCHAR2,
                                 itemkey   IN VARCHAR2,
                                 actid     IN NUMBER,
                                 funcmode  IN VARCHAR2,
                                 resultout OUT NOCOPY VARCHAR2) IS
    l_invoice_due_date DATE;
    l_invoice_id       NUMBER;
  BEGIN
    l_invoice_id := wf_engine.getitemattrnumber(itemtype,
                                                itemkey,
                                                'INVOICE_ID');
    BEGIN
      SELECT DISTINCT (apsa.due_date)
        INTO l_invoice_due_date
        FROM ap_payment_schedules_all apsa
       WHERE apsa.invoice_id = l_invoice_id;
    EXCEPTION
      WHEN OTHERS THEN
        l_invoice_due_date := NULL;
    END;
  
    IF l_invoice_due_date IS NOT NULL THEN
      BEGIN
        wf_engine.SetItemAttrDate('APINVAPR',
                                  itemkey,
                                  'XX_INVOICE_DUE_DATE',
                                  l_invoice_due_date);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      wf_core.CONTEXT('APINVAPR',
                      'set_attribute_values',
                      itemtype,
                      itemkey,
                      TO_CHAR(actid),
                      funcmode);
      RAISE;
  END set_attribute_values;
  -- END of code changes Added by CCBWIL for CR7198 - Personal AP Worklist View Creation  
END xxap_workflow_pkg;
/
