SET SERVEROUTPUT ON SIZE 1000000 LINES 132 TRIMOUT ON TAB OFF PAGES 100;

WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

CREATE OR REPLACE PACKAGE xxpa_equip_order_in_pkg AUTHID DEFINER 
IS
  /******************************************************************************
  *                           - COPYRIGHT NOTICE -                              *
  *******************************************************************************
  ** Title            :        XXPA2592
  ** File             :        XXPA_EQUIP_ORDER_IN_PKG.pks
  ** Description      :        Package to perform Orchestration in Oracle R12
  **                           for SPECTRUM LA Orders (Project/Non-project SO)
  ** Parameters       :        {None}
  ** Run as           :        APPS
  ** 12_2_compliant   :        YES
  ** Keyword Tracking :
  **   
  **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_equip_order_in_pkg.pks 1.9.0.5 19-JUL-2023 14:44:49 U105471 $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.9.0.5 (COMPLETE)
  **     Created:  19-JUL-2023 14:44:49      U105471 (Jai ShankarKumar)
  **       CR25098 - Enhance this Integration for NEOCRM_CN Partner - Pre UAT
  **       Changes
  **   
  **   Revision 1.9.0.4 (COMPLETE)
  **     Created:  03-JUL-2023 06:50:37      U105471 (Jai ShankarKumar)
  **       CR25098 - Enhance this Integration for NEOCRM_CN Partner - Post SIT
  **       Changes
  **   
  **   Revision 1.9.0.3 (COMPLETE)
  **     Created:  16-MAY-2023 11:49:27      U105471 (Jai ShankarKumar)
  **       CR25098 - Enhance this Integration for NEOCRM_CN Partner - SIT
  **       Changes
  **   
  **   Revision 1.9.0.2 (COMPLETE)
  **     Created:  13-APR-2023 15:42:59      U105471 (Jai ShankarKumar)
  **       CR25098 - Enhance this Integration for NEOCRM_CN Partner
  **   
  **   Revision 1.9.0.1.1.0 (COMPLETE)
  **     Created:  31-JAN-2020 12:59:13      CCBPNA (Jyotsana Kandpal)
  **       MEA S&S CR24421 - Bolt-on to not populate the Virtual Sales
  **       location for specific OUs
  **   
  **   Revision 1.9.0.1 (COMPLETE)
  **     Created:  10-OCT-2019 16:51:20      CCBSSJ (Vishnusimman Manivannan)
  **       CR24287 - Update Bolton to pass collector account to XXONT1239
  **   
  **   Revision 1.8 (COMPLETE)
  **     Created:  21-AUG-2019 19:24:06      CCBSSJ (Vishnusimman Manivannan)
  **       HPQC30256  - Incorrect Event Number sequence for Prepayment Invoice
  **       Events
  **   
  **   Revision 1.7 (COMPLETE)
  **     Created:  26-JUL-2019 21:20:00      CCBSSJ (Vishnusimman Manivannan)
  **       CR24082 - Create Billing/Revenue events for SPECTRUM_MEA
  **       CR24100 - Bolton to support multi project structure
  **       CR23103 - Bolton to populate sales commission on billing lines when
  **       applicable
  **       CR24104 - Creation of projects only through Spectrum-Bolton
  **       integration
  **       CR24105 - Supporting new process for milestone billing
  **   
  **   Revision 1.6 (COMPLETE)
  **     Created:  08-AUG-2018 13:37:48      CCBSSJ (Vishnusimman Manivannan)
  **       Merged 1.4 and 1.5 version
  **   
  **   Revision 1.5 (COMPLETE)
  **     Created:  28-APR-2018 13:35:37      IRGLQI (Prakash Kammula)
  **       CR22497: XXONT1239 V2.0 event name change
  **   
  **   Revision 1.4 (COMPLETE)
  **     Created:  07-NOV-2017 03:09:44      CCBSSJ (Vishnusimman Manivannan)
  **       CR23783 - Add customer validation to warehouse/OU default logic
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  06-JUL-2017 10:12:59      CCBUUN (Joydeb Saha)
  **       Moved branch (1.2.0.1) to Trunk version (1.3)
  **   
  **   Revision 1.2.0.1 (COMPLETE)
  **     Created:  18-JAN-2017 08:34:24      CCBUUN (Joydeb Saha)
  **       Phase 4A - CR23505 - HPQC#24280 - Code Changes
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  08-NOV-2016 06:50:25      CCBUUN (Joydeb Saha)
  **       RT#6859721 : Code modified to reduce logging.
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  26-OCT-2016 11:25:32      CCBSSJ (Vishnusimman Manivannan)
  **       CR23505 - Addition of New Partner SPECRTUM_AP
  **   
  **   Revision 1.0.10 (COMPLETE)
  **     Created:  27-APR-2016 08:42:50      CCBSSJ (Vishnusimman Manivannan)
  **       CR22563 - XXPA2592 - Phase 3B W3 Added Concurrent Program
  **       Submission as part of SMOKE Test Issues
  **   
  **   Revision 1.0.9 (COMPLETE)
  **     Created:  21-MAR-2016 15:42:34      CCBSSJ (Vishnusimman Manivannan)
  **       Changes for HPQC21314, HPQC21376 and CR23274 XXONT3030 ( XXPA2592 -
  **       Phase 3B W3)
  **   
  **   Revision 1.0.8 (COMPLETE)
  **     Created:  05-MAR-2016 23:21:35      CCBSSJ (Vishnusimman Manivannan)
  **       XXPA2592 - XXONT3030 - Phase 3B W3- Added Report Clob data for
  **       CR23274
  **   
  **   Revision 1.0.7 (COMPLETE)
  **     Created:  05-MAR-2016 23:16:21      CCBSSJ (Vishnusimman Manivannan)
  **       CR22563 - XXPA2592 - Phase 3B W3 Ship method Validation and other
  **       SMOKE Test Issues
  **   
  **   Revision 1.0.6 (COMPLETE)
  **     Created:  04-JAN-2016 09:21:26      CCBSSJ (Vishnusimman Manivannan)
  **       Deliver to Address Change
  **   
  **   Revision 1.0.5 (COMPLETE)
  **     Created:  17-DEC-2015 08:51:55      CCBSSJ (Vishnusimman Manivannan)
  **       HPQC Defect 20664 - XXPA2592 - INT3 Phase3B W3 - Deliver Address
  **       Change
  **   
  **   Revision 1.0.4 (COMPLETE)
  **     Created:  04-DEC-2015 00:23:13      CCBSSJ (Vishnusimman Manivannan)
  **       QC 20554 - Fix for removing Deliver to and Ship to address creation
  **       in XXPA2592 - Phase 3B W3
  **   
  **   Revision 1.0.3 (COMPLETE)
  **     Created:  13-NOV-2015 05:20:22      CCBSSJ (Vishnusimman Manivannan)
  **       CR22926 , CR22928, CR22534 - XXPA2381 - Phase 3B W3 - Single
  **       Project Approach and Spectrum LA Project Order Orchestration
  **   
  **   Revision 1.0.2 (COMPLETE)
  **     Created:  29-OCT-2015 15:23:20      CCBSSJ (Vishnusimman Manivannan)
  **       Spectrum Project Order Orchestration CR22563 and CR22928 
  **   
  **   Revision 1.0.1 (COMPLETE)
  **     Created:  30-JUL-2015 09:11:17      CCBPNA (Jyotsana Kandpal)
  **       After multiple changes from Func Testing
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  22-JUN-2015 19:58:50      CCBSSJ (Vishnusimman Manivannan)
  **       Initial revision.
  **   
  ** History          :
  ** Date          Who                Description
  ** -----------   ------------------ ------------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ** 26-Oct-2016   Vishnusimman M     CR23505 Addition of New Partner SPECTRUM_AP*   
  ** 08-NOV-2016   Joydeb Saha		  RT#6859721: Modified debugging logic to log based on logging level.
  ** 								  This will help reducing the log file size in production.
  ** 18-Jan-2017   Joydeb Saha		  HPQC#24280: Drop the 'User Item Description' Mapping for Spectrum Model Number
  **								  for the Bolton Interface with Partner of Spectrum_AP. A new masking key value is introduced.
  ** 6-July-2017   Joydeb Saha		  Moved branch (1.2.0.1) to Trunk version (1.3)
  ** 30-Oct-2017   Vishnusimman M     CR23783 - Add customer validation to warehouse/OU default logic
  ** 06-May-2019   Vishnusimman M     CR24082 - Create Billing/Revenue events for SPECTRUM_MEA
  **                                  CR24100 - Bolton to support multi project structure
  **                                  CR23103 - Bolton to populate sales commission on billing lines when applicable
  **                                  CR24104 - Creation of projects only through Spectrum-Bolton integration
  **                                  CR24105 - Supporting new process for milestone billing
  ** 21-Aug-2019	Vishnusimman M    HPQC30256  - Incorrect Event Number sequence for Prepayment Invoice Events
  ** 10-Oct-2019    Vishnusimman M    CR24287 - Update Bolton to pass collector account to XXONT1239
  ** 31-Jan-2019   Jyotsana Kandpal   CR24421 - Bolt-on to not populate the Virtual Sales location for specific OUs
  ** 13-Apr-2023   Jai Shankar Kumar  CR25098 - Reuse this Integration for NeoCRM Partner                                                                
  *******************************************************************************/

  ---*********** Global Constants Declaration **************-----
  gc_key_type                 xxint_event_type_key_vals.key_type%TYPE := 'PARTNER';
  gc_enabled_keyname          xxint_event_type_key_vals.key_name%TYPE := 'ENABLED';
  gc_email_keyname            xxint_event_type_key_vals.key_name%TYPE := 'EMAIL_ADDRESS';
  gc_project_status_code      xxint_event_type_key_vals.key_name%TYPE := 'PROJECT_STATUS_CODE';
  -- CR25098 - Adding Variables - START
  gc_project_status_code_ic   xxint_event_type_key_vals.key_name%TYPE := 'PROJECT_STATUS_CODE_IC';
  gc_pop_proj_approval_dt     xxint_event_type_key_vals.key_name%TYPE := 'POPULATE_PROJ_APPROVAL_DT';
  gc_include_project_budget   xxint_event_type_key_vals.key_name%TYPE := 'INCLUDE_PROJECT_BUDGET';
  gc_deduce_order_ssd         xxint_event_type_key_vals.key_name%TYPE := 'DEDUCE_ORDER_SSD';
  gc_ncode_consolidation      xxint_event_type_key_vals.key_name%TYPE := 'NCODE_CONSOLIDATION';
  gc_default_pay_term         xxint_event_type_key_vals.key_name%TYPE := 'DEFAULT_PAYMENT_TERM';
  gc_create_bill_event_phase3 xxint_event_type_key_vals.key_name%TYPE := 'CREATE_BILL_EVENT_PHASE3';
  gc_error_notif_agr_owner    xxint_event_type_key_vals.key_name%TYPE := 'ERROR_NOTIF_AGR_OWNER';
  -- CR25098 - Adding Variables - END  
  gc_ncode_keyname            xxint_event_type_key_vals.key_name%TYPE := 'TASK_NCODES';
  gc_masking_keyname          xxint_event_type_key_vals.key_name%TYPE := 'PARTNER_SPECIFIC_MASKING';
  gc_operating_unit_code      xxint_event_type_key_vals.key_name%TYPE := 'OPERATING_UNIT_CODE'; --Added for HPQC 20664
  gc_sales_credit_type_code   xxint_event_type_key_vals.key_name%TYPE := 'SALES_CREDIT_TYPE'; --Added for HPQC 21314
  gc_event_type               xxint_event_types.event_type%TYPE := 'XXPA2592_EQUIP_ORDER_IN';
  gc_prj_cre_event_type       xxint_event_types.event_type%TYPE := 'XXPA2381_PROJECT_IN';
  gc_ord_cre_event_type       xxint_event_types.event_type%TYPE := 'XXONT1239_ORDER_IN';
  gc_prj_ev_event_type        xxint_event_types.event_type%TYPE := 'XXPA2672_BILLING_EVENTS_IN';
  gc_interface_name           VARCHAR2(30) := 'XXPA2592_EQUIP_ORDER_IN';
  gc_error                    VARCHAR2(100) := 'ERROR';
  gc_success                  VARCHAR2(100) := 'SUCCESS';
  gc_approved                 VARCHAR2(100) := 'APPROVED';
  gc_display_null_tags        NUMBER DEFAULT FND_PROFILE.VALUE('XXINT_XML_UTIL_NULL_BEHAVOR');
  gc_vsl_key_name             xxint_event_type_key_vals.key_name%TYPE := 'NO_VIRTUAL_SALES_LOC'; -- Added for CR24421

  gc_ship_instr_key_val       xxint_event_type_key_vals.key_name%TYPE := 'SHIPPING_INSTRUCTIONS'; --Added for CR23505
  gc_ord_hdr_ref_key_val      xxint_event_type_key_vals.key_value%TYPE := 'ORDER_HEADER_REFERENCE'; --Added for CR23505
  gc_ord_unique_key_val       xxint_event_type_key_vals.key_value%TYPE := 'ORDER_UNIQUE_IDENTIFIER'; --Added for CR23505
  gc_price_adj_key_val        xxint_event_type_key_vals.key_value%TYPE := 'PRICING_ADJUSTMENTS'; --Added for CR23505
  gc_Price_adj_reason_key_val xxint_event_type_key_vals.key_value%TYPE := 'CHANGE_REASON_TEXT'; --Added for CR23505
  gc_append_po_key_val        xxint_event_type_key_vals.key_value%TYPE := 'APPEND_CUST_PO_NUMBER'; --Added for CR23505

  gc_usr_item_desc_key_val    xxint_event_type_key_vals.key_value%TYPE := 'USER_ITEM_DESCRIPTION'; --Added by Joydeb as per HPQC#24280
  gc_create_events_key_val    xxint_event_type_key_vals.key_value%TYPE := 'CREATE_PROJECT_EVENT';
  gc_proj_event_guid_clob_code xxint_event_clobs.clob_code%type := 'G_PROJ_EVENT_GUID';
  
  ---************Start Record Type and Table Type Declaration***************---
   --Added for CR24105
   TYPE g_prj_att_rec is record(
    noteType varchar2(200),
    notes    long,
    entityName varchar2(200),
    seqNumber number,
    title varchar2(200),
    description varchar2(2000),
    agreement_num varchar2(200),
    project_num varchar2(200),
    task_num varchar2(200)
    );

  TYPE g_prj_att_t IS TABLE OF g_prj_att_rec INDEX BY BINARY_INTEGER;
  g_prj_att_tbl g_prj_att_t;
  --End of Added for CR24105
  
 --Added for CR24082, CR23103
  TYPE g_proj_event_data is record(
    P_PM_EVENT_REFERENCE       VARCHAR2(200),
    P_TASK_NUMBER              VARCHAR2(200),
    P_EVENT_NUMBER             VARCHAR2(200),
    P_EVENT_TYPE               VARCHAR2(200),
    P_AGREEMENT_NUMBER         VARCHAR2(200),
    P_AGREEMENT_TYPE           VARCHAR2(200),
    P_CUSTOMER_NUMBER          VARCHAR2(200),
    P_DESCRIPTION              VARCHAR2(200),
    P_BILL_HOLD_FLAG           VARCHAR2(200),
    P_COMPLETION_DATE          VARCHAR2(200),
    P_DESC_FLEX_NAME           VARCHAR2(200),
    P_ATTRIBUTE_CATEGORY       VARCHAR2(200),
    P_ATTRIBUTE1               VARCHAR2(200),
    P_ATTRIBUTE2               VARCHAR2(200),
    P_ATTRIBUTE3               VARCHAR2(200),
    P_ATTRIBUTE4               VARCHAR2(200),
    P_ATTRIBUTE5               VARCHAR2(200),
    P_ATTRIBUTE6               VARCHAR2(200),
    P_ATTRIBUTE7               VARCHAR2(200),
    P_ATTRIBUTE8               VARCHAR2(200),
    P_ATTRIBUTE9               VARCHAR2(200),
    P_ATTRIBUTE10              VARCHAR2(200),
    P_PROJECT_NUMBER           VARCHAR2(200),
    P_ORGANIZATION_NAME        VARCHAR2(200),
    P_INVENTORY_ORG_NAME       VARCHAR2(200),
    P_INVENTORY_ITEM_ID        VARCHAR2(200),
    P_QUANTITY_BILLED          VARCHAR2(200),
    P_UOM_CODE                 VARCHAR2(200),
    P_UNIT_PRICE               VARCHAR2(200),
    P_REFERENCE1               VARCHAR2(200),
    P_REFERENCE2               VARCHAR2(200),
    P_REFERENCE3               VARCHAR2(200),
    P_REFERENCE4               VARCHAR2(200),
    P_REFERENCE5               VARCHAR2(200),
    P_REFERENCE6               VARCHAR2(200),
    P_REFERENCE7               VARCHAR2(200),
    P_REFERENCE8               VARCHAR2(200),
    P_REFERENCE9               VARCHAR2(200),
    P_REFERENCE10              VARCHAR2(200),
    P_BILL_TRANS_CURRENCY_CODE VARCHAR2(200),
    P_BILL_TRANS_BILL_AMOUNT   NUMBEr,
    P_BILL_TRANS_REV_AMOUNT    NUMBER,
    P_PROJECT_RATE_TYPE        VARCHAR2(200),
    P_PROJECT_RATE_DATE        DATE,
    P_PROJECT_EXCHANGE_RATE    NUMBER,
    P_PROJFUNC_RATE_TYPE       VARCHAR2(200),
    P_PROJFUNC_RATE_DATE       DATE,
    P_PROJFUNC_EXCHANGE_RATE   NUMBER,
    P_FUNDING_RATE_TYPE        VARCHAR2(200),
    P_FUNDING_RATE_DATE        DATE,
    P_FUNDING_EXCHANGE_RATE    NUMBER,
    P_ADJUSTING_REVENUE_FLAG   VARCHAR2(200),
    P_EVENT_ID                 NUMBER,
    P_DELIVERABLE_ID           NUMBER,
    P_ACTION_ID                NUMBER,
    P_CONTEXT                  VARCHAR2(200),
    P_RECORD_VERSION_NUMBER    VARCHAR2(200),
    P_BILL_GROUP               VARCHAR2(200),
    P_REVENUE_HOLD_FLAG        VARCHAR2(200),
    P_HEADER_NOTES             VARCHAR2(200),
    P_SHIP_TO_CUSTOMER         VARCHAR2(200),
    P_SHIP_TO_ADDRESS_ID       NUMBER,
    P_SHIP_TO_ADDRESS_1        VARCHAR2(200),
    P_SHIP_TO_ADDRESS_2        VARCHAR2(200),
    P_SHIP_TO_ADDRESS_3        VARCHAR2(200),
    P_SHIP_TO_ADDRESS_4        VARCHAR2(200),
    P_CITY                     VARCHAR2(200),
    P_STATE                    VARCHAR2(200),
    P_COUNTY                   VARCHAR2(200),
    P_PROVINCE                 VARCHAR2(200),
    P_POSTAL_CODE              VARCHAR2(200),
    P_COUNTRY                  VARCHAR2(200),
    P_EXT_ATTRIBUTE1           VARCHAR2(200),
    P_EXT_ATTRIBUTE2           VARCHAR2(200),
    P_EXT_ATTRIBUTE3           VARCHAR2(200),
    P_EXT_ATTRIBUTE4           VARCHAR2(200),
    P_EXT_ATTRIBUTE5           VARCHAR2(200),
    P_EXT_ATTRIBUTE6           VARCHAR2(200),
    P_EXT_ATTRIBUTE7           VARCHAR2(200),
    P_EXT_ATTRIBUTE8           VARCHAR2(200),
    P_EXT_ATTRIBUTE9           VARCHAR2(200),
    P_EXT_ATTRIBUTE10          VARCHAR2(200),
    P_EXT_ATTRIBUTE11          VARCHAR2(200),
    P_EXT_ATTRIBUTE12          VARCHAR2(200),
    P_EXT_ATTRIBUTE13          VARCHAR2(200),
    P_EXT_ATTRIBUTE14          VARCHAR2(200),
    P_EXT_ATTRIBUTE15          VARCHAR2(200),
    P_TASK_PRODUCT_CODE        VARCHAR2(200),
    P_SELLER_LEVEL             NUMBER,
    p_pricing_group            NUMBER,
    p_calculate_sales_commision varchar2(20),
    p_create_event_flag         varchar2(20)
    );

  TYPE g_proj_event_data_tbl IS TABLE OF g_proj_event_data INDEX BY BINARY_INTEGER;
  g_proj_event_data_rec g_proj_event_data_tbl;
  --End of Added for CR24082,CR23103


  -- Record Type for retrieving multiple Order Details
  TYPE g_order_data IS RECORD(
    order_ref           VARCHAR2(100),
    order_number        VARCHAR2(200), --Added for HPQC 20664
    oracle_order_number VARCHAR2(200),
    guid                VARCHAR2(200),
    error_message       VARCHAR2(2000), --Added for CR23274
    email_date          DATE);

  TYPE g_order_data_tbl IS TABLE OF g_order_data INDEX BY BINARY_INTEGER;
  g_order_data_rec g_order_data_tbl;

  -- Record Type for Error Handling for reports
  TYPE g_error_rec IS RECORD(
    error_text VARCHAR2(2000));

  TYPE g_error_rec_tbl IS TABLE OF g_error_rec INDEX BY BINARY_INTEGER;
  g_error_count NUMBER := 1;
  g_error_tbl   g_error_rec_tbl;

  -- Record Type for N-Code information to derive Project Tasks
  TYPE n_code_rec IS RECORD(
    line_number        VARCHAR2(20),
    n_code             VARCHAR2(100),
    n_code_description VARCHAR2(500),
    n_code_amount      NUMBER,
    work_type          VARCHAR2(200));

  TYPE n_code_tbl IS TABLE OF n_code_rec INDEX BY BINARY_INTEGER;

  -------------------- Create Record type for Pricing Adjustments --------------
  TYPE g_order_prc_adj_rec_t IS RECORD(
    orig_sys_discount_ref        OE_PRICE_ADJS_IFACE_ALL.orig_sys_discount_ref%type,
    change_sequence              OE_PRICE_ADJS_IFACE_ALL.change_sequence%type,
    change_request_code          OE_PRICE_ADJS_IFACE_ALL.change_request_code%type,
    automatic_flag               OE_PRICE_ADJS_IFACE_ALL.automatic_flag%type,
    context                      OE_PRICE_ADJS_IFACE_ALL.context%type,
    attribute1                   OE_PRICE_ADJS_IFACE_ALL.attribute1%type,
    attribute2                   OE_PRICE_ADJS_IFACE_ALL.attribute2%type,
    attribute3                   OE_PRICE_ADJS_IFACE_ALL.attribute3%type,
    attribute4                   OE_PRICE_ADJS_IFACE_ALL.attribute4%type,
    attribute5                   OE_PRICE_ADJS_IFACE_ALL.attribute5%type,
    attribute6                   OE_PRICE_ADJS_IFACE_ALL.attribute6%type,
    attribute7                   OE_PRICE_ADJS_IFACE_ALL.attribute7%type,
    attribute8                   OE_PRICE_ADJS_IFACE_ALL.attribute8%type,
    attribute9                   OE_PRICE_ADJS_IFACE_ALL.attribute9%type,
    attribute10                  OE_PRICE_ADJS_IFACE_ALL.attribute10%type,
    attribute11                  OE_PRICE_ADJS_IFACE_ALL.attribute11%type,
    attribute12                  OE_PRICE_ADJS_IFACE_ALL.attribute12%type,
    attribute13                  OE_PRICE_ADJS_IFACE_ALL.attribute13%type,
    attribute14                  OE_PRICE_ADJS_IFACE_ALL.attribute14%type,
    attribute15                  OE_PRICE_ADJS_IFACE_ALL.attribute15%type,
    list_header_id               OE_PRICE_ADJS_IFACE_ALL.list_header_id%type,
    list_name                    OE_PRICE_ADJS_IFACE_ALL.list_name%type,
    list_line_id                 OE_PRICE_ADJS_IFACE_ALL.list_line_id%type,
    list_line_type_code          OE_PRICE_ADJS_IFACE_ALL.list_line_type_code%type,
    modifier_mechanism_type_code OE_PRICE_ADJS_IFACE_ALL.modifier_mechanism_type_code%type,
    modified_from                OE_PRICE_ADJS_IFACE_ALL.modified_from%type,
    modified_to                  OE_PRICE_ADJS_IFACE_ALL.modified_to%type,
    updated_flag                 OE_PRICE_ADJS_IFACE_ALL.updated_flag%type,
    update_allowed               OE_PRICE_ADJS_IFACE_ALL.update_allowed%type,
    applied_flag                 OE_PRICE_ADJS_IFACE_ALL.applied_flag%type,
    change_reason_code           OE_PRICE_ADJS_IFACE_ALL.change_reason_code%type,
    change_reason_text           OE_PRICE_ADJS_IFACE_ALL.change_reason_text%type,
    discount_id                  OE_PRICE_ADJS_IFACE_ALL.discount_id%type,
    discount_line_id             OE_PRICE_ADJS_IFACE_ALL.discount_line_id%type,
    discount_name                OE_PRICE_ADJS_IFACE_ALL.discount_name%type,
    percent                      OE_PRICE_ADJS_IFACE_ALL.percent%type,
    operation_code               OE_PRICE_ADJS_IFACE_ALL.operation_code%type,
    operand                      OE_PRICE_ADJS_IFACE_ALL.operand%type,
    arithmetic_operator          OE_PRICE_ADJS_IFACE_ALL.arithmetic_operator%type,
    pricing_phase_id             OE_PRICE_ADJS_IFACE_ALL.pricing_phase_id%type,
    adjusted_amount              OE_PRICE_ADJS_IFACE_ALL.adjusted_amount%type,
    modifier_name                OE_PRICE_ADJS_IFACE_ALL.modifier_name%type,
    list_line_number             OE_PRICE_ADJS_IFACE_ALL.list_line_number%type,
    version_number               OE_PRICE_ADJS_IFACE_ALL.version_number%type,
    invoiced_flag                OE_PRICE_ADJS_IFACE_ALL.invoiced_flag%type,
    estimated_flag               OE_PRICE_ADJS_IFACE_ALL.estimated_flag%type,
    inc_in_sales_performance     OE_PRICE_ADJS_IFACE_ALL.inc_in_sales_performance%type,
    charge_type_code             OE_PRICE_ADJS_IFACE_ALL.charge_type_code%type,
    charge_subtype_code          OE_PRICE_ADJS_IFACE_ALL.charge_subtype_code%type,
    credit_or_charge_flag        OE_PRICE_ADJS_IFACE_ALL.credit_or_charge_flag%type,
    include_on_returns_flag      OE_PRICE_ADJS_IFACE_ALL.include_on_returns_flag%type,
    cost_id                      OE_PRICE_ADJS_IFACE_ALL.cost_id%type,
    tax_code                     OE_PRICE_ADJS_IFACE_ALL.tax_code%type,
    parent_adjustment_id         OE_PRICE_ADJS_IFACE_ALL.parent_adjustment_id%type,
    ac_context                   OE_PRICE_ADJS_IFACE_ALL.ac_context%type,
    ac_attribute1                OE_PRICE_ADJS_IFACE_ALL.ac_attribute1%type,
    ac_attribute2                OE_PRICE_ADJS_IFACE_ALL.ac_attribute2%type,
    ac_attribute3                OE_PRICE_ADJS_IFACE_ALL.ac_attribute3%type,
    ac_attribute4                OE_PRICE_ADJS_IFACE_ALL.ac_attribute4%type,
    ac_attribute5                OE_PRICE_ADJS_IFACE_ALL.ac_attribute5%type,
    ac_attribute6                OE_PRICE_ADJS_IFACE_ALL.ac_attribute6%type,
    ac_attribute7                OE_PRICE_ADJS_IFACE_ALL.ac_attribute7%type,
    ac_attribute8                OE_PRICE_ADJS_IFACE_ALL.ac_attribute8%type,
    ac_attribute9                OE_PRICE_ADJS_IFACE_ALL.ac_attribute9%type,
    ac_attribute10               OE_PRICE_ADJS_IFACE_ALL.ac_attribute10%type,
    ac_attribute11               OE_PRICE_ADJS_IFACE_ALL.ac_attribute11%type,
    ac_attribute12               OE_PRICE_ADJS_IFACE_ALL.ac_attribute12%type,
    ac_attribute13               OE_PRICE_ADJS_IFACE_ALL.ac_attribute13%type,
    ac_attribute14               OE_PRICE_ADJS_IFACE_ALL.ac_attribute14%type,
    ac_attribute15               OE_PRICE_ADJS_IFACE_ALL.ac_attribute15%type,
    operand_per_pqty             OE_PRICE_ADJS_IFACE_ALL.operand_per_pqty%type,
    adjusted_amount_per_pqty     OE_PRICE_ADJS_IFACE_ALL.adjusted_amount_per_pqty%type,
    price_adjustment_id          OE_PRICE_ADJS_IFACE_ALL.price_adjustment_id%type,
    tax_rate_id                  OE_PRICE_ADJS_IFACE_ALL.tax_rate_id%type,
    error_flag                   OE_PRICE_ADJS_IFACE_ALL.error_flag%type,
    interface_status             OE_PRICE_ADJS_IFACE_ALL.interface_status%type,
    status_flag                  OE_PRICE_ADJS_IFACE_ALL.status_flag%type,
    sold_to_org                  OE_PRICE_ADJS_IFACE_ALL.sold_to_org%type,
    sold_to_org_id               OE_PRICE_ADJS_IFACE_ALL.sold_to_org_id%type);

  -- Create variable for Pricing Attributes Record Type
  g_order_prc_adj_rec g_order_prc_adj_rec_t;

  -- Create table type for Pricing Attributes Record Type
  TYPE g_order_prc_adj_rec_tbl_t IS TABLE OF g_order_prc_adj_rec_t INDEX BY BINARY_INTEGER;

  -- Variables for Pricing Attributes Table Type
  g_order_prc_adj_rec_tbl_l g_order_prc_adj_rec_tbl_t;
  g_order_prc_adj_rec_tbl_h g_order_prc_adj_rec_tbl_t;

  -------------------- Create Record type for Pricing Attributes --------------

  TYPE g_order_prc_attr_line_rec_t IS RECORD(
    CONTEXT             oe_price_atts_iface_all.CONTEXT%TYPE,
    attribute1          oe_price_atts_iface_all.attribute1%TYPE,
    attribute2          oe_price_atts_iface_all.attribute2%TYPE,
    attribute3          oe_price_atts_iface_all.attribute3%TYPE,
    attribute4          oe_price_atts_iface_all.attribute4%TYPE,
    attribute5          oe_price_atts_iface_all.attribute5%TYPE,
    attribute6          oe_price_atts_iface_all.attribute6%TYPE,
    attribute7          oe_price_atts_iface_all.attribute7%TYPE,
    attribute8          oe_price_atts_iface_all.attribute8%TYPE,
    attribute9          oe_price_atts_iface_all.attribute9%TYPE,
    attribute10         oe_price_atts_iface_all.attribute10%TYPE,
    attribute11         oe_price_atts_iface_all.attribute11%TYPE,
    attribute12         oe_price_atts_iface_all.attribute12%TYPE,
    attribute13         oe_price_atts_iface_all.attribute13%TYPE,
    attribute14         oe_price_atts_iface_all.attribute14%TYPE,
    attribute15         oe_price_atts_iface_all.attribute15%TYPE,
    pricing_context     oe_price_atts_iface_all.pricing_context%TYPE,
    pricing_attribute1  oe_price_atts_iface_all.pricing_attribute1%TYPE,
    pricing_attribute2  oe_price_atts_iface_all.pricing_attribute2%TYPE,
    pricing_attribute3  oe_price_atts_iface_all.pricing_attribute3%TYPE,
    pricing_attribute4  oe_price_atts_iface_all.pricing_attribute4%TYPE,
    pricing_attribute5  oe_price_atts_iface_all.pricing_attribute5%TYPE,
    pricing_attribute6  oe_price_atts_iface_all.pricing_attribute6%TYPE,
    pricing_attribute7  oe_price_atts_iface_all.pricing_attribute7%TYPE,
    pricing_attribute8  oe_price_atts_iface_all.pricing_attribute8%TYPE,
    pricing_attribute9  oe_price_atts_iface_all.pricing_attribute9%TYPE,
    pricing_attribute10 oe_price_atts_iface_all.pricing_attribute10%TYPE,
    pricing_attribute11 oe_price_atts_iface_all.pricing_attribute11%TYPE,
    pricing_attribute12 oe_price_atts_iface_all.pricing_attribute12%TYPE,
    pricing_attribute13 oe_price_atts_iface_all.pricing_attribute13%TYPE,
    pricing_attribute14 oe_price_atts_iface_all.pricing_attribute14%TYPE,
    pricing_attribute15 oe_price_atts_iface_all.pricing_attribute15%TYPE);

  -- Create variable for Pricing Attributes Record Type
  g_order_prc_attr_line_rec g_order_prc_attr_line_rec_t;

  -- Create table type for Pricing Attributes Record Type
  TYPE g_order_prc_attr_line_tbl_t IS TABLE OF g_order_prc_attr_line_rec_t INDEX BY BINARY_INTEGER;

  -- Variables for Pricing Attributes Table Type
  g_order_prc_attr_line_tbl_l g_order_prc_attr_line_tbl_t;
  g_order_prc_attr_line_tbl_h g_order_prc_attr_line_tbl_t;

  -------------------- Create Record type for Dynamic Additional DFF Attributes --------------

  TYPE g_order_add_attr_line_rec_t IS RECORD(
    attribute_type  VARCHAR2(1000),
    attribute_group VARCHAR2(1000),
    attribute_name  VARCHAR2(1000),
    attribute_value VARCHAR2(1000));

  -- Create variable for Src Attributes Record Type
  g_order_add_attr_line_rec g_order_add_attr_line_rec_t;

  -- Create table type for Src Attributes Record Type
  TYPE g_order_add_attr_line_tbl_t IS TABLE OF g_order_add_attr_line_rec_t INDEX BY BINARY_INTEGER;

  -------------------- Create Record type for Dynamic SRC Attributes --------------

  TYPE g_src_attributes_rec_t IS RECORD(
    NAME  VARCHAR2(1000),
    VALUE VARCHAR2(1000));

  -- Create variable for Src Attributes Record Type
  g_src_attributes_rec g_src_attributes_rec_t;

  -- Create table type for Src Attributes Record Type
  TYPE g_src_attributes_tbl_t IS TABLE OF g_src_attributes_rec_t INDEX BY BINARY_INTEGER;

  -- Variable for Src Attributes table type
  g_src_attributes_tbl g_src_attributes_tbl_t;

  -------------------- Create Record type for Order Attachments --------------

  TYPE g_order_attachment_rec_t IS RECORD(
    line_number     xxont_order_attach_in.line_number%TYPE,
    attachment_type xxont_order_attach_in.notes_type%TYPE, --fnd_attached_documents.document_id%TYPE,
    short_text      xxont_order_attach_in.notes%TYPE);

  -- Create variable for  Order Attachment Record Type
  g_order_attachment_rec g_order_attachment_rec_t;

  -- Create table type for  Order Attachment Record Type
  TYPE g_order_attachment_tbl_t IS TABLE OF g_order_attachment_rec_t INDEX BY BINARY_INTEGER;

  -- Variable for  Order Attachment table type
  g_order_attachment_tbl g_order_attachment_tbl_t;

  -------------------- Create Record type for Sales Order Line --------------
  TYPE g_sales_order_line_main_rec_t IS RECORD(
    line_number           oe_lines_iface_all.line_number%TYPE,
    inventory_item        oe_lines_iface_all.inventory_item%TYPE,
    ordered_quantity      oe_lines_iface_all.ordered_quantity%TYPE,
    ordered_quantity_uom  oe_lines_iface_all.order_quantity_uom%TYPE,
    ship_from_org_id      oe_lines_iface_all.ship_from_org_id%TYPE,
    deliverToOrgId        oe_lines_iface_all.deliver_to_org_id%TYPE,
    fob                   VARCHAR2(100),
    shipment_priority     oe_lines_iface_all.shipment_priority%TYPE,
    request_date          oe_lines_iface_all.request_date%TYPE,
    project_number        oe_lines_iface_all.project%TYPE,
    task_number           oe_lines_iface_all.task%TYPE,
    attribute_category    VARCHAR2(100),
    attribute1            oe_lines_iface_all.attribute1%TYPE,
    attribute2            oe_lines_iface_all.attribute2%TYPE,
    attribute3            oe_lines_iface_all.attribute3%TYPE,
    attribute4            oe_lines_iface_all.attribute4%TYPE,
    attribute5            oe_lines_iface_all.attribute5%TYPE,
    attribute6            oe_lines_iface_all.attribute6%TYPE,
    attribute7            oe_lines_iface_all.attribute7%TYPE,
    attribute8            oe_lines_iface_all.attribute8%TYPE,
    attribute9            oe_lines_iface_all.attribute9%TYPE,
    attribute10           oe_lines_iface_all.attribute10%TYPE,
    attribute11           oe_lines_iface_all.attribute11%TYPE,
    attribute12           oe_lines_iface_all.attribute12%TYPE,
    attribute13           oe_lines_iface_all.attribute13%TYPE,
    attribute14           oe_lines_iface_all.attribute14%TYPE,
    attribute15           oe_lines_iface_all.attribute15%TYPE,
    attribute16           oe_lines_iface_all.attribute16%TYPE,
    attribute17           oe_lines_iface_all.attribute17%TYPE,
    attribute18           oe_lines_iface_all.attribute18%TYPE,
    attribute19           oe_lines_iface_all.attribute19%TYPE,
    attribute20           oe_lines_iface_all.attribute20%TYPE,
    user_item_description oe_lines_iface_all.user_item_description%TYPE);

  -- Create variable for Sales Order Line Main Record Type
  g_sales_order_line_main_rec g_sales_order_line_main_rec_t;

  --Create Composite record type for Sales Order Lines
  TYPE g_sales_order_line_rec_t IS RECORD(
    g_sales_order_line_main_rec g_sales_order_line_main_rec_t,
    g_order_add_attr_line_tbl_l g_order_add_attr_line_tbl_t,
    g_order_prc_attr_line_tbl_l g_order_prc_attr_line_tbl_t,
    g_order_prc_adj_rec_tbl_l   g_order_prc_adj_rec_tbl_t,
    g_src_attributes_tbl_l      g_src_attributes_tbl_t,
    g_order_attachment_tbl_l    g_order_attachment_tbl_t);

  -- Create a table type for Sales Order Lines
  TYPE g_sales_order_line_tbl_t IS TABLE OF g_sales_order_line_rec_t INDEX BY BINARY_INTEGER;

  -------------------- Create Record type for Sales Order Header --------------

  TYPE g_sales_order_hdr_main_rec_t IS RECORD(
    org_code                   varchar2(200),
    org_id                     oe_headers_iface_all.org_id%TYPE,
    ordertype                  VARCHAR2(2000),
    ordertypeid                NUMBER,
    request_date               oe_headers_iface_all.request_date%TYPE,
    transactional_curr_code    oe_headers_iface_all.transactional_curr_code%TYPE,
    shipment_priority          oe_headers_iface_all.shipment_priority%TYPE,
    freight_terms              oe_headers_iface_all.freight_terms%TYPE,
    shipping_method            oe_headers_iface_all.shipping_method%TYPE,
    fob                        VARCHAR2(100),
    shipping_instructions      oe_headers_iface_all.shipping_instructions%TYPE,
	packingInstructions        oe_headers_iface_all.packing_Instructions%type,--Added as part of CR24287
    ordered_date               oe_headers_iface_all.ordered_date%TYPE,
    pricelist                  VARCHAR2(1000),
    attribute_category         VARCHAR2(30),
    attribute1                 oe_headers_iface_all.attribute1%TYPE,
    attribute2                 oe_headers_iface_all.attribute2%TYPE,
    attribute3                 oe_headers_iface_all.attribute3%TYPE,
    attribute4                 oe_headers_iface_all.attribute4%TYPE,
    attribute5                 oe_headers_iface_all.attribute5%TYPE,
    attribute6                 oe_headers_iface_all.attribute6%TYPE,
    attribute7                 oe_headers_iface_all.attribute7%TYPE,
    attribute8                 oe_headers_iface_all.attribute8%TYPE,
    attribute9                 oe_headers_iface_all.attribute9%TYPE,
    attribute10                oe_headers_iface_all.attribute10%TYPE,
    attribute11                oe_headers_iface_all.attribute11%TYPE,
    attribute12                oe_headers_iface_all.attribute12%TYPE,
    attribute13                oe_headers_iface_all.attribute13%TYPE,
    attribute14                oe_headers_iface_all.attribute14%TYPE,
    attribute15                oe_headers_iface_all.attribute15%TYPE,
    attribute16                oe_headers_iface_all.attribute16%TYPE,
    attribute17                oe_headers_iface_all.attribute17%TYPE,
    attribute18                oe_headers_iface_all.attribute18%TYPE,
    attribute19                oe_headers_iface_all.attribute19%TYPE,
    attribute20                oe_headers_iface_all.attribute20%TYPE,
    order_type                 oe_headers_iface_all.order_type%TYPE,
    organization_name          VARCHAR2(150),
    tpcontext                  oe_headers_iface_all.tp_context%TYPE,
    tpattribute1               oe_headers_iface_all.tp_attribute1%TYPE,
    tpattribute2               oe_headers_iface_all.tp_attribute2%TYPE,
    tpattribute3               oe_headers_iface_all.tp_attribute3%TYPE,
    tpattribute4               oe_headers_iface_all.tp_attribute4%TYPE,
    tpattribute5               oe_headers_iface_all.tp_attribute5%TYPE,
    tpattribute6               oe_headers_iface_all.tp_attribute6%TYPE,
    tpattribute7               oe_headers_iface_all.tp_attribute7%TYPE,
    tpattribute8               oe_headers_iface_all.tp_attribute8%TYPE,
    tpattribute9               oe_headers_iface_all.tp_attribute9%TYPE,
    tpattribute10              oe_headers_iface_all.tp_attribute10%TYPE,
    tpattribute11              oe_headers_iface_all.tp_attribute11%TYPE,
    tpattribute12              oe_headers_iface_all.tp_attribute12%TYPE,
    tpattribute13              oe_headers_iface_all.tp_attribute13%TYPE,
    tpattribute14              oe_headers_iface_all.tp_attribute14%TYPE,
    tpattribute15              oe_headers_iface_all.tp_attribute15%TYPE,
    customer_number            oe_headers_iface_all.customer_number%TYPE,
    bill_to_customer_id        oe_headers_iface_all.invoice_customer_id%TYPE,
    ship_to_customer_id        oe_headers_iface_all.ship_to_customer_id%TYPE,
    bill_to_party_site_id      oe_headers_iface_all.invoice_to_party_site_id%TYPE,
    payment_terms              oe_headers_iface_all.customer_payment_term%TYPE,
    ship_to_party_site_id      oe_headers_iface_all.ship_to_party_site_id%TYPE,
    ship_to_adress_line1       oe_headers_iface_all.ship_to_address1%TYPE,
    ship_to_adress_line2       oe_headers_iface_all.ship_to_address2%TYPE,
    ship_to_adress_line3       oe_headers_iface_all.ship_to_address3%TYPE,
    ship_to_adress_line4       oe_headers_iface_all.ship_to_address4%TYPE,
    ship_to_adress_city        oe_headers_iface_all.ship_to_city%TYPE,
    ship_to_adress_state       oe_headers_iface_all.ship_to_state%TYPE,
    ship_to_adress_postal_code oe_headers_iface_all.ship_to_postal_code%TYPE,
    ship_to_adress_country     oe_headers_iface_all.ship_to_country%TYPE,
    ship_to_adress_county      oe_headers_iface_all.ship_to_county%TYPE,
    ship_to_party_site_number  oe_headers_iface_all.ship_to_party_number%TYPE,
    bill_to_party_site_number  oe_headers_iface_all.invoice_to_party_number%TYPE,
    customer_id                oe_headers_iface_all.customer_id%TYPE,
    customer_po_number         oe_headers_iface_all.customer_po_number%TYPE,
    salesrep                   oe_headers_iface_all.salesrep%TYPE,
    salesrepId                 oe_headers_iface_all.salesrep_id%TYPE,
	-- CR25098 - Include Deliver to Address Elements in this Record Type - START
	deliver_to_address1        oe_headers_iface_all.deliver_to_address1%TYPE,   
    deliver_to_address2        oe_headers_iface_all.deliver_to_address2%TYPE,   
    deliver_to_address3        oe_headers_iface_all.deliver_to_address3%TYPE,
    deliver_to_address4        oe_headers_iface_all.deliver_to_address4%TYPE,   
    deliver_to_city            oe_headers_iface_all.deliver_to_city%TYPE,       
    deliver_to_county          oe_headers_iface_all.deliver_to_county%TYPE,     
    deliver_to_country         oe_headers_iface_all.deliver_to_country%TYPE,    
    deliver_to_province        oe_headers_iface_all.deliver_to_province%TYPE,   
    deliver_to_postal_code     oe_headers_iface_all.deliver_to_postal_code%TYPE
	-- CR25098 - Include Deliver to Address Elements in this Record Type - END
	);

  -- Create variable for Sales Order Header Main Record Type
  g_sales_order_hdr_main_rec g_sales_order_hdr_main_rec_t;
  --Added for HPQC 21314
  TYPE g_sales_credit_hdr_rec_t IS RECORD(
    employee_number   VARCHAR2(200),
    salesrepId        NUMBER,
    salesrep          VARCHAR2(200),
    salesCreditTypeId NUMBER,
    salesCreditType   VARCHAR2(200),
    percent           NUMBER,
    ebs_user_name     VARCHAR2(200));

  -- Create variable for  Order Attachment Record Type
  g_sales_credit_hdr_rec g_sales_credit_hdr_rec_t;

  -- Create table type for  Order Attachment Record Type
  TYPE g_sales_credit_hdr_tbl_t IS TABLE OF g_sales_credit_hdr_rec_t INDEX BY BINARY_INTEGER;
  --End of Added for HPQC 21314
  -- Variable for  Order Attachment table type
  g_sales_credit_hdr_tbl g_sales_credit_hdr_tbl_t;

  -- Create Composite record type for Sales Order Header
  TYPE g_sales_order_header_rec_t IS RECORD(
    g_sales_order_hdr_main_rec  g_sales_order_hdr_main_rec_t,
    g_sales_credit_hdr_tbl      g_sales_credit_hdr_tbl_t, --Added for HPQC 21314
    g_sales_order_line_tbl      g_sales_order_line_tbl_t,
    g_order_add_attr_line_tbl_h g_order_add_attr_line_tbl_t,
    g_order_prc_attr_line_tbl_h g_order_prc_attr_line_tbl_t,
    g_order_prc_adj_rec_tbl_h   g_order_prc_adj_rec_tbl_t,
    g_src_attributes_tbl_h      g_src_attributes_tbl_t,
    g_order_attachment_tbl_h    g_order_attachment_tbl_t);

  -- Record Type variable for Sales Order Header
  g_sales_order_header_rec g_sales_order_header_rec_t;

  -- Create a table type for Sales Order Header
  TYPE g_sales_order_header_tbl_t IS TABLE OF g_sales_order_header_rec_t INDEX BY BINARY_INTEGER;
  --Added for CR23274 XXONT3030
  -- Record Type for XXONT3030 Event Visibility Report
  TYPE g_report_rec_t IS RECORD(
    GUID                        XXINT_EVENTS.GUID%TYPE,
    EVENT_CREATION_DATE         XXINT_EVENTS.CREATION_DATE%TYPE,
    EVENT_STATUS                XXINT_EVENTS.ATTRIBUTE3%TYPE,
    PARTNER_CODE                VARCHAR2(200),
    REQUEST_TYPE                VARCHAR2(1),
    PM_AGREEMENT_REFERENCE      PA_AGREEMENTS_ALL.PM_AGREEMENT_REFERENCE%TYPE,
    AGREEMENT_NUM               PA_AGREEMENTS_ALL.AGREEMENT_NUM%TYPE,
    AGREEMENT_TYPE              PA_AGREEMENTS_ALL.AGREEMENT_TYPE%TYPE,
    PO_AMOUNT                   PA_AGREEMENTS_ALL.AMOUNT%TYPE,
    CURRENCY_CODE               VARCHAR2(20),
    CUSTOMER_PO_NUMBER          VARCHAR2(200),
    PM_PRODUCT_CODE             PA_PROJECTS_ALL.PM_PRODUCT_CODE%TYPE,
    OWNING_ORGANIZATION_CODE    VARCHAR2(20),
    OWNING_ORGANIZATION_NAME    VARCHAR2(200),
    CUSTOMER_NUMBER             VARCHAR2(200),
    BILL_TO_PARTY_SITE_ID       NUMBER,
    PAYMENT_TERMS               VARCHAR2(200),
    PA_PROJECT_NUMBER           VARCHAR2(50),
    PROJECT_NAME                VARCHAR2(200),
    DESCRIPTION                 VARCHAR2(2000),
    PROJECT_STATUS              VARCHAR2(2000),
    START_DATE                  DATE,
    COMPLETION_DATE             DATE,
    ORD_ORACLE_ORDER_NUMBER     OE_ORDER_HEADERS_ALL.ORDER_NUMBER%TYPE,
    ORD_ORACLE_ORDER_STATUS     OE_ORDER_HEADERS_ALL.FLOW_STATUS_CODE%TYPE,
    ORD_ORG_CODE                VARCHAR2(20),
    ORD_REQUEST_DATE            DATE,
    ORD_TRANSACTIONAL_CURR_CODE VARCHAR2(20),
    ORD_SHIPPING_METHOD         VARCHAR2(2000),
    ORD_FOB                     VARCHAR2(200),
    ORD_FREIGHT_TERMS           VARCHAR2(200),
    ORD_ATTRIBUTE19             VARCHAR2(200),
    ILC_NAME                    VARCHAR2(200),
    XXPA2381_GUID               XXINT_EVENTS.GUID%TYPE,
    XXPA2381_PHASE              VARCHAR2(200),
    XXPA2381_STATUS             VARCHAR2(200),
    XXONT1239_GUID              XXINT_EVENTS.GUID%TYPE,
    XXONT1239_PHASE             VARCHAR2(200),
    XXONT1239_STATUS            VARCHAR2(200),
    XXPA2672_GUID               XXINT_EVENTS.GUID%TYPE,
    XXPA2672_PHASE              VARCHAR2(200),
    XXPA2672_STATUS             VARCHAR2(200),
    EVENT_CURRENT_STATUS        VARCHAR2(2000),
    ERROR_MESSAGE               VARCHAR2(32676));

  TYPE g_report_tbl_t IS TABLE OF g_report_rec_t INDEX BY BINARY_INTEGER;
  g_report_rec g_report_tbl_t;
  --End of Added for CR23274 XXONT3030
  --Procedure to Add debug Log data in XXINT Event Logs
  PROCEDURE log_debug(p_text      VARCHAR2,
                      p_log_level in pls_integer default NULL); -- Added parameter by Joydeb as per RT#6859721

  FUNCTION get_formatted_address(p_location_id IN NUMBER) return varchar2; --Added for CR23783 to retrieve address in Value set

  --Procedure to Add Error data in g_error_tbl
  PROCEDURE log_error(p_text VARCHAR2);
  --Added for CR23274 XXONT3030
  -- Procedure to read generate G_REPORT_DATA Clob file if Clob file is missing
  PROCEDURE get_report_clob(p_event_current_phase VARCHAR2,
                            p_guid                varchar2);

  -- Procedure to read generate generate G_REPORT_DATA Clob File
  PROCEDURE generate_report_data;
  --End of Added for CR23274 XXONT3030

  --Function Added to Submit XXINT Background Process Adhoc
  FUNCTION submit_xxint_bkg_program(p_guid                       in VARCHAR2,
                                    p_event_phase                IN VARCHAR2,
                                    p_event_interval             IN VARCHAR2,
                                    p_event_type                 IN VARCHAR2,
                                    p_event_owner                IN VARCHAR2,
                                    p_override_next_attempt_time IN VARCHAR2,
                                    p_lock_timeout_sec           IN VARCHAR2)
    RETURN NUMBER;

  -- Procedure to create 15Digit Item for 40digit Item Number
  PROCEDURE xxont_item_matching(p_40_dgt_item    IN VARCHAR2,
                                p_15_dgt_item    IN OUT VARCHAR2,
                                p_price_list     IN VARCHAR2,
                                p_list_price     IN VARCHAR2,
                                p_pricing_date   IN DATE,
                                p_product_family IN VARCHAR2,
                                p_product_code   IN VARCHAR2,
                                p_status         IN OUT VARCHAR2,
                                p_error_message  IN OUT VARCHAR2);

  -- Procedure Create Deliver to Site Address on the Fly
  PROCEDURE xxont_create_deliverto_site(p_site_code                 IN VARCHAR2,
                                        p_execution_mode            IN VARCHAR2,
                                        p_cust_account_id           IN NUMBER,
                                        p_address_string1           IN VARCHAR2,
                                        p_address_string2           IN VARCHAR2,
                                        p_address4                  IN VARCHAR2,
                                        p_org_id                    IN NUMBER,
                                        x_create_cust_site_rec_type IN OUT xxont_validate_create_site.create_cust_site_rec_type,
                                        x_cust_site_use_rec         IN OUT hz_cust_account_site_v2pub.cust_site_use_rec_type);

  -- Procedure to Validate Partner/Partner Input Request Type
  PROCEDURE phase1(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2);

  -- Procedure to Validate Project and Sales Order Data and Create Project Event XXPA2381 incase of 'P' Request Type
  PROCEDURE phase2(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2);

  -- Procedure to Validate Project Creation, Project Approval and PJM Addition for 'P' Request Type
  PROCEDURE phase3(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2);

  -- Procedure to Validate Sales Order Data and Create XXONT1239 Event for Sales Order Creation
  PROCEDURE phase4(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2);

  -- Procedure to Validate Sales Order Event and Update Order Number and Close the Event
  PROCEDURE phase5(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2);

--
--  FUNCTION get_sales_commision(p_product_code  in number,
--                               p_pricing_group in number,
--                               p_seller_level  in number) return number;

END xxpa_equip_order_in_pkg;
/
show errors