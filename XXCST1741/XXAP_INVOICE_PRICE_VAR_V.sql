/*********************************************************
** Title:       XXAP_INVOICE_PRICE_VAR_V View
** File:        XXAP_INVOICE_PRICE_VAR_V.sql
** Description: This script creates a custom view on XXAP_INVOICE_PRICE_VAR_V, for use in XXCST1741.
** Parameters:  {None.}
** Run as:      APPS
** Keyword Tracking:
**   
**   $Header: xxcst/12.0.0/patch/115/sql/XXAP_INVOICE_PRICE_VAR_V.sql 1.5 14-JAN-2015 09:28:18 CCAZOQ $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.5 (COMPLETE)
**     Created:  14-JAN-2015 09:28:18      CCAZOQ (Archana Satpathy)
**       Defect 16415 -- Added AP_DISTRIBUTION_ID_ERV
**   
**   Revision 1.4 (COMPLETE)
**     Created:  14-JAN-2015 09:24:33      CCAZOQ (Archana Satpathy)
**       Defect 16415 -- Added AP_DISTRIBUTION_ID_ERV
**   
**   Revision 1.3 (COMPLETE)
**     Created:  05-JAN-2015 03:47:44      CCBAZR (None)
**       Defect 16080
**   
**   Revision 1.2 (COMPLETE)
**     Created:  31-DEC-2014 06:09:02      CCBAZR (None)
**       Defect 16080
**   
**   Revision 1.1 (COMPLETE)
**     Created:  31-DEC-2014 06:03:33      CCBAZR (None)
**       Defect 16080 
**   
**   Revision 1.0 (COMPLETE)
**     Created:  05-AUG-2014 05:57:33      C-APINGLE (Anand Pingle)
**       initial version
**   
**
** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 05-08-2014    Jaya Gupta          Initial Creation - CR11542
**                                   This Custom View is extension to Seeded View AP_INVOICE_PRICE_VAR_V
** 31-12-2014    Jaya Gupta          Defect 16080 - Removed 2 Cols extra added to Seeded View, corrected AP Dist Id
**14-Jan-2014                        Defect 16415 -- Added AP_DISTRIBUTION_ID_ERV
********************************************************/
SET serveroutput ON size 1000000 lines 132 trimout ON tab OFF pages 100
whenever sqlerror EXIT failure ROLLBACK
CREATE OR REPLACE FORCE VIEW "APPS"."XXAP_INVOICE_PRICE_VAR_V" ("INVOICE_NUM", "INVOICE_ID", "INVOICE_DATE", "INVOICE_RATE",
"INVOICE_AMOUNT", "INVOICE_BASE_AMOUNT", "INVOICE_CURRENCY", "LINE_TYPE", "LINE_AMOUNT", "QUANTITY_INVOICED", "INVOICE_PRICE",
"AP_DISTRIBUTION_ID", "AP_DISTRIBUTION_ID_ERV", "ORG_ID", "PO_DISTRIBUTION_ID", "RCV_TRANSACTION_ID", "ACCOUNTING_DATE", "PRICE_VAR", "BASE_PRICE_VAR",
"EXCH_RATE_VAR", "TAX_RATE_VAR", "BASE_TAX_RATE_VAR") AS 
  SELECT   ai.invoice_num                     Invoice_Num
,        ai.invoice_id                      Invoice_Id
,        ai.invoice_date                    Invoice_Date
,        ai.exchange_rate                   Invoice_Rate
,        ai.invoice_amount                  Invoice_Amount
,        ai.base_amount                     Invoice_Base_Amount
,        ai.invoice_currency_code           Invoice_Currency
,        aid.line_type_lookup_code           Line_Type
,        aid.amount                          Line_Amount
,        aid.quantity_invoiced               Quantity_Invoiced
,        AID.UNIT_PRICE                      INVOICE_PRICE
--,        nvl(AIDIPV.INVOICE_DISTRIBUTION_ID,AIDERV.INVOICE_DISTRIBUTION_ID)         AP_DISTRIBUTION_ID  -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
,        AIDIPV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
,        AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415 
,        ai.org_id  org_id
,        aid.po_distribution_id              Po_Distribution_Id
,        aid.Rcv_Transaction_Id              Rcv_Transaction_Id
,        aid.Accounting_Date                 Accounting_Date
,        nvl(aidipv.amount,0)                Price_Var
,        nvl(aidipv.base_amount,0)           Base_Price_Var
,        nvl(aiderv.base_amount,0)           Exch_Rate_Var
,        NULL                                Tax_Rate_Var
,        NULL                                Base_Tax_Rate_Var
FROM     ap_invoices_all                  ai
,        ap_invoice_distributions_all     aid
,        ap_invoice_distributions_all     aidipv
,        ap_invoice_distributions_all     aiderv
WHERE    ai.invoice_id = aid.invoice_id
AND      aidipv.posted_flag(+)  = 'Y'
AND      aiderv.posted_flag(+)  = 'Y'
AND      aid.line_type_lookup_code IN ( 'ITEM' , 'ACCRUAL','RETROEXPENSE','RETROACCRUAL' )
AND      aidipv.related_id(+) = aid.invoice_distribution_id
AND      aidipv.corrected_invoice_dist_id IS NULL
AND      aidipv.line_type_lookup_code(+) = 'IPV'
AND      aiderv.related_id(+) = aid.invoice_distribution_id
AND      aiderv.line_type_lookup_code(+) = 'ERV'
AND      aiderv.corrected_invoice_dist_id IS NULL
AND      (aiderv.base_amount is not null or aidipv.amount is not null )
UNION ALL
/* Item line variances on corrections/adjustment corrections */
SELECT   ai.invoice_num                     Invoice_Num
,        ai.invoice_id                      Invoice_Id
,        ai.invoice_date                    Invoice_Date
,        ai.exchange_rate                   Invoice_Rate
,        ai.invoice_amount                  Invoice_Amount
,        ai.base_amount                     Invoice_Base_Amount
,        ai.invoice_currency_code           Invoice_Currency
,        aid.line_type_lookup_code           Line_Type
,        aid.amount                          Line_Amount
,        nvl(aidipv.corrected_quantity,aidipv.quantity_invoiced) Quantity_Invoiced
,        AIDIPV.UNIT_PRICE                   INVOICE_PRICE
--,        nvl(AIDIPV.INVOICE_DISTRIBUTION_ID,AIDERV.INVOICE_DISTRIBUTION_ID)         AP_DISTRIBUTION_ID  -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
,        AIDIPV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
,        AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415
,        ai.org_id  org_id
,        aid.po_distribution_id              Po_Distribution_Id
,        aid.Rcv_Transaction_Id              Rcv_Transaction_Id
,        aid.Accounting_Date                 Accounting_Date
,        nvl(aidipv.amount,0)                Price_Var
,        nvl(aidipv.base_amount,0)           Base_Price_Var
,        nvl(aiderv.base_amount,0)           Exch_Rate_Var
,        NULL                                Tax_Rate_Var
,        NULL                                Base_Tax_Rate_Var
FROM     ap_invoices_all                  ai
,        ap_invoice_distributions_all     aid
,        ap_invoice_distributions_all     aidipv
,        ap_invoice_distributions_all     aiderv
WHERE    ai.invoice_id = aidipv.invoice_id
AND      aidipv.posted_flag            = 'Y'
AND      aiderv.posted_flag(+)            = 'Y'
/* IPV line type is included for adjustment corrections */
AND      aid.line_type_lookup_code IN ( 'ITEM' ,'ACCRUAL','RETROEXPENSE','RETROACCRUAL','IPV')
AND      aidipv.corrected_invoice_dist_id = aid.invoice_distribution_id
AND      aidipv.line_type_lookup_code in ('IPV')
AND      aiderv.related_id(+) = aidipv.invoice_distribution_id
AND      aiderv.line_type_lookup_code(+) = 'ERV'
AND      (aiderv.base_amount is not null or aidipv.amount is not null)
UNION ALL
/* Tax variances on base match invoices/price adjustments
   with NONREC tax as leading distribution*/
SELECT   ai.invoice_num                     Invoice_Num
,        ai.invoice_id                      Invoice_Id
,        ai.invoice_date                    Invoice_Date
,        ai.exchange_rate                   Invoice_Rate
,        ai.Invoice_Amount                  Invoice_Amount
,        ai.base_amount                     Invoice_Base_Amount
,        ai.Invoice_Currency_code           Invoice_Currency
,        aid.line_type_lookup_code           Line_Type
,        aid.amount                          Line_Amount
,        NULL                                Quantity_Invoiced
,        NULL                                INVOICE_PRICE
--,        nvl(AIDIPV.INVOICE_DISTRIBUTION_ID,AIDERV.INVOICE_DISTRIBUTION_ID)         AP_DISTRIBUTION_ID  -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
,        AIDIPV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
,        AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415
,        ai.org_id   org_id
,        aid.Po_Distribution_Id              Po_Distribution_Id
,        aid.Rcv_Transaction_Id              Rcv_Transaction_Id
,        aid.Accounting_Date                 Accounting_Date
,        nvl(aidipv.amount,0)                Price_Var
,        nvl(aidipv.base_amount,0)           Base_Price_Var
,        nvl(aiderv.base_amount,0)           Exch_Rate_Var
,        nvl(aidtrv.amount,0)                Tax_Rate_Var
,        nvl(aidtrv.base_amount,0)           Base_Tax_Rate_Var
FROM     ap_invoices_all                  ai
,        ap_invoice_distributions_all     aid
,        ap_invoice_distributions_all     aidipv
,        ap_invoice_distributions_all     aiderv
,        ap_invoice_distributions_all     aidtrv
WHERE    ai.invoice_id = aid.invoice_id
AND      aidipv.posted_flag(+)  = 'Y'
AND      aiderv.posted_flag(+)  = 'Y'
AND      aidtrv.posted_flag(+)  = 'Y'
AND      aid.line_type_lookup_code in ( 'NONREC_TAX' )
AND      aidipv.related_id(+) = aid.invoice_distribution_id
AND      aidipv.line_type_lookup_code(+) = 'TIPV'
AND      aidipv.corrected_invoice_dist_id IS NULL
AND      aiderv.related_id(+) = aid.invoice_distribution_id
AND      aiderv.line_type_lookup_code(+) = 'TERV'
AND      aiderv.corrected_invoice_dist_id IS NULL
AND      aidtrv.related_id(+) = aid.invoice_distribution_id
AND      aidtrv.line_type_lookup_code(+) = 'TRV'
AND      aidtrv.corrected_invoice_dist_id IS NULL
AND      (aiderv.base_amount is not null or aidipv.amount is not null or aidtrv.amount is not null)
UNION ALL
/* Tax variances on base match invoices/price adjustments
   without NONREC and TRV as leading tax distribution*/
SELECT   ai.invoice_num                     Invoice_Num
,        ai.invoice_id                      Invoice_Id
,        ai.invoice_date                    Invoice_Date
,        ai.exchange_rate                   Invoice_Rate
,        ai.Invoice_Amount                  Invoice_Amount
,        ai.base_amount                     Invoice_Base_Amount
,        ai.Invoice_Currency_code           Invoice_Currency
,        'NONREC_TAX'                        Line_Type
,         0                                  Line_Amount
,        NULL                                Quantity_Invoiced
,        NULL                                INVOICE_PRICE
--,        nvl(AIDIPV.INVOICE_DISTRIBUTION_ID,AIDERV.INVOICE_DISTRIBUTION_ID)         AP_DISTRIBUTION_ID  -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
,        AIDIPV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
,        AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415
,        ai.org_id   org_id
,        aid.Po_Distribution_Id              Po_Distribution_Id
,        aid.Rcv_Transaction_Id              Rcv_Transaction_Id
,        aid.Accounting_Date                 Accounting_Date
,        nvl(aidipv.amount,0)                Price_Var
,        nvl(aidipv.base_amount,0)           Base_Price_Var
,        nvl(aiderv.base_amount,0)           Exch_Rate_Var
,        nvl(aid.amount,0)                   Tax_Rate_Var
,        nvl(aid.base_amount,0)              Base_Tax_Rate_Var
FROM     ap_invoices_all                  ai
,        ap_invoice_distributions_all     aid
,        ap_invoice_distributions_all     aidipv
,        ap_invoice_distributions_all     aiderv
WHERE    ai.invoice_id = aid.invoice_id
AND      aidipv.posted_flag(+)  = 'Y'
AND      aiderv.posted_flag(+)  = 'Y'
AND      aid.posted_flag(+)  = 'Y'
AND      (aid.line_type_lookup_code in ('TRV')
          and aid.corrected_invoice_dist_id IS NULL
	  and (aid.related_id IS NULL
	       or aid.related_id = aid.invoice_distribution_id))
AND      aidipv.related_id(+) = aid.invoice_distribution_id
AND      aidipv.line_type_lookup_code(+) = 'TIPV'
AND      aidipv.corrected_invoice_dist_id IS NULL
AND      aiderv.related_id(+) = aid.invoice_distribution_id
AND      aiderv.line_type_lookup_code(+) = 'TERV'
AND      aiderv.corrected_invoice_dist_id IS NULL
AND      (aiderv.base_amount is not null or aidipv.amount is not null or aid.amount is not null)
UNION ALL
/* Tax variances on base match invoices/price adjustments
   without NONREC and TIPV as leading tax distribution*/
SELECT   ai.invoice_num                     Invoice_Num
,        ai.invoice_id                      Invoice_Id
,        ai.invoice_date                    Invoice_Date
,        ai.exchange_rate                   Invoice_Rate
,        ai.Invoice_Amount                  Invoice_Amount
,        ai.base_amount                     Invoice_Base_Amount
,        ai.Invoice_Currency_code           Invoice_Currency
,        'NONREC_TAX'                        Line_Type
,        0                                   Line_Amount
,        NULL                                Quantity_Invoiced
,        NULL                                INVOICE_PRICE
--,        nvl(aidtrv.INVOICE_DISTRIBUTION_ID,aiderv.INVOICE_DISTRIBUTION_ID)         AP_DISTRIBUTION_ID  -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
,        AIDTRV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
,        AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415
,        ai.org_id  org_id
,        aid.Po_Distribution_Id              Po_Distribution_Id
,        aid.Rcv_Transaction_Id              Rcv_Transaction_Id
,        aid.Accounting_Date                 Accounting_Date
,        nvl(aid.amount,0)                   Price_Var
,        nvl(aid.base_amount,0)              Base_Price_Var
,        nvl(aiderv.base_amount,0)           Exch_Rate_Var
,        nvl(aidtrv.amount,0)                Tax_Rate_Var
,        nvl(aidtrv.base_amount,0)           Base_Tax_Rate_Var
FROM     ap_invoices_all                  ai
,        ap_invoice_distributions_all     aid
,        ap_invoice_distributions_all     aidtrv
,        ap_invoice_distributions_all     aiderv
WHERE    ai.invoice_id = aid.invoice_id
AND      aid.posted_flag(+)  = 'Y'
AND      aiderv.posted_flag(+) = 'Y'
AND      aidtrv.posted_flag(+)  = 'Y'
AND      (aid.line_type_lookup_code in ('TIPV')
          and aid.corrected_invoice_dist_id IS NULL
	  and (aid.related_id IS NULL
	       or aid.related_id = aid.invoice_distribution_id))
AND      aidtrv.related_id(+) = aid.invoice_distribution_id
AND      aidtrv.line_type_lookup_code(+) = 'TRV'
AND      aidtrv.corrected_invoice_dist_id IS NULL
AND      aiderv.related_id(+) = aid.invoice_distribution_id
AND      aiderv.line_type_lookup_code(+) = 'TERV'
AND      aiderv.corrected_invoice_dist_id IS NULL
AND      (aiderv.base_amount is not null or aid.amount is not null or aidtrv.amount is not null)
UNION ALL
/* Tax variances on corrections and TIPV is leading tax distribution
   /adjustment corrections*/
SELECT   ai.invoice_num                     Invoice_Num
,        ai.invoice_id                      Invoice_Id
,        ai.invoice_date                    Invoice_Date
,        ai.exchange_rate                   Invoice_Rate
,        ai.Invoice_Amount                  Invoice_Amount
,        ai.base_amount                     Invoice_Base_Amount
,        ai.Invoice_Currency_code           Invoice_Currency
,        (CASE
          WHEN (aid.line_type_lookup_code ='NONREC_TAX'
                or
                (aid.line_type_lookup_code ='TIPV' and
           NVL(aidipv.dist_match_type,' ') =
              'ADJUSTMENT_CORRECTION')) THEN
                    aid.line_type_lookup_code
           ELSE
          'NONREC_TAX'
              END)                           Line_Type
,        (CASE
          WHEN (aid.line_type_lookup_code ='NONREC_TAX'
                or
                (aid.line_type_lookup_code ='TIPV' and
           NVL(aidipv.dist_match_type,' ') =
                   'ADJUSTMENT_CORRECTION')) THEN
                    aid.amount
          ELSE
          0
             END)                            Line_Amount
,        NULL                                Quantity_Invoiced
,        NULL                                INVOICE_PRICE
--,        nvl(aidipv.invoice_distribution_id,aiderv.invoice_distribution_id)        AP_DISTRIBUTION_ID  -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
,        AIDIPV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
,        AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415
,        ai.org_id  org_id
,        aid.Po_Distribution_Id              Po_Distribution_Id
,        aid.Rcv_Transaction_Id              Rcv_Transaction_Id
,        aid.Accounting_Date                 Accounting_Date
,        nvl(aidipv.amount,0)                Price_Var
,        nvl(aidipv.base_amount,0)           Base_Price_Var
,        nvl(aiderv.base_amount,0)           Exch_Rate_Var
,        NVL(AIDTRV.AMOUNT,0)                TAX_RATE_VAR
,        nvl(aidtrv.base_amount,0)           Base_Tax_Rate_Var
FROM     ap_invoices_all                  ai
,        ap_invoice_distributions_all     aidipv
,        ap_invoice_distributions_all     aiderv
,        ap_invoice_distributions_all     aidtrv
,        ZX_REC_NREC_DIST                 zd
,        ap_invoice_distributions_all     aid
WHERE    ai.invoice_id = aidipv.invoice_id
AND      aidipv.posted_flag     = 'Y'
AND      aiderv.posted_flag(+)  = 'Y'
AND      aidtrv.posted_flag(+)  = 'Y'
AND      aidipv.line_type_lookup_code = 'TIPV'
AND      aidipv.corrected_invoice_dist_id IS NOT NULL
AND      aiderv.related_id(+) = aidipv.invoice_distribution_id
AND      aiderv.line_type_lookup_code(+) = 'TERV'
AND      aidtrv.related_id(+) = aidipv.invoice_distribution_id
AND      aidtrv.line_type_lookup_code(+) = 'TRV'
AND     (
          /* Price corrections case - Base invoice can have
       NONREC/TRV/TIPV as main tax distribution */
         ((aidipv.invoice_distribution_id=aidipv.related_id
               or aidipv.related_id is null)
          and aidipv.detail_tax_dist_id = zd.rec_nrec_tax_dist_id
          and zd.adjusted_doc_tax_dist_id = aid.detail_tax_dist_id
          and aid.line_type_lookup_code in ('NONREC_TAX', 'TRV','TIPV')
          and (aid.related_id IS NULL or
               aid.related_id=aid.invoice_distribution_id))
          OR /* Adjustments corrections case */
         (NVL(aidipv.dist_match_type,' ') = 'ADJUSTMENT_CORRECTION'
    and aidipv.corrected_invoice_dist_id = aid.invoice_distribution_id
    and zd.rec_nrec_tax_dist_id = aid.detail_tax_dist_id
    and zd.rec_nrec_tax_dist_id = aidipv.detail_tax_dist_id
    and aid.line_type_lookup_code in ('TIPV'))
         )
AND      (aiderv.base_amount is not null or aidipv.amount is not null or aidtrv.amount is not null)
UNION ALL
/* Tax variances on corrections and TRV is leading tax distribution */
SELECT ai.invoice_num Invoice_Num,
       ai.invoice_id Invoice_Id,
       ai.invoice_date Invoice_Date,
       ai.exchange_rate Invoice_Rate,
       ai.Invoice_Amount Invoice_Amount,
       ai.base_amount Invoice_Base_Amount,
       ai.Invoice_Currency_code Invoice_Currency,
       'NONREC_TAX'Line_Type,
       (CASE
         WHEN (aid.line_type_lookup_code = 'NONREC_TAX') THEN
              aid.amount
         ELSE
          0
       END) Line_Amount,
       NULL Quantity_Invoiced,
       NULL INVOICE_PRICE
      -- nvl(aidipv.invoice_distribution_id,aiderv.invoice_distribution_id) AP_DISTRIBUTION_ID , -- extra Col added to Seeded View AP_INVOICE_PRICE_VAR_V
      ,AIDIPV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID  --Defect 16415 
       , AIDERV.INVOICE_DISTRIBUTION_ID      AP_DISTRIBUTION_ID_ERV --Defect 16415
       ,ai.org_id ORG_ID,
       aid.Po_Distribution_Id Po_Distribution_Id,
       aid.Rcv_Transaction_Id Rcv_Transaction_Id,
       aid.Accounting_Date Accounting_Date,
       nvl(aidipv.amount, 0) Price_Var,
       nvl(aidipv.base_amount, 0) Base_Price_Var,
       nvl(aiderv.base_amount, 0) Exch_Rate_Var,
       nvl(aidtrv.amount, 0) Tax_Rate_Var,
       NVL(AIDTRV.BASE_AMOUNT, 0) BASE_TAX_RATE_VAR
  FROM ap_invoices_all              ai,
       ap_invoice_distributions_all aidipv,
       ap_invoice_distributions_all aiderv,
       ap_invoice_distributions_all aidtrv,
       ZX_REC_NREC_DIST             zd,
       ap_invoice_distributions_all aid
 WHERE ai.invoice_id = aidipv.invoice_id
   AND aidipv.posted_flag = 'Y'
   AND aiderv.posted_flag(+) = 'Y'
   AND aidtrv.posted_flag(+) = 'Y'
   AND aidtrv.line_type_lookup_code = 'TRV'
   AND aidtrv.corrected_invoice_dist_id IS NOT NULL
   AND (aidtrv.related_id = aidtrv.invoice_distribution_id or
       aidtrv.related_id is null)
   AND aidipv.line_type_lookup_code = 'TIPV'
   AND aidipv.related_id = aidtrv.invoice_distribution_id
   AND aidipv.corrected_invoice_dist_id IS NOT NULL
   AND aiderv.related_id(+) = aidtrv.invoice_distribution_id
   AND aiderv.line_type_lookup_code(+) = 'TERV'
   AND /* Price corrections case - Base invoice can have
             NONREC/TRV/TIPV as leading tax distribution */
       (aidipv.detail_tax_dist_id = zd.rec_nrec_tax_dist_id and
       zd.adjusted_doc_tax_dist_id = aid.detail_tax_dist_id and
       aid.line_type_lookup_code in ('NONREC_TAX', 'TRV', 'TIPV') and
       (aid.related_id IS NULL or
       aid.related_id = aid.invoice_distribution_id))
   AND (AIDERV.BASE_AMOUNT IS NOT NULL OR AIDIPV.AMOUNT IS NOT NULL OR
       aidtrv.amount is not null)
WITH read only;
/
