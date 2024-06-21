CREATE OR REPLACE PACKAGE APPS.xxpa_event_creation_fp_pkg
AS
/**********************************************************************************************************************
*                           - COPYRIGHT NOTICE -                                                                      *
***********************************************************************************************************************
** Title            :   XXPA2846                                                                                      *
** File             :   xxpa_event_creation_fp_pkg.pks                                                                    *
** Description      :   Package Spec for Event Form Personalization conditions              *
** Parameters       :   {None}                                                                                        *
** Run as           :   APPS                                                                                          *
** Keyword Tracking :                                                                                                 *
**                                                                *
**   $Header: xxpa/patch/115/sql/xxpa_event_creation_fp_pkg.pks 1.0 02-SEP-2015 11:25:02 CCBSVW $                                                                       *
**   $Change History$ (*ALL VERSIONS*)                                                            *
**   Revision 1.0 (COMPLETE)
**     Created:  02-SEP-2015 11:25:02      CCBSVW
**       Initial revision.
**                                                                  *
**                                                                                                                    *
** History          :                                                                                                 *
** Date          Who                Description                                                                       *
** -----------   ------------------ -----------------------------------------------------------------------------------
** 18-Aug-2015   Rajeev Chakraborty  Initial Version                                                              *
***********************************************************************************************************************/
---
---
   FUNCTION xxpa_condition_check (
      p_project_id   IN   NUMBER,
      p_event_type   IN   VARCHAR2,
      p_task_id      IN   NUMBER
   )
      RETURN VARCHAR2;
      
  FUNCTION xxpa_condition_check_wrap (
     p_project_id   IN   NUMBER,
      p_event_type   IN   VARCHAR2,
      p_task_id      IN   NUMBER,
      p_user_id      IN NUMBER,
      p_resp_id      IN NUMBER,
      p_resp_appl_id IN NUMBER,
      p_org_id       IN NUMBER
   )    RETURN VARCHAR2;


  FUNCTION xxpa_derive_project_type (
     p_project_id   IN   NUMBER,
      p_event_type   IN   VARCHAR2,
      p_task_id      IN   NUMBER,
      p_user_id      IN NUMBER,
      p_resp_id      IN NUMBER,
      p_resp_appl_id IN NUMBER,
      p_org_id       IN NUMBER
   )    RETURN VARCHAR2;
  FUNCTION xxpa_date_task_mandatory
  RETURN VARCHAR2;
END xxpa_event_creation_fp_pkg;
/
