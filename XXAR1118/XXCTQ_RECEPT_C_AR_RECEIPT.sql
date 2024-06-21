/*********************************************************
** Title:       XXX_RECEPT_C Staging Table
** File:        XXCTQ_RECEPT_C_AR_RECEIPT.sql
** Description: This script creates a table
** Parameters:  {None.}
** Run as:      XXAU
** Keyword Tracking:
**   
**   $Header: xxctq/12.0.0/patch/115/sql/XXCTQ_RECEPT_C_AR_RECEIPT.sql 1.0 14-AUG-2013 02:28:50 CCAZJG $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  14-AUG-2013 02:28:50      CCAZJG (None)
**       Initial revision.
**   
**
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 15-JUL-2013   B.Aishwarya         XXCTQ table for XXX_RECEPT_C 
**
********************************************************/
--Whenever sqlerror exit failure rollback
set serveroutput on size 1000000 lines 132 trimout on tab off pages 100


--drop table XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT;

create table XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT
(
  h_orig_system             VARCHAR2(240),
  h_receipt_method          VARCHAR2(240),
  h_receipt_number          VARCHAR2(240),
  h_currency_code           VARCHAR2(240),
  h_receipt_amount          VARCHAR2(240),
  h_receipt_date            VARCHAR2(240),
  h_gl_date                 VARCHAR2(240),
  h_customer_number         VARCHAR2(240),
  h_customer_location       VARCHAR2(240),
  h_comments                VARCHAR2(240),
  h_exchange_rate           VARCHAR2(240),
  h_exchange_rate_type      VARCHAR2(240),
  h_on_account_amount       VARCHAR2(240),
  h_on_account_applied_date VARCHAR2(240),
  batch_id                  NUMBER,
  record_id                 NUMBER,
  file_name                 VARCHAR2(2000),
  status                    VARCHAR2(10),
  last_update_login         NUMBER,
  last_updated_by           NUMBER,
  last_update_date          DATE,
  creation_date             DATE,
  created_by                NUMBER,
  h_organization_name       VARCHAR2(200),
  receipt_method_id_tv      NUMBER,
  cust_account_id_tv        NUMBER,
  site_use_id_tv            NUMBER,
  dest_org_id_tv            NUMBER,
  x_cash_receipt_id         NUMBER
);
-- Add comments to the table 
comment on table XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT
  is '$Header: xxctq/patch/115/sql/XXCTQ_RECEPT_C_AR_RECEIPT_v.sql 1.1 26-AUG-2014 13:42:13 CCBIZB $';
-- Create/Recreate indexes 
create index XXCTQ.RECEPT_C_AR_RECEIPT_N01 on XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT (RECORD_ID)
  tablespace APPS_TS_TX_DATA ;
create index XXCTQ.RECEPT_C_AR_RECEIPT_N02 on XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT (BATCH_ID)
  tablespace APPS_TS_TX_DATA ;
create index XXCTQ.XXCTQ_RECEPT_C_AR_RE_N3 on XXCTQ.XXCTQ_RECEPT_C_AR_RECEIPT (BATCH_ID, LAST_UPDATE_DATE)
  tablespace APPS_TS_TX_DATA ;
exec apps.xx_pk_grant.p_apps_grant('XXCTQ_RECEPT_C_AR_RECEIPT');
/