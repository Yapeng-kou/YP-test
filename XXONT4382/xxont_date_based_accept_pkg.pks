CREATE OR REPLACE PACKAGE xxont_date_based_accept_pkg AUTHID definer AS/***********************************************************************************
** Title:       XX Manual Acceptance for Project Order Lines
** File:        xxont_china_manual_accept_pkg.pkS
** Description: This script creates a package body
** Parameters:  {None}
** Run as:      APPS
** Keyword Tracking:
**
**
** Change History:
**=================================================================================
** Date         | Name              | Remarks
**=================================================================================
**03-jul-2023   | Vimalraj Govindhasamy   | Initial Creation.
************************************************************************************/

/* This is the main procedure for this package called from conc program */
    PROCEDURE xx_date_based_accept_main (
        p_errbuf  OUT VARCHAR2,
        p_retcode OUT VARCHAR2,
		p_org_id  IN  NUMBER,
	    p_so_number IN NUMBER,
		p_so_line_number IN NUMBER
    );

END xxont_date_based_accept_pkg;
/

SHOW ERR