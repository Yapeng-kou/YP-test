create or replace PACKAGE XXPA_PROJ_IN_PKG IS
  /******************************************************************************
  *                           - COPYRIGHT NOTICE -                              *
  *******************************************************************************
  ** Title            :        XXPA2381
  ** File             :        XXPA_PROJ_IN_PKG.pks
  ** Description      :        Package for creating Projects, Agreement
  ** Parameters       :        {None}
  ** Run as           :        APPS
  ** 12_2_compliant   :        YES
  ** Keyword Tracking :
  **
  **
  ** History          :
  ** Date          Who                		Description
  ** -----------   ------------------ 		------------------------------------------
  ** 10-Oct-2013   Vipulgiri Gosai    		Initial
  ** 06-Jan-2015   Jyotsana Kandpal   		Invalid Number Error during implicit conversion of Customer Number and Party Site Number
  ** 24-Feb-2017   Joydeb Saha    			Merged WRITE Project Code (version 1.13) with production code (version 1.14).
  ** 08-Jun-2017   Joydeb Saha    			RT7196623 - SIBEL ID needs to mapped to SHIP to site use attribute1 in order to XXONT1222 work seamlessly.
  **                                          g_prj_cust_rec_in_extra_t record type is modified to store this additional information.
  ** 26-Jul-2018   Vishnusimman M     		CR9339 - Map OEM expenditure for AGRL task sent from Siebel
  ** 06-May-2019   Vishnusimman M     		CR24105 - Supporting new process for milestone billing
  ** 29-Oct-2020   Vishnusimman M     		Created new trunck Version from 1.18.0.1 to 1.19
  ** 12-Dec-2021   Arnab/Vishnu       		CR24470 - Adding logic to create initial Forecast Cost and Revenue budget
  ** 14-Jan-21     Vinay Samudrala      	Worksight - CR24585 - Add xxint_phase5 to track for acknowledgement service.
  ** 20-Oct-21	   Sourabh Bhattacharjee    Adding procedure xml_callback_hook for XEDIT
  ** 27-Jan-22	   Joydeb Saha				Worksight - CR24894 - add assign_pjm_org. This will be used for phase2.
  **										  Existing phase2 will move to phase3.
  ** 12-May-2022   Santhosh R12				INC0420830 - Move ack service procedure call xxint_phase_ack from Phase5 to Phase1 and deleted Phase5 procedure
  ** 31-Jan-23     Dheeraj Nambiar          WorkSight - CR25148 - Project and task completion date extension and handling revaluate_funding_flag and include_gains_losses_flag
  ** 04-May-2023   Jai Shankar Kumar        CR25098 - Enhance this Integration for new partner NEOCRM_CN
  ** 23-Aug-2023   Vishnusimman M           CR25364 - Extend Existing Project Creation to include Subtask details
  ** 31-Dec-2023   Dheeraj Nambiar          WorkSight - CR25448 - Modify Project Manager Update Logic for WS-EQ
  *******************************************************************************/
  gc_key_type                    xxint_event_type_key_vals.key_type%TYPE := 'PARTNER';
  gc_enabled_keyname             xxint_event_type_key_vals.key_name%TYPE := 'ENABLED';
  gc_updateallow_keyname         xxint_event_type_key_vals.key_name%TYPE := 'AGR_UPDATE_ALLOWED';
  gc_agr_part_upd_keyname        xxint_event_type_key_vals.key_name%TYPE := 'AGREEMENT_PARTIAL_UPDATE'; -- Added by Vinod for WRITE
  gc_updateproj_allow_keyname    xxint_event_type_key_vals.key_name%TYPE := 'PROJ_UPDATE_ALLOWED';
  gc_updatetask_allow_keyname    xxint_event_type_key_vals.key_name%TYPE := 'TASK_UPDATE_ALLOWED';
  gc_updatetask_addr_keyname     xxint_event_type_key_vals.key_name%TYPE := 'TASK_ADDRESS_UPD_ALLOWED';
  gc_update_cross_prd_keyname    xxint_event_type_key_vals.key_name%TYPE := 'ALLOW_CROSS_PRD_UPDATE';
  gc_address_validation          xxint_event_type_key_vals.key_name%TYPE := 'ADDRESS_VALIDATION_REQUIRED';
  gc_proj_partial_update_keyname xxint_event_type_key_vals.key_name%TYPE := 'ALLOW_PROJ_PARTIAL_UPDATE';
  gc_proj_status_udpate_keyname  xxint_event_type_key_vals.key_name%TYPE := 'PROJ_STATUS_UPDATE'; -- Added by Vinod for WRITE
  gc_soldto_cust_change_keyname  xxint_event_type_key_vals.key_name%TYPE:= 'ALLOW_SOLDTO_CUSTOMER_CHANGE';
  gc_proj_completion_dt_extn     VARCHAR2(100) := 'PROJ_COMP_DATE_EXTN'; --Added as part of CR25148
  gc_revaluate_funding_flag     VARCHAR2(100) := 'REVALUATE_FUNDING_FLAG'; --Added as part of CR25148
  gc_include_gain_loss_flag     VARCHAR2(100) := 'INCL_GAIN_LOSS_FLAG'; --Added as part of CR25148
  gc_proj_manager_upd_st_dt		VARCHAR2(100) := 'PM_UPD_START_DATE'; --Added as part of CR25448
  gv_exclude_budget_update      VARCHAR2(200):= 'EXCLUDE_BUDGET_UPDATE';
  gc_event_type                  VARCHAR2(1000) := 'XXPA2381_PROJECT_IN';
  gc_interface_name              VARCHAR2(30) := 'XXPA2381';
  g_org_id                       NUMBER;
  gc_api_version_number          NUMBER := 1.0;
  gc_commit                      VARCHAR2(1) := 'F';
  gc_init_msg_list               VARCHAR2(1) := 'T';
  g_return_status                VARCHAR2(1) := 'F';
  g_msg_count                    NUMBER := 0;
  g_msg_data                     VARCHAR2(2000) := NULL;
  g_data                         VARCHAR2(2000) := NULL;
  g_msg_index_out                NUMBER;
  gc_error                       VARCHAR2(100) := 'ERROR';
  gc_success                     VARCHAR2(100) := 'SUCCESS';
  gc_warning                     VARCHAR2(100) := 'WARNING'; --Added for RT7010726

  ----------------Added by Arnab for CR24470-------------
  gc_create_fc_budget xxint_event_type_key_vals.key_name%TYPE := 'CREATE_PRJ_BUDGET';
  gc_bs_task_type     PA_WORK_TYPES_V.name%type := 'Buy/Sell';
  gc_eq_task_type     PA_WORK_TYPES_V.name%type := 'Equipment';
  gc_su_task_type     PA_WORK_TYPES_V.name%type := 'StartUp';
  gc_ff_task_type     PA_WORK_TYPES_V.name%type := 'Equipment Facilitation fee';
  ---gc_wr_task_type     PA_WORK_TYPES_V.name%type := 'Warranty';
  ---------------- Ended by Arnab ------------------------
  --Added for CR24105
  TYPE g_prj_att_rec is record(
    noteType               varchar2(200),
    notes                  long,
    entityName             varchar2(200),
    seqNumber              number,
    title                  varchar2(200),
    description            varchar2(2000),
    agreement_num          varchar2(200),
    project_num            varchar2(200),
    task_num               varchar2(200),
    project_funding_amount varchar2(200));

  TYPE g_prj_att_t IS TABLE OF g_prj_att_rec INDEX BY BINARY_INTEGER;
  g_proj_attach_tbl g_prj_att_t;
  --End of Added for CR24105

  ---************Start Project Customer Record***************---
  --Create record type for Extra Field in Project Customer Record Type
  TYPE g_prj_cust_rec_in_extra_t IS RECORD(
    customer_number hz_cust_accounts.account_number%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    bill_to_customer_number hz_cust_accounts.account_number%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_customer_number hz_cust_accounts.account_number%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_address_1 hz_locations.address1%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_address_2 hz_locations.address2%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_address_3 hz_locations.address3%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_address_4 hz_locations.address4%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    city             VARCHAR2(100),
    county           VARCHAR2(100),
    state            VARCHAR2(100),
    province         VARCHAR2(100),
    postal_code      VARCHAR2(100),
    country          VARCHAR2(100),
    ship_to_party_id hz_parties.party_id%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_party_site_id hz_party_sites.party_site_id%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_party_site_use_id hz_cust_site_uses_all.site_use_id%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    ship_to_party_site_number hz_party_sites.party_site_number%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    building_id      VARCHAR2(100),
    bill_to_party_id hz_parties.party_id%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    bill_to_party_site_id hz_party_sites.party_site_id%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    bill_to_party_site_use_id hz_cust_site_uses_all.site_use_id%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    bill_to_party_site_number hz_party_sites.party_site_number%TYPE
    -- Changed from VARCHAR2 to %TYPE on 6-Jan-2015 by Jyotsana Kandpal
    ,
    partner_site_id hz_cust_site_uses_all.attribute1%TYPE -- Added by Joydeb as per RT7196623
    );

  -- Create Variable for Project Customer Extra Field Record Type
  g_prj_cust_rec_in_extra g_prj_cust_rec_in_extra_t;

  -- Create Record type for Project Customer + Extra Field
  TYPE g_prj_cust_rec_in IS RECORD(
    prj_cust_tbl   pa_project_pub.customer_tbl_type,
    prj_cust_extra g_prj_cust_rec_in_extra%TYPE);

  -- Create variable for Project Customer  + Extra field Record Type
  g_prj_cust_rec_t g_prj_cust_rec_in;
  -- Create variable for Project Customer  passing to API
  g_customers_in       pa_project_pub.customer_tbl_type;
  g_customers_blank    pa_project_pub.customer_tbl_type;
  g_customers_upd      pa_project_pub.customer_tbl_type;
  g_customers_in_extra g_prj_cust_rec_in_extra%TYPE;
  -- Create a Project customer table type for   Project customer + Extra field Record Type
  --TYPE g_prj_cust_tbl_t IS  TABLE OF g_prj_cust_rec_in INDEX BY BINARY_INTEGER;
  ---************Start Project Customer Record***************---

  ---************Start Project Task Record***************---
  --Create record type for Extra Field in Project TASK Record Type
  TYPE g_prj_task_rec_in_extra_t IS RECORD(
    reserve_amount  NUMBER,
    work_type       varchar2(2000),
    carrying_out_org_name varchar2(200),
    carrying_out_org_code varchar2(200),
	task_mgr_ebs_user_name varchar2(200),--Added for CR25364
    task_mgr_emp_number varchar2(200),--Added for CR25364
    g_task_cust_rec g_prj_cust_rec_t%TYPE);

  -- Create a Project table type for   Project Task Extra field Record Type
  TYPE g_prj_task_tbl_t IS TABLE OF g_prj_task_rec_in_extra_t INDEX BY BINARY_INTEGER;

  --Added for CR9339
  TYPE g_task_limit_exp_rec IS RECORD(
    project_number         pa_projects_all.segment1%type,
    task_number            pa_tasks.task_number%type,
    task_exp_category_code Pa_Transaction_Controls.Expenditure_Category%Type);

  -- Create a Project table type for   Project Task Extra field Record Type
  TYPE g_task_limit_exp_t IS TABLE OF g_task_limit_exp_rec INDEX BY BINARY_INTEGER;

  -- CR25098 - Create record type for Extra Field to Store Project Credit Receiver Record Type- START
  TYPE g_prj_crdrecver_rec_split_t
  IS RECORD(salesrep_split VARCHAR2(240),
	        pa_task_number VARCHAR2(25));

  TYPE g_prj_crd_rec_split_tbl_t IS TABLE OF g_prj_crdrecver_rec_split_t INDEX BY BINARY_INTEGER;
  -- CR25098 - Create record type for Extra Field to Store Project Credit Receiver Record Type- END

  -- Create Record type for Project task + Extra Field
  TYPE g_prj_task_rec_in IS RECORD(
    tasks_in_tbl              pa_project_pub.task_in_tbl_type,
    g_prj_task_extra_tbl      g_prj_task_tbl_t,
    g_task_limit_exp          g_task_limit_exp_t, --Added for CR9339
	g_prj_crd_rec_split_tbl   g_prj_crd_rec_split_tbl_t -- Added for CR25098
    );

  -- Create variable for Project task  + Extra field Record Type
  g_prj_task_rec_t g_prj_task_rec_in;
  -- Create variable for Project Task  passing to API
  g_tasks_in    pa_project_pub.task_in_tbl_type;
  g_tasks_out   pa_project_pub.task_out_tbl_type;
  g_tasks_upd   pa_project_pub.task_in_tbl_type;
  g_tasks_blank pa_project_pub.task_in_tbl_type;

  ---************End Project Task Record***************---

  ---************Start Project Players Record***************---
  --Create record type for Extra Field in Project Players Record Type
  TYPE g_prj_player_rec_in_extra_t IS RECORD(
    prj_player_emp_no VARCHAR2(100),
    ebs_user_name     VARCHAR2(200));

  -- Create Variable for Project Player Extra Field Record Type
  --g_prj_player_rec_in_extra g_prj_player_rec_in_extra_t;

  -- Create a Project table type for   Project PLAYER Extra field Record Type
  TYPE g_prj_player_tbl_t IS TABLE OF g_prj_player_rec_in_extra_t INDEX BY BINARY_INTEGER;

  -- Create Record type for Project Players + Extra Field
  TYPE g_prj_player_rec_in IS RECORD(
    prj_player_main_tbl  pa_project_pub.project_role_tbl_type,
    prj_player_extra_tbl g_prj_player_tbl_t);

  -- Create variable for Project task  + Extra field Record Type
  g_prj_player_rec_t g_prj_player_rec_in;
  -- Create variable for Project Task  passing to API
  g_key_members       pa_project_pub.project_role_tbl_type;
  g_key_members_in    pa_project_pub.project_role_tbl_type;
  g_key_members_blank pa_project_pub.project_role_tbl_type;

  ---************Start Credit Receiver Record***************---

  --Create record type for Project Credit Receiver Record Type
  TYPE g_prj_crdrecver_rec_t IS RECORD(
    person_id             NUMBER,
    credit_type_code      VARCHAR2(100),
    project_id            NUMBER,
    last_update_date      DATE,
    last_updated_by       NUMBER,
    creation_date         DATE,
    created_by            NUMBER,
    last_update_login     NUMBER,
    start_date_active     DATE,
    credit_percentage     NUMBER,
    task_id               NUMBER,
    end_date_active       DATE,
    transfer_to_ar_flag   VARCHAR2(100),
    salesrep_id           NUMBER,
    budget_type_code      VARCHAR2(100),
    record_version_number VARCHAR2(100),
    credit_receiver_id    NUMBER,
    employee_number       VARCHAR2(2000),
    ebs_user_name         VARCHAR2(200));

  -- Create a Project table type for   Project PLAYER Extra field Record Type
  TYPE g_prj_crd_recver_tbl_t IS TABLE OF g_prj_crdrecver_rec_t INDEX BY BINARY_INTEGER;

  ---************End Project Player Record***************---

  -- Create Record type for Project Classification Record Type
  g_class_categories_in    pa_project_pub.class_category_tbl_type;
  g_class_categories_blank pa_project_pub.class_category_tbl_type;
  ---************End Project Classification Record***************---
  --*************Budget***************************--
  g_budget_line_in_tbl_t  pa_budget_pub.budget_line_in_tbl_type;
  g_budget_line_out_tbl_t pa_budget_pub.budget_line_out_tbl_type;

  TYPE g_prj_budget_line_extra_t IS RECORD(
    task_number      VARCHAR2(100),
    expenditure_type VARCHAR2(200),
    --Added for CR24470
    work_type_id    pa_work_types_vl.work_type_id%type,
    work_type       pa_work_types_vl.name%type,
    total_task_fund number
    -- Ended for CR24470
    );

  TYPE g_prj_budget_line_extra_tbl IS TABLE OF g_prj_budget_line_extra_t INDEX BY BINARY_INTEGER;

  -- Create Record type for Project Budget  Field
  TYPE g_budget_prj_rec_in IS RECORD(
    p_pa_project_id              NUMBER,
    p_pm_project_reference       VARCHAR2(100),
    p_rev_budget_entry_method_cd VARCHAR2(30),
    pm_budget_reference          VARCHAR2(240),
    budget_version_name          VARCHAR2(60),
    budget_type_code             VARCHAR2(30),
    change_reason_code           VARCHAR2(30),
    description                  VARCHAR2(255),
    entry_method_code            VARCHAR2(30),
    resource_list_name           VARCHAR2(240),
    resource_list_id             NUMBER,
    attribute_category           VARCHAR2(150),
    attribute1                   VARCHAR2(150),
    attribute2                   VARCHAR2(150),
    attribute3                   VARCHAR2(150),
    attribute4                   VARCHAR2(150),
    attribute5                   VARCHAR2(150),
    attribute6                   VARCHAR2(150),
    attribute7                   VARCHAR2(150),
    attribute8                   VARCHAR2(150),
    attribute9                   VARCHAR2(150),
    attribute10                  VARCHAR2(150),
    attribute11                  VARCHAR2(150),
    attribute12                  VARCHAR2(150),
    attribute13                  VARCHAR2(150),
    attribute14                  VARCHAR2(150),
    attribute15                  VARCHAR2(150),
    BUDGET_UPDATE_FLAG           VARCHAR2(2), -- Added for HPQC19004
    g_budget_line_in_tbl         pa_budget_pub.budget_line_in_tbl_type,
    g_prj_bud_line_extra_t       g_prj_budget_line_extra_tbl,
    g_budget_line_out_tbl        pa_budget_pub.budget_line_out_tbl_type);

  -- Create a budget table type for   Budget field Record Type
  TYPE g_budget_prj_tbl_t IS TABLE OF g_budget_prj_rec_in INDEX BY BINARY_INTEGER;

  g_budget_prj_tbl g_budget_prj_tbl_t;

  -- Create Record type for Budget Main and line Field
  TYPE g_budget_rec_in IS RECORD(
    g_budget_prj_tbl      g_budget_prj_tbl_t,
    g_budget_line_in_tbl  pa_budget_pub.budget_line_in_tbl_type,
    g_budget_line_out_tbl pa_budget_pub.budget_line_out_tbl_type);

  -- Create variable for Budget Main and line Field
  g_budget_rec g_budget_rec_in;

  -- Create a budget table type for   Budget field Record Type
  TYPE g_budget_tbl_t IS TABLE OF g_budget_rec_in INDEX BY BINARY_INTEGER;

  -- Create a variable for agreement table type
  g_budget_tbl g_budget_tbl_t;

  ---************Start Project Record***************---
  --Create record type for Extra Field in Project Record Type
  TYPE g_prj_rec_in_extra_type IS RECORD(
    template_name                  VARCHAR2(100),
    template_name_oracle           VARCHAR2(100),
    carrying_out_organization_code VARCHAR2(100),
    carrying_out_organization_name VARCHAR2(250),
    project_type                   VARCHAR2(100),
    project_type_oracle            VARCHAR2(100),
    rev_budget_entry_method_cd     VARCHAR2(100),
    rev_budget_resource_list_id    NUMBER,
    cost_budget_entry_method_cd    VARCHAR2(100),
    cost_budget_resource_list_id   NUMBER,
    partner_project_status_code    VARCHAR2(100),
    prj_type_def_status_code       VARCHAR2(100),
    enable_project_wf_flag         VARCHAR2(1),
    prj_status                     VARCHAR2(100),
    prj_message                    VARCHAR2(4000),
    create_update_flag             VARCHAR2(20),
    proj_rev_version_name          VARCHAR2(240),
    pm_product_code                VARCHAR2(200));

  -- Create Variable for Project Extra Field Record Type
  g_prj_rec_in_extra g_prj_rec_in_extra_type;

  -- Create Record type for Project + Extra Field
  --l_project_in          pa_project_pub.project_in_rec_type;
  TYPE g_prj_rec_in IS RECORD(
    prj_main_rec           pa_project_pub.project_in_rec_type,
    prj_extra_rec          g_prj_rec_in_extra%TYPE,
    g_prj_cust_rec         g_prj_cust_rec_t%TYPE,
    g_prj_task_rec         g_prj_task_rec_t%TYPE,
    g_prj_player_rec       g_prj_player_rec_t%TYPE,
    g_class_categories_tbl g_class_categories_in%TYPE,
    g_prj_crd_recver_tbl   g_prj_crd_recver_tbl_t,
    g_budget_prj_tbl       g_budget_prj_tbl_t);

  -- Create variable for Project + Extra field Record Type
  g_prj_rec g_prj_rec_in;
  -- Create variable for Project Record Type for passing to API
  g_project_in    pa_project_pub.project_in_rec_type;
  g_project_blank pa_project_pub.project_in_rec_type;
  g_project_out   pa_project_pub.project_out_rec_type;

  -- Create a Project table type for   Project + Extra field Record Type
  TYPE g_prj_tbl_t IS TABLE OF g_prj_rec_in INDEX BY BINARY_INTEGER;

  -- Create a variable for agreement table type
  --g_prj_tbl g_prj_tbl_t;

  ---************End Project Record***************---

  ---************Start Project Funding Record***************---
  --Create record type for Extra Field in Project FundingRecord Type
  TYPE g_prj_funding_in_extra_type IS RECORD(
    pa_project_number     VARCHAR2(100),
    pa_task_number        VARCHAR2(100),
    baseline_funding_flag VARCHAR2(100),
    prj_fund_status       VARCHAR2(100),
    prj_fund_message      VARCHAR2(4000),
	-- CR25098 - Adding Attribute Columns at Project Funding record type - START
	attribute_category    pa_project_fundings.attribute_category%TYPE,
	attribute1            pa_project_fundings.attribute1%TYPE,
	attribute2            pa_project_fundings.attribute2%TYPE,
	attribute3            pa_project_fundings.attribute3%TYPE,
	attribute4            pa_project_fundings.attribute4%TYPE,
	attribute5            pa_project_fundings.attribute5%TYPE,
	attribute6            pa_project_fundings.attribute6%TYPE,
	attribute7            pa_project_fundings.attribute7%TYPE,
	attribute8            pa_project_fundings.attribute8%TYPE,
	attribute9            pa_project_fundings.attribute9%TYPE,
	attribute10           pa_project_fundings.attribute10%TYPE
	-- CR25098 - Adding Attribute Columns at Project Funding record type - END
	);

  -- Create Variable for Project Funding Extra Field Record Type
  g_prj_funding_in_extra g_prj_funding_in_extra_type;

  -- Create a Project table type for   Project PLAYER Extra field Record Type
  TYPE g_prj_funding_tbl_t IS TABLE OF g_prj_funding_in_extra_type INDEX BY BINARY_INTEGER;

  -- Create Record type for Project Funding + Extra Field
  TYPE g_prj_funding_rec_in IS RECORD(
    prj_funding_main_tbl  pa_agreement_pub.funding_in_tbl_type,
    prj_funding_extra_tbl g_prj_funding_tbl_t);

  -- Create variable for Project funding  + Extra field Record Type
  g_prj_funding_rec_t g_prj_funding_rec_in;
  -- Create variable for Project Task  passing to API
  g_funding_in  pa_agreement_pub.funding_in_tbl_type;
  g_funding_out pa_agreement_pub.funding_out_tbl_type;

  ---************End Project Funding Record***************---

  ---************Start Agreement Record***************---
  --Create record type for Extra Field in Agreement Record Type
  TYPE g_agr_rec_in_extra_type IS RECORD(
    pm_product_code          VARCHAR2(100),
    term_name                VARCHAR2(100),
    owned_by_person_number   VARCHAR2(100),
    owning_organization_code VARCHAR2(100),
    owning_organization_name VARCHAR2(250),
    update_agreement_allowed VARCHAR2(100),
    in_guid                  VARCHAR2(100),
    agr_status               VARCHAR2(100),
    agr_message              VARCHAR2(4000),
    ebs_user_name            VARCHAR2(200),
    create_update_flag       VARCHAR2(20),
    job_location_country     VARCHAR2(200));

  -- Create Variable for Agreement Extra Field Record Type
  g_agr_rec_in_extra g_agr_rec_in_extra_type;

  -- Create Record type for Agreement + Extra Field
  TYPE g_agr_rec_in IS RECORD(
    agr_main_rec      pa_agreement_pub.agreement_rec_in_type,
    agr_extra_rec     g_agr_rec_in_extra%TYPE,
    g_prj_tbl         g_prj_tbl_t,
    g_prj_funding_rec g_prj_funding_rec_t%TYPE);

  -- Create variable for Agreement + Extra field Record Type
  g_agr_rec g_agr_rec_in;
  -- Create variable for Agreement for passing to API
  g_agreement_in_rec  pa_agreement_pub.agreement_rec_in_type;
  g_agreement_out_rec pa_agreement_pub.agreement_rec_out_type;

  -- Create a agreement table type for   Agreement + Extra field Record Type
  TYPE g_agr_tbl_t IS TABLE OF g_agr_rec_in INDEX BY BINARY_INTEGER;

  -- Create a variable for agreement table type
  g_agr_tbl g_agr_tbl_t;

  ---************End Agreement Record***************---

  /*
  ** Procedure Name  Name: main_proc
  **
  ** Purpose:  Main Procedure called from XXINT Event
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ---------------   ----------------------------------------
  ** 10-Oct-13            Vipul Gosai      Created new
  */
  PROCEDURE main_proc(p_retcode IN OUT NUMBER,
                      p_errbuff IN OUT VARCHAR2,
                      p_guid    IN VARCHAR2);

  PROCEDURE derive_organization_idcd(p_organization_code IN OUT VARCHAR2,
                                     p_organization_name IN OUT VARCHAR2,
                                     p_organization_id   IN OUT NUMBER,
                                     x_return_status     OUT VARCHAR2,
                                     x_return_message    OUT VARCHAR2);

  PROCEDURE log_error_prc(p_entity_id     xxau_error_lines.entity_id%TYPE,
                          p_entity_name   xxau_error_lines.entity_name%TYPE,
                          p_sql_stmt      xxau_error_lines.debug_step%TYPE,
                          p_severity      VARCHAR2 DEFAULT 'E' --E,C or W
                         ,
                          p_error_code    xxau_error_lines.ERROR_CODE%TYPE,
                          p_error_message xxau_error_lines.error_message%TYPE);

  PROCEDURE derive_cust_shipto_id(p_customer_number IN OUT VARCHAR2,
                                  p_customer_id     IN OUT NUMBER,
                                  p_site_code       IN OUT VARCHAR2,
                                  p_prj_cust_rec    IN OUT g_prj_cust_rec_in,
                                  x_return_status   OUT VARCHAR2,
                                  x_return_message  OUT VARCHAR2);

  PROCEDURE init_apps(p_organization_id IN NUMBER,
                      p_org_id          OUT NUMBER,
                      x_return_status   OUT VARCHAR2,
                      x_return_message  OUT VARCHAR2);

   PROCEDURE addnl_dff_proc(p_retcode OUT NUMBER,
                           p_errbuf OUT VARCHAR2,
                           p_guid IN VARCHAR2);
  --Procedure for Phase5 of XXINT. Added by Vinay
 /* PROCEDURE xxint_phase5(x_retcode IN OUT NUMBER,
                         x_retmesg IN OUT VARCHAR2,
                         p_guid    IN VARCHAR2); */ -- INC0420830 - Deleted and added logic in Phase1 itself
-- Procedure for XEDIT
  PROCEDURE xml_callback_hook(o_return_status IN OUT VARCHAR2,
                              o_error_message IN OUT VARCHAR2,
                              i_source_type   IN xxint_xedit_txn_docs.source_type%TYPE,
                              i_source_key    IN xxint_xedit_txn_docs.source_key%TYPE);
  --added as per CR24894
  PROCEDURE assign_pjm_org(x_retcode IN OUT NUMBER,
                         x_retmesg IN OUT VARCHAR2,
                         p_guid    IN VARCHAR2);
END XXPA_PROJ_IN_PKG;
/