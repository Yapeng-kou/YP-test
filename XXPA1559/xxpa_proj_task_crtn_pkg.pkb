create or replace PACKAGE BODY xxpa_proj_task_crtn_pkg
AS
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
  **14-Aug-2023    Jijo Palayoor       PRB0044640 Performance Improvements to make sure the Sub Task also only Checking for a Delta of time stamp **									Changed the View to Standard table on PJM Org Validation
  *******************************************************************************************************************/

  g_pkg_name        varchar2(40) := 'XXPA_PROJ_TASK_CREATN_PKG';
  g_proc_name       varchar2(40) := 'XXPA_PROJ_TASK_CREATN_PROC';
  g_interface_name  varchar2(40) := 'XXPA1559_2';
  g_assignment_type varchar2(10) := 'MATERIAL';
  g_source_sys      varchar2(40) := 'IROracleApps';
  g_user_id         number := fnd_global.user_id;
  g_login_id        number := fnd_global.login_id;
  g_con_request_id  number := fnd_global.conc_request_id;

  ------------------------------------------------------------------------
  -- Function to validate if any new org added in Project parameters
  -- are newly added to lookup
  -- Added for RT6579102
  ------------------------------------------------------------------------
  function check_missed_pjm_orgs(p_project_id in number) return varchar2 is
    lv_status varchar2(2) := 'Y';
   begin
       
         select decode(count(1), 0, 'N', 'Y')
          into lv_status
          from hr_organization_information hoi,
               org_organization_definitions  ood,
               cst_cost_groups               ccg,
               fnd_lookup_values             flv,
               pjm_org_parameters            pop
         where org_information1 = 'PJM'
           and org_information2 = 'Y'
           and ood.organization_id = hoi.organization_id
           and ood.organization_id = ccg.organization_id
           and flv.lookup_type = 'XXPA1559_PJM_CG_ORG_MAPPING'
           and flv.language = userenv('LANG')
           and flv.lookup_code = upper(ood.organization_code)
           and upper(ccg.cost_group) = upper(flv.meaning)
           and pop.organization_id = hoi.organization_id
           and nvl(flv.enabled_flag, 'N') = 'Y'
           and sysdate between nvl(flv.start_date_active, sysdate - 1) and  nvl(flv.end_date_active, sysdate + 1)
           and not exists
         (select 1
                  from apps.pjm_project_parameters
                 where project_id = p_project_id
                   and organization_id = ood.organization_id);
    
    return lv_status;
  
  exception
    when others then
      lv_status := 'Y';
      return lv_status;
  
  end check_missed_pjm_orgs;
  
  ------------------------------------------------------------------------
  -- Procedure called from Concurrent Program for Associating Projects with PJM
  ------------------------------------------------------------------------
  procedure xxpa_proj_task_creatn_proc(p_errbuf              out varchar2,
                                       p_retcode             out varchar2,
                                       p_project_id          in number,
                                       p_check_for_agreement in varchar2,
                                       p_buffer_lst_run_mins in number) is


    l_proj_status_lkp  varchar2(50) := 'XXPA1559_PROJECT_STATUS';

    -- Cursor to fetch the primary project and task details which will be added to Project Mfg Org
    cursor cur_proj_creation(p_date date, p_backward_date date) is
      select ppa.segment1,
             ppa.carrying_out_organization_id,
             ppa.org_id,
             ppa.project_id,
             ppa.start_date,
             ppa.project_type,
             pta.task_id,
             pta.task_number
        from pa_projects_all ppa
		, pa_tasks pta --,
        , pa_project_statuses pps
       where ppa.project_id = nvl(p_project_id, ppa.project_id)
       and ppa.project_status_code = pps.project_status_code
       and exists (
                   select flv.meaning 
                   from fnd_lookup_values_vl flv
                   where flv.lookup_type = l_proj_status_lkp
                   and flv.meaning = pps.project_status_name
                   and flv.view_application_id = 275
                   and flv.security_group_id = 0
                   and trunc (sysdate) between trunc (nvl (flv.start_date_active, sysdate)) and trunc (nvl (flv.end_date_active, sysdate))
                   and flv.enabled_flag = 'Y'
                   ) 
         and ppa.template_flag = 'N' 
         and pta.project_id = ppa.project_id
         and ppa.last_update_date >decode(p_project_id, null,  (p_date - p_buffer_lst_run_mins / 1440), p_backward_date) ---To convert minutes to Day Divided by 1440
         and pta.task_id = (select task_id 
                              from pa_tasks ptk
                             where ptk.project_id = ppa.project_id
                               and rownum = 1)
         and exists
       (select 1
                from apps.hr_organization_information_v hoi
               where hoi.organization_id = ppa.carrying_out_organization_id
                 and org_information1_meaning =
                     'Project Expenditure/Event Organization'
                 and org_information2_meaning = 'Yes')
       order by ppa.org_id; 
  
  
    -- Cursor to fetch the Child Project for a Project
    cursor cur_sub_proj_task(p_date date, p_backward_date date) is
      select ppa.segment1,
             ppa.carrying_out_organization_id,
             ppa.org_id,
             ppa.project_id,
             ppa.project_type ,
             pta.task_id,
             pta.task_number,
             pfsl.parent_project_number
        from pa_projects_all ppa ,
             pa_tasks pta,
             pa_fin_structures_links_v pfsl,
			 pa_project_statuses pps
       where  ppa.project_status_code = pps.project_status_code
	   and exists (
                    select flv.meaning 
                    from fnd_lookup_values_vl flv
                   where flv.lookup_type = l_proj_status_lkp
                       and flv.meaning = pps.project_status_name
                       and flv.view_application_id = 275
                       and flv.security_group_id = 0
                       and trunc (sysdate) between trunc (nvl (flv.start_date_active, sysdate))  and trunc (nvl (flv.end_date_active, sysdate))
                       and flv.enabled_flag = 'Y'
                    )  
         and pta.project_id = ppa.project_id
         and pfsl.parent_project_id = nvl(p_project_id, pfsl.parent_project_id) 
         and ppa.last_update_date > decode(p_project_id, null,  (p_date - p_buffer_lst_run_mins / 1440), p_backward_date)
         and pfsl.sub_project_id = ppa.project_id
         and pta.task_id = (select task_id 
                              from pa_tasks ptk
                             where ptk.project_id = ppa.project_id
                               and rownum = 1);
   

    -- Cursor to fetch all the project Manufacturing Organization
    cursor cur_pjm_org(pv_project_id number) is
      select ood.organization_id,
             ood.organization_name,
             ccg.cost_group_id,
             ccg.cost_group,
             ipv_expenditure_type,
             erv_expenditure_type,
             freight_expenditure_type,
             tax_expenditure_type,
             misc_expenditure_type,
             ppv_expenditure_type,
             dir_item_expenditure_type
        from hr_organization_information hoi,
             org_organization_definitions  ood,
             cst_cost_groups               ccg,
             fnd_lookup_values             flv,
             pjm_org_parameters            pop
       where org_information1 =  'PJM'
         and org_information2 = 'Y'
         and ood.organization_id = hoi.organization_id
         and ood.organization_id = ccg.organization_id
         and flv.lookup_type = 'XXPA1559_PJM_CG_ORG_MAPPING'
         and flv.language = userenv('LANG')
         and flv.lookup_code = upper(ood.organization_code)
         and upper(ccg.cost_group) = upper(flv.meaning)
         and pop.organization_id = hoi.organization_id
         and nvl(flv.enabled_flag, 'N') = 'Y'
         and sysdate between nvl(flv.start_date_active, sysdate - 1) and nvl(flv.end_date_active, sysdate + 1)
         and not exists
       (select 1
                from apps.pjm_project_parameters
               where project_id = pv_project_id
                 and organization_id = ood.organization_id)
      ;

    l_date                            date;
    l_backward_date             date default to_date('01-JAN-01', 'DD-MON-YY', 'NLS_DATE_LANGUAGE = AMERICAN');
    l_return_status                varchar2(100);
    l_last_run_update            boolean;
    l_msg_count                   number;
    l_msg_data                     varchar2(4000);
    l_paramrectype               pjm_project_param_pub.paramrectype;
    l_msg_index_out             number;
    l_data                            varchar2(4000);
    l_project_type                 pa_projects_all.project_type%type;
    l_count_proj_type            number;
    l_paramrectype_task        pjm_project_param_pub.paramrectype;
    l_commit_flag                  varchar2(1);
    l_project_number             pa_projects_all.segment1%type;
    l_api_err_msg                  varchar2(4000);
    l_prgm_submtd_by           fnd_user.description%type;
    l_parent_proj_counter      number := 1;
    l_prgm_submtd_date        varchar2(500);
    l_prgm_actual_start_date  varchar2(500);
    l_cursor_flag                    varchar2(1);
    l_org_id                           pa_projects_all.org_id%type;
    l_error_mess_dis              varchar2(4000);
    l_cust_api_msg                 varchar2(100);
    l_cust_api_status              varchar2(1);
    l_cust_api_msg1               varchar2(100);
    l_cust_api_status1             varchar2(1);

    l_count_sub_project_id      number;
    l_contract_cnt                   number;
    l_status_cnt                      number;
    l_cnt_project_pjm             number;
   
    l_count                            number := 0; --Added for RT6579102
    l_request_id                     number; -- Added for CR5963
    
    
  begin

    -- To fetch last run date of the program
    begin
      l_date := xxau_comn_util_pkg.f_get_last_run_dt(g_interface_name);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Last run date ' ||  to_char(l_date, 'DD-MON-YYYY HH:MI:SS AM'));
    exception
      when others then
        l_date := '01-JAN-1990';
        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,   'Error while fetching previous run date ' || sqlerrm);
    end;
    
    ---------------------------------------------------------------------------------
    --Query to fetch program submission date------
    begin
      select to_char(sysdate, 'DD-Mon-YYYY HH12:MI:SS AM')
        into l_prgm_submtd_date
        from dual;
    exception
      when no_data_found then
        l_prgm_submtd_date := sysdate;
    end;
    ---------------------------------------------------------------------------------

    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   '--------------------------------------------------------------------------------------');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   '                  XX Project and Task addition to Project Manufacturing Organization                 ');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   '--------------------------------------------------------------------------------------');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  'Parameters                                                                            ');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   '1.Project Number         : ' ||                      l_project_number);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '2.Check for Agreement    : ' ||       p_check_for_agreement);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   'Program Submitted Date   : ' ||  l_prgm_submtd_date);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   'Program Submitted By     : ' ||     l_prgm_submtd_by);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,   '--------------------------------------------------------------------------------------');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  'Below Project -> Task are added to the Project Manufacturing Organization             ');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '--------------------------------------------------------------------------------------');
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '                                                                                      ');

  
    ---- Cursor to fetching the Parent project and task details which will be added to Project Mfg Org
    for rec_cur_proj in cur_proj_creation(l_date, l_backward_date) loop
      
          l_cursor_flag     := 'Y'; -- For checking cursor has returned rows
          l_commit_flag     := 'Y';
          l_api_err_msg     := null;
          l_cust_api_msg    := null;
          l_cust_api_status := null;
          l_project_number    := rec_cur_proj.segment1;
          l_project_type         := rec_cur_proj.project_type;
          l_org_id                  := rec_cur_proj.org_id; 

 
            select count(*) into l_count_proj_type
            from pa_projects_all ppa, fnd_lookup_values flv
             where ppa.project_id = rec_cur_proj.project_id
               and flv.lookup_type = 'XXPA1559_PRJ_TYPE_FOR_PRJ_MFG'
               and flv.language = userenv('LANG')
               and flv.lookup_code = upper(ppa.project_type);
     
          if (l_count_proj_type = 0) then
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '-------------------------------Parent Project Details--------------------------------');
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  'Project type ' || l_project_type || ' of project ' || l_project_number ||  '  is not valid to add to Project Manufacturing Org');
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '--------------------------------------------------------------------------------------');
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '                                                                                     ');
          end if;

      if (l_count_proj_type > 0) then

        for rec_cur_pjm_org in cur_pjm_org(rec_cur_proj.project_id) loop
          
            l_paramrectype.organization_id   := rec_cur_pjm_org.organization_id;
            l_paramrectype.project_id        := rec_cur_proj.project_id;
            l_paramrectype.start_date_active := rec_cur_proj.start_date;
            l_paramrectype.cost_group_id     := rec_cur_pjm_org.cost_group_id;
            l_paramrectype.ipv_expenditure_type      := rec_cur_pjm_org.ipv_expenditure_type;
            l_paramrectype.erv_expenditure_type      := rec_cur_pjm_org.erv_expenditure_type;
            l_paramrectype.freight_expenditure_type  := rec_cur_pjm_org.freight_expenditure_type;
            l_paramrectype.tax_expenditure_type      := rec_cur_pjm_org.tax_expenditure_type;
            l_paramrectype.misc_expenditure_type     := rec_cur_pjm_org.misc_expenditure_type;
            l_paramrectype.ppv_expenditure_type      := rec_cur_pjm_org.ppv_expenditure_type;
            l_paramrectype.dir_item_expenditure_type := rec_cur_pjm_org.dir_item_expenditure_type;

            mo_global.set_policy_context('S', rec_cur_proj.org_id);
            pjm_project_param_pub.create_project_parameter(p_api_version   => 1.0,
                                                               p_init_msg_list => fnd_api.g_false,
                                                               p_commit        => fnd_api.g_false,
                                                               x_return_status => l_return_status,
                                                               x_msg_count     => l_msg_count,
                                                               x_msg_data      => l_msg_data,
                                                               p_param_data    => l_paramrectype);

             --Insert in table will add task details to Project Manufacturing Org
              if (l_msg_count = 0 and l_return_status = 'S') then

                    begin
                      xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt(g_assignment_type,
                                                                  rec_cur_proj.project_id,
                                                                  rec_cur_proj.task_id,
                                                                  rec_cur_pjm_org.organization_id,
                                                                  l_cust_api_msg,
                                                                  l_cust_api_status);

                      xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Status of custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt to insert rows in pjm_default_tasks for   ' ||rec_cur_proj.segment1 || ' for org_id ' || rec_cur_pjm_org.organization_id || ' is ' || l_cust_api_status);
                    exception
                      when others then
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Exception while calling xxpa_pjm_dft_task_insrt API for Parent Project ' || rec_cur_proj.segment1 || ' : ' || sqlerrm);
                    end;

                    if (l_cust_api_status <> 'S') then
                      l_commit_flag := 'N';
                      xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name,
                                                  in_debug_level    => 1,
                                                  iv_called_by      => g_proc_name,
                                                  iv_interface_name => g_interface_name,
                                                  in_request_id     => g_con_request_id,
                                                  iv_entity_id      => rec_cur_proj.project_id,
                                                  iv_entity_name    => 'PROJECT_ID',
                                                  iv_source_system  => g_source_sys,
                                                  iv_dest_system    => g_source_sys,
                                                  iv_severity       => to_char('ERROR'),
                                                  iv_error_code     => l_return_status,
                                                  iv_error_msg      => l_cust_api_msg,
                                                  iv_error_step     => 'Error in Custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt inserting rows in pjm_default_task for org_id');

                      l_error_mess_dis := l_cust_api_msg;
                    end if;

              else
                
                    for i in 1 .. l_msg_count loop
                      pa_interface_utils_pub.get_messages(p_encoded       => 'F',
                                                            p_msg_index     => i,
                                                            p_msg_count     => l_msg_count,
                                                            p_msg_data      => l_msg_data,
                                                            p_data          => l_data,
                                                            p_msg_index_out => l_msg_index_out);

                        l_api_err_msg    := l_api_err_msg || '-' || l_data;
                        l_error_mess_dis := 'CREATE_PROJECT_PARAMETER API Error ' || ': ' || l_data;
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  'Error Message while Addition of Parent Project ' ||  rec_cur_proj.segment1 ||' for org_id ' ||rec_cur_pjm_org.organization_id ||' to Project Mgf Org: ' || l_data);
                      end loop;
                      l_commit_flag := 'N';

                     xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name,
                                            in_debug_level    => 1,
                                            iv_called_by      => g_proc_name,
                                            iv_interface_name => g_interface_name,
                                            in_request_id     => g_con_request_id,
                                            iv_entity_id      => rec_cur_proj.project_id,
                                            iv_entity_name    => 'PROJECT_ID',
                                            iv_source_system  => g_source_sys,
                                            iv_dest_system    => g_source_sys,
                                            iv_severity       => to_char('ERROR'),
                                            iv_error_code     => l_return_status,
                                            iv_error_msg      => l_api_err_msg,
                                            iv_error_step     => 'create_project_parameter');
              
                end if;

              if (l_commit_flag = 'Y') then
                commit;

                if l_count = 0 then
                  xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '-------------------------------Parent Project Details--------------------------------');
                  xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  rpad('S.No', 8, ' ') || rpad('Project No', 22, ' ') || rpad('Sub Project No', 20, ' ') || rpad('Task Number', 20, ' ') || rpad('Cost Group', 20, ' ') ||   'Organization');
                  l_count := 1;
                end if;
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output, rpad(l_parent_proj_counter, 8, ' ') || rpad(rec_cur_proj.segment1, 22, ' ') ||   rpad(' ', 20, ' ') || rpad(rec_cur_proj.task_number, 20, ' ') ||   rpad(rec_cur_pjm_org.cost_group,  20, ' ') ||  rec_cur_pjm_org.organization_name);
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '                                                                                      ');
              else
                if l_count = 0 then
                  xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '-------------------------------Parent Project Details--------------------------------');
                  l_count := 1;
                end if;
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Roll back for ...' || l_project_number);
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  'Parent Project ' || l_project_number ||     ' for organization ' ||    rec_cur_pjm_org.organization_name ||  ' is not added to Project Manufacturing Org due to ' || l_error_mess_dis);
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,     '--------------------------------------------------------------------------------------');
                xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '                                                                                       ');
                rollback;
              end if;
              l_parent_proj_counter := l_parent_proj_counter + 1;
         
        end loop; --End of cursor fetching PJM Organizations
        
        
            --Added for CR5963
            for c_data in (select guid,
                                  xint.current_phase event_phase,
                                  xet.phase03_who    event_owner,
                                  phase03_when       event_interval,
                                  xet.event_type
                             from xxint_events xint, xxint_event_types xet
                            where xet.event_type = 'XXPA2592_EQUIP_ORDER_IN'
                              and current_phase = 'PHASE03'
                              and xet.event_type = xint.event_type
                              and attribute6 = rec_cur_proj.segment1) loop
                        
                        l_request_id := xxpa_equip_order_in_pkg.submit_xxint_bkg_program(p_guid                       => c_data.guid,
                                                                               p_event_phase                => c_data.event_phase,
                                                                               p_event_interval             => c_data.event_interval,
                                                                               p_event_type                 => c_data.event_type,
                                                                               p_event_owner                => c_data.event_owner,
                                                                               p_override_next_attempt_time => 'Y',
                                                                               p_lock_timeout_sec           => 30);
                        xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  'Request Id for XXPA2592 GUID (' || c_data.guid || ') : ' || l_request_id);
            end loop;

        end if;

    end loop; ---Parent Cursor Ends


    ---------------- Cursor fetching the child project details-------------------
    l_count := 0;
    for rec_cur_task in cur_sub_proj_task(l_date, l_backward_date) loop

      l_commit_flag         := 'Y';
      l_cust_api_msg1       := null;
      l_cust_api_status1    := null;
      l_parent_proj_counter := 1;
      l_project_number    := rec_cur_task.segment1;
      l_project_type         := rec_cur_task.project_type;
      l_org_id                  := rec_cur_task.org_id; 
      
      for rec_cur_pjm_org in cur_pjm_org(rec_cur_task.project_id) loop
       
          l_paramrectype_task.organization_id := rec_cur_pjm_org.organization_id;
          l_paramrectype_task.project_id      := rec_cur_task.project_id;
          l_paramrectype_task.cost_group_id   := rec_cur_pjm_org.cost_group_id;
          l_paramrectype_task.ipv_expenditure_type      := rec_cur_pjm_org.ipv_expenditure_type;
          l_paramrectype_task.erv_expenditure_type      := rec_cur_pjm_org.erv_expenditure_type;
          l_paramrectype_task.freight_expenditure_type  := rec_cur_pjm_org.freight_expenditure_type;
          l_paramrectype_task.tax_expenditure_type      := rec_cur_pjm_org.tax_expenditure_type;
          l_paramrectype_task.misc_expenditure_type     := rec_cur_pjm_org.misc_expenditure_type;
          l_paramrectype_task.ppv_expenditure_type      := rec_cur_pjm_org.ppv_expenditure_type;
          l_paramrectype_task.dir_item_expenditure_type := rec_cur_pjm_org.dir_item_expenditure_type;

          mo_global.set_policy_context('S', rec_cur_task.org_id);
          pjm_project_param_pub.create_project_parameter(p_api_version   => 1.0,
                                                         p_init_msg_list => fnd_api.g_false,
                                                         p_commit        => fnd_api.g_false,
                                                         x_return_status => l_return_status,
                                                         x_msg_count     => l_msg_count,
                                                         x_msg_data      => l_msg_data,
                                                         p_param_data    => l_paramrectype_task);

       
        --Insert in table will add task details to Project Manufacturing Org
        if (l_msg_count = 0 and l_return_status = 'S') then

          begin
            xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt(g_assignment_type,
                                                        rec_cur_task.project_id,
                                                        rec_cur_task.task_id ,
                                                        rec_cur_pjm_org.organization_id,
                                                        l_cust_api_msg1,
                                                        l_cust_api_status1);

            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Status of custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt to insert rows in pjm_default_tasks for Child project ' || rec_cur_task.segment1 || ' for org_id ' ||  rec_cur_pjm_org.organization_id || ' is' || l_cust_api_status1);
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  '                                                                                                                                         ');
          exception
            when others then
              xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Error while calling xxpa_pjm_dft_task_insrt API for child project ' || rec_cur_task.segment1 || ' : ' || sqlerrm);
          end;

              if (l_cust_api_status1 <> 'S') then
                l_commit_flag := 'N';
                 xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name,
                                            in_debug_level    => 1,
                                            iv_called_by      => g_proc_name,
                                            iv_interface_name => g_interface_name,
                                            in_request_id     => g_con_request_id,
                                            iv_entity_id      => rec_cur_task.project_id,
                                            iv_entity_name    => 'PROJECT_ID',
                                            iv_source_system  => g_source_sys,
                                            iv_dest_system    => g_source_sys,
                                            iv_severity       => to_char('ERROR'),
                                            iv_error_code     => l_cust_api_status1,
                                            iv_error_msg      => l_cust_api_msg,
                                            iv_error_step     => 'Error in Custom API xxpa_custom_api_pkg.xxpa_pjm_dft_task_insrt inserting rows in pjm_default_task');

                
              end if;

        else
        
              for i in 1 .. l_msg_count loop
                  pa_interface_utils_pub.get_messages(p_encoded       => 'F',
                                                      p_msg_index     => i,
                                                      p_msg_count     => l_msg_count,
                                                      p_msg_data      => l_msg_data,
                                                      p_data          => l_data,
                                                      p_msg_index_out => l_msg_index_out);

                  l_api_err_msg    := l_api_err_msg || '-' || l_data;
                  l_error_mess_dis := 'CREATE_PROJECT_PARAMETER API Error ' || ': ' || l_data;
                  xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  'Error Message while Addition of Child Project ' ||  rec_cur_task.segment1 ||  ' for org_id ' || rec_cur_pjm_org.organization_id || '  is ' || l_data);
              end loop;

          l_commit_flag := 'N';
          xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name,
                                      in_debug_level    => 1,
                                      iv_called_by      => g_proc_name,
                                      iv_interface_name => g_interface_name,
                                      in_request_id     => g_con_request_id,
                                      iv_entity_id      => rec_cur_task.segment1,
                                      iv_entity_name    => 'PROJECT_NUMBER',
                                      iv_source_system  => g_source_sys,
                                      iv_dest_system    => g_source_sys,
                                      iv_severity       => to_char('ERROR'),
                                      iv_error_code     => l_return_status,
                                      iv_error_msg      => l_api_err_msg,
                                      iv_error_step     => 'create_sub_project_parameter');
        end if;

        if (l_commit_flag = 'Y') then
          commit;
          if l_count = 0 then
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '-------------------------------Child Project Details--------------------------------');
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  rpad('S.No', 8, ' ') || rpad('Project No', 22, ' ') ||rpad('Sub Project No', 20, ' ') || rpad('Task Number', 20, ' ') || rpad('Cost Group', 20, ' ') || 'Organization');
            l_count := 1;
          end if;
          xx_pk_fnd_file.put_line(xx_pk_fnd_file.output, rpad(l_parent_proj_counter, 8, ' ') || rpad(rec_cur_task.parent_project_number, 22, ' ') ||rpad(rec_cur_task.segment1, 20, ' ') || rpad(rec_cur_task.task_number, 20, ' ') ||rpad(rec_cur_pjm_org.cost_group, 20, ' ') ||rec_cur_pjm_org.organization_name);
          xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '                                                                                      ');
        else
          if l_count = 0 then
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  '-------------------------------Child Project Details--------------------------------');
            l_count := 1;
          end if;
          xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  'Roll back for ...' || l_project_number);
          xx_pk_fnd_file.put_line(xx_pk_fnd_file.output,  'Child Project ' || rec_cur_task.segment1 ||   ' for org_id ' || rec_cur_pjm_org.organization_id ||' is not added to Project Manufacturing Org due to ' ||  l_error_mess_dis);
          rollback;
        end if;
        l_parent_proj_counter := l_parent_proj_counter + 1;
      
      end loop;
  
    end loop; ---Sub Project Ends



    -- To update run date in history table
    if (p_project_id is null) then
    
           --To get the Actual Start date of the Concurrent Program
            begin
              select to_char(actual_start_date, 'DD-Mon-YYYY HH12:MI:SS AM')
                into l_prgm_actual_start_date
                from fnd_concurrent_requests
               where request_id = g_con_request_id;
            exception
              when no_data_found then
                l_prgm_actual_start_date := sysdate;
            end; 
    
            l_last_run_update := xxau_comn_util_pkg.f_set_last_run_dt(g_interface_name, l_prgm_actual_start_date);

          if (l_last_run_update) then
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Successfully updated run date');
          else
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  'Error while updating run date');
          end if;
    end if;

  exception
  when others then
      rollback;
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.log,  'Main Exception:' || sqlerrm);

  end xxpa_proj_task_creatn_proc;

end xxpa_proj_task_crtn_pkg;
/
Show errors package body xxpa_proj_task_crtn_pkg
