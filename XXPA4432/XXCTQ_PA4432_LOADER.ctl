-- ********************************************************************************************
-- Title:       sql*loader control file to load data into XXPA_PROJ_ATT_TEMP for validation
-- File:        XXCTQ_PA4432_LOADER.ctl
-- Description: sql*loader control file to load data into XXPA_PROJ_ATT_TEMP for validation
-- Parameters:  {None.}
-- Run as:      APPLMGR
-- Keyword Tracking:
--
--   $Header: xxctq/bin/XXCTQ_PA4432_LOADER.ctl
-- History:
-- Date          Who                Description 
-- -----------   ------------------ ---------------------------------------
-- 25-SEP-2023   Sowmya shetty      CR25375 - Initial Creation
-- ************************************************************************************
OPTIONS (SKIP=1, ERRORS=999) --PARALLEL=TRUE, BINDSIZE=89526
LOAD DATA 
CHARACTERSET 
INFILE * 
APPEND 
INTO TABLE XXPA.XXPA_PROJECT_ATTACHMENTS_STG
FIELDS TERMINATED BY '~' 
OPTIONALLY ENCLOSED BY '"' 
TRAILING NULLCOLS
(
 ATTACHMENT_LEVEL      "TRIM(:ATTACHMENT_LEVEL)"
,ATT_PROJ_AG_REFERENCE   "TRIM(:ATT_PROJ_AG_REFERENCE)"
,ATTACH_NOTES            Char(4000) --"TRIM(:ATTACH_NOTES)"
,ATTACH_CATEGORY         "TRIM(:ATTACH_CATEGORY)"
,ATTACH_SOURCE           "TRIM(:ATTACH_SOURCE)"
,ATTACH_TITLE            "TRIM(:ATTACH_TITLE)"
,ATTACH_SEQ_NUMBER       "TRIM(:ATTACH_SEQ_NUMBER)"
,ATTACH_DESCRIPTION      "TRIM(:ATTACH_DESCRIPTION)"
,RECORD_ID               "xxpa.xxpa_project_attachments_stg_s.nextval"
,STATUS               constant 'NEW'  
,FILE_NAME            constant 'PA_Attach_Rec'
,BATCH_ID              CONSTANT 'XXXXXX' --"CP_REQUEST_ID"
,CREATION_DATE        SYSDATE
,CREATED_BY           "FND_GLOBAL.USER_ID"
,LAST_UPDATE_DATE     SYSDATE
,LAST_UPDATED_BY      "FND_GLOBAL.USER_ID"
)