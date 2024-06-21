/*********************************************************
** Title:       XXPA_PROJECT_ATTACHMENTS_STG
** File:        XXPA_PROJECT_ATTACHMENTS_SYN
** Description: This script creates a table
** Parameters:  {None.}
** Run as:      XXPA
** 12_2_compliant:YES
** Keyword Tracking:
**   %PCMS_HEADER_SUBSTITUTION_START%
**   $Header: %HEADER% $
**   $Change History$ (*ALL VERSIONS*)
**   %PL%
**   %PCMS_HEADER_SUBSTITUTION_END%
**
** History:
** Date          Who                Description
** -----------   ------------------ -------------------------
** 27-SEP-2023   Sowmya Shetty      SYNONYM creation
********************************************************/
--Whenever sqlerror exit failure rollback
set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

CREATE SYNONYM APPS.XXPA_PROJECT_ATTACHMENTS_STG FOR XXPA.XXPA_PROJECT_ATTACHMENTS_STG;

Commit;