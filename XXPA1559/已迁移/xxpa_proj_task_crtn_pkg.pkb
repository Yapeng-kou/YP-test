CREATE OR REPLACE PACKAGE BODY xxpa_proj_task_crtn_pkg AS
    /******************************************************************************
    *                           - COPYRIGHT NOTICE -                              *
    *******************************************************************************
    ** Title       :    XXPA1559
    ** File        :    XPA_PROJ_TASK_CRTN_PKG.PKB
    ** Description :
    ** Parameters  :   {None}
    ** Run as      :    APPS
    ** 12_2_compliant:YES
    ** Keyword Tracking:
    **
    **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_proj_task_crtn_pkg.pkb 1.19 17-DEC-2021 13:26:10 CCZCFG $
    **   $Change History$ (*ALL VERSIONS*)
    **   Revision 1.19 (COMPLETE)
    **     Created:  17-DEC-2021 13:26:10      CCZCFG (Athilakshmi G)
    **       Added Project Status lookup
    **
    **   Revision 1.18 (COMPLETE)
    **     Created:  22-SEP-2021 17:28:29      CCZCFG (Athilakshmi G)
    **       Custom project status code HVAC NA SUBMITTED
    **
    **   Revision 1.17 (COMPLETE)
    **     Created:  20-JUL-2017 00:13:59      CCBSSJ (Vishnusimman Manivannan)
    **       CR5963 - Automatic submission of XXPA2592 event once project is
    **       added to PJM
    **
    **   Revision 1.16 (COMPLETE)
    **     Created:  19-JUL-2016 13:53:18      CCBSSJ (Vishnusimman Manivannan)
    **       RT6696151 - XXPA1559_2 -  PERFORMANCE ISSUE WITH CONCURRENT PROGRAM
    **       FOR ADDING PROJECTS TO PJM ORG
    **
    **   Revision 1.15.0.2 (COMPLETE)
    **     Created:  13-JUL-2016 16:20:22      CCBSSJ (Vishnusimman Manivannan)
    **       RT6579102 code merged with CR22563
    **
    **   Revision 1.15.0.1 (COMPLETE)
    **     Created:  20-APR-2016 14:30:35      CCBSSJ (Vishnusimman Manivannan)
    **       CR22563 - XXPA1559 - Modified Organization Validation to look into
    **       org_organization_definitions instead of hr_organization_units to
    **       add Projects to non-inventory orgs.
    **
    **   Revision 1.15 (COMPLETE)
    **     Created:  01-APR-2013 09:37:00      C-LTOSHN (Lalitha Toshniwal)
    **       Cursor queries changed to fetch single task for a project.
    **
    **   Revision 1.14 (COMPLETE)
    **     Created:  06-MAR-2013 07:05:40      C-LTOSHN (Lalitha Toshniwal)
    **       Buffer in minutes parameter added to Procedure
    **
    **   Revision 1.13 (COMPLETE)
    **     Created:  28-FEB-2013 06:56:13      C-LTOSHN (Lalitha Toshniwal)
    **       Added logic to not update the last run date when program is ran for
    **       specific project
    **
    **   Revision 1.12 (COMPLETE)
    **     Created:  15-JAN-2013 16:11:08      CCAZYS (None)
    **       Project Template should be ingnored
    **
    **   Revision 1.11 (COMPLETE)
    **     Created:  18-DEC-2012 02:03:31      C-LTOSHN (Lalitha Toshniwal)
    **       updated code for last run date
    **
    **   Revision 1.10 (COMPLETE)
    **     Created:  17-DEC-2012 04:59:51      C-LTOSHN (Lalitha Toshniwal)
    **       Change done for last_update)date
    **
    **   Revision 1.9 (COMPLETE)
    **     Created:  14-NOV-2012 02:27:24      C-LTOSHN (Lalitha Toshniwal)
    **       updated package for last_run_update date.
    **
    **   Revision 1.8 (COMPLETE)
    **     Created:  07-NOV-2012 05:52:22      C-LTOSHN (Lalitha Toshniwal)
    **       Changes done as per NEW CR.
    **
    **   Revision 1.7 (COMPLETE)
    **     Created:  06-NOV-2012 08:26:00      C-LTOSHN (Lalitha Toshniwal)
    **       Changes done for Last run date
    **
    **   Revision 1.6 (COMPLETE)
    **     Created:  05-NOV-2012 08:58:11      C-LTOSHN (Lalitha Toshniwal)
    **       Changes done for INT3.
    **
    **   Revision 1.5 (COMPLETE)
    **     Created:  19-OCT-2012 01:59:34      C-LTOSHN (Lalitha Toshniwal)
    **       Included code for calling Custom API for DML operations
    **
    **   Revision 1.4 (COMPLETE)
    **     Created:  16-OCT-2012 06:26:57      C-LTOSHN (Lalitha Toshniwal)
    **       Change in logic as per business needs
    **
    **   Revision 1.3 (COMPLETE)
    **     Created:  28-SEP-2012 05:59:35      CCAYRB (None)
    **       Change in logic
    **
    **   Revision 1.2 (COMPLETE)
    **     Created:  25-SEP-2012 06:45:20      CCAYRB (None)
    **       Change in Body
    **
    **   Revision 1.1 (COMPLETE)
    **     Created:  24-SEP-2012 09:58:07      CCAYRB (None)
    **       Change in logic
    **
    **   Revision 1.0 (COMPLETE)
    **     Created:  21-SEP-2012 15:54:50      CCAZYS (None)
    **       Initial revision.
    **
    **
    ** History:
    ** Date          Who                 Description
    ** -----------   ------------------  ----------------------------------------
    **06-Sep-2012   Tejasvi Shah        XXPA1559 Initial Creation             **
    **01-Apr-2013   Tejasvi Shah        Cursor Querires changed To fetch only one task for a project
    **18-Jul-2017   Vishnu M            CR5963 - Automatic submission of XXPA2592 event once project is added to PJM
    ** 31-Aug-2021   Athilakshmi G       Added new project status code HVAC NA SUBMITTED in lookup XXPA1559_PROJECT_STATUS
    **14-Aug-2023    Jijo Palayoor       PRB0044640 Performance Improvements to make sure the Sub Task also only Checking for a Delta of time stamp **                  Changed the View to Standard table on PJM Org Validation
    **update by yapeng.kou 2024-06-13     Missing function for obtaining dates.
    *******************************************************************************************************************/

    g_pkg_name        VARCHAR2(40) := 'XXPA_PROJ_TASK_CREATN_PKG';
    g_proc_name       VARCHAR2(40) := 'XXPA_PROJ_TASK_CREATN_PROC';
    g_interface_name  VARCHAR2(40) := 'XXPA1559_2';
    g_assignment_type VARCHAR2(10) := 'MATERIAL';
    g_source_sys      VARCHAR2(40) := 'IROracleApps';
    g_user_id         NUMBER := fnd_global.user_id;
    g_login_id        NUMBER := fnd_global.login_id;
    g_con_request_id  NUMBER := fnd_global.conc_request_id;

    ------------------------------------------------------------------------
    -- Function to validate if any new org added in Project parameters
    -- are newly added to lookup
    -- Added for RT6579102
    ------------------------------------------------------------------------
    FUNCTION check_missed_pjm_orgs(p_project_id IN NUMBER) RETURN VARCHAR2 IS
        lv_status VARCHAR2(2) := 'Y';
    BEGIN
    
        SELECT decode(COUNT(1)
                     ,0
                     ,'N'
                     ,'Y')
        INTO   lv_status
        FROM   hr_organization_information  hoi
              ,org_organization_definitions ood
              ,cst_cost_groups              ccg
              ,fnd_lookup_values            flv
              ,pjm_org_parameters           pop
        WHERE  org_information1 = 'PJM'
        AND    org_information2 = 'Y'
        AND    ood.organization_id = hoi.organization_id
        AND    ood.organization_id = ccg.organization_id
        AND    flv.lookup_type = 'XXPA1559_PJM_CG_ORG_MAPPING'
        AND    flv.language = userenv('LANG')
        AND    flv.lookup_code = upper(ood.organization_code)
        AND    upper(ccg.cost_group) = upper(flv.meaning)
        AND    pop.organization_id = hoi.organization_id
        AND    nvl(flv.enabled_flag
                  ,'N') = 'Y'
        AND    SYSDATE BETWEEN nvl(flv.start_date_active
                                  ,SYSDATE - 1) AND nvl(flv.end_date_active
                                                       ,SYSDATE + 1)
        AND    NOT EXISTS (SELECT 1
                FROM   apps.pjm_project_parameters
                WHERE  project_id = p_project_id
                AND    organization_id = ood.organization_id);
    
        RETURN lv_status;
    
    EXCEPTION
        WHEN OTHERS THEN
            lv_status := 'Y';
            RETURN lv_status;
        
    END check_missed_pjm_orgs;

    ------------------------------------------------------------------------
    -- Procedure called from Concurrent Program for Associating Projects with PJM
    ------------------------------------------------------------------------
    PROCEDURE xxpa_proj_task_creatn_proc(p_errbuf              OUT VARCHAR2
                                        ,p_retcode             OUT VARCHAR2
                                        ,p_project_id          IN NUMBER
                                        ,p_check_for_agreement IN VARCHAR2
                                        ,p_buffer_lst_run_mins IN NUMBER) IS
    
    
        l_proj_status_lkp VARCHAR2(50) := 'XXPA1559_PROJECT_STATUS';
    
        -- Cursor to fetch the primary project and task details which will be added to Project Mfg Org
        CURSOR cur_proj_creation(p_date          DATE
                                ,p_backward_date DATE) IS
            SELECT ppa.segment1
                  ,ppa.carrying_out_organization_id
                  ,ppa.org_id
                  ,ppa.project_id
                  ,ppa.start_date
                  ,ppa.project_type
                  ,pta.task_id
                  ,pta.task_number
            FROM   pa_projects_all     ppa
                  ,pa_tasks            pta --,
                  ,pa_project_statuses pps
            WHERE  ppa.project_id = nvl(p_project_id
                                       ,ppa.project_id)
            AND    ppa.project_status_code = pps.project_status_code
            AND    EXISTS (SELECT flv.meaning
                    FROM   fnd_lookup_values_vl flv
                    WHERE  flv.lookup_type = l_proj_status_lkp
                    AND    flv.meaning = pps.project_status_name
                    AND    flv.view_application_id = 275
                    AND    flv.security_group_id = 0
                    AND    trunc(SYSDATE) BETWEEN trunc(nvl(flv.start_date_active
                                                           ,SYSDATE)) AND trunc(nvl(flv.end_date_active
                                                                                   ,SYSDATE))
                    AND    flv.enabled_flag = 'Y')
            AND    ppa.template_flag = 'N'
            AND    pta.project_id = ppa.project_id
            AND    ppa.last_update_date > decode(p_project_id
                                                ,NULL
                                                ,(p_date - p_buffer_lst_run_mins / 1440)
                                                ,p_backward_date) ---To convert minutes to Day Divided by 1440
            AND    pta.task_id = (SELECT task_id
                                  FROM   pa_tasks ptk
                                  WHERE  ptk.project_id = ppa.project_id
                                  AND    rownum = 1)
            AND    EXISTS (SELECT 1
                    FROM   apps.hr_organization_information_v hoi
                    WHERE  hoi.organization_id = ppa.carrying_out_organization_id
                    AND    org_information1_meaning = 'Project Expenditure/Event Organization'
                    AND    org_information2_meaning = 'Yes')
            ORDER  BY ppa.org_id;
    
    
        -- Cursor to fetch the Child Project for a Project
        CURSOR cur_sub_proj_task(p_date          DATE
                                ,p_backward_date DATE) IS
            SELECT ppa.segment1
                  ,ppa.carrying_out_organization_id
                  ,ppa.org_id
                  ,ppa.project_id
                  ,ppa.project_type
                  ,pta.task_id
                  ,pta.task_number
                  ,pfsl.parent_project_number
            FROM   pa_projects_all           ppa
                  ,pa_tasks                  pta
                  ,pa_fin_structures_links_v pfsl
                  ,pa_project_statuses       pps
            WHERE  ppa.project_status_code = pps.project_status_code
            AND    EXISTS (SELECT flv.meaning
                    FROM   fnd_lookup_values_vl flv
                    WHERE  flv.lookup_type = l_proj_status_lkp
                    AND    flv.meaning = pps.project_status_name
                    AND    flv.view_application_id = 275
                    AND    flv.security_group_id = 0
                    AND    trunc(SYSDATE) BETWEEN trunc(nvl(flv.start_date_active
                                                           ,SYSDATE)) AND trunc(nvl(flv.end_date_active
                                                                                   ,SYSDATE))
                    AND    flv.enabled_flag = 'Y')
            AND    pta.project_id = ppa.project_id
            AND    pfsl.parent_project_id = nvl(p_project_id
                                               ,pfsl.parent_project_id)
            AND    ppa.last_update_date > decode(p_project_id
                                                ,NULL
                                                ,(p_date - p_buffer_lst_run_mins / 1440)
                                                ,p_backward_date)
            AND    pfsl.sub_project_id = ppa.project_id
            AND    pta.task_id = (SELECT task_id
                                  FROM   pa_tasks ptk
                                  WHERE  ptk.project_id = ppa.project_id
                                  AND    rownum = 1);
    
    
        -- Cursor to fetch all the project Manufacturing Organization
        CURSOR cur_pjm_org(pv_project_id NUMBER) IS
            SELECT ood.organization_id
                  ,ood.organization_name
                  ,ccg.cost_group_id
                  ,ccg.cost_group
                  ,ipv_expenditure_type
                  ,erv_expenditure_type
                  ,freight_expenditure_type
                  ,tax_expenditure_type
                  ,misc_expenditure_type
                  ,ppv_expenditure_type
                  ,dir_item_expenditure_type
            FROM   hr_organization_information  hoi
                  ,org_organization_definitions ood
                  ,cst_cost_groups              ccg
                  ,fnd_lookup_values            flv
                  ,pjm_org_parameters           pop
            WHERE  org_information1 = 'PJM'
            AND    org_information2 = 'Y'
            AND    ood.organization_id = hoi.organization_id
            AND    ood.organization_id = ccg.organization_id
            AND    flv.lookup_type = 'XXPA1559_PJM_CG_ORG_MAPPING'
            AND    flv.language = userenv('LANG')
            AND    flv.lookup_code = upper(ood.organization_code)
            AND    upper(ccg.cost_group) = upper(flv.meaning)
            AND    pop.organization_id = hoi.organization_id
            AND    nvl(flv.enabled_flag
                      ,'N') = 'Y'
            AND    SYSDATE BETWEEN nvl(flv.start_date_active
                                      ,SYSDATE - 1) AND nvl(flv.end_date_active
                                                           ,SYSDATE + 1)
            AND    NOT EXISTS (SELECT 1
                    FROM   apps.pjm_project_parameters
                    WHERE  project_id = pv_project_id
                    AND    organization_id = ood.organization_id);
    
        l_date                   DATE;
        l_backward_date          DATE DEFAULT to_date('01-JAN-01'
                                                     ,'DD-MON-YY'
                                                     ,'NLS_DATE_LANGUAGE = AMERICAN');
        l_return_status          VARCHAR2(100);
        l_last_run_update        BOOLEAN;
        l_msg_count              NUMBER;
        l_msg_data               VARCHAR2(4000);
        l_paramrectype           pjm_project_param_pub.paramrectype;
        l_msg_index_out          NUMBER;
        l_data                   VARCHAR2(4000);
        l_project_type           pa_projects_all.project_type%TYPE;
        l_count_proj_type        NUMBER;
        l_paramrectype_task      pjm_project_param_pub.paramrectype;
        l_commit_flag            VARCHAR2(1);
        l_project_number         pa_projects_all.segment1%TYPE;
        l_api_err_msg            VARCHAR2(4000);
        l_prgm_submtd_by         fnd_user.description%TYPE;
        l_parent_proj_counter    NUMBER := 1;
        l_prgm_submtd_date       VARCHAR2(500);
        l_prgm_actual_start_date VARCHAR2(500);
        l_cursor_flag            VARCHAR2(1);
        l_org_id                 pa_projects_all.org_id%TYPE;
        l_error_mess_dis         VARCHAR2(4000);
        l_cust_api_msg           VARCHAR2(100);
        l_cust_api_status        VARCHAR2(1);
        l_cust_api_msg1          VARCHAR2(100);
        l_cust_api_status1       VARCHAR2(1);
    
        l_count_sub_project_id NUMBER;
        l_contract_cnt         NUMBER;
        l_status_cnt           NUMBER;
        l_cnt_project_pjm      NUMBER;
    
        l_count      NUMBER := 0; --Added for RT6579102
        l_request_id NUMBER; -- Added for CR5963
    
    
    BEGIN
    
        -- To fetch last run date of the program
        BEGIN
            --update by yapeng.kou 2024-06-13
            --l_date := xxau_comn_util_pkg.f_get_last_run_dt(g_interface_name);
            l_date := f_get_last_run_dt(g_interface_name);
            --update end 2024-06-13
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                   ,'Last run date ' || to_char(l_date
                                                               ,'DD-MON-YYYY HH:MI:SS AM'));
        EXCEPTION
            WHEN OTHERS THEN
                l_date := '01-JAN-1990';
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                       ,'Error while fetching previous run date ' || SQLERRM);
        END;
    
        ---------------------------------------------------------------------------------
        --Query to fetch program submission date------
        BEGIN
            SELECT to_char(SYSDATE
                          ,'DD-Mon-YYYY HH12:MI:SS AM')
            INTO   l_prgm_submtd_date
            FROM   dual;
        EXCEPTION
            WHEN no_data_found THEN
                l_prgm_submtd_date := SYSDATE;
        END;
        ---------------------------------------------------------------------------------
    
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'--------------------------------------------------------------------------------------');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'                  XX Project and Task addition to Project Manufacturing Organization                 ');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'--------------------------------------------------------------------------------------');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'Parameters                                                                            ');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'1.Project Number         : ' || l_project_number);
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'2.Check for Agreement    : ' || p_check_for_agreement);
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'Program Submitted Date   : ' || l_prgm_submtd_date);
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'Program Submitted By     : ' || l_prgm_submtd_by);
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'--------------------------------------------------------------------------------------');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'Below Project -> Task are added to the Project Manufacturing Organization             ');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'--------------------------------------------------------------------------------------');
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                               ,'                                                                                      ');
    
    
        ---- Cursor to fetching the Parent project and task details which will be added to Project Mfg Org
        FOR rec_cur_proj IN cur_proj_creation(l_date
                                             ,l_backward_date) LOOP
        
            l_cursor_flag     := 'Y'; -- For checking cursor has returned rows
            l_commit_flag     := 'Y';
            l_api_err_msg     := NULL;
            l_cust_api_msg    := NULL;
            l_cust_api_status := NULL;
            l_project_number  := rec_cur_proj.segment1;
            l_project_type    := rec_cur_proj.project_type;
            l_org_id          := rec_cur_proj.org_id;
        
        
            SELECT COUNT(*)
            INTO   l_count_proj_type
            FROM   pa_projects_all   ppa
                  ,fnd_lookup_values flv
            WHERE  ppa.project_id = rec_cur_proj.project_id
            AND    flv.lookup_type = 'XXPA1559_PRJ_TYPE_FOR_PRJ_MFG'
            AND    flv.language = userenv('LANG')
            AND    flv.lookup_code = upper(ppa.project_type);
        
            IF (l_count_proj_type = 0) THEN
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                       ,'-------------------------------Parent Project Details--------------------------------');
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                       ,'Project type ' || l_project_type || ' of project ' || l_project_number || '  is not valid to add to Project Manufacturing Org');
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                       ,'--------------------------------------------------------------------------------------');
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                       ,'                                                                                     ');
            END IF;
        
            IF (l_count_proj_type > 0) THEN
            
                FOR rec_cur_pjm_org IN cur_pjm_org(rec_cur_proj.project_id) LOOP
                
                    l_paramrectype.organization_id           := rec_cur_pjm_org.organization_id;
                    l_paramrectype.project_id                := rec_cur_proj.project_id;
                    l_paramrectype.start_date_active         := rec_cur_proj.start_date;
                    l_paramrectype.cost_group_id             := rec_cur_pjm_org.cost_group_id;
                    l_paramrectype.ipv_expenditure_type      := rec_cur_pjm_org.ipv_expenditure_type;
                    l_paramrectype.erv_expenditure_type      := rec_cur_pjm_org.erv_expenditure_type;
                    l_paramrectype.freight_expenditure_type  := rec_cur_pjm_org.freight_expenditure_type;
                    l_paramrectype.tax_expenditure_type      := rec_cur_pjm_org.tax_expenditure_type;
                    l_paramrectype.misc_expenditure_type     := rec_cur_pjm_org.misc_expenditure_type;
                    l_paramrectype.ppv_expenditure_type      := rec_cur_pjm_org.ppv_expenditure_type;
                    l_paramrectype.dir_item_expenditure_type := rec_cur_pjm_org.dir_item_expenditure_type;
                
                    mo_global.set_policy_context('S'
                                                ,rec_cur_proj.org_id);
                    pjm_project_param_pub.create_project_parameter(p_api_version => 1.0
                                                                  ,p_init_msg_list => fnd_api.g_false
                                                                  ,p_commit => fnd_api.g_false
                                                                  ,x_return_status => l_return_status
                                                                  ,x_msg_count => l_msg_count
                                                                  ,x_msg_data => l_msg_data
                                                                  ,p_param_data => l_paramrectype);
                
                    --Insert in table will add task details to Project Manufacturing Org
                    IF (l_msg_count = 0 AND l_return_status = 'S') THEN
                    
                        BEGIN
                            xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt(g_assignment_type
                                                                       ,rec_cur_proj.project_id
                                                                       ,rec_cur_proj.task_id
                                                                       ,rec_cur_pjm_org.organization_id
                                                                       ,l_cust_api_msg
                                                                       ,l_cust_api_status);
                        
                            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                                   ,'Status of custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt to insert rows in pjm_default_tasks for   ' ||
                                                    rec_cur_proj.segment1 || ' for org_id ' || rec_cur_pjm_org.organization_id || ' is ' || l_cust_api_status);
                        EXCEPTION
                            WHEN OTHERS THEN
                                xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                                       ,'Exception while calling xxpa_pjm_dft_task_insrt API for Parent Project ' || rec_cur_proj.segment1 || ' : ' || SQLERRM);
                        END;
                    
                        IF (l_cust_api_status <> 'S') THEN
                            l_commit_flag := 'N';
                            xx_au_debug.p_debug_error(iv_debug_key => g_pkg_name
                                                     ,in_debug_level => 1
                                                     ,iv_called_by => g_proc_name
                                                     ,iv_interface_name => g_interface_name
                                                     ,in_request_id => g_con_request_id
                                                     ,iv_entity_id => rec_cur_proj.project_id
                                                     ,iv_entity_name => 'PROJECT_ID'
                                                     ,iv_source_system => g_source_sys
                                                     ,iv_dest_system => g_source_sys
                                                     ,iv_severity => to_char('ERROR')
                                                     ,iv_error_code => l_return_status
                                                     ,iv_error_msg => l_cust_api_msg
                                                     ,iv_error_step => 'Error in Custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt inserting rows in pjm_default_task for org_id');
                        
                            l_error_mess_dis := l_cust_api_msg;
                        END IF;
                    
                    ELSE
                    
                        FOR i IN 1 .. l_msg_count LOOP
                            pa_interface_utils_pub.get_messages(p_encoded => 'F'
                                                               ,p_msg_index => i
                                                               ,p_msg_count => l_msg_count
                                                               ,p_msg_data => l_msg_data
                                                               ,p_data => l_data
                                                               ,p_msg_index_out => l_msg_index_out);
                        
                            l_api_err_msg    := l_api_err_msg || '-' || l_data;
                            l_error_mess_dis := 'CREATE_PROJECT_PARAMETER API Error ' || ': ' || l_data;
                            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                                   ,'Error Message while Addition of Parent Project ' || rec_cur_proj.segment1 || ' for org_id ' ||
                                                    rec_cur_pjm_org.organization_id || ' to Project Mgf Org: ' || l_data);
                        END LOOP;
                        l_commit_flag := 'N';
                    
                        xx_au_debug.p_debug_error(iv_debug_key => g_pkg_name
                                                 ,in_debug_level => 1
                                                 ,iv_called_by => g_proc_name
                                                 ,iv_interface_name => g_interface_name
                                                 ,in_request_id => g_con_request_id
                                                 ,iv_entity_id => rec_cur_proj.project_id
                                                 ,iv_entity_name => 'PROJECT_ID'
                                                 ,iv_source_system => g_source_sys
                                                 ,iv_dest_system => g_source_sys
                                                 ,iv_severity => to_char('ERROR')
                                                 ,iv_error_code => l_return_status
                                                 ,iv_error_msg => l_api_err_msg
                                                 ,iv_error_step => 'create_project_parameter');
                    
                    END IF;
                
                    IF (l_commit_flag = 'Y') THEN
                        COMMIT;
                    
                        IF l_count = 0 THEN
                            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                                   ,'-------------------------------Parent Project Details--------------------------------');
                            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                                   ,rpad('S.No'
                                                        ,8
                                                        ,' ') || rpad('Project No'
                                                                     ,22
                                                                     ,' ') || rpad('Sub Project No'
                                                                                  ,20
                                                                                  ,' ') || rpad('Task Number'
                                                                                               ,20
                                                                                               ,' ') || rpad('Cost Group'
                                                                                                            ,20
                                                                                                            ,' ') || 'Organization');
                            l_count := 1;
                        END IF;
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,rpad(l_parent_proj_counter
                                                    ,8
                                                    ,' ') || rpad(rec_cur_proj.segment1
                                                                 ,22
                                                                 ,' ') || rpad(' '
                                                                              ,20
                                                                              ,' ') || rpad(rec_cur_proj.task_number
                                                                                           ,20
                                                                                           ,' ') || rpad(rec_cur_pjm_org.cost_group
                                                                                                        ,20
                                                                                                        ,' ') || rec_cur_pjm_org.organization_name);
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,'                                                                                      ');
                    ELSE
                        IF l_count = 0 THEN
                            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                                   ,'-------------------------------Parent Project Details--------------------------------');
                            l_count := 1;
                        END IF;
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                               ,'Roll back for ...' || l_project_number);
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,'Parent Project ' || l_project_number || ' for organization ' || rec_cur_pjm_org.organization_name ||
                                                ' is not added to Project Manufacturing Org due to ' || l_error_mess_dis);
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,'--------------------------------------------------------------------------------------');
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,'                                                                                       ');
                        ROLLBACK;
                    END IF;
                    l_parent_proj_counter := l_parent_proj_counter + 1;
                
                END LOOP; --End of cursor fetching PJM Organizations
            
            
                --Added for CR5963
                /*FOR c_data IN (SELECT guid
                                     ,xint.current_phase event_phase
                                     ,xet.phase03_who    event_owner
                                     ,phase03_when       event_interval
                                     ,xet.event_type
                               FROM   xxint_events      xint
                                     ,xxint_event_types xet
                               WHERE  xet.event_type = 'XXPA2592_EQUIP_ORDER_IN'
                               AND    current_phase = 'PHASE03'
                               AND    xet.event_type = xint.event_type
                               AND    attribute6 = rec_cur_proj.segment1) LOOP
                
                    l_request_id := xxpa_equip_order_in_pkg.submit_xxint_bkg_program(p_guid => c_data.guid
                                                                                    ,p_event_phase => c_data.event_phase
                                                                                    ,p_event_interval => c_data.event_interval
                                                                                    ,p_event_type => c_data.event_type
                                                                                    ,p_event_owner => c_data.event_owner
                                                                                    ,p_override_next_attempt_time => 'Y'
                                                                                    ,p_lock_timeout_sec => 30);
                    xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                           ,'Request Id for XXPA2592 GUID (' || c_data.guid || ') : ' || l_request_id);
                END LOOP;*/
            
            END IF;
        
        END LOOP; ---Parent Cursor Ends
    
    
        ---------------- Cursor fetching the child project details-------------------
        l_count := 0;
        FOR rec_cur_task IN cur_sub_proj_task(l_date
                                             ,l_backward_date) LOOP
        
            l_commit_flag         := 'Y';
            l_cust_api_msg1       := NULL;
            l_cust_api_status1    := NULL;
            l_parent_proj_counter := 1;
            l_project_number      := rec_cur_task.segment1;
            l_project_type        := rec_cur_task.project_type;
            l_org_id              := rec_cur_task.org_id;
        
            FOR rec_cur_pjm_org IN cur_pjm_org(rec_cur_task.project_id) LOOP
            
                l_paramrectype_task.organization_id           := rec_cur_pjm_org.organization_id;
                l_paramrectype_task.project_id                := rec_cur_task.project_id;
                l_paramrectype_task.cost_group_id             := rec_cur_pjm_org.cost_group_id;
                l_paramrectype_task.ipv_expenditure_type      := rec_cur_pjm_org.ipv_expenditure_type;
                l_paramrectype_task.erv_expenditure_type      := rec_cur_pjm_org.erv_expenditure_type;
                l_paramrectype_task.freight_expenditure_type  := rec_cur_pjm_org.freight_expenditure_type;
                l_paramrectype_task.tax_expenditure_type      := rec_cur_pjm_org.tax_expenditure_type;
                l_paramrectype_task.misc_expenditure_type     := rec_cur_pjm_org.misc_expenditure_type;
                l_paramrectype_task.ppv_expenditure_type      := rec_cur_pjm_org.ppv_expenditure_type;
                l_paramrectype_task.dir_item_expenditure_type := rec_cur_pjm_org.dir_item_expenditure_type;
            
                mo_global.set_policy_context('S'
                                            ,rec_cur_task.org_id);
                pjm_project_param_pub.create_project_parameter(p_api_version => 1.0
                                                              ,p_init_msg_list => fnd_api.g_false
                                                              ,p_commit => fnd_api.g_false
                                                              ,x_return_status => l_return_status
                                                              ,x_msg_count => l_msg_count
                                                              ,x_msg_data => l_msg_data
                                                              ,p_param_data => l_paramrectype_task);
            
            
                --Insert in table will add task details to Project Manufacturing Org
                IF (l_msg_count = 0 AND l_return_status = 'S') THEN
                
                    BEGIN
                        xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt(g_assignment_type
                                                                   ,rec_cur_task.project_id
                                                                   ,rec_cur_task.task_id
                                                                   ,rec_cur_pjm_org.organization_id
                                                                   ,l_cust_api_msg1
                                                                   ,l_cust_api_status1);
                    
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                               ,'Status of custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt to insert rows in pjm_default_tasks for Child project ' ||
                                                rec_cur_task.segment1 || ' for org_id ' || rec_cur_pjm_org.organization_id || ' is' || l_cust_api_status1);
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                               ,'                                                                                                                                         ');
                    EXCEPTION
                        WHEN OTHERS THEN
                            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                                   ,'Error while calling xxpa_pjm_dft_task_insrt API for child project ' || rec_cur_task.segment1 || ' : ' || SQLERRM);
                    END;
                
                    IF (l_cust_api_status1 <> 'S') THEN
                        l_commit_flag := 'N';
                        xx_au_debug.p_debug_error(iv_debug_key => g_pkg_name
                                                 ,in_debug_level => 1
                                                 ,iv_called_by => g_proc_name
                                                 ,iv_interface_name => g_interface_name
                                                 ,in_request_id => g_con_request_id
                                                 ,iv_entity_id => rec_cur_task.project_id
                                                 ,iv_entity_name => 'PROJECT_ID'
                                                 ,iv_source_system => g_source_sys
                                                 ,iv_dest_system => g_source_sys
                                                 ,iv_severity => to_char('ERROR')
                                                 ,iv_error_code => l_cust_api_status1
                                                 ,iv_error_msg => l_cust_api_msg
                                                 ,iv_error_step => 'Error in Custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt inserting rows in pjm_default_task');
                    
                    
                    END IF;
                
                ELSE
                
                    FOR i IN 1 .. l_msg_count LOOP
                        pa_interface_utils_pub.get_messages(p_encoded => 'F'
                                                           ,p_msg_index => i
                                                           ,p_msg_count => l_msg_count
                                                           ,p_msg_data => l_msg_data
                                                           ,p_data => l_data
                                                           ,p_msg_index_out => l_msg_index_out);
                    
                        l_api_err_msg    := l_api_err_msg || '-' || l_data;
                        l_error_mess_dis := 'CREATE_PROJECT_PARAMETER API Error ' || ': ' || l_data;
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                               ,'Error Message while Addition of Child Project ' || rec_cur_task.segment1 || ' for org_id ' || rec_cur_pjm_org.organization_id ||
                                                '  is ' || l_data);
                    END LOOP;
                
                    l_commit_flag := 'N';
                    xx_au_debug.p_debug_error(iv_debug_key => g_pkg_name
                                             ,in_debug_level => 1
                                             ,iv_called_by => g_proc_name
                                             ,iv_interface_name => g_interface_name
                                             ,in_request_id => g_con_request_id
                                             ,iv_entity_id => rec_cur_task.segment1
                                             ,iv_entity_name => 'PROJECT_NUMBER'
                                             ,iv_source_system => g_source_sys
                                             ,iv_dest_system => g_source_sys
                                             ,iv_severity => to_char('ERROR')
                                             ,iv_error_code => l_return_status
                                             ,iv_error_msg => l_api_err_msg
                                             ,iv_error_step => 'create_sub_project_parameter');
                END IF;
            
                IF (l_commit_flag = 'Y') THEN
                    COMMIT;
                    IF l_count = 0 THEN
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,'-------------------------------Child Project Details--------------------------------');
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,rpad('S.No'
                                                    ,8
                                                    ,' ') || rpad('Project No'
                                                                 ,22
                                                                 ,' ') || rpad('Sub Project No'
                                                                              ,20
                                                                              ,' ') || rpad('Task Number'
                                                                                           ,20
                                                                                           ,' ') || rpad('Cost Group'
                                                                                                        ,20
                                                                                                        ,' ') || 'Organization');
                        l_count := 1;
                    END IF;
                    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                           ,rpad(l_parent_proj_counter
                                                ,8
                                                ,' ') || rpad(rec_cur_task.parent_project_number
                                                             ,22
                                                             ,' ') || rpad(rec_cur_task.segment1
                                                                          ,20
                                                                          ,' ') || rpad(rec_cur_task.task_number
                                                                                       ,20
                                                                                       ,' ') || rpad(rec_cur_pjm_org.cost_group
                                                                                                    ,20
                                                                                                    ,' ') || rec_cur_pjm_org.organization_name);
                    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                           ,'                                                                                      ');
                ELSE
                    IF l_count = 0 THEN
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                               ,'-------------------------------Child Project Details--------------------------------');
                        l_count := 1;
                    END IF;
                    xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                           ,'Roll back for ...' || l_project_number);
                    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output
                                           ,'Child Project ' || rec_cur_task.segment1 || ' for org_id ' || rec_cur_pjm_org.organization_id ||
                                            ' is not added to Project Manufacturing Org due to ' || l_error_mess_dis);
                    ROLLBACK;
                END IF;
                l_parent_proj_counter := l_parent_proj_counter + 1;
            
            END LOOP;
        
        END LOOP; ---Sub Project Ends
    
    
    
        -- To update run date in history table
        IF (p_project_id IS NULL) THEN
        
            --To get the Actual Start date of the Concurrent Program
            BEGIN
                SELECT to_char(actual_start_date
                              ,'DD-Mon-YYYY HH12:MI:SS AM')
                INTO   l_prgm_actual_start_date
                FROM   fnd_concurrent_requests
                WHERE  request_id = g_con_request_id;
            EXCEPTION
                WHEN no_data_found THEN
                    l_prgm_actual_start_date := SYSDATE;
            END;
        
            /*l_last_run_update := xxau_comn_util_pkg.f_set_last_run_dt(g_interface_name
            ,l_prgm_actual_start_date);*/
            l_last_run_update := f_set_last_run_dt(g_interface_name
                                                  ,l_prgm_actual_start_date);
            IF (l_last_run_update) THEN
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                       ,'Successfully updated run date');
            ELSE
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                       ,'Error while updating run date');
            END IF;
        END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log
                                   ,'Main Exception:' || SQLERRM);
        
    END xxpa_proj_task_creatn_proc;
    --add by yapeng.kou 2024-06-13
    --copy function from xxau_comn_util_pkg.f_get_last_run_dt()
    FUNCTION f_get_last_run_dt(p_interface_num IN VARCHAR2) RETURN DATE IS
        l_max_run_date DATE;
    BEGIN
        SELECT nvl(last_run_date
                  ,SYSDATE)
        INTO   l_max_run_date
        FROM   xxau_interface_history
        WHERE  interface_name = p_interface_num;
    
        RETURN l_max_run_date;
    
    EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                INSERT INTO xxau_interface_history
                VALUES
                    (p_interface_num
                    ,SYSDATE);
                COMMIT;
            
                RETURN to_date('1900/01/01 00:00:00'
                              ,'RRRR/MM/DD hh24:mi:ss');
            EXCEPTION
                WHEN OTHERS THEN
                    xx_au_debug.p_debug_error(iv_debug_key => 'xxau_comn_util_pkg'
                                             ,in_debug_level => 1
                                             ,iv_called_by => 'xxau_comn_util_pkg.f_get_last_run_dt'
                                             ,iv_interface_name => 'xxau_comn_util_pkg.f_get_last_run_dt'
                                             ,in_request_id => 'NA'
                                             ,iv_entity_id => NULL
                                             ,iv_entity_name => p_interface_num
                                             ,iv_source_system => 'R12 Oracle'
                                             ,iv_dest_system => 'WEBM'
                                             ,iv_severity => 'ERROR'
                                             ,iv_error_code => SQLCODE
                                             ,iv_error_msg => SQLERRM
                                             ,iv_error_step => 'While getting last run date');
            END;
    END;
    --add by yapeng,copy function from xxau_comn_util_pkg package
    FUNCTION f_set_last_run_dt(p_interface_num IN VARCHAR2
                              ,p_date          IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        UPDATE xxau_interface_history
        SET    last_run_date = to_date(p_date
                                      ,'DD-Mon-YYYY HH12:MI:SS AM')
        WHERE  interface_name = p_interface_num;
    
        COMMIT;
        RETURN TRUE;
    
    EXCEPTION
        WHEN OTHERS THEN
            xx_au_debug.p_debug_error(iv_debug_key => 'xxau_comn_util_pkg'
                                     ,in_debug_level => 1
                                     ,iv_called_by => 'xxau_comn_util_pkg.f_set_last_run_dt(Interface_num,p_date)'
                                     ,iv_interface_name => p_interface_num
                                     ,in_request_id => 'NA'
                                     ,iv_entity_id => NULL
                                     ,iv_entity_name => p_interface_num
                                     ,iv_source_system => 'R12 Oracle'
                                     ,iv_dest_system => 'R12 Oracle'
                                     ,iv_severity => 'ERROR'
                                     ,iv_error_code => SQLCODE
                                     ,iv_error_msg => SQLERRM
                                     ,iv_error_step => 'While setting last run date');
        
            RETURN FALSE;
    END;

--end by yapeng.kou 2024-06-13

END xxpa_proj_task_crtn_pkg;

/
Show errors package body xxpa_proj_task_crtn_pkg
