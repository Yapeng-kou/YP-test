-- ********************************************************************************************
-- Title:       sql*loader control file 
-- File:        XXCTQ_RECEPT_CTL.ctl
-- Description: sql*loader control file 
-- Parameters:  File Path
-- Run as:      APPLMGR
-- Keyword Tracking:
--   
--   
--   $Header: xxctq/12.0.0/bin/XXCTQ_RECEPT_CTL.ctl 1.5.0.1 05-JUN-2023 12:43:09 U111721 $
--   $Change History$ (*ALL VERSIONS*)
--   Revision 1.5.0.1 (COMPLETE)
--     Created:  05-JUN-2023 12:43:09      U111721 (Sachin Rao)
--       Defect 34907 - Increased Character length of H_COMMENTS to 1760
--   
--   Revision 1.5 (COMPLETE)
--     Created:  26-AUG-2015 06:04:08      CCBUMF (None)
--       Updated
--   
--   Revision 1.4 (COMPLETE)
--     Created:  05-SEP-2014 11:09:00      CCBIZB (None)
--       Added history description
--   
--   Revision 1.3 (COMPLETE)
--     Created:  26-AUG-2014 10:52:08      CCBIZB (None)
--       Added new column H_ORGANIZATION_NAME
--   
--   Revision 1.2 (COMPLETE)
--     Created:  08-OCT-2013 07:29:42      CCAZJG (None)
--       Replace regexp cmd.
--   
--   Revision 1.1 (COMPLETE)
--     Created:  29-AUG-2013 04:14:58      CCAZJG (None)
--       Changed Sequence
--   
--   Revision 1.0 (COMPLETE)
--     Created:  08-AUG-2013 16:58:50      CCBGSX (Nagesh Ponduri)
--       Initial revision.
--      --   
--
-- History:
-- Date          Who                Description
-- -----------   ------------------ ------------------------------------
-- 26-JUL-2013   Nagesh Ponduri 	Initial Creation
-- 20-Aug-2014   Susmit Ghosh	 	Added new column H_ORGANIZATION_NAME
-- 26-Aug-2015   Rahul Banerjee     RT#6145726 - Changes for UNICODE characters and Archive Data files
-- 02-Jun-2022   Sachin Rao         Defect 34907 - Increased Character length of H_COMMENTS to 1760
-- ********************************************************************************************
OPTIONS ( SKIP=1, ERRORS=999)
LOAD DATA 
CHARACTERSET
INFILE *
APPEND
INTO TABLE XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT
FIELDS TERMINATED BY '~'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
    ( 
H_ORGANIZATION_NAME   "TRIM(:H_ORGANIZATION_NAME)",
H_ORIG_SYSTEM   "TRIM(:H_ORIG_SYSTEM)",
H_RECEIPT_METHOD   "TRIM(:H_RECEIPT_METHOD)",
H_RECEIPT_NUMBER   "TRIM(:H_RECEIPT_NUMBER)",
H_CURRENCY_CODE   "TRIM(:H_CURRENCY_CODE)",
H_RECEIPT_AMOUNT   "TRIM(:H_RECEIPT_AMOUNT)",
H_RECEIPT_DATE   "TRIM(:H_RECEIPT_DATE)",
H_GL_DATE   "TRIM(:H_GL_DATE)",
H_CUSTOMER_NUMBER   "TRIM(:H_CUSTOMER_NUMBER)",
H_CUSTOMER_LOCATION   "TRIM(:H_CUSTOMER_LOCATION)",
H_COMMENTS       CHAR(1760), --removed "TRIM(:H_COMMENTS )",Added specific length for Defect 34907
H_EXCHANGE_RATE	"TRIM(:H_EXCHANGE_RATE)",
H_EXCHANGE_RATE_TYPE   "TRIM(:H_EXCHANGE_RATE_TYPE)",
H_ON_ACCOUNT_AMOUNT   "TRIM(:H_ON_ACCOUNT_AMOUNT)",
H_ON_ACCOUNT_APPLIED_DATE   "regexp_replace(:H_ON_ACCOUNT_APPLIED_DATE,'([^[:graph:]|^[:blank:]])','')",
BATCH_ID	   CONSTANT 'XXXXXX',--"TRIM(:BATCH_ID)",
STATUS     CONSTANT 'NEW',
RECORD_ID	INTEGER EXTERNAL "XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT_S.NEXTVAL"
)