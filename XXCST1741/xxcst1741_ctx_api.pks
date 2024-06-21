set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

Whenever sqlerror exit failure rollback
CREATE OR REPLACE PACKAGE xxcst1741_ctx_api IS
/*********************************************************
** Title:       xxcst1741_ctx_api context
** File:        xxcst1741_ctx_api.pks
** Description: This script creates a custom context api that will be used in XXAP_INVOICE_PRICE_VAR_V, for use in XXCST1741.
** Parameters:  {None.}
** Run as:      APPS
** Keyword Tracking:
**   
**   $Header: xxcst/12.0.0/patch/115/sql/xxcst1741_ctx_api.pks 1.0 12-JAN-2021 16:09:58 IRHZXS $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  12-JAN-2021 16:09:58      IRHZXS (Ravi Alapati)
**       initial creation
**   
**
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 12-Jan-2021  Ravi Alapati     RT9001090 - performance tuning
********************************************************/

    procedure set_from_date(p_date in date);
    
    procedure set_to_date(p_date in date);
			
END xxcst1741_ctx_api;
/
Show errors PACKAGE xxcst1741_ctx_api

