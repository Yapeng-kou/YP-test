CREATE OR REPLACE PACKAGE BODY APPS.xxpa_contract_creation_pmo_pkg
AS
  /**************************************************************************************************************
  *                           - COPYRIGHT NOTICE -                                                              *
  ***************************************************************************************************************
  ** Title            :        XXPA1559                                                                         *
  ** File             :        xxpa_contract_creation_pmo_pkg.pkb                                               *
  ** Description      :                                                                                         *
  ** Parameters       :        {None}                                                                           *
  ** Run as           :        APPS                                                                             *
  ** Keyword Tracking:
  **   
  **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_contract_creation_pmo_pkg.pkb 1.32 17-JUL-2015 03:24:08 CCBUUN $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.32 (COMPLETE)
  **     Created:  17-JUL-2015 03:24:08      CCBUUN (Joydeb Saha)
  **       Modified logic for RT#6117963
  **   
  **   Revision 1.31 (COMPLETE)
  **     Created:  19-JAN-2015 02:28:26      CCBPNA (Jyotsana Kandpal)
  **       HPQC#16545: Program not creating contracts from MOAC Projects
  **       Schedule responsiblity
  **   
  **   Revision 1.30 (COMPLETE)
  **     Created:  25-NOV-2014 07:09:03      CCABMM (None)
  **       Changes for RT#5719082 and Defect 14720 and CR3922 Contract
  **       currency
  **   
  **   Revision 1.29 (COMPLETE)
  **     Created:  17-SEP-2014 05:13:05      CCAYPW (None)
  **       RT_05576600
  **   
  **   Revision 1.28 (COMPLETE)
  **     Created:  09-JAN-2014 12:37:14      CCAZYS (None)
  **       Added AND fnd_pm_code.lookup_type          = 'PM_PRODUCT_CODE'
  **   
  **   Revision 1.27 (COMPLETE)
  **     Created:  17-DEC-2013 23:39:56      CCAZYS (None)
  **       13-Dec-2013   Vasudeva Sreedhar   HPQC CR#10911. Consider the
  **       Projects whose PM_PRODUCT_CODE has Tasg = Y in the PM_PRODUCT_CODE
  **       Lookup                        
  **       13-Dec-2013   Vasudeva Sreedhar   HPQC CR#11008. Populate the
  **       Contract Amount as Agreement Amount, if the Project was attached to
  **       a Single Agreement. If the Agreement Amount cannot be found, or
  **       more than one is found, it should be left blank  
  **       17-Dec=2013   Vasudeva Sreedhar   HPQC CR#11761. Manual contracts
  **       not picking up when submitted from Projects-> Tools Menu.
  **   
  **   Revision 1.26 (COMPLETE)
  **     Created:  29-OCT-2013 11:39:16      CCAZYS (None)
  **       CR#11178. Make the XX Create Contract Program OU Specific
  **   
  **   Revision 1.25 (COMPLETE)
  **     Created:  17-JUL-2013 11:26:25      CCAZYS (None)
  **       Phase-2 : CR#11034 : Create the EQUIPMENT and PART Nodes when
  **       missing
  **   
  **   Revision 1.24 (COMPLETE)
  **     Created:  16-APR-2013 07:59:15      C-LTOSHN (Lalitha Toshniwal)
  **       Modified code to update the NSP Flag = 'N' of Sub Contract Line.
  **   
  **   Revision 1.23 (COMPLETE)
  **     Created:  10-APR-2013 10:32:56      C-LTOSHN (Lalitha Toshniwal)
  **       Added Comment in Comment Section
  **   
  **   Revision 1.22 (COMPLETE)
  **     Created:  10-APR-2013 09:57:19      C-LTOSHN (Lalitha Toshniwal)
  **       condition added for fnd_lookup_values - Enabled_flag = 'Y'
  **   
  **   Revision 1.21 (COMPLETE)
  **     Created:  10-APR-2013 05:41:03      C-LTOSHN (Lalitha Toshniwal)
  **       Changes done for Remedy ticket 4664334, 4664355
  **   
  **   Revision 1.20 (COMPLETE)
  **     Created:  08-MAR-2013 05:08:14      C-LTOSHN (Lalitha Toshniwal)
  **       Buffer for last run in minutes default value changed to 5
  **   
  **   Revision 1.19 (COMPLETE)
  **     Created:  06-MAR-2013 07:04:17      C-LTOSHN (Lalitha Toshniwal)
  **       IN PROCEDURE xxpa_proj_task_mfgorg_proc
  **       --FND_REQUEST.SUBMIT_REQUEST argument3 added for buffer in minutes.
  **   
  **   Revision 1.18 (COMPLETE)
  **     Created:  28-FEB-2013 06:53:30      C-LTOSHN (Lalitha Toshniwal)
  **       Added a logic for not updating the last run date if the program is
  **       ran for specific project
  **   
  **   Revision 1.17 (COMPLETE)
  **     Created:  08-FEB-2013 01:51:39      C-LTOSHN (Lalitha Toshniwal)
  **       Defect #6718
  **   
  **   Revision 1.16 (COMPLETE)
  **     Created:  15-JAN-2013 01:33:09      C-LTOSHN (Lalitha Toshniwal)
  **       Changes done for join mismatch for lookup_coe and description
  **   
  **   Revision 1.15 (COMPLETE)
  **     Created:  18-DEC-2012 02:02:34      C-LTOSHN (Lalitha Toshniwal)
  **       updated code for last run date
  **   
  **   Revision 1.14 (COMPLETE)
  **     Created:  17-DEC-2012 04:37:48      C-LTOSHN (Lalitha Toshniwal)
  **       Change done as per defect 4728
  **   
  **   Revision 1.13 (COMPLETE)
  **     Created:  12-DEC-2012 00:55:22      C-LTOSHN (Lalitha Toshniwal)
  **       Spanish date format
  **   
  **   Revision 1.12 (COMPLETE)
  **     Created:  06-NOV-2012 08:23:03      C-LTOSHN (Lalitha Toshniwal)
  **       Changes done for Last run date
  **   
  **   Revision 1.11 (COMPLETE)
  **     Created:  05-NOV-2012 09:00:19      C-LTOSHN (Lalitha Toshniwal)
  **       Changes done for INT3
  **   
  **   Revision 1.10 (COMPLETE)
  **     Created:  25-OCT-2012 12:49:04      CCAZYS (None)
  **       HPQC Change Request # 2011,2013,2015,2105
  **   
  **   Revision 1.9 (COMPLETE)
  **     Created:  16-OCT-2012 06:19:41      C-LTOSHN (Lalitha Toshniwal)
  **       Change as per business rrequirements
  **   
  **   Revision 1.8 (COMPLETE)
  **     Created:  28-SEP-2012 06:01:40      CCAYRB (None)
  **       change in logic
  **   
  **   Revision 1.7 (COMPLETE)
  **     Created:  27-SEP-2012 01:31:53      C-LTOSHN (Lalitha Toshniwal)
  **       Multiple contract message
  **   
  **   Revision 1.6 (COMPLETE)
  **     Created:  26-SEP-2012 00:04:00      C-LTOSHN (Lalitha Toshniwal)
  **       FP message changes
  **   
  **   Revision 1.5 (COMPLETE)
  **     Created:  25-SEP-2012 08:10:37      CCAYRB (None)
  **       Change in body
  **   
  **   Revision 1.4 (COMPLETE)
  **     Created:  25-SEP-2012 06:51:38      CCAYRB (None)
  **       Change in Body
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  25-SEP-2012 02:03:00      C-LTOSHN (Lalitha Toshniwal)
  **       Requset set changes in FP
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  24-SEP-2012 09:56:57      CCAYRB (None)
  **       Change in logic
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  21-SEP-2012 17:32:43      CCAZYS (None)
  **       Moving the Forms Personalization Procedures into this package
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  21-SEP-2012 15:55:36      CCAZYS (None)
  **       Initial revision.
  **   
  **
  ** History:                                                                                                   *
  ** Date          Who                 Description                                                              *
  ** -----------   ------------------  --------------------------------------------------------------------------
  ** 06-Sep-2012   Tejasvi Shah        XXPA1559 Initial Creation                                                *
  ** 07-Feb-2013   Lalitha Toshniwal   Defect#6718                                                              *
  ** 10-Apr-2013   Tejasvi Shah        Remedy 4664334 End date considered for FND_LOOKUP_VALUES,OKE_K_TYPES_VL  *
  ** 10-Apr-2013   Tejasvi Shah        Remedy 4664355 NSP_FLAG = 'N' For Contract lines to enable unit price    *
  ** 16-Jul-2013   Vasudeva Sreedhar   CR#11034. While creating the Project Contract, donot pass EXIPRES ON     *
  ** 25-Oct-2013   Vasudeva Sreedhar   CR#11178. Make the XX Create Contract Program OU Specific                *
  ** 13-Dec-2013   Vasudeva Sreedhar   HPQC CR#10911. Consider the Projects whose PM_PRODUCT_CODE has Tasg = Y  *
  **                                    in the PM_PRODUCT_CODE Lookup                                           *
  ** 13-Dec-2013   Vasudeva Sreedhar   HPQC CR#11008. Populate the Contract Amount as Agreement Amount, if the  *
  **                                     Project was attached to a Single Agreement. If the Agreement Amount    *
  **                                     cannot be found, or more than one is found, it should be left blank    *
  ** 17-Dec=2013   Vasudeva Sreedhar   HPQC CR#11761. Manual contracts not picking up when submitted from       *
  **                                    Projects-> Tools Menu.                                                  *
  ** 17-Dec-2014  Vrushali Nalawade    Changes added for RT_5576600 -CONTRACT VALUE IS NULL IN CASE OF TWO      * 
  **                                      FUNDING LINES IN A PROJECT WITH SAME AGREEMENT                        * 
  ** 11-Nov-2014  Vajraghosh Bhambore  HPQC Defect#14720 Contract currency and agreement currency different     *
  **                                   and CR#3922 handling of multiple and no agreement situation              *
  ** 19-Jan-2015  Jyotsana Kandpal	   HPQC Defect#16454 'XX Create Contract for Projects' Program not creating *
  **	    						   contracts from MOAC Projects Schedule responsiblity: Due to Org ID valn  *
  ** 16-Jul-2015  Joydeb Saha          RT#6117963: If program is running from MOAC responsibility, interface name *
  **                                   in xxau_interface_history table is stored as NULL. Fixed initialization  *
  **                                   of g_interface_name_ou to handle this situation                          *
  ***************************************************************************************************************/

  g_interface_name     VARCHAR2(40)                              DEFAULT 'XXPA1559_3';
  g_interface_name_ou  VARCHAR2(40)                              DEFAULT '';                 -- CR 11178 - Making the cursor OU Specific
  g_ou_id              hr_operating_units.organization_id%TYPE   DEFAULT FND_GLOBAL.ORG_ID;  -- CR 11178 - Making the cursor OU Specific
  g_ou_code            hr_operating_units.short_code%TYPE        DEFAULT '';                 -- CR 11178 - Making the cursor OU Specific
  g_ou_name            hr_operating_units.name%TYPE              DEFAULT '';                 -- CR 11178 - Making the cursor OU Specific
  g_source_sys         VARCHAR2(40)                              DEFAULT 'IROracleApps';
  g_contract_status    VARCHAR2(100)                             DEFAULT 'ENTERED';

  g_pkg_name           VARCHAR2(40)  DEFAULT 'XXPA_CONTRACT_CREATION_PMO_PKG';
  g_proc_name          VARCHAR2(40)  DEFAULT 'XXPA_CONTRACT_CREATION_PMO_PROC';

  g_con_request_id     NUMBER        DEFAULT FND_GLOBAL.CONC_REQUEST_ID;
  g_user_id            NUMBER        DEFAULT FND_GLOBAL.USER_ID;
  g_login_id           NUMBER        DEFAULT FND_GLOBAL.LOGIN_ID;

  g_error_msg          VARCHAR2(2000);
  g_request_id         NUMBER;
  g_request_id1           NUMBER;

PROCEDURE xxpa_contract_crtn_pmo_proc(p_errbuf                    OUT  VARCHAR2
                                     ,p_retcode                   OUT  VARCHAR2
                                     ,p_project_id                 IN  NUMBER
                                     ,p_check_agreement_exists     IN  VARCHAR2
                                     ,p_chk_for_pjm_exists         IN  VARCHAR2
                                     ,p_invoke_from_tools_menu     IN  VARCHAR2 DEFAULT 'N')  -- 17-Dec-2013 # HPQC CR#11761 # Added the paramter
IS
  -----------------------------------------------------------------------------------
  --Cursor for getting the contract templates and template details for a project type
  -----------------------------------------------------------------------------------
  --
 -- Begin # Vasudeva Sreedhar # 25-Oct-2013 # Commented this cursor to make the Cursor OU Specific. Create the same cursor with MO Views.
  --
  /*
  CURSOR cur_contract_creation(p_date             DATE,
                               p_backward_date          DATE)
  IS
    SELECT eh.k_header_id,
           ppa.project_id,
           segment1,
           ppa.name,
           project_type,
           ppa.start_date,
           ppa.completion_date,
           ppa.description,
           ppa.org_id,
           project_currency_code,
           ch.scs_code,
           ch.buy_or_sell,
           eh.k_type_code,
           eh.bill_without_def_flag,
           ch.inv_organization_id,
           ppa.carrying_out_organization_id
    FROM   okc_k_headers_all_b           ch,
           hr_all_organization_units_tl  hou,
           oke_k_headers                 eh,
           oke_k_types_vl                kt,
           fnd_lookup_values             fnd,
           pa_projects_all               ppa
    WHERE  template_yn            = 'Y'
    AND    ppa.template_flag      <>'Y'
    AND    ch.org_id              = hou.organization_id
    AND    hou.language (+)       = USERENV('LANG')
    AND    ch.id                  = eh.k_header_id
    AND    kt.k_type_code         = eh.k_type_code
    AND    lookup_type            = 'XXPA1559_PROJECT_CONTRACT_TEMP'
    AND    fnd.language           = userenv('LANG')
    AND    fnd.enabled_flag           = 'Y'              -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
    AND    UPPER(fnd.lookup_code) = UPPER(kt.k_type_name)
    AND    lookup_code            = UPPER(ppa.project_type)
    AND    ppa.project_id         = NVL(p_project_id,ppa.project_id)
    AND    ppa.last_update_date   > decode(p_project_id,null,p_date,p_backward_date)
    AND    TRUNC(sysdate) between  fnd.start_date_active -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
    AND    NVL(fnd.end_date_active, TRUNC(sysdate))      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
    AND    TRUNC(sysdate) between  kt.start_date_active  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
    AND    NVL(kt.end_date_active, TRUNC(SYSDATE));      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
   */

  CURSOR cur_contract_creation(p_date             DATE,
                               p_backward_date          DATE)
  IS
    SELECT eh.k_header_id
          ,pp.project_id
          ,segment1
          ,pp.name
          ,project_type
          ,pp.start_date
          ,pp.completion_date
          ,pp.description
          ,pp.org_id
          ,project_currency_code
          ,ch.scs_code
          ,ch.buy_or_sell
          ,eh.k_type_code
          ,eh.bill_without_def_flag
          ,ch.inv_organization_id
          ,pp.carrying_out_organization_id
    FROM   okc_k_headers_all_b           ch
          ,hr_all_organization_units_tl  hou
          ,oke_k_headers                 eh
          ,oke_k_types_vl                kt
          ,fnd_lookup_values             fnd
          ,pa_projects                   pp
    WHERE  template_yn            = 'Y'
      AND  pp.template_flag      <>'Y'
      AND  ch.org_id              = hou.organization_id
      AND  hou.language (+)       = USERENV('LANG')
      AND  ch.id                  = eh.k_header_id
      AND  kt.k_type_code         = eh.k_type_code
      AND  lookup_type            = 'XXPA1559_PROJECT_CONTRACT_TEMP'
      AND  fnd.language           = USERENV('LANG')
      AND  fnd.enabled_flag       = 'Y'                  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
      AND  UPPER(fnd.lookup_code) = UPPER(kt.k_type_name)
      AND  fnd.lookup_code        = UPPER(pp.project_type)
      AND  pp.project_id          = NVL(p_project_id,pp.project_id)
      AND  pp.last_update_date    > decode(p_project_id,null,p_date,p_backward_date)
	  -- Line commented below by Jyotsana Kandpal on 19-Jan-2015 for HPQC #16545 Program not running for MOAC responsibilities
      --AND  pp.org_id              = FND_GLOBAL.ORG_ID    -- CR 11178 - Making the cursor OU Specific
      AND  TRUNC(sysdate) between  fnd.start_date_active -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
      AND  NVL(fnd.end_date_active, TRUNC(sysdate))      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
      AND  TRUNC(sysdate) between  kt.start_date_active  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
      AND  NVL(kt.end_date_active, TRUNC(SYSDATE))       -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
      AND  (EXISTS ( SELECT 'X'                 -- HPQC CR#10911. Consider the Projects whose PM_PRODUCT_CODE has Tag = Y  in the PM_PRODUCT_CODE Lookup
                      FROM fnd_lookup_values  fnd_pm_code     -- When scheduled.
                     WHERE fnd_pm_code.lookup_code          = pp.pm_product_code
                       AND fnd_pm_code.lookup_type          = 'PM_PRODUCT_CODE'
                       AND NVL(TRIM(fnd_pm_code.tag),'N')   = 'Y'
                       AND fnd_pm_code.enabled_flag         = 'Y'
                       AND fnd_pm_code.language             = USERENV('LANG')
                       AND NVL(p_invoke_from_tools_menu,'N')= 'N'
                     )
            OR p_invoke_from_tools_menu = 'Y');     -- 17-Dec-2013 # HPQC CR#11761 # Added the OR Condition

     ------------------------------------------------------------------------
     -- Cursor to get the Operating Unit Code
     ------------------------------------------------------------------------
     CURSOR cur_get_ou_code
     IS
        SELECT short_code
              ,name
          FROM hr_operating_units
         WHERE organization_id = g_ou_id;

  --
  -- End # Vasudeva Sreedhar # 25-Oct-2013 # Commented this cursor to make the Cursor OU Specific. Create the same cursor with MO Views.
  --
  ---------------------------------------------------------------------------------
  --Cursor to get the parent lines for a contract template
  ---------------------------------------------------------------------------------
  CURSOR cur_parent_cont_lines(temp_header_id NUMBER)
  IS
    SELECT oklb.lse_id,
           oklb.id,
           oklb.line_number,
           oklb.display_sequence
    FROM   okc_k_lines_b oklb
    WHERE  chr_id      = temp_header_id
    AND    cle_id      IS NULL;
  ---------------------------------------------------------------------------------
  --Cursor to get if child lines are present for a contract template
  ---------------------------------------------------------------------------------
  CURSOR cur_child_cont_lines(parent_k_line_id NUMBER)
  IS
    SELECT oklb.lse_id,
           oklb.line_number,
           oklb.display_sequence
      FROM okc_k_lines_b oklb
     START WITH oklb.cle_id  = parent_k_line_id
   CONNECT BY NOCYCLE PRIOR oklb.id =oklb.CLE_ID ;
  ----------------------------------------------------------------------------------------------------
  --Cursor to get the customer,bill_to,Ship_to of project for creating party roles of Project Contract
  ----------------------------------------------------------------------------------------------------
  CURSOR cur_party_roles(cur_project_id NUMBER)
  IS
    SELECT lookup_code,
           CASE
               WHEN lookup_code = 'K_CUSTOMER'
               THEN
                   (SELECT customer_id FROM pa_project_customers WHERE project_id = cur_project_id)
               WHEN lookup_code = 'BILL_TO'
               THEN
                   (SELECT bill_to_customer_id FROM pa_project_customers WHERE project_id = cur_project_id)
               WHEN lookup_code = 'SHIP_TO'
               THEN
                   (SELECT ship_to_customer_id FROM pa_project_customers WHERE project_id = cur_project_id)
               WHEN lookup_code = 'CONTRACTOR'
               THEN
                   (SELECT org_id FROM pa_projects_all WHERE project_id = cur_project_id)
               END role_code
    FROM   fnd_lookups
    WHERE  lookup_type  = 'OKC_ROLE'
    AND    lookup_code  in ('BILL_TO','SHIP_TO','K_CUSTOMER','CONTRACTOR')
    AND    trunc(sysdate) between  start_date_active -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
    AND    NVL(end_date_active, TRUNC(sysdate))
    AND    enabled_flag           = 'Y' ;
  ---------------------------------------------------------------------------------
  --Cursor to get the contacts of project for creating contacts of Project Contract
  ---------------------------------------------------------------------------------
  CURSOR cur_Contact_roles(cur_project_id NUMBER)
  IS
    SELECT ppc.contact_id,
           ppc.project_contact_type_code
    FROM   pa_project_contacts ppc
    WHERE  ppc.project_id = cur_project_id;

  l_date              DATE;
  l_backward_date        DATE           DEFAULT TO_DATE('01-JAN-01','DD-MON-YY','NLS_DATE_LANGUAGE = AMERICAN') ;
  l_return_status        VARCHAR2(200);
  l_msg_count            NUMBER;
  l_msg_data             VARCHAR2(2000);
  l_msg_index_out        NUMBER;
  l_data                 VARCHAR2(2000);
  l_commit_flag          VARCHAR2(1);
  l_api_err_msg          VARCHAR2(1000);
  l_count_template       NUMBER;
  l_api_excpt_flag       VARCHAR2(1);
  l_prgm_submtd_date     VARCHAR2(500);
  l_error_mess_dis       VARCHAR2(2000);
  l_cpl_id               NUMBER;
  l_count_sub_project_id NUMBER;
  l_contract_cnt         NUMBER;
  l_status_cnt           NUMBER;
  l_last_run_update      BOOLEAN;
  l_contract_counter     NUMBER := 1;
  l_sucess_count       NUMBER := 0;
  l_failure_count     NUMBER := 0;
  line1_rec              oke_import_contract_pub.cle_rec_type;
  line_out               oke_import_contract_pub.cle_rec_type;
  line_child_rec         oke_import_contract_pub.cle_rec_type;
  line_child_out         oke_import_contract_pub.cle_rec_type;
  header_rec             oke_import_contract_pub.chr_rec_type;
  header_out             oke_import_contract_pub.chr_rec_type;
  bill_tbl               oke_import_contract_pub.bill_tbl_type;
  x_cplv_rec             okc_contract_party_pub.cplv_rec_type;
  v_cplv_rec             okc_contract_party_pub.cplv_rec_type;
  v_ctcv_rec             okc_contract_party_pub.ctcv_rec_type;
  b_ctcv_rec             okc_contract_party_pub.ctcv_rec_type;
  l_prgm_submtd_by       fnd_user.description%TYPE;
  l_cro_code             fnd_lookup_values.lookup_code%type;
  l_jtot_code            jtf_objects_b.object_code%type;
  l_project_pjm          pjm_project_parameters.project_id%type;
  l_project_type         pa_projects_all.project_type%TYPE;
  l_project_number       pa_projects_all.segment1%TYPE;
  l_ou_name              hr_all_organization_units.name%TYPE;
  l_template_flag        pa_projects_all.template_flag%TYPE;
  ln_agreement_amount    NUMBER NULL;  -- HPQC CR#11008. Populate the Contract Amount as Agreement Amount
  ln_agreement_id        NUMBER :=0; --added for 5576600
  ln_agreement_cur       pa_agreements_all.agreement_currency_code%TYPE;  -- Added for Defect#14720 by Vajraghosh on 11-Nov-2014
  e_pjm_not_exists       EXCEPTION;
  e_not_parent_project   EXCEPTION;
  e_contract_present     EXCEPTION;
  e_projct_status_excpt  EXCEPTION;
  e_invalid_project      EXCEPTION;
  e_template_project     EXCEPTION;

BEGIN

     --
     -- Begin # Vasudeva Sreedhar # 25-Oct-2013 # OU Specific Changes
     --

     -------------------------------------------------------------------------------------
     -- Get the Operating Unit Code of the Current Concurrent Request
     -------------------------------------------------------------------------------------
     FOR cgoc IN cur_get_ou_code
     LOOP
        g_ou_code            := cgoc.short_code;
        g_ou_name            := cgoc.name;
        g_interface_name_ou  := g_interface_name||'_'||g_ou_code;
     END LOOP;
	 --Logic added by Joydeb. As per RT#6117963, if g_interface_name_ou is NULL then assign g_interface_name to g_interface_name_ou
	 IF g_interface_name_ou IS NULL
	 THEN
	    g_interface_name_ou := g_interface_name;
	 END IF;
	 --End of logic added by Joydeb.
     --
     -- End # Vasudeva Sreedhar # 25-Oct-2013 # OU Specific Changes
     --

     -- To fetch last run date of the program
     BEGIN
          --l_date:= xxau_comn_util_pkg.f_get_last_run_dt(g_interface_name);    -- CR 11178 - Making the cursor OU Specific
          l_date:= xxau_comn_util_pkg.f_get_last_run_dt(g_interface_name_ou);
       XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Last run date ' ||TO_CHAR(l_date,'DD-MON-YYYY HH:MI:SS AM'));
     EXCEPTION
     WHEN OTHERS THEN
          l_date    := '01-JAN-1990';
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error while fetching previous run date: ' ||SQLERRM);
     END;


     --Query to fetch project number and project type
     IF(p_project_id IS NOT NULL)
     THEN
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'LAST_RUN_DATE is not updated as the program ran for a specific project');
         BEGIN
              SELECT ppa.segment1
                    ,ppa.project_type
                    ,hou.name
                    ,template_flag
               INTO  l_project_number
                    ,l_project_type
                    ,l_ou_name
                    ,l_template_flag
               FROM  pa_projects_all           ppa,
                     hr_all_organization_units hou
              WHERE  ppa.org_id        = hou.organization_id
              AND    ppa.project_id    = p_project_id;
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
              RAISE e_invalid_project;
         WHEN OTHERS THEN
              RAISE e_invalid_project;
         END;
         IF (l_template_flag = 'Y')
         THEN
             RAISE e_template_project;
         END IF;
     END IF;

     --Query to fetch program submitted by
     BEGIN
          SELECT user_name
          INTO   l_prgm_submtd_by
          FROM   fnd_user
          WHERE  user_id = g_user_id;
     EXCEPTION
     WHEN NO_DATA_FOUND THEN
          l_prgm_submtd_by := NULL;
     END;

     --Query to fetch program submission date
     BEGIN
          SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH12:MI:SS AM')
          INTO   l_prgm_submtd_date
          FROM   DUAL;
     EXCEPTION
     WHEN NO_DATA_FOUND THEN
          l_prgm_submtd_date := SYSDATE;
     END;

     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'-------------------------------------------------------------------------------------------------------------------------------------');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'                                                  XX Create Contract for Projects                                                    ');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'-------------------------------------------------------------------------------------------------------------------------------------');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Parameters                                                                                                                           ');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'                                                                                                                                     ');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'1.Project Number                                           : '|| l_project_number                                                     );
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'2.Check for Agreement                                      : '|| p_check_agreement_exists                                             );
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'3.Check for Project assigned to Project Manufacturing Org  : '|| p_chk_for_pjm_exists                                                 );
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'4.Submitted from Tool Menu                                 : '|| p_invoke_from_tools_menu                                             );
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Program Submitted Date                                     : '|| l_prgm_submtd_date                                                   );
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Program Submitted By                                       : '|| l_prgm_submtd_by                                                     );
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Program Submitted for Operating Unit                       : '|| g_ou_name                                                            ); -- CR 11178 - Making the cursor OU Specific
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'----------------------------------------------------------------------------------------------------------------------------------------------------');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD( 'S.No', 10, ' ' ) || RPAD( 'Operating Unit',45,' ')  ||RPAD( 'Project No', 25, ' ' ) || RPAD( 'Contract Number', 25, ' ' )||'Error Message     ');
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'----------------------------------------------------------------------------------------------------------------------------------------------------');

    IF (p_check_agreement_exists = 'Y')
    THEN
        NULL;
    END IF;

    -- Check if the Project is having more than ONE Template defined in the LOOKUP
    IF (p_project_id IS NOT NULL)
    THEN
        BEGIN
             SELECT COUNT(eh.k_header_id)
             INTO   l_count_template
             FROM   okc_k_headers_all_b          ch,
                    hr_all_organization_units_tl hou,
                    oke_k_headers                eh,
                    oke_k_types_vl               kt,
                    fnd_lookup_values            fnd,
                    pa_projects_all              ppa
             WHERE  template_yn              = 'Y'
             AND    ppa.template_flag        <>'Y'
             AND    ch.org_id                = hou.organization_id
             AND    hou.language(+)          = USERENV('LANG')
             AND    ch.id                    = eh.k_header_id
             AND    kt.k_type_code           = eh.k_type_code
             AND    lookup_type              = 'XXPA1559_PROJECT_CONTRACT_TEMP'
             AND    fnd.enabled_flag           = 'Y'                  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             and    fnd.language(+)          = userenv('LANG')
             AND    UPPER(fnd.lookup_code)   = UPPER(kt.k_type_name)
             AND    lookup_code              = UPPER(ppa.project_type)
             AND    ppa.project_id           = p_project_id
             AND    TRUNC(sysdate) between  fnd.start_date_active -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    NVL(fnd.end_date_active, TRUNC(sysdate))      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    TRUNC(sysdate) between  kt.start_date_active  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    NVL(kt.end_date_active, TRUNC(SYSDATE));      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        END ;
    END IF;

    IF(l_count_template = 0)
    THEN
        l_failure_count := l_failure_count + 1;
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' ) || RPAD( l_ou_name,45,' ') || RPAD(l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'There are no Templates defined for the project type '||l_project_type);
    END IF;

    IF(l_count_template > 1)
    THEN
        l_failure_count := l_failure_count + 1;
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' ) || RPAD( l_ou_name,45,' ') || RPAD(l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'There are more than ONE Contract Template defined for the project type '||l_project_type);
    END IF;

    --Contract Header Cursor

    FOR rec_cur_cont_h IN cur_contract_creation(l_date,l_backward_date)
    LOOP
        l_commit_flag  := 'Y';

        --Query to project details
        BEGIN
             SELECT ppa.segment1
                   ,ppa.project_type
                   ,hou.name
              INTO  l_project_number
                   ,l_project_type
                   ,l_ou_name
              FROM  pa_projects_all           ppa
                   ,hr_all_organization_units hou
         WHERE  ppa.org_id        = hou.organization_id
              AND   ppa.project_id    = NVL(p_project_id,rec_cur_cont_h.project_id);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        END;

        --Query to check whether project is primary project or not
        BEGIN
             SELECT COUNT(*)
             INTO   l_count_sub_project_id
             FROM   pa_fin_structures_links_v
             WHERE  sub_project_id = nvl(p_project_id,rec_cur_cont_h.project_id);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        END;

        IF (l_count_sub_project_id > 0)
        THEN
            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD( l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )||'Project is not Primary Project.');
        END IF;

        --Query to check whether contract already exists for the project
        BEGIN
             SELECT COUNT(*)
               INTO l_contract_cnt
               FROM oke_k_headers
              WHERE project_id = nvl(p_project_id,rec_cur_cont_h.project_id);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        END;

        IF (l_contract_cnt > 0)
        THEN
            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD( l_contract_counter, 10, ' ' ) || RPAD( l_ou_name,45,' ')|| RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'Contract is already present for this Project' );
        END IF;

        --Query to check if more than 1 template is available
        BEGIN
             SELECT COUNT(eh.k_header_id)
             INTO   l_count_template
             FROM   okc_k_headers_all_b          ch,
                    hr_all_organization_units_tl hou,
                    oke_k_headers                eh,
                    oke_k_types_vl               kt,
                    fnd_lookup_values            fnd,
                    pa_projects_all              ppa
             WHERE  template_yn           = 'Y'
             AND    ppa.template_flag     <>'Y'
             AND    ch.org_id             = hou.organization_id
             AND    hou.language(+)       = USERENV('LANG')
             AND    fnd.enabled_flag           = 'Y'                  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    ch.id                 = eh.k_header_id
             AND    kt.k_type_code        = eh.k_type_code
             AND    lookup_type           = 'XXPA1559_PROJECT_CONTRACT_TEMP'
             AND    fnd.language(+)       = USERENV('LANG')
             AND    UPPER(fnd.lookup_code)= UPPER(kt.k_type_name)
             AND    lookup_code           = UPPER(ppa.project_type)
             AND    ppa.project_id        = NVL(p_project_id,rec_cur_cont_h.project_id)
             AND    TRUNC(sysdate) between  fnd.start_date_active -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    NVL(fnd.end_date_active, TRUNC(sysdate))      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    TRUNC(sysdate) between  kt.start_date_active  -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
             AND    NVL(kt.end_date_active, TRUNC(SYSDATE));      -- Changes Done for Remedy Ticket 4664334 dated 10-Apr-2013
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             NULL;
        END ;

        IF(l_count_template = 0)
        THEN
            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD( l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ')|| RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'There are no Templates defined for the project type '||l_project_type);
        END IF;

        IF(l_count_template > 1)
        THEN
            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ')|| RPAD(l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'There are more than ONE Contract Template defined for the project type '||l_project_type);
        END IF;

        IF(l_count_template  = 1 and l_contract_cnt = 0 and l_count_sub_project_id = 0 )
        THEN
            header_rec.contract_number              := rec_cur_cont_h.segment1;              -- Project Number
            header_rec.buy_or_sell                  := rec_cur_cont_h.buy_or_sell;           -- Contract Template
          --  header_rec.currency_code                := rec_cur_cont_h.project_currency_code; -- Project Currency  --commented for Defect#14720 By Vajraghosh on 11-Nov-2014
            header_rec.sts_code                     := g_contract_status;
            header_rec.scs_code                     := rec_cur_cont_h.scs_code;            -- Contract Template SCS Code
            header_rec.start_date                   := rec_cur_cont_h.start_date;            -- Project Start Date
            --header_rec.end_date                   := rec_cur_cont_h.completion_date;       -- Commented # Vasudeva Sreedhar # 06-JUL-2013 # CR11034
            header_rec.inv_organization_id          := rec_cur_cont_h.inv_organization_id;   -- Contract Template INV_ORGANIZATION_ID
            header_rec.authoring_org_id             := rec_cur_cont_h.org_id;                -- Project Org ID
            header_rec.short_description            := rec_cur_cont_h.name;                  -- Project Name
            header_rec.description                  := rec_cur_cont_h.description;
            header_rec.template_yn                  := 'N';
            header_rec.project_id                   := rec_cur_cont_h.project_id;            -- Project ID
            header_rec.bill_without_def_flag        := rec_cur_cont_h.bill_without_def_flag;
            header_rec.k_type_code                  := rec_cur_cont_h.k_type_code;           -- Contract Type
            header_rec.owning_organization_id        := rec_cur_cont_h.carrying_out_organization_id;

            --
            -- BEGIN. 13-Dec-2013 # Vasudeva Sreedhar # HPQC CR#11008. Populate the Contract Amount as Agreement Amount
            --
            -- Get the Agreement Amount for the Corresponding Project.
            --   Populate the Contract Amount as Agreement Amount, if the Project was attached to a Single Agreement.
            --   If the Agreement cannot be found, or more than one is found, it should be left blank
            --

            BEGIN

               SELECT distinct paa.agreement_id,paa.amount --- added for RT#5576600
			         ,paa.agreement_currency_code                       ---Added for Defect#14720 By Vajraghosh on 11-Nov-2014
             INTO ln_agreement_id, ln_agreement_amount    ------ added for RT_5576600
			      ,ln_agreement_cur                      --Added for Defect#14720 By Vajraghosh on 11-Nov-2014
			 FROM pa_projects_all        ppa
                 ,pa_project_fundings    ppf
                 ,pa_agreements_all      paa
            WHERE ppa.project_id     = ppf.project_id
              AND ppf.agreement_id   = paa.agreement_id
              AND ppa.template_flag  = 'N'
              AND ppa.project_id     = rec_cur_cont_h.project_id;

            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                 -- ln_agreement_amount := NULL; commented for RT_5576600
                  ln_agreement_amount :=0;  --added for RT_5576600
				  ln_agreement_cur    := rec_cur_cont_h.project_currency_code;              --Added for CR#3922 By Vajraghosh on 25-Nov-2014
				  
               WHEN TOO_MANY_ROWS
               THEN
                 -- ln_agreement_amount := NULL;  commented for RT_5576600
                 ln_agreement_amount :=0; --Added for RT_5576600 
				 ln_agreement_cur    := rec_cur_cont_h.project_currency_code;              --Added for CR#3922 By Vajraghosh on 25-Nov-2014
               
			   WHEN OTHERS
               THEN
			   --    ln_agreement_amount := NULL;      --commented by Vajraghosh for CR#3922
                  ln_agreement_amount := 0;            --Added for CR#3922 By Vajraghosh on 25-Nov-2014
				  ln_agreement_cur    := rec_cur_cont_h.project_currency_code;           --Added for Defect#14720 By Vajraghosh on 11-Nov-2014
            END;

            header_rec.estimated_amount             := ln_agreement_amount;
			header_rec.currency_code                := ln_agreement_cur;  --Added for Defect#14720 By Vajraghosh on 11-Nov-2014
            
           -- XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Agreement Amount  :'|| ln_agreement_amount ||' Project'|| rec_cur_cont_h.project_id );

            --
            -- END. 13-Dec-2013 # Vasudeva Sreedhar # HPQC CR#11008. Populate the Contract Amount as Agreement Amount
            --


            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Start of create contract Header for Project  :'|| rec_cur_cont_h.segment1);

            oke_import_contract_pub.create_contract_header( p_api_version    => 1.0
                                                           ,p_init_msg_list  => OKE_API.G_TRUE
                                                           ,x_return_status  => l_return_status
                                                           ,x_msg_count      => l_msg_count
                                                           ,x_msg_data       => l_msg_data
                                                           ,p_chr_rec        => header_rec
                                                           ,x_chr_rec        => header_out);

            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Count of Create Contract Header for Project '|| rec_cur_cont_h.segment1||' : '||l_msg_count);
            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Status of Create Contract Header for Project'|| rec_cur_cont_h.segment1||' : '||l_return_status);
            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');

            IF (l_msg_count = 0 AND l_return_status = 'S' )
            THEN
                XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Creation of Contract Header is Success for Project : '||Rec_Cur_cont_h.segment1);
            ELSE
                FOR i IN 1..l_msg_count
                LOOP
                    pa_interface_utils_pub.get_messages (  p_encoded         =>'F'
                                                          ,p_msg_index       => i
                                                          ,p_msg_count       => l_msg_count
                                                          ,p_msg_data        => l_msg_data
                                                          ,p_data            => l_data
                                                          ,p_msg_index_out   => l_msg_index_out );

                    l_api_err_msg    := l_api_err_msg || '-'||l_data;
                    l_error_mess_dis := 'CREATE_CONTRACT_HEADER API Error ' || ': ' ||l_data;
                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error Message of create_contract_header for Project : '||Rec_Cur_cont_h.segment1||' API '||l_data);
                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');
                END LOOP;
                l_commit_flag := 'N';
                xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name
                                         ,in_debug_level    => 1
                                         ,iv_called_by      => g_proc_name
                                         ,iv_interface_name => g_interface_name_ou --g_interface_name -- CR 11178 - Making the cursor OU Specific
                                         ,in_request_id     => g_con_request_id
                                         ,iv_entity_id      => rec_cur_cont_h.segment1
                                         ,iv_entity_name    => 'PROJECT_NUMBER'
                                         ,iv_source_system  => g_source_sys
                                         ,iv_dest_system    => g_source_sys
                                         ,iv_severity       => TO_CHAR('ERROR')
                                         ,iv_error_code     => l_return_status
                                         ,iv_error_msg      => l_api_err_msg
                                         ,iv_error_step     => 'create_contract_header');
            END IF;

            --Cursor fetching parent lines for a contract template and creating new Contract lines for project contract

            FOR rec_Cur_parent_cont_lines IN cur_parent_cont_lines(rec_cur_cont_h.k_header_id)
            LOOP
                IF (l_commit_flag = 'Y')
                THEN
                    line1_rec.lse_id                     := rec_cur_parent_cont_lines.lse_id;
                    line1_rec.sts_code                   := g_contract_status;          --Contract Status Approved
                    line1_rec.line_number                := rec_cur_parent_cont_lines.line_number;
                    line1_rec.chr_id                     := header_out.k_header_id ;    --K_HEADER_ID OF contract HEADER IF NO PARENT line. Otherwise must put NULL.
                    line1_rec.cle_id                     := NULL;                       --K_LINE_ID of parent line. NULL if no parent line
                    line1_rec.dnz_chr_id                 := header_out.k_header_id ;    --K_HEADER_ID OF contract HEADER
                    line1_rec.exception_yn               := 'N';
                    line1_rec.start_date                 := rec_cur_cont_h.start_date;  --Project Start Date
                    line1_rec.display_sequence           := rec_cur_parent_cont_lines.display_sequence;
                    line1_rec.parent_line_id             := NULL;
                    line1_rec.project_id                 := rec_cur_cont_h.project_id;
                    line1_rec.nsp_flag                   := 'N';                        -- Changes Done for Remedy Ticket 4664355 : NSP_FLAG = 'N' For Contract lines to enable unit price

                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,' Start of Parent contract_line for Project '|| rec_cur_cont_h.segment1||' lse_id '||rec_cur_parent_cont_lines.lse_id);

                    oke_import_contract_pub.create_contract_line( p_api_version   => 1.0
                                                                 ,p_init_msg_list => OKE_API.G_TRUE
                                                                 ,x_return_status => l_return_status
                                                                 ,x_msg_count     => l_msg_count
                                                                 ,x_msg_data      => l_msg_data
                                                                 ,p_cle_rec       => line1_rec
                                                                 ,x_cle_rec       => line_out);

                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Count of Parent contract_line for Project '|| rec_cur_cont_h.segment1||' lse_id '||rec_cur_parent_cont_lines.lse_id||' : '||l_msg_count);
                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Status of Parent contract_line for Project '|| rec_cur_cont_h.segment1||' lse_id '||rec_cur_parent_cont_lines.lse_id||' : '||l_return_status);
                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');

                    IF (l_msg_count = 0 AND l_return_status = 'S' )
                    THEN
                        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Creation of Parent Contract Line is Sucess for Project :'||Rec_Cur_cont_h.segment1||' lse_id '||rec_cur_parent_cont_lines.lse_id);
                    ELSE
                        FOR i IN 1..l_msg_count
                        LOOP
                            pa_interface_utils_pub.get_messages ( p_encoded       =>'F'
                                                                 ,p_msg_index     => i
                                                                 ,p_msg_count     => l_msg_count
                                                                 ,p_msg_data      => l_msg_data
                                                                 ,p_data          => l_data
                                                                 ,p_msg_index_out => l_msg_index_out);
                            l_api_err_msg := l_api_err_msg || '-'||l_data;
                            l_error_mess_dis := 'Parent CREATE_CONTRACT_LINE API Error ' || ': ' ||l_data;
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error in  Parent Contract Line for Project '||Rec_Cur_cont_h.segment1||' lse_id '||rec_cur_parent_cont_lines.lse_id||' is '||l_data);
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');
                        END LOOP;

                        l_commit_flag := 'N';
                        xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name
                                                 ,in_debug_level    => 1
                                                 ,iv_called_by      => g_proc_name
                                                 ,iv_interface_name => g_interface_name_ou --g_interface_name -- CR 11178 - Making the cursor OU Specific
                                                 ,in_request_id     => g_con_request_id
                                                 ,iv_entity_id      => rec_cur_cont_h.segment1
                                                 ,iv_entity_name    => 'PROJECT_NUMBER'
                                                 ,iv_source_system  => g_source_sys
                                                 ,iv_dest_system    => g_source_sys
                                                 ,iv_severity       => TO_CHAR('ERROR')
                                                 ,iv_error_code     => l_return_status
                                                 ,iv_error_msg      => l_api_err_msg
                                                 ,iv_error_step     => 'create_contract_line');
                    END IF;

                    --Child Cursor of Contract Lines
                    FOR rec_cur_child_cont_lines IN cur_child_cont_lines(rec_cur_parent_cont_lines.id )
                    LOOP
                        IF (l_commit_flag = 'Y')
                        THEN
                            line_child_rec.lse_id                     := rec_cur_child_cont_lines.lse_id;
                            line_child_rec.sts_code                   := g_contract_status;
                            line_child_rec.line_number                := rec_cur_child_cont_lines.line_number;
                            line_child_rec.chr_id                     := NULL ;              --K_HEADER_ID of contract header if no parent line. Otherwise must put NULL.
                            line_child_rec.cle_id                     := line_out.k_line_id; --K_LINE_ID of parent line. NULL if no parent line
                            line_child_rec.dnz_chr_id                 := header_out.k_header_id ;
                            line_child_rec.exception_yn               := 'N';
                            line_child_rec.start_date                 := rec_cur_cont_h.start_date;  --Project Start Date
                            line_child_rec.display_sequence           := rec_cur_child_cont_lines.display_sequence;
                            line_child_rec.parent_line_id             := line_out.k_line_id;
                            line_child_rec.project_id                 := rec_cur_cont_h.project_id;
                            line_child_rec.nsp_flag                   := 'N';                        -- Changes Done for Remedy Ticket 4664355 : NSP_FLAG = 'N' For Contract lines to enable unit price

                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,' Start of Child contract_line for Project '|| rec_cur_cont_h.segment1||' Child lse_id '||Rec_Cur_child_cont_lines.lse_id);
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');

                            oke_import_contract_pub.create_contract_line(  p_api_version   => 1.0
                                                                          ,p_init_msg_list => OKE_API.G_TRUE
                                                                          ,x_return_status => l_return_status
                                                                          ,x_msg_count     => l_msg_count
                                                                          ,x_msg_data      => l_msg_data
                                                                          ,p_cle_rec       => line_child_rec
                                                                          ,x_cle_rec       => line_child_out);

                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Count of  Child contract_line for Project '|| rec_cur_cont_h.segment1||' Child  lse_id '||Rec_Cur_child_cont_lines.lse_id||' :'||l_msg_count);
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Status of Child contract_line for Project '|| rec_cur_cont_h.segment1||' Child lse_id '||Rec_Cur_child_cont_lines.lse_id||' :'||l_return_status);
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');

                            IF (l_msg_count = 0 AND l_return_status = 'S' )
                            THEN
                                XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Creation of Child Contract Line is Sucess for Project_id '||Rec_Cur_cont_h.segment1);
                            ELSE
                                FOR i IN 1..l_msg_count
                                LOOP
                                    pa_interface_utils_pub.get_messages (  p_encoded        =>'F'
                                                                          ,p_msg_index      => i
                                                                          ,p_msg_count      => l_msg_count
                                                                          ,p_msg_data       => l_msg_data
                                                                          ,p_data           => l_data
                                                                          ,p_msg_index_out  => l_msg_index_out);
                                    l_api_err_msg := l_api_err_msg || '-'||l_data;
                                    l_error_mess_dis := 'Child CREATE_CONTRACT_LINE API Error ' || ': ' ||l_data;
                                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error in  Child Contract Line for Project :'||Rec_Cur_cont_h.segment1||' Child lse_id '||Rec_Cur_child_cont_lines.lse_id||' is '||l_data);
                                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');
                                END LOOP;

                               l_commit_flag := 'N';
                               xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name
                                                        ,in_debug_level    => 1
                                                        ,iv_called_by      => g_proc_name
                                                        ,iv_interface_name => g_interface_name_ou --g_interface_name -- CR 11178 - Making the cursor OU Specific
                                                        ,in_request_id     => g_con_request_id
                                                        ,iv_entity_id      => rec_cur_cont_h.segment1
                                                        ,iv_entity_name    => 'PROJECT_NUMBER'
                                                        ,iv_source_system  => g_source_sys
                                                        ,iv_dest_system    => g_source_sys
                                                        ,iv_severity       => TO_CHAR('ERROR')
                                                        ,iv_error_code     => l_return_status
                                                        ,iv_error_msg      => l_api_err_msg
                                                        ,iv_error_step     => 'create_contract_header for Child Lines');
                            END IF;
                        END IF;
                    END LOOP; -- End of Child Line Cur
                END IF;
            END LOOP ;  -- End of Parent Lines Cur

            --Party roles Cursor

            FOR rec_cur_party_roles IN cur_party_roles(rec_cur_cont_h.project_id)
            LOOP
                IF (l_commit_flag = 'Y')
                THEN
                    v_cplv_rec.chr_id     := header_out.k_header_id ;
                    v_cplv_rec.dnz_chr_id := header_out.k_header_id ;
                    v_cplv_rec.sfwt_flag  := 'N';
                    v_cplv_rec.rle_code   := rec_cur_party_roles.lookup_code;

                    IF rec_cur_party_roles.lookup_code = 'CONTRACTOR'
                    THEN
                        v_cplv_rec.jtot_object1_code :='OKX_OPERUNIT'; --This is hardcoded as of now need to check how to map to Bill_to and Ship_to
                    ELSE
                        v_cplv_rec.jtot_object1_code :='OKE_CUSTACCT'; --This is hardcoded as of now need to check how to map to Bill_to and Ship_to
                    END IF;

                    v_cplv_rec.object1_id1       := rec_cur_party_roles.role_code;
                    v_cplv_rec.object1_id2       := '#';
                    v_cplv_rec.created_by        := fnd_global.user_id;
                    v_cplv_rec.creation_date     := SYSDATE;
                    v_cplv_rec.last_update_login := fnd_global.user_id;
                    v_cplv_rec.last_updated_by   := fnd_global.user_id;
                    v_cplv_rec.last_update_date  := SYSDATE;

                    okc_contract_party_pub.create_k_party_role(p_api_version   => 1.0
                                                              ,p_init_msg_list => oke_api.g_true
                                                              ,x_return_status => l_return_status
                                                              ,x_msg_count     => l_msg_count
                                                              ,x_msg_data      => l_msg_data
                                                              ,p_cplv_rec      => v_cplv_rec
                                                              ,x_cplv_rec      => x_cplv_rec );

                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Count of  create_party_role API for Project '|| rec_cur_cont_h.segment1||' is '||l_msg_count||' for Role Code '||rec_cur_party_roles.lookup_code);
                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Status create_party_role API for Project  '|| rec_cur_cont_h.segment1||' is '||l_return_status||' for Role Code '||rec_cur_party_roles.lookup_code);
                    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');

                    IF (l_msg_count = 0 AND l_return_status = 'S' )
                    THEN
                        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Creation of Party Contact is Sucess for Project : '||Rec_Cur_cont_h.segment1||' and Role Code '||rec_cur_party_roles.lookup_code );
                    ELSE
                        FOR i IN 1..l_msg_count
                        LOOP
                            pa_interface_utils_pub.get_messages ( p_encoded        =>'F',
                                                                  p_msg_index      => i,
                                                                  p_msg_count      => l_msg_count,
                                                                  p_msg_data       => l_msg_data,
                                                                  p_data           => l_data,
                                                                  p_msg_index_out  => l_msg_index_out );

                            l_api_err_msg := l_api_err_msg || '-'||l_data;
                            l_error_mess_dis := 'CREATE_K_PARTY_ROLE API Error ' || ': ' ||l_data;
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error in  create_party_role API for Project  '|| rec_cur_cont_h.segment1||' and for Role Code '||rec_cur_party_roles.lookup_code||' is '||l_data);
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');
                        END LOOP;
                        l_commit_flag := 'N';
                        xx_au_debug.p_debug_error(iv_debug_key      => g_pkg_name
                                                 ,in_debug_level    => 1
                                                 ,iv_called_by      => g_proc_name
                                                 ,iv_interface_name => g_interface_name_ou --g_interface_name -- CR 11178 - Making the cursor OU Specific
                                                 ,in_request_id     => g_con_request_id
                                                 ,iv_entity_id      => rec_cur_cont_h.segment1
                                                 ,iv_entity_name    => 'PROJECT_NUMBER'
                                                 ,iv_source_system  => g_source_sys
                                                 ,iv_dest_system    => g_source_sys
                                                 ,iv_severity       => TO_CHAR('ERROR')
                                                 ,iv_error_code     => l_return_status
                                                 ,iv_error_msg      => l_api_err_msg
                                                 ,iv_error_step     => 'create_k_party_role');
                    END IF;
                END IF;
            END LOOP; --End of Party roles Cur

            --Cursor fetching the  contacts of project for creating contacts of Project Contract
            FOR rec_cur_contact_roles IN cur_contact_roles(rec_cur_cont_h.project_id)
            LOOP
                IF (l_commit_flag = 'Y')
                THEN
                    IF(cur_contact_roles%rowcount >0)
                    THEN
                        BEGIN
                             SELECT lookup_code
                               INTO l_cro_code
                               FROM fnd_lookup_values
                              WHERE lookup_code   = rec_cur_contact_roles.project_contact_type_code
                                AND lookup_type   = 'OKC_CONTACT_ROLE'
                                AND language      = 'US';
                        EXCEPTION
                        WHEN no_data_found
                        THEN
                            IF (rec_cur_contact_roles.project_contact_type_code LIKE '%CH%APP%' )
                            THEN
                                l_cro_code := 'CHG_APPR';
                            ELSE
                                l_cro_code := rec_cur_contact_roles.project_contact_type_code;
                            END IF;
                        END;

                        BEGIN
                             SELECT id
                               INTO l_cpl_id
                               FROM okc_k_party_roles_b
                              WHERE SUBSTR(rle_code,1,4) LIKE SUBSTR(rec_cur_contact_roles.project_contact_type_code, 1, 4)
                                AND chr_id = header_out.k_header_id;
                        EXCEPTION
                        WHEN no_data_found
                        THEN
                            BEGIN
                                 SELECT id
                                 INTO   l_cpl_id
                                 FROM   okc_k_party_roles_b
                                 WHERE  rle_code = 'K_CUSTOMER'
                                 AND    chr_id     = header_out.k_header_id;
                            EXCEPTION
                            WHEN no_data_found
                            THEN
                                NULL;
                            END;
                        END;

                        IF (rec_cur_contact_roles.project_contact_type_code like 'BILL%')
                        THEN
                            l_jtot_code := 'OKX_CONTBILL';
                        ELSIF (rec_cur_contact_roles.project_contact_type_code like 'SHIP%')
                        THEN
                            l_jtot_code := 'OKX_CONTSHIP';
                        ELSE
                            l_jtot_code := 'OKX_CONTSHIP';
                        END IF;

                        v_ctcv_rec.cpl_id            := l_cpl_id; --ID of okc_k_party_roles_b
                        v_ctcv_rec.dnz_chr_id        := header_out.k_header_id ;
                        v_ctcv_rec.cro_code          := l_cro_code; -- map with the LOOKUP_CODE
                        v_ctcv_rec.jtot_object1_code := l_jtot_code;
                        v_ctcv_rec.object1_id1       := rec_cur_contact_roles.contact_id;
                        v_ctcv_rec.object1_id2       := '#';
                        v_ctcv_rec.created_by        := fnd_global.user_id;
                        v_ctcv_rec.creation_date     := SYSDATE;
                        v_ctcv_rec.last_update_login := '-1';
                        v_ctcv_rec.last_updated_by   := fnd_global.user_id;
                        v_ctcv_rec.last_update_date  := SYSDATE;


                        okc_contract_party_pub.create_contact(p_api_version   => 1.0
                                                             ,p_init_msg_list => OKC_API.G_FALSE
                                                             ,x_return_status => l_return_status
                                                             ,x_msg_count     => l_msg_count
                                                             ,x_msg_data      => l_msg_data
                                                             ,p_ctcv_rec      => v_ctcv_rec
                                                             ,x_ctcv_rec      => b_ctcv_rec);


                        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Count of  create_contact API for Project '|| rec_cur_cont_h.segment1||' is '||l_msg_count||' for CRO Code '||l_cro_code);
                        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Status create_contact API for Project  '|| rec_cur_cont_h.segment1||' is '||l_return_status||' for CRO Code '||l_cro_code);
                        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');

                        IF (l_msg_count = 0 AND l_return_status = 'S' )
                        THEN
                            XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Creation of Contact Role is Sucess for Project '||Rec_Cur_cont_h.segment1||' for CRO Code '||l_cro_code);
                        ELSE
                            FOR i IN 1..l_msg_count
                            LOOP
                                pa_interface_utils_pub.get_messages ( p_encoded         =>'F',
                                                                      p_msg_index       => i,
                                                                      p_msg_count       => l_msg_count,
                                                                      p_msg_data        => l_msg_data,
                                                                      p_data            => l_data,
                                                                      p_msg_index_out   => l_msg_index_out);
                                l_api_err_msg    := l_api_err_msg || '-'||l_data;
                                l_error_mess_dis := 'CREATE_CONTACT API Error ' || ': ' ||l_data;
                                XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error in  create_contact API for Project  '|| rec_cur_cont_h.segment1||' and for CRO Code'||l_cro_code||' is '||l_data);
                                XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'');
                            END LOOP;
                            l_commit_flag := 'N';
                            xx_au_debug.p_debug_error(iv_debug_key             => g_pkg_name,
                                                      in_debug_level           => 1,
                                                      iv_called_by             => g_proc_name,
                                                      iv_interface_name        => g_interface_name_ou, --g_interface_name, -- CR 11178 - Making the cursor OU Specific
                                                      in_request_id            => g_con_request_id,
                                                      iv_entity_id             => rec_cur_cont_h.segment1,
                                                      iv_entity_name           => 'PROJECT_NUMBER',
                                                      iv_source_system         => g_source_sys,
                                                      iv_dest_system           => g_source_sys,
                                                      iv_severity              => to_char('ERROR'),
                                                      iv_error_code            => l_return_status,
                                                      iv_error_msg             => l_api_err_msg,
                                                      iv_error_step            => 'create_contact');
                        END IF;
                    END IF;
                END IF;
            END LOOP;  --End of cur_contact_roles

            IF (l_commit_flag = 'Y')
            THEN
                COMMIT;
                l_sucess_count := l_sucess_count +1;
                XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( l_project_number, 25, ' ' ));
            ELSE
                ROLLBACK;
                l_failure_count := l_failure_count +1;
                XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )||l_error_mess_dis );
            END IF;
        ELSE
            l_failure_count := l_failure_count + 1;
        END IF;       --End of l_count_template = 1
        l_contract_counter := l_contract_counter+1;
        XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'');
    END LOOP ;  -- End of cur_contract_creation

    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'-----------------------------------------------------------------------------------');
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'                              Report Execution Summary                             ');
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'-----------------------------------------------------------------------------------');
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Project Considered after       : '||  TO_CHAR(l_date,'DD-Mon-YYYY HH12:MI:SS AM')   );
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Project Considered in this run : '||  (l_contract_counter-1)                        );
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Project Contracts Created      : '||  l_sucess_count                                );
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'Project Rejected/Error         : '||  l_failure_count                               );
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,'-----------------------------------------------------------------------------------');

    -- To update run date in history table
    IF(p_project_id IS NULL)
    THEN
    --l_last_run_update := xxau_comn_util_pkg.f_set_last_run_dt(g_interface_name); -- CR 11178 - Making the cursor OU Specific
    l_last_run_update := xxau_comn_util_pkg.f_set_last_run_dt(g_interface_name_ou);

      IF(l_last_run_update)
      THEN
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Successfully updated run date');
      ELSE
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Error while updating run date');
      END IF;
    END IF;

EXCEPTION
WHEN e_pjm_not_exists
THEN
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )||'Project is not present in Project Manufacturing Organization.');
WHEN e_not_parent_project
THEN
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )||'Project is not Primary Project.');
WHEN e_contract_present
THEN
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'Contract is already present for this Project' );
WHEN e_template_project
THEN
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )|| 'Project is Template Project' );
WHEN e_invalid_project
THEN
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.OUTPUT,RPAD(l_contract_counter, 10, ' ' )|| RPAD( l_ou_name,45,' ') || RPAD( l_project_number, 25, ' ' ) || RPAD( ' ', 25, ' ' )||'Project is not a Valid');
WHEN OTHERS THEN
    ROLLBACK;
    XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,'Contract Not Created for project '||l_project_number ||':'||SQLERRM);
END xxpa_contract_crtn_pmo_proc;



PROCEDURE xxpa_contract_creation_proc(p_project_id  IN NUMBER)
IS
  l_project_number         VARCHAR2(25);
  l_req_status             BOOLEAN;
  l_req_id                 NUMBER;
  e_submit_request         EXCEPTION;
BEGIN
     BEGIN
          SELECT segment1
          INTO   l_project_number
          FROM   pa_projects
          WHERE  project_id   = p_project_id;
     EXCEPTION
     WHEN OTHERS THEN
          g_error_msg := SQLERRM;
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
     END;

     l_req_id := FND_REQUEST.SUBMIT_REQUEST(    application => 'XXPA',
                              program     => 'XXPA1559_3',
                              description => 'XX Create Contract for Projects',
                              start_time  => SYSDATE,
                              sub_request => FALSE,
                              argument1   => p_project_id,
                        argument2   => 'N',
                        argument3   => 'Y',
                        argument4   => 'Y');
     COMMIT;

     IF l_req_id <= 0
     THEN
         g_error_msg         := 'Failed to Submit XX Create Contract for Projects Program For Project Number :- '|| l_project_number;
         RAISE e_submit_request;
     END IF;

     g_request_id     := l_req_id;

EXCEPTION
   WHEN e_submit_request
   THEN
      ROLLBACK;
      XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
   WHEN OTHERS
   THEN
      g_error_msg := SQLERRM;
      XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_contract_creation_proc;




FUNCTION xxpa_contract_creation_request RETURN VARCHAR2
AS
BEGIN
     IF g_request_id IS NOT NULL
     THEN
         RETURN('XX Create Contract for Projects Program has been Submitted with Request Id: '||g_request_id);
     ELSE
         RETURN('XX Create Contract for Projects Program has not been Submitted');
     END IF;

     g_request_id:=NULL;

EXCEPTION
   WHEN OTHERS
   THEN
      RETURN(NULL);
      g_error_msg := SQLERRM;
      XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_contract_creation_request;



PROCEDURE xxpa_proj_task_mfgorg_proc(p_project_id  IN NUMBER)
IS
  l_project_number          VARCHAR2(25);
  l_req_id                  NUMBER;
  e_submit_request          EXCEPTION;
BEGIN
     BEGIN
          SELECT segment1
          INTO   l_project_number
          FROM   pa_projects
          WHERE  project_id   = p_project_id;
     EXCEPTION
     WHEN OTHERS THEN
          g_error_msg := SQLERRM;
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
     END;

     l_req_id := FND_REQUEST.SUBMIT_REQUEST(    application => 'XXPA',
                             program     => 'XXPA1559_2',
                             description => 'Project and Task Addition to Project Manufacturing Org',
                             start_time  => SYSDATE,
                             sub_request => FALSE,
                             argument1   => p_project_id,
                            argument2   => 'N',
                argument3   => 5);

     COMMIT;

     IF l_req_id <= 0
     THEN
         g_error_msg         := 'Failed to Submit XX Project and Task addition to Project Manufacturing Organization Program For Project Number :- '|| l_project_number;
         RAISE e_submit_request;
     END IF;

     g_request_id1   := l_req_id;
EXCEPTION
WHEN e_submit_request THEN
     ROLLBACK;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
WHEN OTHERS THEN
     g_error_msg := SQLERRM;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_proj_task_mfgorg_proc;

FUNCTION xxpa_proj_task_mfgorg_request RETURN VARCHAR2
AS
BEGIN
     IF g_request_id1 IS NOT NULL
     THEN
         RETURN('XX Project and Task addition to Project Manufacturing Organization Program has been Submitted with Request Id: '||g_request_id1);
     ELSE
         RETURN('XX Project and Task addition to Project Manufacturing Organization Program has not been Submitted');
     END IF;
     g_request_id1:=NULL;
EXCEPTION
WHEN OTHERS THEN
     RETURN(NULL);
     g_error_msg := SQLERRM;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_proj_task_mfgorg_request;

FUNCTION xxpa_contract_number(p_project_id  IN NUMBER) RETURN VARCHAR2
AS
  CURSOR cur_contract_num IS
  SELECT k_number_disp
    FROM oke_k_headers    okh
   WHERE okh.project_id = p_project_id;

  l_contract_number VARCHAR2(240):= NULL;
  l_project_number  VARCHAR2(25);
BEGIN
     BEGIN
          SELECT segment1
          INTO   l_project_number
          FROM   pa_projects
          WHERE  project_id   = p_project_id;
     EXCEPTION
     WHEN OTHERS THEN
          g_error_msg := SQLERRM;
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
     END;

     FOR rec_cur_contract_num IN cur_contract_num
     LOOP
         IF (cur_contract_num%ROWCOUNT=1)
         THEN
             l_contract_number := rec_cur_contract_num.k_number_disp;
         ELSE
             l_contract_number := rec_cur_contract_num.k_number_disp|| ','||l_contract_number;
         END IF;
     END LOOP;

     RETURN('Contract '||l_contract_number ||' is already created for this Project Number: '||l_project_number);
EXCEPTION
WHEN OTHERS THEN
     RETURN(NULL);
     g_error_msg := SQLERRM;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_contract_number;

END xxpa_contract_creation_pmo_pkg;
/
