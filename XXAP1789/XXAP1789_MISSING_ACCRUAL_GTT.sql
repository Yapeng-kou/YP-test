/*********************************************************
** Title:       Create custom global temp table
** File:        XXAP1789_MISSING_ACCRUAL_GTT.sql
** Description: This script creates a table
** Parameters:  {None.}
** Run as:      XXAP
** Keyword Tracking:
**   
**   $Header: xxap/12.0.0/patch/115/sql/XXAP1789_MISSING_ACCRUAL_GTT.sql 1.2.SEP 15-JAN-2020 20:18:19 CCEGEZ $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.2.SEP (COMPLETE)
**     Created:  15-JAN-2020 20:18:19      CCEGEZ (Pankaj Karan)
**       Updated
**   
**   Revision 1.1.SEP (COMPLETE)
**     Created:  15-JAN-2020 20:12:10      CCEGEZ (Pankaj Karan)
**       Updated
**   
**   Revision 1.0.SEP (COMPLETE)
**     Created:  15-JAN-2020 19:43:38      CCEGEZ (Pankaj Karan)
**       Updated on Commit preserve
**   
**   Revision 1.0 (COMPLETE)
**     Created:  15-JAN-2020 18:52:50      CCEGEZ (Pankaj Karan)
**       Initial revision.
**   
**
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 15-Jan-2019   Pankaj Karan        Initial Creation - Defect# 824 SEP-5733
********************************************************/
Whenever sqlerror exit failure rollback

CREATE GLOBAL TEMPORARY TABLE XXAP.XXAP1789_MISSING_ACCRUAL_GTT
(
  CODE_COMBINATION_ID NUMBER
)
ON COMMIT PRESERVE ROWS;
-- CREATE/RECREATE INDEXES 
CREATE INDEX XXAP.XXAP1789_MISSING_ACC_IDX ON XXAP.XXAP1789_MISSING_ACCRUAL_GTT (CODE_COMBINATION_ID);

comment on table XXAP.XXAP1789_MISSING_ACCRUAL_GTT is
  '$Header: xxap/12.0.0/patch/115/sql/XXAP1789_MISSING_ACCRUAL_GTT.sql 1.2.SEP 15-JAN-2020 20:18:19 CCEGEZ $'
;
exec apps.xx_pk_grant.p_apps_grant('XXAP1789_MISSING_ACCRUAL_GTT');