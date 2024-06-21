/*********************************************************
** Title:       ATTCHMENT VIEW
** File:        XXCTQ_PA_PROJECT_ATTACHMENT_V
** Description: This script creates a view for attchment
** Parameters:  {None.}
** Run as:      APPS
** 12_2_compliant:YES
** Keyword Tracking:
**   
**   $Header: xxmfg/12.0.0/patch/115/sql/xxmfg_flow_schd_so_v.sql 1.7.0.1 09-JUL-2023 20:18:10 U112025 $
**   $Change History$ (*ALL VERSIONS*)
**   
**
** History:
** Date          Who                  Description
** -----------   ------------------   -------------------------------
** 04-OCT-2023   Sowmya shetty        Initial creation
*****************************************************************/

SET serveroutput ON size 1000000 lines 132 trimout ON tab OFF pages 100
Whenever sqlerror EXIT failure ROLLBACK

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "APPS"."XXCTQ_PA_PROJECT_ATTACHMENT_V" ("ATTACHMENT_LEVEL", "ATT_PROJ_AG_REFERENCE", "ATTACH_NOTES", "ATTACH_CATEGORY", "ATTACH_SOURCE", "ATTACH_TITLE", "ATTACH_SEQ_NUMBER", "ATTACH_DESCRIPTION", "MESSAGE", "STATUS", "FILE_NAME", "BATCH_ID", "RECORD_ID", "PROJECT_ID", "AGREEMENT_ID", "ORG_ID", "REC_ERROR") AS 
  SELECT
        attachment_level,
        att_proj_ag_reference,
        attach_notes,
        attach_category,
        attach_source,
		ATTACH_TITLE,
        attach_seq_number,
        attach_description,
        message,
        status,
        file_name,
        batch_id,
        record_id,
        project_id,
        agreement_id,
        org_id,
        decode(
            status, 'SUCCESS', NULL, 'VALID', NULL, xxctq_util_pkg.xxctq_record_error_extract(
                batch_id, record_id, 'Project-Attachments'
            )
        ) rec_error
    FROM
        xxpa_project_attachments_stg
WITH READ ONLY;

