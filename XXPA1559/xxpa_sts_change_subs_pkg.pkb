create or replace PACKAGE BODY xxpa_sts_change_subs_pkg AS
  /***********************************************************************
  ** Title:       XXPA Project Credit Approval Status Change Subscription Program
  ** File:        xxpa_sts_change_subs_pkg.pkb
  ** Description: Package is called on Project Credit Approval Workflow Completion
  ** Run as:      APPS
  ** Keyword Tracking:
  **
  ** Keyword Tracking:
  **   
  **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_sts_change_subs_pkg.pkb 1.4 04-DEC-2017 01:35:15 CCBSSJ $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.4 (COMPLETE)
  **     Created:  04-DEC-2017 01:35:15      CCBSSJ (Vishnusimman Manivannan)
  **       CR5963 - Added delay if there are multiple requisitions available
  **       for the project to avoid duplicates
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  20-NOV-2017 22:30:48      CCBSSJ (Vishnusimman Manivannan)
  **       CR5963 - Added delay if there are multiple requisitions available
  **       for the project to avoid duplicates
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  09-NOV-2017 18:20:44      CCBSSJ (Vishnusimman Manivannan)
  **       CR5963 - Added submit_xxint_bkg_program to avoid timing issues with
  **       Requsition
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  20-JUL-2017 05:06:52      CCBUUN (Joydeb Saha)
  **       CR5963 Changes.
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  20-JUL-2017 00:31:24      CCBSSJ (Vishnusimman Manivannan)
  **       Initial revision.
  **   
  **
  **
  ** History:
  ** Date           Who                Description
  ** -----------    ------------------ ------------------------------------
  ** 20-Jun-2017    Vishnusimman M     Initial Creation for CR5963
  ** 09-Nov-2017    Vishnusimman M     Added submit_xxint_bkg_program to avoid timing issues with Requsition
  ** 20-Nov-2017    Vishnusimman M     Added delay if there are multiple requisitions available for the project to avoid duplicates
  ************************************************************************/
  FUNCTION submit_xxint_bkg_program(p_guid                       in VARCHAR2,
                                    p_event_phase                IN VARCHAR2,
                                    p_event_interval             IN VARCHAR2,
                                    p_event_type                 IN VARCHAR2,
                                    p_event_owner                IN VARCHAR2,
                                    p_override_next_attempt_time IN VARCHAR2,
                                    p_lock_timeout_sec           IN VARCHAR2,
                                    p_start_date                 IN VARCHAR2)
    RETURN NUMBER IS
    l_request_id NUMBER;
  BEGIN
    --Following code is modified by Vishnu for CR5963
    l_request_id := fnd_request.submit_request('XXINT', --program-application-code
                                               'XXINT_EVENT_BACKGROUND_PROCESS', --program-short-name
                                               'XXINT_EVENT_BACKGROUND_PROCESS (WF) submitted for GUID=' ||
                                               p_guid, --description
                                               nvl(p_start_date,
                                                   TO_CHAR(sysdate +
                                                           (3 / 3600),
                                                           'DD-MON-YYYY HH24:MI:SS')), --start-time
                                               false, --sub-request
                                               nvl(p_event_interval, ''), --current phase when like
                                               p_event_type, --event-type-like
                                               nvl(p_event_phase, CHR(0)), --current-phase-like
                                               nvl(p_guid, CHR(10)), --guid
                                               'Y', --force reprocess errors
                                               'Y', --ignore fault group status
                                               '1', --exit after this many events
                                               nvl(p_event_owner, ''), --current phase who like
                                               '', --current phase what like
                                               '', --current phase how like
                                               '', --p_concatenated_segments
                                               '', --p_attribute1
                                               '', --p_attribute2
                                               '', --p_attribute3
                                               '', --p_attribute4
                                               '', --p_attribute5
                                               '', --p_attribute6
                                               '', --p_attribute7
                                               '', --p_attribute8
                                               '', --p_attribute9
                                               '', --p_attribute10
                                               '', --p_attribute11
                                               '', --p_attribute12
                                               '', --p_attribute13
                                               '', --p_attribute14
                                               '', --p_attribute15
                                               nvl(p_override_next_attempt_time,
                                                   'Y'), --ignore next attempt date
                                               XXINT_EVENT_UTIL_SITE.G_DEFAULT_LOCK_TIMEOUT_SEC, --lock timeout sec.
                                               XXINT_EVENT_API_PUB.get_default_bg_proces_mode(XXINT_EVENT_API_PUB.get_event_record(p_guid)),
                                               chr(0) --end of parameters
                                               );
    return l_request_id;
  exception
    when others then
      return null;
  END submit_xxint_bkg_program;

  FUNCTION process_request(p_subscription_guid IN RAW,
                           p_event             IN OUT wf_event_t)
    RETURN VARCHAR2 IS
    --
    l_err_msg                   VARCHAR2(4000);
    l_request_id                NUMBER;
    lv_project_id               pa_projects_all.project_id%type;
    lv_project_status_code      pa_projects_all.project_status_code%type;
    lv_prev_project_status_code pa_projects_all.project_status_code%type;
    lv_project_number           pa_projects_all.segment1%type;
    lv_xxpa2592_guid            xxint_events.guid%type;
    lv_agreement_id             pa_agreements_all.agreement_id%TYPE;
    lv_wf_item_key              wf_items.item_key%TYPE;
    lv_customer_id              hz_cust_accounts.cust_account_id%TYPE;

    --
    cursor c_2592_rec(p_project_number pa_projects_all.segment1%type) is
      select guid,
             xint.current_phase event_phase,
             xet.phase03_who    event_owner,
             phase03_when       event_interval,
             xet.event_type
        from xxint_events xint, xxint_event_types xet
       where xet.event_type = 'XXPA2592_EQUIP_ORDER_IN'
         and current_phase = 'PHASE03'
         and xet.event_type = xint.event_type
         and attribute6 = p_project_number;
    --
  BEGIN

    lv_project_id               := p_event.getvalueforparameter('PROJECT_ID');
    lv_project_status_code      := p_event.getvalueforparameter('PROJECT_STATUS_CODE');
    lv_prev_project_status_code := p_event.getvalueforparameter('XX_PROJ_BEGINNING_STATUS');
    lv_agreement_id             := p_event.getvalueforparameter('XX_AGREEMENT_ID');
    lv_wf_item_key              := p_event.getvalueforparameter('XX_WF_ITEM_KEY');
    lv_customer_id              := p_event.getvalueforparameter('XX_CUSTOMER_ID');

    select segment1
      into lv_project_number
      from pa_projects_all
     where project_id = lv_project_id;

    for c_2592_data in c_2592_rec(lv_project_number) loop

      l_request_id := submit_xxint_bkg_program(p_guid                       => c_2592_data.guid,
                                               p_event_phase                => c_2592_data.event_phase,
                                               p_event_interval             => c_2592_data.event_interval,
                                               p_event_type                 => c_2592_data.event_type,
                                               p_event_owner                => c_2592_data.event_owner,
                                               p_override_next_attempt_time => 'Y',
                                               p_lock_timeout_sec           => 30,
                                               p_start_date                 => TO_CHAR(sysdate +
                                                                                       (3 / 3600),
                                                                                       'DD-MON-YYYY HH24:MI:SS'));
    end loop;

    if lv_project_status_code = 'APPROVED' and
       lv_project_status_code <> lv_prev_project_status_code and
       lv_project_id is not null then
      l_request_id := fnd_request.submit_request(application => 'XXPA',
                                                 program     => 'XXPA1559_2',
                                                 description => 'XX Project and Task addition to Project Manufacturing Organization(WF)',
                                                 start_time  => TO_CHAR(sysdate +
                                                                        (3 / 3600),
                                                                        'DD-MON-YYYY HH24:MI:SS'),
                                                 sub_request => FALSE,
                                                 argument1   => lv_project_id,
                                                 argument2   => 'N',
                                                 argument3   => 5);
    end if;

    RETURN 'SUCCESS';
    --
    --
  EXCEPTION
    WHEN OTHERS THEN
      --
      --Provide context information that helps locate the source of an error.
      --
      wf_core.CONTEXT(pkg_name  => 'xxpa_sts_change_subs_pkg',
                      proc_name => 'process_request',
                      arg1      => p_event.geteventname(),
                      arg2      => p_event.geteventkey(),
                      arg3      => p_subscription_guid);
      --
      --Retrieves error information from the error stack and sets it into the event message.
      --
      wf_event.seterrorinfo(p_event => p_event, p_type => 'ERROR');
      l_err_msg := SUBSTR('SQLERM : ' || SQLERRM, 1, 350);
      --
      RETURN 'ERROR';
      --
  END process_request;

  FUNCTION check_requisition_request(p_subscription_guid IN RAW,
                                     p_event             IN OUT wf_event_t)
    RETURN VARCHAR2 IS
    --
    l_err_msg                   VARCHAR2(4000);
    l_request_id                NUMBER;
    lv_project_id               pa_projects_all.project_id%type;
    lv_project_status_code      pa_projects_all.project_status_code%type;
    lv_prev_project_status_code pa_projects_all.project_status_code%type;
    lv_project_number           pa_projects_all.segment1%type;
    lv_agreement_id             pa_agreements_all.agreement_id%TYPE;
    lv_wf_item_key              wf_items.item_key%TYPE;
    lv_customer_id              hz_cust_accounts.cust_account_id%TYPE;

    --
    cursor c_2413_rec(p_project_number pa_projects_all.segment1%type) is
      select guid,
             xint.current_phase event_phase,
             xet.phase01_who    event_owner,
             phase01_when       event_interval,
             xet.event_type,
			 rownum*5 delay_count --Added for v1.3 used for delaying start of subsequent requests
        from xxint_events xint, xxint_event_types xet
       where xet.event_type = 'XXPO2413_REQUISITION_EVENT_IN'
         and current_status <> 'CLOSED'
         and xet.event_type = xint.event_type
         and last_process_msg like '%' || p_project_number || '%';
    --
  BEGIN

    lv_project_id               := p_event.getvalueforparameter('PROJECT_ID');
    lv_project_status_code      := p_event.getvalueforparameter('PROJECT_STATUS_CODE');
    lv_prev_project_status_code := p_event.getvalueforparameter('XX_PROJ_BEGINNING_STATUS');
    lv_agreement_id             := p_event.getvalueforparameter('XX_AGREEMENT_ID');
    lv_wf_item_key              := p_event.getvalueforparameter('XX_WF_ITEM_KEY');
    lv_customer_id              := p_event.getvalueforparameter('XX_CUSTOMER_ID');

    select segment1
      into lv_project_number
      from pa_projects_all
     where project_id = lv_project_id;

    for c_2413_data in c_2413_rec(lv_project_number) loop

      l_request_id := submit_xxint_bkg_program(p_guid                       => c_2413_data.guid,
                                               p_event_phase                => c_2413_data.event_phase,
                                               p_event_interval             => c_2413_data.event_interval,
                                               p_event_type                 => c_2413_data.event_type,
                                               p_event_owner                => c_2413_data.event_owner,
                                               p_override_next_attempt_time => 'Y',
                                               p_lock_timeout_sec           => 30,
                                               p_start_date                 => TO_CHAR(sysdate +
                                                                                       ((10 + c_2413_data.delay_count) / 3600),
                                                                                       'DD-MON-YYYY HH24:MI:SS'));
    end loop;

    RETURN 'SUCCESS';
    --
    --
  EXCEPTION
    WHEN OTHERS THEN
      --
      --Provide context information that helps locate the source of an error.
      --
      wf_core.CONTEXT(pkg_name  => 'xxpa_sts_change_subs_pkg',
                      proc_name => 'process_request',
                      arg1      => p_event.geteventname(),
                      arg2      => p_event.geteventkey(),
                      arg3      => p_subscription_guid);
      --
      --Retrieves error information from the error stack and sets it into the event message.
      --
      wf_event.seterrorinfo(p_event => p_event, p_type => 'ERROR');
      l_err_msg := SUBSTR('SQLERM : ' || SQLERRM, 1, 350);
      --
      RETURN 'ERROR';
      --
  END check_requisition_request;
END xxpa_sts_change_subs_pkg;
/
show errors xxpa_sts_change_subs_pkg