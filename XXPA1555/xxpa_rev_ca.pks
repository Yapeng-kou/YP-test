create or replace PACKAGE apps.xxpa_rev_ca AS
 /*********************************************************
** Title:       XXPA1555 Extension for Term Service Contract Revenue Recognition
** File:        XXPA_REV_CA.pks
** Description: This script creates a package header
** Parameters:  {None.}
** Run as:      APPS
** Keyword Tracking:
**
**   $Header: xxpa/patch/115/sql/xxpa_rev_ca.pks 1.1 21-DEC-2012 00:21:35 CCBAZR $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.1 (COMPLETE)
**     Created:  21-DEC-2012 00:21:35      CCBAZR
**       CR4464
**
**   Revision 1.0 (COMPLETE)
**     Created:  01-NOV-2012 06:37:12      CCBAZR
**       Initial revision.
**
**
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 31-Oct-2012   Jaya Gupta         Initial Creation Main procedure called
**                                  form PRC: Generate Draft Revenue for a Single Project
**                                  xxpa_rev_ca.Auto_rev_event_gen().
** 10-Jan-2013   Jaya Gupta	        Changes for CR4464.
********************************************************/
/* Custom Billing Extension */
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
    X_status OUT NOCOPY        NUMBER );
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
    X_request_id            IN NUMBER DEFAULT NULL );
END xxpa_rev_ca;
/