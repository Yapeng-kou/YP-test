create or replace PACKAGE      xxpa_rev_cn AS
/*********************************************************
** Title:       XXPA1555 Extension for Term Service Contract lr_revenue Recognition
** File:        xxpa_rev_cn.pks
** Description: This script creates a package SPECIFICATION. Procedure Auto_rev_event_gen() creates
**              automatic events for lr_revenue Recong.
** Parameters:  {None.}
** Run as:      APPS
** R12_2_compliant: YES	
** Keyword tracking:
**
**   
**   $Header: xxpa/12.0.0/patch/115/sql/xxpa_rev_cn.pks 1.0 28-JUN-2023 12:07:09 CCHWDF $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  28-JUN-2023 12:07:08      CCHWDF (Rahaman Rawoof)
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
/* Custom Billing Extension */
PROCEDURE get_rev_budget_amount(X2_project_id                      NUMBER,
                                X2_task_id                         NUMBER DEFAULT NULL,
                                X2_agreement_id                    NUMBER DEFAULT NULL,
                                X2_revenue_amount 		OUT NOCOPY REAL,
                                P_rev_budget_type_code 	        IN VARCHAR2 DEFAULT NULL,
                                P_rev_plan_type_id     	        IN NUMBER DEFAULT NULL,                             
                                X_rev_budget_type_code 	OUT NOCOPY VARCHAR2,
                                X_rev_date 				        IN DATE,
                                X_error_message 		OUT NOCOPY VARCHAR2,
                                X_status 				OUT NOCOPY NUMBER);
								
PROCEDURE Auto_rev_event_gen(X_project_id            IN NUMBER,
                             X_top_task_id           IN NUMBER DEFAULT NULL,
                             X_calling_process       IN VARCHAR2 DEFAULT NULL,
                             X_calling_place         IN VARCHAR2 DEFAULT NULL,
                             X_amount                IN NUMBER DEFAULT NULL,
                             X_percentage            IN NUMBER DEFAULT NULL,
                             X_rev_or_bill_date      IN DATE DEFAULT NULL,
                             X_billing_assignment_id IN NUMBER DEFAULT NULL,
                             X_billing_extension_id  IN NUMBER DEFAULT NULL,
                             X_request_id            IN NUMBER DEFAULT NULL );
END xxpa_rev_cn;

/