/*********************************************************
** Title:       XXX_PRCLST_C Staging Table
** File:        XXCTQ_PROJECT_ATTACHMENTS_STG
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
** -----------   ------------------ --------------------------------
** 27-SEP-2023   Sowmya Shetty      XXCTQ Table for XXCTQ_PROJECT_ATT
********************************************************/
--Whenever sqlerror exit failure rollback

set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

CREATE TABLE XXPA.XXPA_PROJECT_ATTACHMENTS_STG
( ATTACHMENT_LEVEL     VARCHAR2(250)
,ATT_PROJ_AG_REFERENCE VARCHAR2(250)
,ATTACH_NOTES          VARCHAR2(2000)
,ATTACH_CATEGORY       VARCHAR2(250)
,ATTACH_SOURCE         VARCHAR2(250)
,ATTACH_TITLE          VARCHAR2(250) 
,ATTACH_SEQ_NUMBER     NUMBER  
,ATTACH_DESCRIPTION    VARCHAR2(250) 
,PROJECT_ID            NUMBER
,AGREEMENT_ID          NUMBER
,RECORD_ID             NUMBER
,ORG_ID                NUMBER
,MESSAGE               VARCHAR2(4000) 
,STATUS                VARCHAR2(15)    
,FILE_NAME             VARCHAR2(250)  
,BATCH_ID              NUMBER
,CREATION_DATE         DATE
,CREATED_BY            NUMBER
,LAST_UPDATE_DATE      DATE
,LAST_UPDATED_BY       NUMBER
   );

Commit;