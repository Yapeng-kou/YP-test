SET SERVEROUTPUT ON SIZE 1000000 LINES 132 TRIMOUT ON TAB OFF PAGES 100;

WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

CREATE OR REPLACE PACKAGE xxpa_contract_creation_pkg AUTHID DEFINER AS
/******************************************************************************
*                           - COPYRIGHT NOTICE -                              *
*******************************************************************************
** Title	:        XXPA1559 
** File		:        xxpa_contract_creation_pkg.pks
** Description	: 	 This script creates xxpa_contract_creation_pkg package header
** Parameters	:  	 {None}
** Run as	:        APPS
** Keyword Tracking:
**   
**   $Header: xxpa/12.0.0/patch/115/sql/xxpa_contract_creation_pkg.pks 1.0 21-SEP-2012 03:05:55 C-LTOSHN $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  21-SEP-2012 03:05:55      C-LTOSHN (Lalitha Toshniwal)
**       Initial revision.
**   
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------------
** 10-Sep-2012   Lalitha Toshniwal   XXPA1559 Initial Creation               *
*****************************************************************************/

PROCEDURE xxpa_contract_creation_proc(p_project_id  IN NUMBER);

FUNCTION xxpa_contract_creation_request RETURN VARCHAR2;

FUNCTION xxpa_contract_number(p_project_id  IN NUMBER) RETURN VARCHAR2;

END xxpa_contract_creation_pkg;
/
SHOW ERRORS PACKAGE xxpa_contract_creation_pkg;

DESC xxpa_contract_creation_pkg;