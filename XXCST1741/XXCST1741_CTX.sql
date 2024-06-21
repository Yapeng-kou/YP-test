/*********************************************************
** Title:       XXCST1741_CTX context
** File:        XXCST1741_CTX.sql
** Description: This script creates a custom context that will be used in XXAP_INVOICE_PRICE_VAR_V, for use in XXCST1741.
** Parameters:  {None.}
** Run as:      APPS
** Keyword Tracking:
**   
**   $Header: xxcst/12.0.0/patch/115/sql/XXCST1741_CTX.sql 1.0 12-JAN-2021 16:09:27 IRHZXS $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  12-JAN-2021 16:09:27      IRHZXS (Ravi Alapati)
**       initial creation
**   
**
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 12-Jan-2021  Ravi Alapati     RT9001090 - performance tuning
********************************************************/
SET serveroutput ON size 1000000 lines 132 trimout ON tab OFF pages 100
whenever sqlerror EXIT failure ROLLBACK
CREATE OR REPLACE CONTEXT XXCST1741_CTX USING XXCST1741_CTX_API;
/