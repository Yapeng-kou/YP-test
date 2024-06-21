/*******************************************************************************
   ** Title:       XXAP_GRNI_GTT
   ** File:        XXAP_GRNI_GTT.sql
   ** Description: Global Temporary table for temporarily storing data
   ** Parameters:  Default
   ** Run as:      XXAP
   ** Keyword Tracking:
   **   
   **   $Header: xxap/12.0.0/patch/115/sql/XXAP_GRNI_GTT.sql 1.7 29-MAY-2019 10:33:42 CCCGCW $
   **   $Change History$ (*ALL VERSIONS*)
   **   Revision 1.7 (COMPLETE)
   **     Created:  29-MAY-2019 10:33:42      CCCGCW (Harshil Shah)
   **       Added new column TRANE_REF_NUMBER for CR8035
   **   
   **   Revision 1.6 (COMPLETE)
   **     Created:  11-APR-2019 12:40:34      CCBNLW (Raju Patel)
   **       CR#8035
   **   
   **   Revision 1.5 (COMPLETE)
   **     Created:  11-APR-2019 11:25:18      CCBNLW (Raju Patel)
   **       CR#8035
   **   
   **   Revision 1.4 (COMPLETE)
   **     Created:  10-APR-2019 14:56:13      CCBNLW (Raju Patel)
   **       CR#8035-Multiple Changes
   **   
   **   Revision 1.2 (COMPLETE)
   **     Created:  15-MAY-2018 05:23:52      CCBWIL (Soniya Doshi)
   **       defect number 26916/ RT 7682244 
   **   
   **   Revision 1.1 (COMPLETE)
   **     Created:  14-MAR-2017 02:38:40      CCBWIL (Soniya Doshi)
   **       Intial version
   **   
   **   Revision 1.0 (COMPLETE)
   **     Created:  02-MAR-2017 06:08:31      CCCZAO (Sourav Bera)
   **       Initial revision.
   **   	
   ** History:
   ** Date          Who                		Description
   ** -----------   ------------------ 		-----------------------------------------------------------------
   ** 11-Feb-2019   c-stondon			   Initial Version
   ** 28-May-2019   Harshil Shah		   Added columns for CR8035 from OPERATING_UNIT till TRANE_REF_NUMBER
   ***********************************************************************************************************/
Whenever sqlerror exit failure rollback;
   
DROP TABLE xxap_grni_gtt CASCADE CONSTRAINTS;

CREATE GLOBAL TEMPORARY TABLE XXAP_GRNI_GTT
( PO_NUMBER                 VARCHAR2(50),
  FOB                       VARCHAR2(25),
  REQ_REQUESTOR             VARCHAR2(240),
  INV_MATCH_OPTION          VARCHAR2(25),
  BUYER_NAME                VARCHAR2(240),
  INVOICE_MATCH_APP         VARCHAR2(240),
  REQ_NUM                   VARCHAR2(25),
  REQ_DATE                  DATE,
  PO_DOC_TYPE               VARCHAR2(25),
  PO_RELEASE_NUMBER         NUMBER,
  PO_HEADER_ID              NUMBER,
  PO_LINE_ID                NUMBER,
  PO_DISTRIBUTION_ID        NUMBER,
  LINE_TYPE                 VARCHAR2(25),
  LINE_NUM                  VARCHAR2(240),
  ITEM_NAME                 VARCHAR2(40),
  CATEGORY                  VARCHAR2(696),
  ITEM_DESCRIPTION          VARCHAR2(240),
  TRANSACTION_ID            NUMBER,
  VENDOR_NAME               VARCHAR2(240),
  VENDOR_NUM                VARCHAR2(30),
  VENDOR_TYPE               VARCHAR2(30),
  VENDOR_SITE_NAME          VARCHAR2(60),
  TRANSACTION_TYPE          VARCHAR2(80),
  TRANSACTION_DATE          DATE,
  ORDERED_QUANTITY          NUMBER,
  QUANTITY_CANCELLED        NUMBER,
  UOM                       VARCHAR2(25),
  QUANTITY_DELIVERED        NUMBER,
  RECEIPT_NUM               VARCHAR2(30),
  EXPENDITURE_TYPE          VARCHAR2(30),
  INVOICE_NUM               VARCHAR2(50),
  INVOICE_LINE_NUM          NUMBER,
  IPV                       NUMBER,
  ENTERED_AMOUNT            NUMBER,
  CURRENCY_CODE             VARCHAR2(15),
  CURRENCY_CONVERSION_RATE  NUMBER,
  TRANSACTION_TYPE_CODE     VARCHAR2(40),
  INVOICE_DISTRIBUTION_ID   NUMBER,
  TRANSACTION_SOURCE        VARCHAR2(3),
  ORG                       VARCHAR2(240),
  ORACLE_AGING_DATE         DATE,
  AGING_DAYS                NUMBER,
  AGE_BUCKET_NON_ZERO       VARCHAR2(20),
  ACCRUAL_CURRENCY_CODE     VARCHAR2(15),
  SHIPMENT_NUMBER           NUMBER,
  UOM_CODE                  VARCHAR2(25),
  DISTRIBUTION_NUM          NUMBER,
  QUANTITY_RECEIVED         NUMBER,
  QUANTITY_BILLED           NUMBER,
  TRX_QTY                   NUMBER,
  FUNCT_AMT                 NUMBER,
  RCV_TRANSACTION_ID        NUMBER,
  TRANSFER_TRANSACTION_ID   NUMBER,
  PACKING_SLIP              VARCHAR2(25),
  ACCRUAL_ACCOUNT           VARCHAR2(200),
  PPV1                      NUMBER,
  PPV2                      NUMBER,
  PO_UNIT_PRICE             NUMBER,
  PO_CURRENCY_CODE          VARCHAR2(15),
  FUNC_UNIT_PRICE           NUMBER,
  CHARGE_ACCOUNT            VARCHAR2(207),
  PO_DATE                   DATE,
  RECEIPT_DATE              DATE, 
  OPERATING_UNIT			VARCHAR2(240),
  BILL_QTY_GREATER_THAN_RECV_QTY	VARCHAR2(50),
  ORDERED_DELIVERED_MATCH	VARCHAR2(3),
  DELIVERED_BILLED_MATCH	VARCHAR2(3),
  ENTITY					VARCHAR2(25),
  LOCATION					VARCHAR2(25),
  LOCATION_NAME				VARCHAR2(240),  
  COST_CENTER				VARCHAR2(25),
  ACCOUNT					VARCHAR2(25),
  PRODUCT					VARCHAR2(25),
  INTERCOMPANY				VARCHAR2(25),
  FUTURE_1					VARCHAR2(25),
  FUTURE_2					VARCHAR2(25),
  PO_CLOSURE_STATUS			VARCHAR2(50),
  PO_LAST_TRX_DATE			DATE,
  LAST_TRX_DATE_AGE_BUCKET	VARCHAR2(50),
  PO_CLOSED_STATUS			VARCHAR2(50),
  RCV_SHIPMENT_NUM			VARCHAR2(30),
  BILL_OF_LADING            VARCHAR2(25),
  SHIPPED_DATE				DATE,
  FREIGHT_CARRIER_CODE		VARCHAR2(25),
  WAYBILL_AIRBILL_NUM       VARCHAR2(30),
  TRANE_REF_NUMBER			VARCHAR2(20)
) ON COMMIT PRESERVE ROWS;

exec apps.xx_pk_grant.p_apps_grant('XXAP_GRNI_GTT');

comment on table XXAP_GRNI_GTT is
  '$Header: xxap/12.0.0/patch/115/sql/XXAP_GRNI_GTT.sql 1.7 29-MAY-2019 10:33:42 CCCGCW$';
/