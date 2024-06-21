  CREATE OR REPLACE PACKAGE BODY      xxpa_rev_cn
  AS
  /*********************************************************
  ** Title:       XXPA1555 Extension for Term Service Contract lr_revenue Recognition
  ** File:        xxpa_rev_cn.pkb
  ** Description: This script creates a package body For HVAC China. Procedure Auto_rev_event_gen() creates
  **              automatic events for lr_revenue Recong.
  ** Parameters:  {None.}
  ** Run as:      APPS
  ** R12_2_compliant: YES	
  ** Keyword tracking:
  **
  **   
  **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_rev_cn.pkb 1.0 28-JUN-2023 19:48:51 CCHWDF $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.0 (COMPLETE)
  **     Created:  28-JUN-2023 19:48:51      CCHWDF (Rahaman Rawoof)
  **       Initial revision.
  **   
  **
  **
  **
  ** History:
  ** DATE           Who                      Description
  ** -----------   ------------------       ------------------------------------
  **27-06-2023     Rahaman Rawoof           CR25222 - Project Billing Extension for HVAC China Maintenance Contracts Which job value <120K AND Extended Warranty
  ************************************************************************************/
  /*****************************************************************************
  -- Global variables to store the attribute12 - 15 columns of
  -- pa_billing_extensions table
  ****************************************************************************/
  g_ca_event_type        VARCHAR2(30);
  g_ca_contra_event_type VARCHAR2(30);
  g_ca_wip_event_type    VARCHAR2(30);
  g_ca_budget_type       VARCHAR2(1) ;
  /***************************************************************************
  Private Procedures and Functions
  ****************************************************************************/
  --
  -- Function to check if closing entries have been created for project and top task
  --
  g1_debug_mode VARCHAR2(1) := NVL(FND_PROFILE.value('PA_DEBUG_MODE'), 'N');
  /* Customer Revenue Amount returning procedure */
PROCEDURE get_rev_budget_amount(
    X2_project_id                NUMBER,
    X2_task_id                   NUMBER DEFAULT NULL,
    X2_agreement_id              NUMBER DEFAULT NULL,
    X2_revenue_amount OUT NOCOPY REAL,
    P_rev_budget_type_code IN VARCHAR2 DEFAULT NULL,
    P_rev_plan_type_id     IN NUMBER DEFAULT NULL,
    /* Added for Fin plan impact */
    X_rev_budget_type_code OUT NOCOPY VARCHAR2,
    X_rev_date IN DATE,
    X_error_message OUT NOCOPY VARCHAR2,
    X_status OUT NOCOPY        NUMBER )
IS
  -- local variables for budget codes
  l_cost_budget_type_code   VARCHAR2(30) ;
  l_rev_budget_type_code    VARCHAR2(30) ;
  l_cost_budget_status_code VARCHAR2(1) ;
  l_rev_budget_status_code  VARCHAR2(1) ;
  dummy                     CHAR(1);
  err_msg                   VARCHAR2(240);
  err_status                NUMBER;
  status                    VARCHAR2(240);
  l_status                  NUMBER:=0;
  l_cost_budget_version_id  NUMBER;
  l_rev_budget_version_id   NUMBER;
  l_raw_cost_total          REAL := 0;
  l_revenue_total           REAL := 0;
  l_quantity_total          NUMBER;
  l_burdened_cost_total     NUMBER;
  l_err_code                NUMBER;
  l_err_stage               VARCHAR2(30);
  l_err_stack               VARCHAR2(630);
  l_max_baseline_dt DATE;
  l_max_fund_allocation_dt DATE;
  l_prj_end_dt DATE;
  l_prj_start_dt DATE;
  /* Added for Fin Plan Impact */
  l_cost_plan_type_id    NUMBER;
  l_rev_plan_type_id     NUMBER;
  l_cost_plan_version_id NUMBER;
  l_rev_plan_version_id  NUMBER;
  /* Till here */
  invalid_cost_budget_code  EXCEPTION;
  invalid_rev_budget_code   EXCEPTION;
  rev_budget_not_baselined  EXCEPTION;
  cost_budget_not_baselined EXCEPTION;
  invalid_funding_budget    EXCEPTION;
BEGIN
  if G1_DEBUG_MODE = 'Y' then
    fnd_file.put_line (fnd_file.LOG,'=====begin xxpa_rev_cn.get_rev_budget_amount======');
    fnd_file.put_line (fnd_file.LOG,'=====Params get_rev_budget_amount X2_project_id              : '||X2_project_id);
    fnd_file.put_line (fnd_file.LOG,'=====Params get_rev_budget_amount X2_task_id                 : '||X2_task_id);
    fnd_file.put_line (fnd_file.LOG,'=====Params get_rev_budget_amount X2_agreement_id            : '||X2_agreement_id);
    fnd_file.put_line (fnd_file.LOG,'=====Params get_rev_budget_amount P_rev_budget_type_code     : '||P_rev_budget_type_code);
    fnd_file.put_line (fnd_file.LOG,'=====Params get_rev_budget_amount P_rev_plan_type_id         : '||P_rev_plan_type_id );
    fnd_file.put_line (fnd_file.LOG,'=====Params get_rev_budget_amount X_rev_date                 : '||X_rev_date );
  END IF;
  X_status        := 0;
  X_error_message := NULL;
  -- If user doesnt provide the budget get the default value from biling extensions
  --
  IF (P_rev_budget_type_code IS NULL OR P_rev_plan_type_id IS NULL ) THEN
    SELECT DECODE(P_rev_budget_type_code,NULL,default_rev_budget_type_code,P_rev_budget_type_code),
      DECODE(P_rev_plan_type_id,NULL,default_rev_plan_type_id, P_rev_plan_type_id)
    INTO l_rev_budget_type_code,
      l_rev_plan_type_id
    FROM pa_billing_extensions
    WHERE billing_extension_id=pa_billing.GetBillingExtensionId;
  END IF;
  IF g1_debug_mode = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' 1 l_rev_budget_type_code '||l_rev_budget_type_code||' l_rev_plan_type_id '||l_rev_plan_type_id);
  END IF;
  BEGIN
    SELECT 'x'
    INTO dummy
    FROM dual
    WHERE EXISTS
      (SELECT *
      FROM pa_fin_plan_types_b f
      WHERE f.fin_plan_type_id=l_rev_plan_type_id
      );
    IF g1_debug_mode = 'Y' THEN
      fnd_file.put_line (fnd_file.LOG,'2 dummy '||dummy);
    END IF;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- The budget code should be a valid code and of the right amount code
    -- If invalid then raise appropriate exception
    BEGIN
      SELECT 'x'
      INTO dummy
      FROM pa_budget_types
      WHERE budget_type_code = l_rev_budget_type_code
      AND budget_amount_code = 'R';
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      raise invalid_rev_budget_code;
    END ;
  END;
  l_max_baseline_dt        := to_date('31-DEC-9999 00:00:00','DD-MON-YYYY HH24:MI:SS');
  L_MAX_FUND_ALLOCATION_DT := TO_DATE('31-DEC-9999 00:00:00','DD-MON-YYYY HH24:MI:SS');
  if g1_debug_mode          = 'Y' then
    fnd_file.put_line (fnd_file.LOG,' Fetching project start and end date.');
  END IF;
  SELECT ppa.COMPLETION_DATE ,
    ppa.START_DATE
  INTO l_prj_end_dt,
    l_prj_start_dt
  FROM pa_projects_all ppa
  where ppa.project_id = x2_project_id;

  if g1_debug_mode          = 'Y' then
    fnd_file.put_line (fnd_file.LOG,' l_prj_end_dt : '||l_prj_end_dt||' l_prj_start_dt : '||l_prj_start_dt);
  END IF;

  SELECT NVL(SUM(NVL(allocated_amount,0)),0)
  INTO l_revenue_total
  FROM PA_PROJECT_FUNDINGS_V
  where project_id                       = x2_project_id
  --AND agreement_id                       = X2_agreement_id
  --AND (task_id                           = X2_task_id
  --OR (X2_task_id                        IS NULL
  --AND task_id                           IS NULL))
  AND budget_type_code                   = 'BASELINE'
  AND date_allocated <= X_rev_date;
  IF l_revenue_total                     = 0 THEN
    raise invalid_funding_budget;
  END IF;
  X2_revenue_amount      := pa_currency.round_currency_amt(l_revenue_total);
  X_rev_budget_type_code := l_rev_budget_type_code;
  IF g1_debug_mode        = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,'22  X2_revenue_amount '||X2_revenue_amount||' X_rev_budget_type_code '||X_rev_budget_type_code);
    fnd_file.put_line (fnd_file.LOG,'=====end xxpa_rev_cn.get_rev_budget_amount======');
  END IF;
EXCEPTION
WHEN invalid_funding_budget THEN
  status   := 'INVALID_FUNDING_BUDGET';
  l_status := 2;
  --RAISE_APPLICATION_ERROR(-20101,status);
  X2_revenue_amount      := NULL;
  X_rev_budget_type_code := NULL;
  X_error_message        := status;
  X_status               := l_status;
  pa_billing_pub.insert_message (X_inserting_procedure_name =>'xxpa_rev_cn.get_rev_budget_amount', X_attribute1 => l_cost_budget_type_code, X_attribute2 => l_rev_budget_type_code, X_message => status, X_error_message=>status, X_status=>l_status);
WHEN OTHERS THEN
  -- DBMS_OUTPUT.PUT_LINE(status);
  -- DBMS_OUTPUT.PUT_LINE(SQLERRM);
  status                 := SUBSTR(SQLERRM,1,240);
  l_status               := SQLCODE;
  X2_revenue_amount      := NULL;
  X_rev_budget_type_code := NULL;
  X_error_message        := status;
  X_status               := l_status;
  pa_billing_pub.insert_message (X_inserting_procedure_name =>'xxpa_rev_cn.get_rev_budget_amount', X_attribute1 => l_cost_budget_type_code, X_attribute2 => l_rev_budget_type_code, X_message => status, X_error_message=>status, X_status=>l_status);
END get_rev_budget_amount;
/* Custom Billing Extension */
PROCEDURE Auto_rev_event_gen(
    X_project_id            IN NUMBER,
    X_top_task_id           IN NUMBER DEFAULT NULL,
    X_calling_process       IN VARCHAR2 DEFAULT NULL,
    X_calling_place         IN VARCHAR2 DEFAULT NULL,
    X_amount                IN NUMBER DEFAULT NULL,
    X_percentage            IN NUMBER DEFAULT NULL,
    X_rev_or_bill_date      IN DATE DEFAULT NULL,
    X_billing_assignment_id IN NUMBER DEFAULT NULL,
    X_billing_extension_id  IN NUMBER DEFAULT NULL,
    X_request_id            IN NUMBER DEFAULT NULL )
IS
  err_msg               VARCHAR2(200);
  err_status            NUMBER;
  STATUS                    VARCHAR2(240);
  L_PRJ_NAME varchar2(50);
  --l_status                  NUMBER:=0;
   X2_revenue_amount     number := NULL;
  X_rev_budget_type_code VARCHAR2(30):= NULL;
  chk_adj_eve_flag      VARCHAR2(1) := NULL;
  crt_curr_mon_eve_flag VARCHAR2(1) := NULL;
  l_revamt_eve_crtd     NUMBER;
  curr_eve_num_days     NUMBER;
  l_last_event_date DATE;
  l_no_days_accrued  NUMBER;
  l_curr_open_period VARCHAR2(20):=NULL;
  l_period_start DATE;
  L_PERIOD_END date;
  l_work_type_id  number:=0;
  l_work_type_nm  varchar2(80):=null;
  l_num_of_mon          NUMBER;
  l_project_funding_amt NUMBER:=0;
  l_rev_amt_per_day     NUMBER:=0;
  l_rev_accrued_till_dt NUMBER:=0;
  l_rev_amt             NUMBER:=0;
  l_prj_start_dt DATE;
  L_PRJ_END_DT date;
  l_tsk_end_dt date;
  l_tsk_start_dt date;
  l_org_id  number;
  L_TOP_TASK_ID number;
  budget_revenue          REAL := 0;
  budget_cost             REAL := 0;
  revenue_amount          REAL := 0;
  revenue                 REAL := 0;
  event_description       VARCHAR2(240);
  l_cost_plan_type_id     NUMBER;
  l_rev_plan_type_id      NUMBER;
  l_cost_plan_version_id  NUMBER;
  l_rev_plan_version_id   NUMBER;
  l_cost_budget_type_code VARCHAR2(30);
  l_rev_budget_type_code  VARCHAR2(30);
  l_status                NUMBER;
  l_error_message         VARCHAR2(240);
  l_prj_no_of_days        number;
  l_task_no_of_days    number;
  L_LOOKUP_TASK           VARCHAR2(30);
  L_LOOKUP_TASK_ID        NUMBER;
  L_PRJ_FUNDING_LVL       VARCHAR2(20);
  l_lookup_found          varchar2(1);
  l_event_task_id number;
  lookup_err              exception;
  NO_LOOKUP_ERR           EXCEPTION;
  ARBIT_ERR               EXCEPTION;
  NO_FUNDIND_ERR          EXCEPTION;
  ERR_COUNT_DAYS          EXCEPTION;
  ERR_INVALID_BUDGET      EXCEPTION;
  ERR_INSERT_EVENT        EXCEPTION;
  prj_tsk_err             EXCEPTION;
  prj_too_many_tsk        EXCEPTION;
  L_EVE_CRT_CURR_CODE     VARCHAR2(10):=NULL;
  l_last_mon_per_closed     varchar2(1):='N'; -- Fix RT 5058267
  l_project_status pa_project_statuses.project_system_status_code%TYPE;
  l_project_type pa_projects_all.project_type%TYPE;
  l_last_rev_eve_dt DATE;
  l_curr_rev_eve_dt DATE;
  l_adj_rev_amt   NUMBER:=0;
  l_rev_amt2      NUMBER:=0;
  TOT_REV_EVE_AMT NUMBER:=0;
  TOT_EVE_AMT2    NUMBER:=0;
  TOT_L_REV_AMT   NUMBER:=0;
  lv_task_rev_rec_method          VARCHAR2 (70);  --  CR22995
  lv_event_type             pa_event_types.event_type%TYPE;
  l_job_value      			VARCHAR2(100);
  l_meaning					VARCHAR2(100);
  l_last_month_hold 		VARCHAR2(20);
  l_rev_annum_amt		    NUMBER:=0;
  l_hold_flag			    VARCHAR2(1) := 'Y';
BEGIN
  IF g1_debug_mode = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' =====START : Params Auto_rev_event_gen X_request_id       : '||X_request_id );
    fnd_file.put_line (fnd_file.LOG,'     =====begin xxpa_rev_cn.Auto_rev_event_gen======     ');
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_project_id               : '||X_project_id);
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_top_task_id              : '||X_top_task_id);
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_calling_process          : '||X_calling_process);
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_calling_place            : '||X_calling_place );
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_amount                   : '||X_amount );
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_percentage               : '||X_percentage );
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_rev_or_bill_date         : '||X_rev_or_bill_date );
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_billing_assignment_id    : '||X_billing_assignment_id );
    fnd_file.put_line (fnd_file.LOG,' =====Params Auto_rev_event_gen X_billing_extension_id     : '||X_billing_extension_id );
  END IF;

  SELECT SEGMENT1 INTO L_PRJ_NAME FROM PA_PROJECTS_ALL WHERE PROJECT_ID = X_PROJECT_ID;

  l_last_rev_eve_dt := (TRUNC(X_rev_or_bill_date,'MM')-1);
  l_curr_rev_eve_dt := last_day(X_rev_or_bill_date);
  IF g1_debug_mode   = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' l_curr_rev_eve_dt: '||l_curr_rev_eve_dt||' l_last_rev_eve_dt: '||l_last_rev_eve_dt);
  end if;
  l_org_id := fnd_profile.value('ORG_ID');

  /* Fetching Project Details*/
  SELECT (ppa.COMPLETION_DATE - ppa.START_DATE)+1 prj_no_of_days,
    ppa.COMPLETION_DATE ,
    ppa.START_DATE ,
    PPS.PROJECT_SYSTEM_STATUS_CODE,
    PPA.PROJECT_TYPE,
    --decode(ptyp.ALLOWABLE_FUNDING_LEVEL_CODE,'P','PROJECT','B','BOTH','T','TOPTASK') -- CR22722 commented
    PA_BILLING_VALUES.FUNDING_LEVEL(ppa.project_id)  -- CR22722 Added
  INTO l_prj_no_of_days,
    l_prj_end_dt,
    l_prj_start_dt,
    l_project_status,
    L_PROJECT_TYPE,
    l_prj_funding_lvl
  FROM PA_PROJECTS_ALL PPA,
    PA_PROJECT_STATUSES PPS,
    pa_project_types_all ptyp
  WHERE PPA.PROJECT_ID = X_PROJECT_ID
  --and ppa.org_id =l_org_id
  AND X_rev_or_bill_date BETWEEN trunc(ppa.START_DATE,'MM') AND last_day(ppa.COMPLETION_DATE)
  AND PPA.PROJECT_STATUS_CODE = PPS.PROJECT_STATUS_CODE
  AND PPS.STATUS_TYPE         = 'PROJECT'
  AND PTYP.PROJECT_TYPE = PPA.PROJECT_TYPE
  and ptyp.org_id = ppa.org_id;

  fnd_file.put_line (fnd_file.LOG,' l_prj_no_of_days                   : '||l_prj_no_of_days );
  fnd_file.put_line (fnd_file.LOG,' l_prj_end_dt                   : '||l_prj_end_dt );
  fnd_file.put_line (fnd_file.LOG,' l_prj_start_dt                   : '||l_prj_start_dt );
  fnd_file.put_line (fnd_file.LOG,' l_project_status                   : '||l_project_status );
  fnd_file.put_line (fnd_file.LOG,' L_PROJECT_TYPE                   : '||L_PROJECT_TYPE );
  fnd_file.put_line (fnd_file.LOG,' l_prj_funding_lvl                   : '||l_prj_funding_lvl );

  IF G1_DEBUG_MODE            = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' Fetching project details.');
  END IF;
  if g1_debug_mode = 'Y' then
    fnd_file.put_line (fnd_file.LOG,' No of days between prj start and end date :'||to_char(l_prj_no_of_days));
    fnd_file.put_line (fnd_file.LOG,'prj start dt:'||TO_CHAR(L_PRJ_START_DT)||' and prj end date :'||TO_CHAR(L_PRJ_END_DT)||' prj_fund_lvl : '||L_PRJ_FUNDING_LVL);
  END IF;

  /* Get the Task Id from the Lookup SERVICE_REV_OU_TASK_MAPPING*/
  BEGIN
  l_lookup_task:=null;
  L_LOOKUP_FOUND:=NULL;
  SELECT description , 'Y'
  into l_lookup_task, l_lookup_found
     from pa_lookups
     where lookup_type='SERVICE_REV_OU_TASK_MAPPING'
     AND LOOKUP_CODE = TO_CHAR(L_ORG_ID)
     AND ENABLED_FLAG='Y'
     and L_CURR_REV_EVE_DT >= NVL(START_DATE_ACTIVE,TO_DATE('01-JAN-1950','DD-MON-RRRR'))
     --and L_CURR_REV_EVE_DT <= NVL(END_DATE_ACTIVE,TO_DATE('31-DEC-2050','DD-MON-RRRR'))
     and case
         when ((l_prj_end_dt <= L_CURR_REV_EVE_DT
                and TO_CHAR(l_prj_end_dt,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM'))
                and l_prj_end_dt <= NVL(END_DATE_ACTIVE,TO_DATE('31-DEC-2050','DD-MON-RRRR')))
                   then 1
         when (TO_CHAR(L_PRJ_END_DT,'YYYY-MM') > TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                and L_CURR_REV_EVE_DT <= NVL(END_DATE_ACTIVE,TO_DATE('31-DEC-2050','DD-MON-RRRR')))
                   then 1
         else 0
         end
         = 1;
  exception
  WHEN TOO_MANY_ROWS THEN
      --xxau_errors_pkg.write_debug_log(p_message => 'Duplicate rows in LOOKUP for CODE : '||fnd_profile.value('ORG_ID'));
      raise LOOKUP_ERR;
  WHEN NO_DATA_FOUND THEN
      l_lookup_found:='N';
      l_lookup_task:=null;
  when others then
      raise ARBIT_ERR;
  END;
   IF g1_debug_mode   = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' l_lookup_task: '||l_lookup_task||' l_lookup_found: '||l_lookup_found);
  end if;
  if l_lookup_found = 'Y' then
    begin
      select TASK_ID ,COMPLETION_DATE
      into l_lookup_task_id,l_tsk_end_dt
      FROM PA_TASKS
      WHERE PROJECT_ID = X_PROJECT_ID
      and task_name = l_lookup_task
      and L_CURR_REV_EVE_DT >= NVL(START_DATE,TO_DATE('01-JAN-1950','DD-MON-RRRR'))
      --and l_curr_rev_eve_dt <= nvl(COMPLETION_DATE,to_date('31-DEC-2050','DD-MON-RRRR'))
      and case
           when (l_prj_end_dt <= L_CURR_REV_EVE_DT
                  and TO_CHAR(L_PRJ_END_DT,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM'))
                 -- and l_prj_end_dt <= NVL(COMPLETION_DATE,TO_DATE('31-DEC-2050','DD-MON-RRRR'))
                     then 1
           when (TO_CHAR(L_PRJ_END_DT,'YYYY-MM') > TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                  and L_CURR_REV_EVE_DT <= NVL(COMPLETION_DATE,TO_DATE('31-DEC-2050','DD-MON-RRRR')))
                     then 1
           else 0
           end
           = 1;
    exception
      WHEN NO_DATA_FOUND THEN
         --xxau_errors_pkg.write_debug_log(p_message => 'No task with name '||l_lookup_task||' in Project '||X_project_id);
         fnd_file.put_line (fnd_file.LOG,' prj_tsk_err ');
          RAISE prj_tsk_err ;
      WHEN TOO_MANY_ROWS THEN
      fnd_file.put_line (fnd_file.LOG,' prj_too_many_tsk ');
          raise prj_too_many_tsk;
      WHEN OTHERS THEN
      fnd_file.put_line (fnd_file.LOG,' arbit_err ');
          raise arbit_err;
    end;
  else
    l_lookup_task_id := null;
  END IF;
  IF g1_debug_mode   = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' l_lookup_task_id: '||l_lookup_task_id);
  end if;

  IF  l_prj_funding_lvl = 'PROJECT' then
     IF l_lookup_found ='Y' then
         --L_TOP_TASK_ID := NULL;
         --As suggested by Harish on 04-Dec-2015
          BEGIN
          SELECT  TASK_ID ,COMPLETION_DATE
          INTO  l_lookup_task_id,l_tsk_end_dt
          FROM  PA_TASKS
          WHERE PROJECT_ID = X_PROJECT_ID
          AND  task_name = l_lookup_task
          AND  L_CURR_REV_EVE_DT >= NVL(START_DATE,TO_DATE('01-JAN-1950','DD-MON-RRRR'))
          --and l_curr_rev_eve_dt <= nvl(COMPLETION_DATE,to_date('31-DEC-2050','DD-MON-RRRR'))
          AND  CASE
                 WHEN  (l_prj_end_dt <= L_CURR_REV_EVE_DT
                        AND  TO_CHAR(L_PRJ_END_DT,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM'))
                       -- and l_prj_end_dt <= NVL(COMPLETION_DATE,TO_DATE('31-DEC-2050','DD-MON-RRRR'))
                           THEN  1
                 WHEN  (TO_CHAR(L_PRJ_END_DT,'YYYY-MM') > TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                        AND  L_CURR_REV_EVE_DT <= NVL(COMPLETION_DATE,TO_DATE('31-DEC-2050','DD-MON-RRRR')))
                           THEN  1
                 ELSE  0
                 END
                 = 1;
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
             --xxau_errors_pkg.write_debug_log(p_message => 'No task with name '||l_lookup_task||' in Project '||X_project_id);
             fnd_file.put_line (fnd_file.LOG,' prj_tsk_err ');
             RAISE prj_tsk_err ;
          WHEN TOO_MANY_ROWS THEN
          fnd_file.put_line (fnd_file.LOG,' prj_too_many_tsk ');
              raise prj_too_many_tsk;
          WHEN OTHERS THEN
          fnd_file.put_line (fnd_file.LOG,' arbit_err ');
              RAISE arbit_err;
         END;
      ELSE  L_TOP_TASK_ID := NULL;
     END IF ; --l_lookup_found ='Y'

          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' IN Params passed to xxpa_billing_pub.get_rev_budget_amount : ');
            fnd_file.put_line (fnd_file.LOG,' Params X_project_id : '||X_project_id);
            fnd_file.put_line (fnd_file.LOG,' Params X_top_task_id : '||L_TOP_TASK_ID);
            fnd_file.put_line (fnd_file.LOG,' Params l_rev_plan_type_id : '||l_rev_plan_type_id);
            fnd_file.put_line (fnd_file.LOG,' Params X_rev_date : '||TO_CHAR(l_curr_rev_eve_dt));
          END IF;
          xxpa_rev_cn.get_rev_budget_amount( x2_project_id => x_project_id,
                                              x2_task_id => L_TOP_TASK_ID,
                                              X2_agreement_id => null,
                                              x2_revenue_amount => budget_revenue,
                                              p_rev_budget_type_code => l_rev_budget_type_code,
                                              p_rev_plan_type_id => l_rev_plan_type_id,
                                              x_rev_budget_type_code => l_rev_budget_type_code,
                                              x_rev_date => l_curr_rev_eve_dt,
                                              x_error_message =>l_error_message,
                                              X_status => l_status);
          IF l_status <> 0 THEN
            --RAISE_APPLICATION_ERROR(-20131,'ERR INVALID BUDGET');
            RAISE ERR_INVALID_BUDGET;
          END IF;
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' OUT values from xxpa_billing_pub.get_rev_budget_amount : ');
            fnd_file.put_line (fnd_file.LOG,' Params X2_revenue_amount : '||budget_revenue);
            fnd_file.put_line (fnd_file.LOG,' Params X_rev_budget_type_code : '||l_rev_budget_type_code);
          END IF;
          IF budget_revenue  = 0 THEN
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,' No budget for the project ');
            END IF;
            RAISE NO_FUNDIND_ERR;
          END IF;
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' budget_revenue amt : '||budget_revenue||' for project '||X_project_id);
            fnd_file.put_line (fnd_file.LOG,' formula applied rev amt per day = '||budget_revenue||' divided by '||l_prj_no_of_days);
          END IF;
        TOT_REV_EVE_AMT  :=0;
        TOT_EVE_AMT2     :=0;
        TOT_L_REV_AMT    :=0;
        l_revamt_eve_crtd:=0;
        FOR agr_tsk      IN
            (SELECT DISTINCT agreement_id,
              task_id
            FROM PA_PROJECT_FUNDINGS_V
            WHERE project_id     = X_project_id
            AND (TASK_ID         =L_TOP_TASK_ID
            OR (TASK_ID         IS NULL
            AND L_TOP_TASK_ID   IS NULL))
            AND budget_type_code = 'BASELINE'
            AND date_allocated  <= l_curr_rev_eve_dt
            )
        LOOP
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' === FOR Loop begin agr_tsk.agreement_id: '||agr_tsk.agreement_id);
            fnd_file.put_line (fnd_file.LOG,' === FOR Loop begin agr_tsk.task_id: '||agr_tsk.task_id);
          END IF;
          SELECT NVL(SUM(NVL(BILL_TRANS_REV_AMOUNT,0)),0),
            NVL(MAX(completion_date),to_date('31-DEC-9999','DD-MON-YYYY'))
          INTO l_revamt_eve_crtd,
            l_last_event_date
          FROM pa_events
          WHERE project_id                  = X_project_id
          AND REFERENCE2                    = TO_CHAR(AGR_TSK.AGREEMENT_ID)
          AND (TASK_ID                      = DECODE(L_LOOKUP_FOUND,'Y',
                                                                 DECODE(L_PRJ_FUNDING_LVL,'PROJECT',
                                                                 L_LOOKUP_TASK_ID,AGR_TSK.TASK_ID),
                                                     agr_tsk.task_id)
          OR (task_id                      IS NULL
          AND agr_tsk.task_id              IS NULL))
          AND NVL(BILL_TRANS_REV_AMOUNT,0) <> 0;
          IF g1_debug_mode                  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' l_revamt_eve_crtd '||l_revamt_eve_crtd||' l_last_event_date '||l_last_event_date);
          END IF;
          l_num_of_mon                            :=0;
          if TO_CHAR(L_LAST_EVENT_DATE,'YYYY-MM') <> '9999-12' then
            -- Fix RT 4884352: ceil added to months_between.
            l_num_of_mon := ceil(months_between(l_curr_rev_eve_dt,l_last_event_date));
          ELSE
            l_num_of_mon := 0;
          end if;

          fnd_file.put_line (fnd_file.LOG,' l_num_of_mon : '||TO_CHAR(l_num_of_mon));
          IF TO_CHAR(l_last_event_date,'YYYY-MM') = '9999-12' AND l_revamt_eve_crtd = 0 THEN
            IF g1_debug_mode                      = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,'First Rev Event to be created for the project.');
            END IF;
            crt_curr_mon_eve_flag := 'F';
            chk_adj_eve_flag      := 'F';
          ELSE
            IF --l_num_of_mon = 0 AND
              TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_last_event_date,'YYYY-MM') THEN
              chk_adj_eve_flag                    := 'Y';
              crt_curr_mon_eve_flag               := 'N';
              IF g1_debug_mode                     = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' Event already created for curr month, adj even to be crtd only. ');
                fnd_file.put_line (fnd_file.LOG,' chk_adj_eve_flag '||chk_adj_eve_flag||' crt_curr_mon_eve_flag '||crt_curr_mon_eve_flag);
              END IF;
            ELSE -- to_char(l_last_rev_eve_dt,'YYYY-MM') = to_char(l_last_event_date,'YYYY-MM')
              --l_curr_rev_eve_dt := last_day(l_last_event_date+1);
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' Event to be created for curr month ');
                fnd_file.put_line (fnd_file.LOG,' Also chk for ADJ Event creation.');
              END IF;
              chk_adj_eve_flag      := 'Y';
              crt_curr_mon_eve_flag := 'Y';
              IF g1_debug_mode       = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' chk_adj_eve_flag '||chk_adj_eve_flag||' crt_curr_mon_eve_flag '||crt_curr_mon_eve_flag);
              END IF;
              --ELSE
            END IF;
          END IF;
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' FINAL chk_adj_eve_flag '||chk_adj_eve_flag||' crt_curr_mon_eve_flag '||crt_curr_mon_eve_flag);
            fnd_file.put_line (fnd_file.LOG,' before loop start l_num_of_mon : '||l_num_of_mon);
          END IF;
          LOOP
            budget_revenue    :=0;
            IF l_num_of_mon    < 0 THEN
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' before exit loop ');
              END IF;
              EXIT;
            ELSIF l_num_of_mon  >= 1 THEN
              l_curr_rev_eve_dt := last_day(l_last_event_date+1);
              l_num_of_mon      := l_num_of_mon              -1;
              IF g1_debug_mode   = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' in loop new l_num_of_mon : '||l_num_of_mon||' l_curr_rev_eve_dt '||l_curr_rev_eve_dt);
              END IF;
            ELSE
              l_num_of_mon    := l_num_of_mon-1;
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' in loop new l_num_of_mon : '||l_num_of_mon||' l_curr_rev_eve_dt '||l_curr_rev_eve_dt);
              END IF;
            end if;
            if l_curr_rev_eve_dt = l_last_event_date --and crt_curr_mon_eve_flag = 'Y'
             then
             -- Fix RT 5058267
             if l_last_mon_per_closed = 'Y' then
                l_curr_rev_eve_dt := last_day(l_last_event_date+1);
                chk_adj_eve_flag := 'N';
             end if;
               if g1_debug_mode = 'Y' then
                 fnd_file.put_line (fnd_file.LOG,' As l_curr_rev_eve_dt = l_last_event_date thus crt_curr_mon_eve_flag is set from Y to N');
               end if;
              -- Fix RT 5058267
              if l_last_mon_per_closed != 'Y' then
               crt_curr_mon_eve_flag := 'N';
              end if;
            END IF;

            BEGIN
              SELECT period_name,
                start_date,
                end_date
              INTO l_curr_open_period,
                l_period_start,
                l_period_end
              FROM pa_periods
              where STATUS ='O'
              --and L_CURR_REV_EVE_DT between START_DATE and END_DATE
              and case
               when (agr_tsk.task_id is not null --and (l_prj_end_dt <= L_CURR_REV_EVE_DT
                      and TO_CHAR(L_PRJ_END_DT,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                      and l_tsk_end_dt between START_DATE and END_DATE)
                         then 1
               when (AGR_TSK.TASK_ID is null
                      and TO_CHAR(L_PRJ_END_DT,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                      and l_prj_end_dt between START_DATE and END_DATE)
                         then 1
               when (TO_CHAR(L_PRJ_END_DT,'YYYY-MM') <> TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                      and L_CURR_REV_EVE_DT between START_DATE and END_DATE)
                         then 1
               else 0
               end
               = 1
              and rownum < 2;
              l_last_mon_per_closed := 'N';
            EXCEPTION
            WHEN no_data_found THEN
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,TO_CHAR(l_curr_rev_eve_dt)||' is not in any Open Period.');
                fnd_file.put_line (fnd_file.LOG,' Invalid X_rev_or_bill_date Param Value.');
              END IF;
              --L_NUM_OF_MON    := L_NUM_OF_MON-1; -- Fix RT 5058267
              l_last_mon_per_closed := 'Y';
              l_last_event_date := last_day(l_curr_rev_eve_dt); -- Fix RT 5058267
              CONTINUE;
              --raise;
            END;
            BEGIN
              SELECT default_cost_plan_type_id,
                default_rev_plan_type_id
              INTO l_cost_plan_type_id,
                l_rev_plan_type_id
              FROM pa_billing_extn_params_v;
            EXCEPTION
            WHEN OTHERS THEN
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,'Error from pa_billing_extn_params_v pa_rev_ca.Auto_rev_event_gen :'||SQLERRM);
              END IF;
              RAISE;
            END;
            l_no_days_accrued :=0;
            tot_eve_amt2      :=0;
            curr_eve_num_days :=0;
            tot_l_rev_amt     :=0;
            tot_rev_eve_amt   :=0;
            /* Loop to calculate the Rev per Funding Line */
            FOR fund_line     IN
            (SELECT project_funding_id,
              date_allocated,
              allocated_amount
            FROM PA_PROJECT_FUNDINGS_V
            WHERE project_id     = X_project_id
            AND (task_id         =DECODE(L_LOOKUP_FOUND,'Y',
                                               DECODE(L_PRJ_FUNDING_LVL,'PROJECT',
                                               L_LOOKUP_TASK_ID,AGR_TSK.TASK_ID),
                                         agr_tsk.task_id)
            OR (task_id         IS NULL
            AND agr_tsk.task_id IS NULL))
            AND AGREEMENT_ID     = AGR_TSK.AGREEMENT_ID
            AND budget_type_code = 'BASELINE'
            AND date_allocated  <= l_curr_rev_eve_dt
            ORDER BY date_allocated ASC
            )
            LOOP
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,'  --- FOR fund_line LOOP project_funding_id '||TO_CHAR(fund_line.project_funding_id));
                fnd_file.put_line (fnd_file.LOG,'  --- FOR fund_line LOOP date_allocated '||TO_CHAR(fund_line.date_allocated));
                fnd_file.put_line (fnd_file.LOG,'  --- FOR fund_line LOOP allocated_amount '||TO_CHAR(fund_line.allocated_amount));
              END IF;
              -- Calc revenue per day amt
              l_rev_amt_per_day := fund_line.allocated_amount / l_prj_no_of_days;
			   fnd_file.put_line (fnd_file.LOG,' abcd');
              IF g1_debug_mode   = 'Y' THEN

                fnd_file.put_line (fnd_file.LOG,' l_rev_amt_per_day = '||l_rev_amt_per_day);
              end if;
              /* Logic to get the number of days for which the Rev is accured so far */
              IF (chk_adj_eve_flag  = 'F' AND crt_curr_mon_eve_flag = 'F') THEN
                l_no_days_accrued                             := 0;
              ELSIF TO_CHAR(L_LAST_EVENT_DATE,'YYYY-MM')      <> '9999-12' THEN
                IF TO_CHAR(fund_line.date_allocated,'YYYY-MM') > TO_CHAR(l_last_event_date,'YYYY-MM') THEN
                  l_no_days_accrued                           := 0;
                else
                  if TO_CHAR(L_LAST_EVENT_DATE,'YYYY-MM') = TO_CHAR(L_PRJ_END_DT,'YYYY-MM') then
                    l_no_days_accrued := l_prj_no_of_days;
                  else
                    l_no_days_accrued := (TRUNC(l_last_event_date) - TRUNC(l_prj_start_dt)) +1;
                  end if;
                END IF;
              ELSE
                l_no_days_accrued := -1;
                IF g1_debug_mode   = 'Y' THEN
                  fnd_file.put_line (fnd_file.LOG,' ERROR l_no_days_accrued '||l_no_days_accrued);
                END IF;
                raise ERR_COUNT_DAYS;
              END IF;
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' l_no_days_accrued '||l_no_days_accrued);
              END IF;
              l_rev_amt2           := 0;
              l_adj_rev_amt        :=0;
              IF l_no_days_accrued >= 0 THEN
                l_rev_amt2         := NVL(l_no_days_accrued,0) * NVL(l_rev_amt_per_day,0);
                --l_rev_amt2 := pa_currency.round_currency_amt(l_rev_amt2);
              END IF;
              tot_eve_amt2                           := tot_eve_amt2 + l_rev_amt2;
              /* Logic to calculate the Rev Amt */
              IF TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_prj_end_dt,'YYYY-MM') THEN
                -- Calculating Revenue Amount for last event creation for the Project
                IF (chk_adj_eve_flag = 'Y' AND crt_curr_mon_eve_flag = 'N') THEN
                  -- Calculating Adj Revenue Amount when Revenue event for the mon is already created.
                  l_rev_amt  := 0;
                ELSIF (CHK_ADJ_EVE_FLAG  = 'Y' AND CRT_CURR_MON_EVE_FLAG = 'Y') THEN
                  IF TO_CHAR(fund_line.date_allocated,'YYYY-MM') <= TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') AND TO_CHAR(fund_line.date_allocated,'YYYY-MM') > TO_CHAR(l_last_event_date,'YYYY-MM') THEN
                    curr_eve_num_days := (l_curr_rev_eve_dt - l_prj_start_dt)+1;
                  ELSE
                    curr_eve_num_days := (l_prj_end_dt - l_last_event_date);
                  END IF;
                  l_rev_amt            := l_rev_amt_per_day * curr_eve_num_days;
                ELSIF (chk_adj_eve_flag = 'F' AND crt_curr_mon_eve_flag = 'F') THEN
                  curr_eve_num_days    := (l_prj_end_dt - l_prj_start_dt) +1;
                  l_rev_amt            := NVL(l_rev_amt_per_day,0) * NVL(curr_eve_num_days,0);
                END IF;
              ELSIF TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_prj_start_dt,'YYYY-MM') THEN
                -- Calculating Revenue Amount for first event creation for the Project
                IF (chk_adj_eve_flag    = 'Y' AND crt_curr_mon_eve_flag = 'N') THEN
                  l_rev_amt            := 0;
                ELSIF (chk_adj_eve_flag = 'Y' AND crt_curr_mon_eve_flag = 'Y') AND TO_CHAR(l_last_event_date,'YYYY-MM') <> '9999-12' THEN
                  curr_eve_num_days    := NVL((TRUNC(l_curr_rev_eve_dt) - TRUNC(l_prj_start_dt))+1,0);
                  l_rev_amt            := l_rev_amt_per_day * curr_eve_num_days;
                ELSIF (chk_adj_eve_flag = 'F' AND crt_curr_mon_eve_flag = 'F') THEN
                  curr_eve_num_days    := (l_curr_rev_eve_dt       - l_prj_start_dt) +1;
                  l_rev_amt            := NVL(l_rev_amt_per_day,0) * NVL(curr_eve_num_days,0);
                END IF;
              ELSE
                IF (chk_adj_eve_flag = 'Y' AND crt_curr_mon_eve_flag = 'N') THEN
                  l_rev_amt := 0;
                ELSIF (chk_adj_eve_flag = 'Y' AND crt_curr_mon_eve_flag = 'Y') AND TO_CHAR(l_last_event_date,'YYYY-MM') <> '9999-12' THEN
                  IF TO_CHAR(fund_line.date_allocated,'YYYY-MM') <= TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') AND TO_CHAR(fund_line.date_allocated,'YYYY-MM') > TO_CHAR(l_last_event_date,'YYYY-MM') THEN
                    curr_eve_num_days := (l_curr_rev_eve_dt - l_prj_start_dt)+1;
                  ELSE
                    curr_eve_num_days := NVL((TRUNC(l_curr_rev_eve_dt) - TRUNC(l_last_event_date)),0);
                  END IF;
                  l_rev_amt            := l_rev_amt_per_day * curr_eve_num_days;
                ELSIF (chk_adj_eve_flag = 'F' AND crt_curr_mon_eve_flag = 'F') THEN
                  curr_eve_num_days    := (l_curr_rev_eve_dt       - l_prj_start_dt) +1;
                  l_rev_amt            := NVL(l_rev_amt_per_day,0) * NVL(curr_eve_num_days,0);
                END IF;
              END IF;
              TOT_L_REV_AMT     := TOT_L_REV_AMT + L_REV_AMT;
              L_REV_AMT         := 0;
              L_REV_AMT_PER_DAY :=0;
              curr_eve_num_days :=0;
            END LOOP;
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,' Rev amt for which events sud have been be crtd till now : tot_eve_amt2 = '||tot_eve_amt2);
              fnd_file.put_line (fnd_file.LOG,' Actual Rev amt for which events are created till now : '||l_revamt_eve_crtd);
              fnd_file.put_line (fnd_file.LOG,' Date of last event crt l_last_event_date '||l_last_event_date);
            END IF;
            IF tot_eve_amt2 <> l_revamt_eve_crtd THEN
              l_adj_rev_amt := NVL(tot_eve_amt2,0) - NVL(l_revamt_eve_crtd,0);
            END IF;
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,' Adj amt calculated as l_adj_rev_amt : '||l_adj_rev_amt);
            END IF;
            /** Call to create Automatic Events **/
            --if (crt_curr_mon_eve_flag = 'Y' and tot_l_rev_amt <> 0) OR
            --   (crt_curr_mon_eve_flag = 'F' and chk_adj_eve_flag = 'F' and tot_l_rev_amt <>0 ) then
            --tot_l_rev_amt := pa_currency.round_currency_amt(tot_l_rev_amt);
            TOT_REV_EVE_AMT := TOT_L_REV_AMT+ L_ADJ_REV_AMT;
            --tot_rev_eve_amt := pa_currency.round_currency_amt(tot_rev_eve_amt);

            /* As Event Currency is to be Agr Currency, thus pull the Agr Currency */
            BEGIN
              SELECT AGREEMENT_CURRENCY_CODE
              INTO L_EVE_CRT_CURR_CODE
              FROM PA_AGREEMENTS_ALL
              WHERE AGREEMENT_ID =AGR_TSK.AGREEMENT_ID;
            EXCEPTION
            WHEN OTHERS THEN
              L_EVE_CRT_CURR_CODE := NULL;
            END;
            /* Set the Insert_Event IN Param Task_id */
            IF L_PRJ_FUNDING_LVL = 'PROJECT' and l_lookup_found ='Y' THEN
               L_EVENT_TASK_ID := L_LOOKUP_TASK_ID;
            ELSE
               L_EVENT_TASK_ID := AGR_TSK.TASK_ID;
            END IF;
            /* Round the final calculated Rev Amt as per the Currency precision set in GL */
            tot_rev_eve_amt := pa_multi_currency_billing.round_trans_currency_amt(nvl(tot_rev_eve_amt, 0),l_eve_crt_curr_code);
            /* Make the Porject End Date as Event Date for last month's event */
            if TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM') = TO_CHAR(L_PRJ_END_DT,'YYYY-MM') then
               if L_EVENT_TASK_ID is not null then
                   L_CURR_REV_EVE_DT := L_TSK_END_DT;
               else
                   L_CURR_REV_EVE_DT := TRUNC(L_PRJ_END_DT);
               end if;
            end if;
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,'pa_billing_pub.insert_event IN Param tot_l_rev_amt:' ||tot_rev_eve_amt|| ' X_project_id:' ||X_project_id|| ' X_top_task_id: ' ||agr_tsk.task_id|| ' X_reference2: ' ||TO_CHAR(agr_tsk.agreement_id) );
            END IF;
            IF tot_rev_eve_amt <> 0 THEN
              pa_billing_pub.insert_event(x_project_id => x_project_id,
                                          x_top_task_id => L_EVENT_TASK_ID,
                                          x_rev_amt => tot_rev_eve_amt,
                                          x_bill_amt => 0,
                                          x_completion_date => l_curr_rev_eve_dt,
                                          x_reference2 => to_char(agr_tsk.agreement_id),
                                          x_txn_currency_code => l_eve_crt_curr_code,
                                          x_error_message => err_msg,
                                          X_status => err_status);
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' Done Inserting REV event '||err_status);
              END IF;
              IF err_status     <> 0 THEN
                IF g1_debug_mode = 'Y' THEN
                  fnd_file.put_line (fnd_file.LOG,' ERROR from pa_billing_pub.insert_event for REV Amt');
                END IF;
                RAISE ERR_INSERT_EVENT;
              END IF;
            END IF;
            /*if chk_adj_eve_flag = 'Y' and l_adj_rev_amt <> 0 then --l_adj_rev_amt <> 0 then
            IF g1_debug_mode  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,'pa_billing_pub.insert_event IN Param l_adj_rev_amt:'||l_adj_rev_amt||' X_project_id:'||X_project_id);
            END IF;
            pa_billing_pub.insert_event(X_project_id        => X_project_id,
            X_top_task_id       => agr_tsk.task_id,
            X_rev_amt           => l_adj_rev_amt,
            X_bill_amt          => 0,
            X_completion_date   => l_curr_rev_eve_dt,
            x_reference2        => to_char(agr_tsk.agreement_id),
            X_error_message     => err_msg,
            X_status            => err_status);
            IF g1_debug_mode  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' Done Inserting ADJ event '||err_status);
            END IF;
            IF err_status <> 0 THEN
            IF g1_debug_mode  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' ERROR from pa_billing_pub.insert_event for ADJ Amt');
            END IF;
            raise ERR_INSERT_EVENT;
            END IF;
            end if;*/
            SELECT NVL(SUM(NVL(BILL_TRANS_REV_AMOUNT,0)),0),
              NVL(MAX(completion_date),to_date('31-DEC-9999','DD-MON-YYYY'))
            INTO l_revamt_eve_crtd,
              l_last_event_date
            FROM pa_events
            WHERE project_id                  = X_project_id
            AND reference2                    = TO_CHAR(agr_tsk.agreement_id) -- DFF Projects:Events
            AND (task_id                      = DECODE(L_LOOKUP_FOUND,'Y',
                                                                 DECODE(L_PRJ_FUNDING_LVL,'PROJECT',
                                                                 L_LOOKUP_TASK_ID,AGR_TSK.TASK_ID),
                                                     agr_tsk.task_id)
            OR (task_id                      IS NULL
            AND agr_tsk.task_id              IS NULL))
            AND NVL(BILL_TRANS_REV_AMOUNT,0) <> 0;
            tot_rev_eve_amt                  :=0;
            tot_l_rev_amt                    :=0;
            tot_eve_amt2                     :=0;

            -- l_curr_rev_eve_dt := last_day(l_curr_rev_eve_dt+1);
          end loop;
      end loop; --FOR agr_tsk IN ..
     --removed as suggested by Harish on 02-Dec-2015
    /*else
      raise err_invalid_budget;
    end if;*/
  ELSE --l_prj_funding_lvl <> 'PROJECT'
    L_TOP_TASK_ID := X_TOP_TASK_ID;
    /* CR22722 Logic Start */
	fnd_file.put_line (fnd_file.LOG,' l_prj_funding_lvl before Task                  : '||l_prj_funding_lvl );
    if l_prj_funding_lvl = 'TASK' then
      begin
        select work_type_id , start_date, completion_date, (completion_date - start_date)+1 tsk_num_of_days
            into l_work_type_id   , l_tsk_start_dt, l_tsk_end_dt, l_task_no_of_days
        FROM PA_TASKS
        WHERE PROJECT_ID = X_PROJECT_ID
        AND TASK_ID = L_TOP_TASK_ID;

		fnd_file.put_line (fnd_file.LOG,' l_work_type_id                  : '||l_work_type_id );
		fnd_file.put_line (fnd_file.LOG,' l_tsk_start_dt                  : '||l_tsk_start_dt );
		fnd_file.put_line (fnd_file.LOG,' l_tsk_end_dt                  : '||l_tsk_end_dt );
		fnd_file.put_line (fnd_file.LOG,' l_task_no_of_days                  : '||l_task_no_of_days );



        SELECT NAME
           INTO l_work_type_nm
        FROM PA_WORK_TYPES_VL
        where work_type_id = l_work_type_id;
      exception
         when OTHERS then
           fnd_file.put_line (fnd_file.LOG,'Project '||X_PROJECT_ID||' Funding Level is TASK. ERROR fetching Work Type. NO EVENTS CEATED.'||sqlerrm);
           raise ERR_INSERT_EVENT; -- Reusing existing Exceptions in Code.
      end;
	  fnd_file.put_line (fnd_file.LOG,' l_work_type_nm                 : '||l_work_type_nm );

	    BEGIN
               SELECT event_type
                 INTO lv_event_type
                 FROM pa_event_types
                WHERE event_type = 'POA-Service Revenue'
                  AND TRUNC (SYSDATE) BETWEEN start_date_active AND NVL (end_date_active, SYSDATE);
		EXCEPTION
			WHEN OTHERS THEN
			    fnd_file.put_line (fnd_file.LOG,'lv_event_type '||lv_event_type||' ERROR IN EVENT_TYPE EXCEPTION.'||sqlerrm);
	  END;	
	  fnd_file.put_line (fnd_file.LOG,'lv_event_type              :' || lv_event_type);
	  BEGIN
	     SELECT attribute1, attribute2,Meaning
		 INTO   l_job_value, l_last_month_hold ,l_meaning
           FROM pa_lookups pl
          WHERE pl.lookup_type='XXPA_CN_REV_SPE_CONDITIONS'
            AND pl.meaning = l_work_type_nm
            AND pl.enabled_flag='Y';
	  EXCEPTION
		 WHEN OTHERS THEN
		    fnd_file.put_line (fnd_file.LOG,'l_job_value '||l_job_value||' ERROR IN LOOKUP EXCEPTION.'||sqlerrm);
	  END;	
	  fnd_file.put_line (fnd_file.LOG,'l_work_type_nm              :' || l_work_type_nm);
	  fnd_file.put_line (fnd_file.LOG,'l_job_value              :' || l_job_value);
	  fnd_file.put_line (fnd_file.LOG,'l_last_month_hold              :' || l_last_month_hold);
	  fnd_file.put_line (fnd_file.LOG,'l_meaning              :' || l_meaning);

      BEGIN         -- CR22995
           SELECT psv.segment_value
			 INTO lv_task_rev_rec_method
		   FROM pa_segment_value_lookup_sets psvls
			   ,pa_segment_value_lookups psv
		   WHERE psv.segment_value_lookup_set_id = psvls.segment_value_lookup_set_id
		   AND   psvls.segment_value_lookup_set_name = 'Work Type to Revenue Method'
		   AND   psv.segment_value_lookup = l_work_type_nm
		   ;
		EXCEPTION
		  WHEN OTHERS THEN
		      lv_task_rev_rec_method := NULL;
		END;                                   -- CR22995

		fnd_file.put_line (fnd_file.LOG,' lv_task_rev_rec_method                 : '||lv_task_rev_rec_method );
    --   if L_WORK_TYPE_NM <> 'Straight Line Revenue' then   -- commented for CR22995
	  if NVL(lv_task_rev_rec_method, 'X') <> 'Straight Line Revenue' then      -- added for CR22995
        fnd_file.put_line (fnd_file.LOG,'Project '||X_PROJECT_ID||' Funding Level is TASK, and Work Type for Task '||L_TOP_TASK_ID||' is not Straight Line Revenue. Thus, NO EVENTS CREATED.'||err_status);
        raise ERR_INVALID_BUDGET; -- END PROCESS. Reusing existing Exceptions in Code.
      end if;
    end if;
       IF g1_debug_mode = 'Y' THEN
          fnd_file.put_line (fnd_file.LOG,' IN Params passed to xxpa_billing_pub.get_rev_budget_amount : ');
          fnd_file.put_line (fnd_file.LOG,' Params X_project_id : '||X_project_id);
          fnd_file.put_line (fnd_file.LOG,' Params X_top_task_id : '||L_TOP_TASK_ID);
          fnd_file.put_line (fnd_file.LOG,' Params l_rev_plan_type_id : '||l_rev_plan_type_id);
          fnd_file.put_line (fnd_file.LOG,' Params X_rev_date : '||TO_CHAR(l_curr_rev_eve_dt));
        END IF;
        xxpa_rev_cn.get_rev_budget_amount( x2_project_id => x_project_id,
                                            x2_task_id => L_TOP_TASK_ID,
                                            X2_agreement_id => null,
                                            x2_revenue_amount => budget_revenue,
                                            p_rev_budget_type_code => l_rev_budget_type_code,
                                            p_rev_plan_type_id => l_rev_plan_type_id,
                                            x_rev_budget_type_code => l_rev_budget_type_code,
                                            x_rev_date => l_curr_rev_eve_dt,
                                            x_error_message =>l_error_message,
                                            X_status => l_status);
        IF l_status <> 0 THEN
          --RAISE_APPLICATION_ERROR(-20131,'ERR INVALID BUDGET');
          RAISE ERR_INVALID_BUDGET;
        END IF;
        IF g1_debug_mode = 'Y' THEN
          fnd_file.put_line (fnd_file.LOG,' OUT values from xxpa_billing_pub.get_rev_budget_amount : ');
          fnd_file.put_line (fnd_file.LOG,' Params X2_revenue_amount : '||budget_revenue);
          fnd_file.put_line (fnd_file.LOG,' Params X_rev_budget_type_code : '||l_rev_budget_type_code);
        END IF;
        IF budget_revenue  = 0 THEN
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' No budget for the project ');
          END IF;
          RAISE NO_FUNDIND_ERR;
        END IF;
        IF g1_debug_mode = 'Y' THEN
          fnd_file.put_line (fnd_file.LOG,' budget_revenue amt : '||budget_revenue||' for project '||X_project_id);
          fnd_file.put_line (fnd_file.LOG,' formula applied rev amt per day = '||budget_revenue||' divided by '||l_prj_no_of_days);
        END IF;
        TOT_REV_EVE_AMT  :=0;
        TOT_EVE_AMT2     :=0;
        TOT_L_REV_AMT    :=0;
        l_revamt_eve_crtd:=0;
        FOR agr_tsk      IN
        (SELECT DISTINCT agreement_id,
          task_id
        FROM PA_PROJECT_FUNDINGS_V
        WHERE project_id     = X_project_id
        AND (TASK_ID         =L_TOP_TASK_ID
        OR (TASK_ID         IS NULL
        AND L_TOP_TASK_ID   IS NULL))
        AND budget_type_code = 'BASELINE'
        AND date_allocated  <= l_curr_rev_eve_dt
        )
        LOOP
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' === FOR Loop begin agr_tsk.agreement_id: '||agr_tsk.agreement_id);
            fnd_file.put_line (fnd_file.LOG,' === FOR Loop begin agr_tsk.task_id: '||agr_tsk.task_id);
          END IF;
          SELECT NVL(SUM(NVL(BILL_TRANS_REV_AMOUNT,0)),0),
            NVL(MAX(completion_date),to_date('31-DEC-9999','DD-MON-YYYY'))
          INTO l_revamt_eve_crtd,
            l_last_event_date
          FROM pa_events
          WHERE project_id                  = X_project_id
          AND REFERENCE2                    = TO_CHAR(AGR_TSK.AGREEMENT_ID)
          AND (TASK_ID                      = DECODE(L_LOOKUP_FOUND,'Y',
                                                                 DECODE(L_PRJ_FUNDING_LVL,'PROJECT',
                                                                 L_LOOKUP_TASK_ID,AGR_TSK.TASK_ID),
                                                     agr_tsk.task_id)
          OR (task_id                      IS NULL
          AND agr_tsk.task_id              IS NULL))
          AND NVL(BILL_TRANS_REV_AMOUNT,0) <> 0;
          if g1_debug_mode                  = 'Y' then
            fnd_file.put_line (fnd_file.LOG,' X_project_id '||X_project_id||' AGR_TSK.AGREEMENT_ID '||AGR_TSK.AGREEMENT_ID||' L_LOOKUP_FOUND '||L_LOOKUP_FOUND||' L_PRJ_FUNDING_LVL '||L_PRJ_FUNDING_LVL||' L_LOOKUP_TASK_ID '||L_LOOKUP_TASK_ID||' AGR_TSK.TASK_ID '||AGR_TSK.TASK_ID);
            fnd_file.put_line (fnd_file.LOG,' l_revamt_eve_crtd '||l_revamt_eve_crtd||' l_last_event_date '||l_last_event_date);
          END IF;
          l_num_of_mon                            :=0;
          if TO_CHAR(L_LAST_EVENT_DATE,'YYYY-MM') <> '9999-12' then
            -- Fix RT 4884352: ceil added to months_between.
            l_num_of_mon := ceil(months_between(l_curr_rev_eve_dt,l_last_event_date));
          ELSE
            l_num_of_mon := 0;
          end if;

          fnd_file.put_line (fnd_file.LOG,' l_num_of_mon : '||TO_CHAR(l_num_of_mon));
          IF TO_CHAR(l_last_event_date,'YYYY-MM') = '9999-12' AND l_revamt_eve_crtd = 0 THEN
            IF g1_debug_mode                      = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,'First Rev Event to be created for the project.');
            END IF;
            crt_curr_mon_eve_flag := 'F';
            chk_adj_eve_flag      := 'F';
          ELSE
            IF --l_num_of_mon = 0 AND
              TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_last_event_date,'YYYY-MM') THEN
              chk_adj_eve_flag                    := 'Y';
              crt_curr_mon_eve_flag               := 'N';
              IF g1_debug_mode                     = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' Event already created for curr month, adj even to be crtd only. ');
                fnd_file.put_line (fnd_file.LOG,' chk_adj_eve_flag '||chk_adj_eve_flag||' crt_curr_mon_eve_flag '||crt_curr_mon_eve_flag);
              END IF;
            ELSE -- to_char(l_last_rev_eve_dt,'YYYY-MM') = to_char(l_last_event_date,'YYYY-MM')
              --l_curr_rev_eve_dt := last_day(l_last_event_date+1);
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' Event to be created for curr month ');
                fnd_file.put_line (fnd_file.LOG,' Also chk for ADJ Event creation.');
              END IF;
              chk_adj_eve_flag      := 'Y';
              crt_curr_mon_eve_flag := 'Y';
              IF g1_debug_mode       = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' chk_adj_eve_flag '||chk_adj_eve_flag||' crt_curr_mon_eve_flag '||crt_curr_mon_eve_flag);
              END IF;
              --ELSE
            END IF;
          END IF;
          IF g1_debug_mode = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' FINAL chk_adj_eve_flag '||chk_adj_eve_flag||' crt_curr_mon_eve_flag '||crt_curr_mon_eve_flag);
            fnd_file.put_line (fnd_file.LOG,' before loop start l_num_of_mon : '||l_num_of_mon);
          END IF;
          LOOP
            budget_revenue    :=0;
            IF l_num_of_mon    < 0 THEN
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' before exit loop ');
              END IF;
              EXIT;
            ELSIF l_num_of_mon  >= 1 THEN
              l_curr_rev_eve_dt := last_day(l_last_event_date+1);
              l_num_of_mon      := l_num_of_mon              -1;
              IF g1_debug_mode   = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' in loop new l_num_of_mon : '||l_num_of_mon||' l_curr_rev_eve_dt '||l_curr_rev_eve_dt);
              END IF;
            ELSE
              l_num_of_mon    := l_num_of_mon-1;
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' in loop new l_num_of_mon : '||l_num_of_mon||' l_curr_rev_eve_dt '||l_curr_rev_eve_dt);
              END IF;
            end if;
            if l_curr_rev_eve_dt = l_last_event_date --and crt_curr_mon_eve_flag = 'Y'
             then
             -- Fix RT 5058267
             if l_last_mon_per_closed = 'Y' then
                l_curr_rev_eve_dt := last_day(l_last_event_date+1);
                chk_adj_eve_flag := 'N';
             end if;
               if g1_debug_mode = 'Y' then
                 fnd_file.put_line (fnd_file.LOG,' As l_curr_rev_eve_dt = l_last_event_date thus crt_curr_mon_eve_flag is set from Y to N');
               end if;
              -- Fix RT 5058267
              if l_last_mon_per_closed != 'Y' then
               crt_curr_mon_eve_flag := 'N';
              end if;
            END IF;

            BEGIN
              SELECT period_name,
                start_date,
                end_date
              INTO l_curr_open_period,
                l_period_start,
                l_period_end
              FROM pa_periods
              where STATUS ='O'
              --and L_CURR_REV_EVE_DT between START_DATE and END_DATE
              and case
               when (agr_tsk.task_id is not null --and (l_prj_end_dt <= L_CURR_REV_EVE_DT
                      and TO_CHAR(L_PRJ_END_DT,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                      and l_tsk_end_dt between START_DATE and END_DATE)
                         then 1
               when (AGR_TSK.TASK_ID is null
                      and TO_CHAR(L_PRJ_END_DT,'YYYY-MM') = TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                      and l_prj_end_dt between START_DATE and END_DATE)
                         then 1
               when (TO_CHAR(L_PRJ_END_DT,'YYYY-MM') <> TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM')
                      and L_CURR_REV_EVE_DT between START_DATE and END_DATE)
                         then 1
               else 0
               end
               = 1
              and rownum < 2;
              l_last_mon_per_closed := 'N';
            EXCEPTION
            WHEN no_data_found THEN
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,TO_CHAR(l_curr_rev_eve_dt)||' is not in any Open Period.');
                fnd_file.put_line (fnd_file.LOG,' Invalid X_rev_or_bill_date Param Value.');
              END IF;
              --L_NUM_OF_MON    := L_NUM_OF_MON-1; -- Fix RT 5058267
              l_last_mon_per_closed := 'Y';
              l_last_event_date := last_day(l_curr_rev_eve_dt); -- Fix RT 5058267
              CONTINUE;
              --raise;
            END;
            BEGIN
              SELECT default_cost_plan_type_id,
                default_rev_plan_type_id
              INTO l_cost_plan_type_id,
                l_rev_plan_type_id
              FROM pa_billing_extn_params_v;
            EXCEPTION
            WHEN OTHERS THEN
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,'Error from pa_billing_extn_params_v pa_rev_ca.Auto_rev_event_gen :'||SQLERRM);
              END IF;
              RAISE;
            END;
            l_no_days_accrued :=0;
            tot_eve_amt2      :=0;
            curr_eve_num_days :=0;
            tot_l_rev_amt     :=0;
            tot_rev_eve_amt   :=0;
            /* Loop to calculate the Rev per Funding Line */
            FOR fund_line     IN
            (SELECT project_funding_id,
              date_allocated,
              allocated_amount
            FROM PA_PROJECT_FUNDINGS_V
            WHERE project_id     = X_project_id
            AND (task_id         =DECODE(L_LOOKUP_FOUND,'Y',
                                               DECODE(L_PRJ_FUNDING_LVL,'PROJECT',
                                               L_LOOKUP_TASK_ID,AGR_TSK.TASK_ID),
                                         agr_tsk.task_id)
            OR (task_id         IS NULL
            AND agr_tsk.task_id IS NULL))
            AND AGREEMENT_ID     = AGR_TSK.AGREEMENT_ID
            AND budget_type_code = 'BASELINE'
            AND date_allocated  <= l_curr_rev_eve_dt
            ORDER BY date_allocated ASC
            )
            LOOP
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,'  --- FOR fund_line LOOP project_funding_id '||TO_CHAR(fund_line.project_funding_id));
                fnd_file.put_line (fnd_file.LOG,'  --- FOR fund_line LOOP date_allocated '||TO_CHAR(fund_line.date_allocated));
                fnd_file.put_line (fnd_file.LOG,'  --- FOR fund_line LOOP allocated_amount '||TO_CHAR(fund_line.allocated_amount));
              END IF;
              -- Calc revenue per day amt
              l_rev_amt_per_day := fund_line.allocated_amount / l_task_no_of_days; -- l_prj_no_of_days; CR22722
			  l_rev_annum_amt := (fund_line.allocated_amount / l_task_no_of_days)*365;	--CR 25222
			  fnd_file.put_line (fnd_file.LOG,' l_rev_annum_amt = '||l_rev_annum_amt);
              IF g1_debug_mode   = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' l_rev_amt_per_day = '||l_rev_amt_per_day);
              end if;
              /* Logic to get the number of days for which the Rev is accured so far */
              IF (chk_adj_eve_flag  = 'F' AND crt_curr_mon_eve_flag = 'F') THEN
                l_no_days_accrued                             := 0;
              ELSIF TO_CHAR(L_LAST_EVENT_DATE,'YYYY-MM')      <> '9999-12' THEN
                IF TO_CHAR(fund_line.date_allocated,'YYYY-MM') > TO_CHAR(l_last_event_date,'YYYY-MM') THEN
                  l_no_days_accrued                           := 0;
                else
                  if to_char(l_last_event_date,'YYYY-MM') = to_char(l_tsk_end_dt,'YYYY-MM') then -- CR22722 l_prj_end_dt replaced with l_tsk_end_dt
                    l_no_days_accrued := l_task_no_of_days;--l_prj_no_of_days; CR22722
                  else
                    --l_no_days_accrued := (TRUNC(l_last_event_date) - TRUNC(l_prj_start_dt)) +1;  CR22722
                    l_no_days_accrued := (TRUNC(l_last_event_date) - TRUNC(l_tsk_start_dt)) +1; --CR22722
                  end if;
                END IF;
              ELSE
                l_no_days_accrued := -1;
                IF g1_debug_mode   = 'Y' THEN
                  fnd_file.put_line (fnd_file.LOG,' ERROR l_no_days_accrued '||l_no_days_accrued);
                END IF;
                raise ERR_COUNT_DAYS;
              END IF;
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' l_no_days_accrued '||l_no_days_accrued);
              END IF;
              l_rev_amt2           := 0;
              l_adj_rev_amt        :=0;
              IF l_no_days_accrued >= 0 THEN
                l_rev_amt2         := NVL(l_no_days_accrued,0) * NVL(l_rev_amt_per_day,0);
                --l_rev_amt2 := pa_currency.round_currency_amt(l_rev_amt2);
              END IF;
              tot_eve_amt2                           := tot_eve_amt2 + l_rev_amt2;
              /* Logic to calculate the Rev Amt */
              IF TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_prj_end_dt,'YYYY-MM') THEN
                -- Calculating Revenue Amount for last event creation for the Project
                IF (chk_adj_eve_flag = 'Y' AND crt_curr_mon_eve_flag = 'N') THEN
                  -- Calculating Adj Revenue Amount when Revenue event for the mon is already created.
                  l_rev_amt  := 0;
                  if g1_debug_mode = 'Y' then
                    fnd_file.put_line (fnd_file.LOG,' 11 Logic to calculate the Rev Amt ');
                  END IF;
                ELSIF (CHK_ADJ_EVE_FLAG  = 'Y' AND CRT_CURR_MON_EVE_FLAG = 'Y') THEN
                  if to_char(fund_line.date_allocated,'YYYY-MM') <= to_char(l_curr_rev_eve_dt,'YYYY-MM')
                        and to_char(fund_line.date_allocated,'YYYY-MM') > to_char(l_last_event_date,'YYYY-MM') then
                    -- curr_eve_num_days := (l_curr_rev_eve_dt - l_prj_start_dt)+1; CR22722
                    curr_eve_num_days := (l_curr_rev_eve_dt - l_tsk_start_dt)+1; --CR22722
                  else
                    --curr_eve_num_days := (l_prj_end_dt - l_last_event_date);  CR22722
                    curr_eve_num_days := (l_tsk_end_dt - l_last_event_date);  --CR22722
                  end if;
                  if g1_debug_mode = 'Y' then
                    fnd_file.put_line (fnd_file.LOG,' 22 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                  END IF;
                  l_rev_amt            := l_rev_amt_per_day * curr_eve_num_days;
                elsif (chk_adj_eve_flag = 'F' and crt_curr_mon_eve_flag = 'F') then
                  curr_eve_num_days    := l_task_no_of_days; --(l_prj_end_dt - l_prj_start_dt) +1; CR22722
                  if g1_debug_mode = 'Y' then
                    fnd_file.put_line (fnd_file.LOG,' 33 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                  END IF;
                  l_rev_amt            := NVL(l_rev_amt_per_day,0) * NVL(curr_eve_num_days,0);
                END IF;
            --  ELSIF TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_prj_start_dt,'YYYY-MM') THEN
			  ELSIF TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_tsk_start_dt,'YYYY-MM') THEN -- Changed l_prj_start_dt to l_tsk_start_dt
                -- Calculating Revenue Amount for first event creation for the Project
                IF (chk_adj_eve_flag    = 'Y' AND crt_curr_mon_eve_flag = 'N') THEN
                  l_rev_amt            := 0;
                  if g1_debug_mode = 'Y' then
                    fnd_file.put_line (fnd_file.LOG,' 44 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                  END IF;
                elsif (chk_adj_eve_flag = 'Y' and crt_curr_mon_eve_flag = 'Y') and to_char(l_last_event_date,'YYYY-MM') <> '9999-12' then
                  curr_eve_num_days    := nvl((trunc(l_curr_rev_eve_dt) - trunc(l_tsk_start_dt))+1,0); -- CR22722 l_prj_start_dt replaced with l_tsk_start_dt
                  l_rev_amt            := l_rev_amt_per_day * curr_eve_num_days;
                  if g1_debug_mode = 'Y' then
                    fnd_file.put_line (fnd_file.LOG,' 55 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                  END IF;
                elsif (chk_adj_eve_flag = 'F' and crt_curr_mon_eve_flag = 'F') then
                  curr_eve_num_days    := (l_curr_rev_eve_dt       - l_tsk_start_dt) +1;  -- CR22722 l_prj_start_dt replaced with l_tsk_start_dt
                  l_rev_amt            := NVL(l_rev_amt_per_day,0) * NVL(curr_eve_num_days,0);
                  if g1_debug_mode = 'Y' then
                    fnd_file.put_line (fnd_file.LOG,' 66 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                  END IF;
                END IF;
              ELSE
                IF (chk_adj_eve_flag = 'Y' AND crt_curr_mon_eve_flag = 'N') THEN
                  l_rev_amt := 0;
                elsif (chk_adj_eve_flag = 'Y' and crt_curr_mon_eve_flag = 'Y')
                         AND TO_CHAR(l_last_event_date,'YYYY-MM') <> '9999-12' THEN
                    if to_char(fund_line.date_allocated,'YYYY-MM') <= to_char(l_curr_rev_eve_dt,'YYYY-MM')
                         and to_char(fund_line.date_allocated,'YYYY-MM') > to_char(l_last_event_date,'YYYY-MM') then
                      curr_eve_num_days := (l_curr_rev_eve_dt - l_tsk_start_dt)+1; -- CR22722 l_prj_start_dt replaced with l_tsk_start_dt
                      if g1_debug_mode = 'Y' then
                        fnd_file.put_line (fnd_file.LOG,' 77 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                      END IF;
                    ELSE
                      curr_eve_num_days := NVL((TRUNC(l_curr_rev_eve_dt) - TRUNC(l_last_event_date)),0);
                      if g1_debug_mode = 'Y' then
                        fnd_file.put_line (fnd_file.LOG,' 88 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                      END IF;
                    end if;
                    l_rev_amt            := l_rev_amt_per_day * curr_eve_num_days;
                elsif (chk_adj_eve_flag = 'F' and crt_curr_mon_eve_flag = 'F') then
				 -- Defect#26090 - If Task end date is less than the Accrue Through Date then use l_tsk_end_dt
				 if l_tsk_end_dt < l_curr_rev_eve_dt then
					l_curr_rev_eve_dt := l_tsk_end_dt;
				 end if;
				 -- End of Defect#26090
                  curr_eve_num_days    := (l_curr_rev_eve_dt       - l_tsk_start_dt) +1; -- CR22722 l_prj_start_dt replaced with l_tsk_start_dt
                  l_rev_amt            := NVL(l_rev_amt_per_day,0) * NVL(curr_eve_num_days,0);
                   if g1_debug_mode = 'Y' then
                      fnd_file.put_line (fnd_file.LOG,' 1010 Logic to calculate the Rev Amt curr_eve_num_days: '||curr_eve_num_days);
                    END IF;
                END IF;
              END IF;
              TOT_L_REV_AMT     := TOT_L_REV_AMT + L_REV_AMT;
              L_REV_AMT         := 0;
              L_REV_AMT_PER_DAY :=0;
              curr_eve_num_days :=0;
            END LOOP;
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,' Rev amt for which events sud have been be crtd till now : tot_eve_amt2 = '||tot_eve_amt2);
              fnd_file.put_line (fnd_file.LOG,' Actual Rev amt for which events are created till now : '||l_revamt_eve_crtd);
              fnd_file.put_line (fnd_file.LOG,' Date of last event crt l_last_event_date '||l_last_event_date);
            END IF;
            IF tot_eve_amt2 <> l_revamt_eve_crtd THEN
              l_adj_rev_amt := NVL(tot_eve_amt2,0) - NVL(l_revamt_eve_crtd,0);
            END IF;
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,' Adj amt calculated as l_adj_rev_amt : '||l_adj_rev_amt);
            END IF;
            /** Call to create Automatic Events **/
            --if (crt_curr_mon_eve_flag = 'Y' and tot_l_rev_amt <> 0) OR
            --   (crt_curr_mon_eve_flag = 'F' and chk_adj_eve_flag = 'F' and tot_l_rev_amt <>0 ) then
            --tot_l_rev_amt := pa_currency.round_currency_amt(tot_l_rev_amt);
            tot_rev_eve_amt := tot_l_rev_amt+ l_adj_rev_amt;
            --tot_rev_eve_amt := pa_currency.round_currency_amt(tot_rev_eve_amt);

            /* As Event Currency is to be Agr Currency, thus pull the Agr Currency */
            BEGIN
              SELECT AGREEMENT_CURRENCY_CODE
              INTO L_EVE_CRT_CURR_CODE
              FROM PA_AGREEMENTS_ALL
              WHERE AGREEMENT_ID =AGR_TSK.AGREEMENT_ID;
            EXCEPTION
            WHEN OTHERS THEN
              L_EVE_CRT_CURR_CODE := NULL;
            END;
            /* Set the Insert_Event IN Param Task_id */
            IF L_PRJ_FUNDING_LVL = 'PROJECT' and l_lookup_found ='Y' THEN
               L_EVENT_TASK_ID := L_LOOKUP_TASK_ID;
            ELSE
               L_EVENT_TASK_ID := AGR_TSK.TASK_ID;
            END IF;
            /* Round the final calculated Rev Amt as per the Currency precision set in GL */
            tot_rev_eve_amt := pa_multi_currency_billing.round_trans_currency_amt(nvl(tot_rev_eve_amt, 0),l_eve_crt_curr_code);
            /* Make the Porject End Date as Event Date for last month's event */
            if TO_CHAR(L_CURR_REV_EVE_DT,'YYYY-MM') = TO_CHAR(L_PRJ_END_DT,'YYYY-MM') then
               if L_EVENT_TASK_ID is not null then
                   L_CURR_REV_EVE_DT := L_TSK_END_DT;
               else
                   L_CURR_REV_EVE_DT := TRUNC(L_PRJ_END_DT);
               end if;
            end if;
            IF g1_debug_mode = 'Y' THEN
              fnd_file.put_line (fnd_file.LOG,'pa_billing_pub.insert_event IN Param tot_l_rev_amt:' ||tot_rev_eve_amt|| ' X_project_id:' ||X_project_id|| ' X_top_task_id: ' ||agr_tsk.task_id|| ' X_reference2: ' ||TO_CHAR(agr_tsk.agreement_id) );
            END IF;
			fnd_file.put_line (fnd_file.LOG,' l_meaning 1 : '||l_meaning);
            IF tot_rev_eve_amt <> 0 THEN
              IF l_meaning = 'Service Agreement' THEN
                IF l_rev_annum_amt < TO_NUMBER(l_job_value) THEN	
						--Accrue through date Month = Task End Date Month
					IF TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_tsk_end_dt,'YYYY-MM') AND l_last_month_hold = 'Y' then				
							fnd_file.put_line (fnd_file.LOG,' BEFORE pa_billing_pub '); 
				    pa_billing_pub.insert_event(x_project_id  	        => x_project_id,
											    x_top_task_id 		    => l_event_task_id,											  
											    x_rev_amt  			    => tot_rev_eve_amt,
											    x_bill_amt 			    => 0,
											    x_event_type  		    => lv_event_type,
											    x_completion_date 	    => l_tsk_end_dt,
											    x_revenue_hold_flag     => l_hold_flag,
											    x_reference2 			=> to_char(agr_tsk.agreement_id),
											    x_txn_currency_code 	=> l_eve_crt_curr_code,
											    x_error_message 		=> err_msg,
											    x_status 				=> err_status);


							fnd_file.put_line (fnd_file.LOG,' AFTER pa_billing_pub1 ');	  
							fnd_file.put_line (fnd_file.LOG,' err_msg1  : '||err_msg);
							fnd_file.put_line (fnd_file.LOG,' tot_rev_eve_amt 1 : '||tot_rev_eve_amt);
							fnd_file.put_line (fnd_file.LOG,' l_curr_rev_eve_dt 1 : '||l_curr_rev_eve_dt);
							fnd_file.put_line (fnd_file.LOG,' l_eve_crt_curr_code 1 : '||l_eve_crt_curr_code);
							fnd_file.put_line (fnd_file.LOG,' l_hold_flag 1 : '||l_hold_flag);
							fnd_file.put_line (fnd_file.LOG,' err_status 1 : '||err_status);

				ELSE --Accrue through date Month <> Task End Date Month
				fnd_file.put_line (fnd_file.LOG,' event created in else part ');
				  pa_billing_pub.insert_event(x_project_id  		=> x_project_id,
											  x_top_task_id 		=> l_event_task_id,
											  x_rev_amt  			=> tot_rev_eve_amt,
											  x_bill_amt 			=> 0,
											  x_completion_date 	=> l_curr_rev_eve_dt,
											  x_reference2 			=> to_char(agr_tsk.agreement_id),
											  x_txn_currency_code 	=> l_eve_crt_curr_code,
											  x_error_message 		=> err_msg,
											  x_status 				=> err_status);
			   /* ELSIF  TO_CHAR(l_curr_rev_eve_dt,'YYYY-MM') = TO_CHAR(l_tsk_end_dt,'YYYY-MM') AND l_last_month_hold = 'Y' THEN
				    fnd_file.put_line (fnd_file.LOG,' event created in elsif part1 ');
					 */
				END IF;
				END IF;							  
				fnd_file.put_line (fnd_file.LOG,' AFTER pa_billing_pub ');	
                fnd_file.put_line (fnd_file.LOG,' l_meaning 2 : '||l_meaning);				


			   ELSIF l_meaning = 'Extended Warranty' THEN
			   fnd_file.put_line (fnd_file.LOG,' event created in elsif part ');
                  pa_billing_pub.insert_event(x_project_id  		=> x_project_id,
											  x_top_task_id 		=> l_event_task_id,
											  x_rev_amt  			=> tot_rev_eve_amt,
											  x_bill_amt 			=> 0,
											  x_completion_date 	=> l_curr_rev_eve_dt,
											  x_reference2 			=> to_char(agr_tsk.agreement_id),
											  x_txn_currency_code 	=> l_eve_crt_curr_code,
											  x_error_message 		=> err_msg,
											  x_status 				=> err_status);

					fnd_file.put_line (fnd_file.LOG,' err_status  : '||err_status);
					fnd_file.put_line (fnd_file.LOG,' AFTER pa_billing_pub ');
					fnd_file.put_line (fnd_file.LOG,' err_msg  : '||err_msg);

			  END IF;
              IF g1_debug_mode = 'Y' THEN
                fnd_file.put_line (fnd_file.LOG,' Done Inserting REV event '||err_status);
              END IF;
              IF err_status     <> 0 THEN
                IF g1_debug_mode = 'Y' THEN
                  fnd_file.put_line (fnd_file.LOG,' ERROR from pa_billing_pub.insert_event for REV Amt');
                END IF;
                RAISE ERR_INSERT_EVENT;
              END IF;
            END IF;
            /*if chk_adj_eve_flag = 'Y' and l_adj_rev_amt <> 0 then --l_adj_rev_amt <> 0 then
            IF g1_debug_mode  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,'pa_billing_pub.insert_event IN Param l_adj_rev_amt:'||l_adj_rev_amt||' X_project_id:'||X_project_id);
            END IF;
            pa_billing_pub.insert_event(X_project_id        => X_project_id,
            X_top_task_id       => agr_tsk.task_id,
            X_rev_amt           => l_adj_rev_amt,
            X_bill_amt          => 0,
            X_completion_date   => l_curr_rev_eve_dt,
            x_reference2        => to_char(agr_tsk.agreement_id),
            X_error_message     => err_msg,
            X_status            => err_status);
            IF g1_debug_mode  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' Done Inserting ADJ event '||err_status);
            END IF;
            IF err_status <> 0 THEN
            IF g1_debug_mode  = 'Y' THEN
            fnd_file.put_line (fnd_file.LOG,' ERROR from pa_billing_pub.insert_event for ADJ Amt');
            END IF;
            raise ERR_INSERT_EVENT;
            END IF;
            end if;*/
            SELECT NVL(SUM(NVL(BILL_TRANS_REV_AMOUNT,0)),0),
              NVL(MAX(completion_date),to_date('31-DEC-9999','DD-MON-YYYY'))
            INTO l_revamt_eve_crtd,
              l_last_event_date
            FROM pa_events
            WHERE project_id                  = X_project_id
            AND reference2                    = TO_CHAR(agr_tsk.agreement_id) -- DFF Projects:Events
            AND (task_id                      = DECODE(L_LOOKUP_FOUND,'Y',
                                                                 DECODE(L_PRJ_FUNDING_LVL,'PROJECT',
                                                                 L_LOOKUP_TASK_ID,AGR_TSK.TASK_ID),
                                                     agr_tsk.task_id)
            OR (task_id                      IS NULL
            AND agr_tsk.task_id              IS NULL))
            AND NVL(BILL_TRANS_REV_AMOUNT,0) <> 0;
            tot_rev_eve_amt                  :=0;
            tot_l_rev_amt                    :=0;
            tot_eve_amt2                     :=0;

            -- l_curr_rev_eve_dt := last_day(l_curr_rev_eve_dt+1);
          end loop;
        END LOOP; --FOR agr_tsk IN ..
        /* CR22722 Logic End */
  end if;


  IF G1_DEBUG_MODE = 'Y' THEN
    fnd_file.put_line (fnd_file.LOG,' =====END : Params Auto_rev_event_gen X_request_id : '||X_request_id );
  END IF;
EXCEPTION
WHEN ERR_COUNT_DAYS THEN
  raise;
WHEN ERR_INVALID_BUDGET THEN
  NULL;
WHEN ERR_INSERT_EVENT THEN
  raise;
WHEN lookup_err THEN
  -- DBMS_OUTPUT.PUT_LINE(status);
  -- DBMS_OUTPUT.PUT_LINE(SQLERRM);
  status                 := 'Incorrect LOOKUP Setup for LOOKUP_CODE: '||fnd_profile.value('ORG_ID');--SUBSTR(SQLERRM,1,240);
  l_status               := SQLCODE;
  X2_revenue_amount      := NULL;
  X_rev_budget_type_code := NULL;
  PA_BILLING_PUB.INSERT_MESSAGE (X_INSERTING_PROCEDURE_NAME =>'xxpa_rev_cn.AUTO_REV_EVENT_GEN',
                                 X_message => 'Invaild LOOKUP Setup for CODE: '||fnd_profile.value('ORG_ID'),
                                  X_attribute1 => l_cost_budget_type_code,
                                  X_attribute2 => l_rev_budget_type_code,
                                  X_error_message=>status,
                                  X_status=>l_status);
WHEN prj_tsk_err THEN
  -- DBMS_OUTPUT.PUT_LINE(status);
  -- DBMS_OUTPUT.PUT_LINE(SQLERRM);
  status                 := 'Task in LOOKUP not exist on Prj:'||L_PRJ_NAME;--SUBSTR(SQLERRM,1,240);
  l_status               := SQLCODE;
  X2_revenue_amount      := NULL;
  X_REV_BUDGET_TYPE_CODE := NULL;
  PA_BILLING_PUB.INSERT_MESSAGE (X_INSERTING_PROCEDURE_NAME =>'xxpa_rev_cn.AUTO_REV_EVENT_GEN',
                                  X_message => 'Task in LOOKUP not exist on Prj: '||L_PRJ_NAME,
                                  X_attribute1 => l_cost_budget_type_code,
                                  X_attribute2 => l_rev_budget_type_code,
                                  X_error_message=>status,
                                  X_status=>l_status);
WHEN prj_too_many_tsk THEN
  -- DBMS_OUTPUT.PUT_LINE(status);
  -- DBMS_OUTPUT.PUT_LINE(SQLERRM);
  status                 := 'Project : '||X_project_id||' has duplicate Tasks';--SUBSTR(SQLERRM,1,240);
  l_status               := SQLCODE;
  X2_revenue_amount      := NULL;
  X_rev_budget_type_code := NULL;

  PA_BILLING_PUB.INSERT_MESSAGE (X_INSERTING_PROCEDURE_NAME =>'xxpa_rev_cn.AUTO_REV_EVENT_GEN',
                                  X_message => 'Project: '||L_PRJ_NAME||' has duplicate Tasks',
                                  X_attribute1 => l_cost_budget_type_code,
                                  X_attribute2 => l_rev_budget_type_code,
                                  X_error_message=>status,
                                  X_status=>l_status);
WHEN OTHERS THEN
  raise;
END AUTO_REV_EVENT_GEN;
END xxpa_rev_cn;
/
SHOW ERR;
