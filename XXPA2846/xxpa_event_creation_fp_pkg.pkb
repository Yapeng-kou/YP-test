CREATE OR REPLACE PACKAGE BODY APPS.xxpa_event_creation_fp_pkg
AS
     /**********************************************************************************************************************
   *                           - COPYRIGHT NOTICE -                                                                      *
   ***********************************************************************************************************************
   ** Title            :   XXPA2846                                                                                      *
   ** File             :   xxpa_event_creation_fp_pkg.pks                                                                    *
   ** Description      :   Package Body for Event Form Personalization conditions              *
   ** Parameters       :   {None}                                                                                        *
   ** Run as           :   APPS                                                                                          *
   ** Keyword Tracking :                                                                                                 *
   **                                                                *
   **   $Header: xxpa/patch/115/sql/xxpa_event_creation_fp_pkg.pkb 1.1 07-MAR-2016 04:46:16 CCBHGP $                                                                       *
   **   $Change History$ (*ALL VERSIONS*)                                                            *
   **   Revision 1.1 (COMPLETE)
   **     Created:  07-MAR-2016 04:46:16      CCBHGP
   **       CR23086 - Project Events Data Entry Form changes - XXPA2960
   **
   **   Revision 1.0 (COMPLETE)
   **     Created:  03-SEP-2015 11:27:15      CCBSVW
   **       Initial revision.
   **                                                                  *
   **                                                                                                                    *
   ** History          :                                                                                                 *
   ** Date          Who                Description                                                                       *
   ** -----------   ------------------ -----------------------------------------------------------------------------------
   ** 18-Aug-2015   Rajeev Chakraborty  Initial Version
   ** 05-Mr-2015    RajniKant Mishra     CR23086 - Project Events Data Entry Form (XXPA2960) changes
   ***********************************************************************************************************************/
   g_resp_id              NUMBER          DEFAULT fnd_global.resp_id;
   g_event_type           VARCHAR2 (30)   DEFAULT 'Prepayment';
   g_valid_product_code   VARCHAR2 (30)   DEFAULT '99999';
   g_error_msg            VARCHAR2 (2000);
   
   PROCEDURE log_debug(p_text IN VARCHAR2)
   IS
   BEGIN
   
    --INSERT INTO  xxpa.xx_form_log (log_message) VALUES (p_text);
    --COMMIT;
    
    NULL;
   
   EXCEPTION
   WHEN OTHERS THEN
   NULL;
   END;

   FUNCTION xxpa_condition_check (
      p_project_id   IN   NUMBER,
      p_event_type   IN   VARCHAR2,
      p_task_id      IN   NUMBER
   )
      RETURN VARCHAR2
   AS
   -- Checking for the required conditions
      l_condition_check       VARCHAR2 (1)   DEFAULT 'N';
      l_resp_exist            NUMBER         := 0;
      l_resp_prj_type_exist   NUMBER         := 0;
      l_product_code          VARCHAR2 (150) DEFAULT '';
      
      l_error VARCHAR2 (150) DEFAULT '';
   BEGIN
   
      SELECT COUNT (1)
        INTO l_resp_exist
        FROM fnd_responsibility_vl frv,
             fnd_lookup_values flv
       WHERE flv.lookup_type = 'XXPA2846_EVENT_FP_PROJECT_TYPE'
         AND flv.meaning = frv.responsibility_name -- AND flv.lookup_code = frv.responsibility_key
         AND flv.LANGUAGE = USERENV ('LANG')
         AND flv.enabled_flag = 'Y'
         AND TRUNC (SYSDATE) BETWEEN TRUNC (flv.start_date_active)
                                 AND TRUNC (NVL (flv.end_date_active,
                                                 SYSDATE + 1
                                                )
                                           )
         AND frv.responsibility_id = g_resp_id;
         
         
         
          --  log_debug(' l_resp_exist '||l_resp_exist);

      BEGIN
         SELECT attribute1
           INTO l_product_code
           FROM pa_tasks
          WHERE project_id = p_project_id AND task_id = p_task_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            l_product_code := '';
      END;
      
      
       
            --log_debug(' l_product_code '||l_product_code);

      
           -- log_debug(' PA_BILLING_VALUES.FUNDING_LEVEL(p_project_id) '||PA_BILLING_VALUES.FUNDING_LEVEL(p_project_id));

     if PA_BILLING_VALUES.FUNDING_LEVEL(p_project_id) = 'PROJECT' THEN

      SELECT COUNT (1)
        INTO l_resp_prj_type_exist
        FROM pa_projects_all ppa,
             fnd_profile_options_vl fpo,
             fnd_profile_option_values fpov,
             fnd_responsibility_vl frv,
             fnd_lookup_values flv
       WHERE flv.lookup_type = 'XXPA2846_EVENT_FP_PROJECT_TYPE'
         AND flv.meaning = frv.responsibility_name -- AND flv.lookup_code = frv.responsibility_key
         AND flv.LANGUAGE = USERENV ('LANG')
         AND flv.enabled_flag = 'Y'
         AND TRUNC (SYSDATE) BETWEEN TRUNC (flv.start_date_active)
                                 AND TRUNC (NVL (flv.end_date_active,
                                                 SYSDATE + 1
                                                )
                                           )
         AND fpov.level_value = frv.responsibility_id
         AND fpo.profile_option_id = fpov.profile_option_id
         AND fpo.profile_option_name = 'ORG_ID'
         AND UPPER (fpo.user_profile_option_name) LIKE UPPER ('MO%OPERATIN%')
         AND fpov.profile_option_value = ppa.org_id
         AND frv.responsibility_id = g_resp_id
         AND ppa.project_id = p_project_id
         AND ((ppa.project_type IN (
                  SELECT     REGEXP_SUBSTR (flv.description,
                                            '[^|]+',
                                            1,
                                            LEVEL
                                           ) RESULT
                        FROM DUAL
                  CONNECT BY LEVEL <=
                                  LENGTH (REGEXP_REPLACE (flv.description,
                                                          '[^|]+'
                                                         )
                                         )
                                + 1)
              )
             );

        ELSE
        SELECT COUNT (1)
        INTO l_resp_prj_type_exist
        FROM pa_projects_all ppa,
             fnd_profile_options_vl fpo,
             fnd_profile_option_values fpov,
             fnd_responsibility_vl frv,
             fnd_lookup_values flv,
             pa_tasks pt,
             pa_work_types_vl wt
       WHERE flv.lookup_type = 'XXPA2846_EVENT_FP_PROJECT_TYPE'
         AND flv.meaning = frv.responsibility_name -- AND flv.lookup_code = frv.responsibility_key
         AND flv.LANGUAGE = USERENV ('LANG')
         AND flv.enabled_flag = 'Y'
         AND TRUNC (SYSDATE) BETWEEN TRUNC (flv.start_date_active)
                                 AND TRUNC (NVL (flv.end_date_active,
                                                 SYSDATE + 1
                                                )
                                           )
         AND fpov.level_value = frv.responsibility_id
         AND fpo.profile_option_id = fpov.profile_option_id
         AND fpo.profile_option_name = 'ORG_ID'
         AND UPPER (fpo.user_profile_option_name) LIKE UPPER ('MO%OPERATIN%')
         AND fpov.profile_option_value = ppa.org_id
         and ppa.project_id = pt.project_id
         and pt.WORK_TYPE_ID = wt.WORK_TYPE_ID
         AND frv.responsibility_id = g_resp_id
         AND ppa.project_id = p_project_id
         and pt.task_id = p_task_id
         AND ((wt.NAME IN (
                  SELECT     REGEXP_SUBSTR (flv.description,
                                            '[^|]+',
                                            1,
                                            LEVEL
                                           ) RESULT
                        FROM DUAL
                  CONNECT BY LEVEL <=
                                  LENGTH (REGEXP_REPLACE (flv.description,
                                                          '[^|]+'
                                                         )
                                         )
                                + 1)
              )
             );
    END IF; --for funding level check
    
    
    
           -- log_debug(' l_resp_exist '||l_resp_exist);
            
    
           -- log_debug('  p_event_type '|| p_event_type||' g_event_type '||g_event_type); 
            
      
            --log_debug('  l_product_code '|| l_product_code||' g_valid_product_code '||g_valid_product_code);  
            
             
            --log_debug('  l_resp_prj_type_exist '||l_resp_prj_type_exist);              


      IF    (    (l_resp_exist <> 0)
             AND (   p_event_type = g_event_type
                  OR l_product_code = g_valid_product_code
                 )
            )
         OR (l_resp_prj_type_exist <> 0)
      THEN
         l_condition_check := 'Y';
      ELSE
         l_condition_check := 'N';
      END IF;
      
         
         --   log_debug('  l_condition_check '||l_condition_check);  
          --  COMMIT;

      RETURN l_condition_check;
   EXCEPTION
      WHEN OTHERS
      THEN
      
      l_error :=SQLERRM;
        
      -- log_debug(' eRROR IN FUNCTTION '||l_error );
      --commit;
         RETURN ('N');
   END xxpa_condition_check;

FUNCTION xxpa_date_task_mandatory
      RETURN VARCHAR2
   AS
      l_condition_check       VARCHAR2 (1)   DEFAULT 'N';
      l_resp_exist            NUMBER         := 0;
   -- Date and Task Mandatory
   BEGIN

      SELECT COUNT (1)
        INTO l_resp_exist
        FROM fnd_responsibility_vl frv,
             fnd_lookup_values flv
       WHERE flv.lookup_type = 'XXPA2846_EVENT_FP_PROJECT_TYPE'
         AND flv.meaning = frv.responsibility_name -- AND flv.lookup_code = frv.responsibility_key
         AND flv.LANGUAGE = USERENV ('LANG')
         AND flv.enabled_flag = 'Y'
         AND TRUNC (SYSDATE) BETWEEN TRUNC (flv.start_date_active)
                                 AND TRUNC (NVL (flv.end_date_active,
                                                 SYSDATE + 1
                                                )
                                           )
         AND frv.responsibility_id = g_resp_id;

      IF    l_resp_exist <> 0
      THEN
         l_condition_check := 'Y';
      ELSE
         l_condition_check := 'N';
      END IF;

      RETURN l_condition_check;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN ('N');
   END xxpa_date_task_mandatory;
   
   FUNCTION xxpa_condition_check_wrap (
      p_project_id   IN   NUMBER,
      p_event_type   IN   VARCHAR2,
      p_task_id      IN   NUMBER,
      p_user_id      IN NUMBER,
      p_resp_id      IN NUMBER,
      p_resp_appl_id IN NUMBER,
      p_org_id       IN NUMBER
   )    RETURN VARCHAR2
   IS
   
   l_condition_check VARCHAR2(1):='N';
   
   BEGIN
   
   
   
 --  fnd_global.apps_initialize(p_user_id, p_resp_id, p_resp_appl_id, 0);
   
    
  -- log_debug(' g_resp_id '||g_resp_id);
  -- COMMIT;
   
  -- RETURN('Y');
   
   IF p_resp_id IS NOT NULL THEN
   g_resp_id:=p_resp_id;   
   END IF;
   
   IF p_org_id  IS NOT NULL THEN   
    mo_global.set_policy_context('S',p_org_id);
   END IF;
   
   l_condition_check:=xxpa_condition_check(p_project_id,
                                                   p_event_type,
                                                   p_task_id
                                                   );
                                                   
   RETURN (l_condition_check);                                                
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN ('N');
   END xxpa_condition_check_wrap;
   
   
   FUNCTION xxpa_derive_project_type (
     p_project_id   IN   NUMBER,
      p_event_type   IN   VARCHAR2,
      p_task_id      IN   NUMBER,
      p_user_id      IN NUMBER,
      p_resp_id      IN NUMBER,
      p_resp_appl_id IN NUMBER,
      p_org_id       IN NUMBER
   )    RETURN VARCHAR2
   IS
   l_project_type VARCHAR2(20);
   BEGIN
   
     IF p_resp_id IS NOT NULL THEN
   g_resp_id:=p_resp_id;   
   END IF;
   
   IF p_org_id  IS NOT NULL THEN   
    mo_global.set_policy_context('S',p_org_id);
   END IF;
   
       IF p_project_id IS NOT NULL THEN
          BEGIN
                SELECT project_type
                  INTO  l_project_type
                  FROM pa_projects
                WHERE  project_id=p_project_id;
                
                RETURN(l_project_type);
                
          EXCEPTION
          
          WHEN OTHERS THEN
          RETURN('X');        
          
          END;     
   
       ELSE
       
       RETURN('X');
       END IF;
   
   
   EXCEPTION
   WHEN OTHERS THEN
   RETURN('X');
   END;
   
END xxpa_event_creation_fp_pkg;
/
