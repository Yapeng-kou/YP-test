SET SERVEROUTPUT ON SIZE 1000000 LINES 132 TRIMOUT ON TAB OFF PAGES 100;

WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

create or replace PACKAGE BODY xxpa_equip_order_in_pkg IS
  /******************************************************************************
    *                           - COPYRIGHT NOTICE -                              *
    *******************************************************************************
    ** Title            :        XXPA2592
    ** File             :        XXPA_EQUIP_ORDER_IN_PKG.pkb
    ** Description      :        Package to perform Orchestration in Oracle R12
    **                           for SPECTRUM LA Orders (Project/Non-project SO)
    ** Parameters       :        {None}
    ** Run as           :        APPS
    ** Keyword Tracking:
    **
    **
    **   $Header: xxpa/12.0.0/patch/115/sql/xxpa_equip_order_in_pkg.pkb 1.23.1.8 05-APR-2021 12:11:13 CCCEAT $
    **   $Change History$ (*ALL VERSIONS*)
    **   Revision 1.23.1.8 (COMPLETE)
    **     Created:  05-APR-2021 12:11:13      CCCEAT (Kamlesh Jain)
    **       CR24595
    **
    **   Revision 1.23.1.7 (COMPLETE)
    **     Created:  04-DEC-2020 09:24:54      IRIHCZ (Kanak R)
    **       HPQC # 31775
    **
    **   Revision 1.23.1.6 (COMPLETE)
    **     Created:  04-DEC-2020 07:44:10      IRIHCZ (Kanak R)
    **       HPQC 31775
    **
    **   Revision 1.23.1.5 (COMPLETE)
    **     Created:  04-DEC-2020 05:29:14      IRIHCZ (Kanak R)
    **       HPQC # 31775
    **
    **   Revision 1.23.1.4 (COMPLETE)
    **     Created:  02-DEC-2020 10:51:48      IRIHCZ (Kanak R)
    **       CR24533
    **
    **   Revision 1.23.1.3 (COMPLETE)
    **     Created:  02-DEC-2020 10:12:06      IRIHCZ (Kanak R)
    **       CR24533
    **
    **   Revision 1.23.1.2 (COMPLETE)
    **     Created:  26-NOV-2020 08:18:01      IRIHCZ (Kanak R)
    **       CR24533
    **
    **   Revision 1.23.1.1 (COMPLETE)
    **     Created:  04-SEP-2020 08:58:07      IRIHCZ (Kanak R)
    **       CR24533
    **
    **   Revision 1.23.1.0 (COMPLETE)
    **     Created:  03-SEP-2020 07:47:22      IRIHCZ (Kanak R)
    **       CR24533
    **
    **   Revision 1.22 (COMPLETE)
    **     Created:  16-JUN-2020 23:05:13      IRHZXS (Ravi Alapati)
    **       19c DB Upgrade v$view retrofit changes
    **
    **   Revision 1.21 (COMPLETE)
    **     Created:  09-APR-2020 23:34:05      IRHZXS (Ravi Alapati)
    **       Adding RT8579992 changes (1.20) to 1.18.0.6
    **
    **   Revision 1.18.0.6 (COMPLETE)
    **     Created:  02-APR-2020 13:25:18      IRIQWM (Varun R Bellur)
    **       RT8658437 - XXPA2592 BOLTON TASK_END_DATE IS NULL FOR SPECTRUM_AP
    **       PARTNER
    **
    **   Revision 1.18.0.5 (COMPLETE)
    **     Created:  06-MAR-2020 19:36:39      CCBSSJ (Vishnusimman Manivannan)
    **       CR24437 - Bolt-on Changes to capture Layman Description
    **
    **   Revision 1.20 (COMPLETE)
    **     Created:  11-MAR-2020 17:29:26      IRHZXS (Ravi Alapati)
    **       Additional Changes for RT8579992 - XXPA2592 - Fix events processing
    **       logic to close events properly
    **
    **   Revision 1.19 (COMPLETE)
    **     Created:  04-MAR-2020 18:21:56      IRHZXS (Ravi Alapati)
    **       RT8579992 - XXPA2592 - Fix events processing logic to close events
    **       properly
    **
    **   Revision 1.18.0.4 (COMPLETE)
    **     Created:  31-JAN-2020 12:58:52      CCBPNA (Jyotsana Kandpal)
    **       MEA Secho KSC_EXIT_STATUS $? 1 CR24421 - Bolt-on to not populate the Virtual Sales
    **       location for specific OUs
    **
    **   Revision 1.18.0.3 (COMPLETE)
    **     Created:  14-JAN-2020 17:16:01      CCBSSJ (Vishnusimman Manivannan)
    **       RT8572634 and RT8596434 - Attachment and Project Event sequence fix
    **
    **   Revision 1.18.0.2 (COMPLETE)
    **     Created:  08-JAN-2020 22:58:40      CCBSSJ (Vishnusimman Manivannan)
    **       RT8572634 and RT8596434 - Attachment and Project Event sequence fix
    **
    **   Revision 1.18.0.1 (COMPLETE)
    **     Created:  08-JAN-2020 03:11:46      CCBSSJ (Vishnusimman Manivannan)
    **       RT8572634 and RT8596434 - Attachment and Project Event sequence fix
    **
    **   Revision 1.16.1.0.SEP (COMPLETE)
    **     Created:  09-DEC-2019 09:58:09      IRIPGP (None)
    **       Changes regarding separation project for Misc story SEP-2406 -
    **       removal of @irco hard coding
    **
    **   Revision 1.16 (COMPLETE)
    **     Created:  03-DEC-2019 12:14:31      IRIGYC (Jai Kumar)
    **       Changes Incorporated for RT8548644
    **
    **   Revision 1.15.0.4.0.SEP (COMPLETE)
    **     Created:  25-OCT-2019 11:03:20      CCDWZT (Sachin Kolhe)
    **       Modified for SEP-4548 Lookup/ValueSet/OUOrg Form changes -
    **       Effectivity Dates.Enabled Flag Changes
    **
    **   Revision 1.15.0.4 (COMPLETE)
    **     Created:  10-OCT-2019 16:56:24      CCBSSJ (Vishnusimman Manivannan)
    **       CR24287 - Update Bolton to pass collector account to XXONT1239
    **
    **   Revision 1.15.0.3 (COMPLETE)
    **     Created:  21-AUG-2019 19:22:05      CCBSSJ (Vishnusimman Manivannan)
    **       HPQC30256  - Incorrect Event Number sequence for Prepayment Invoice
    **       Events
    **
    **   Revision 1.15.0.2 (COMPLETE)
    **     Created:  06-AUG-2019 06:52:18      CCBSSJ (Vishnusimman Manivannan)
    **       CR24090 - Send Agreement DFF Attribute1 and 2 to XXPA2381 based on
    **       XXPA2078 OU level consolidation setup
    **
    **   Revision 1.15.0.1 (COMPLETE)
    **     Created:  26-JUL-2019 21:22:07      CCBSSJ (Vishnusimman Manivannan)
    **       CR24082 - Create Billing/Revenue events for SPECTRUM_MEA
    **       CR24100 - Bolton to support multi project structure
    **       CR23103 - Bolton to populate sales commission on billing lines when
    **       applicable
    **       CR24104 - Creation of projects only through Spectrum-Bolton
    **       integration
    **       CR24105 - Supporting new process for milestone billing
    **
    **   Revision 1.14 (COMPLETE)
    **     Created:  31-JAN-2019 09:51:25      IRIMIE (T Ranganath)
    **       RT#8169777 and RT#8191446
    **
    **   Revision 1.13.0.1 (COMPLETE)
    **     Created:  01-NOV-2018 13:50:53      CCBSSJ (Vishnusimman Manivannan)
    **       CR24018 - Add Arrival Date Type Code for EPL Warehouse orders
    **
    **   Revision 1.12 (COMPLETE)
    **     Created:  08-AUG-2018 14:16:30      CCBSSJ (Vishnusimman Manivannan)
    **       Merged v1.10 and v1.11
    **
    **   Revision 1.11 (COMPLETE)
    **     Created:  07-JUN-2018 16:07:42      CCBSSJ (Vishnusimman Manivannan)
    **       HPQC#26717 - Phase4A - XXPA2592 - Invalid country code issue
    **
    **   Revision 1.10 (COMPLETE)
    **     Created:  19-APR-2018 11:02:55      CCDUHY (Ashwini Tiwari)
    **       Merged version 1.9 and 1.8.0.4 as part of prod code sync up
    **       activity
    **
    **   Revision 1.9 (COMPLETE)
    **     Created:  02-MAR-2018 06:50:36      CCBSSJ (Vishnusimman Manivannan)
    **       RT7585104 - XXPA2592_EQUIP_ORDER_IN  RETENTION DAYS IS SET TO 120,
    **       PLEASE REDUCE TO 60 LIKE OTHER EVENTS
    **
    **   Revision 1.8.0.4 (COMPLETE)
    **     Created:  21-FEB-2018 15:34:28      C-ADAGA (Ashish Daga)
    **       Changes for defect # 26717 for invalid country code issue
    **
    **   Revision 1.8.0.2 (COMPLETE)
    **     Created:  01-FEB-2018 01:22:13      CCBSSJ (Vishnusimman Manivannan)
    **       CR23801 - XXONT1950 - Modify XXONT1950 to Create BPA for new MTO
    **       Configuration Items (Light Commercials)
    **
    **   Revision 1.8.0.1 (COMPLETE)
    **     Created:  10-JAN-2018 03:49:25      CCBSSJ (Vishnusimman Manivannan)
    **       CR23801 - XXONT1950 - Modify XXONT1950 to Create BPA for new MTO
    **       Configuration Items (Light Commercials)
    **
    **   Revision 1.7.0.1 (COMPLETE)
    **     Created:  12-NOV-2017 23:53:01      CCBSSJ (Vishnusimman Manivannan)
    **       CR23783 - Add customer validation to warehouse/OU default logic -
    **       updated with code review comments
    **
    **   Revision 1.7 (COMPLETE)
    **     Created:  07-NOV-2017 03:10:17      CCBSSJ (Vishnusimman Manivannan)
    **       CR23783 - Add customer validation to warehouse/OU default logic
    **
    **   Revision 1.6 (COMPLETE)
    **     Created:  20-JUL-2017 05:29:26      CCBUUN (Joydeb Saha)
    **       CR5963 - Code changes
    **
    **   Revision 1.5 (COMPLETE)
    **     Created:  06-JUL-2017 09:54:06      CCBUUN (Joydeb Saha)
    **       Moved branch (1.4.0.1) to Trunk version (1.5)
    **
    **   Revision 1.4.0.1 (COMPLETE)
    **     Created:  18-MAY-2017 08:40:18      CCBUUN (Joydeb Saha)
    **       Merged code 1.3.0.2 (CR23505 code) with 1.4 (Prod fix for
    **       RT7137886)
    **
    **   Revision 1.4 (COMPLETE)
    **     Created:  04-MAY-2017 11:38:42      CCBUUN (Joydeb Saha)
    **       RT7137886 - Keep the XXPA2381 XML in sync with XSD for SRC
    **       attributes
    **
    **   Revision 1.3.0.2 (COMPLETE)
    **     Created:  27-JAN-2017 06:48:23      CCBUUN (Joydeb Saha)
    **       Phase 4A - CR23505 - HPQC#24280 - Code Changes
    **
    **   Revision 1.3.0.1 (COMPLETE)
    **     Created:  18-NOV-2016 07:17:00      CCBUUN (Joydeb Saha)
    **       Code merged for CR23505 and RT#6859721.
    **
    **   Revision 1.3 (COMPLETE)
    **     Created:  08-NOV-2016 06:37:57      CCBUUN (Joydeb Saha)
    **       RT#6859721: Code modified to reduce log statements.
    **
    **   Revision 1.2.0.1 (COMPLETE)
    **     Created:  26-OCT-2016 11:33:58      CCBSSJ (Vishnusimman Manivannan)
    **       CR23505 - Addition of new Partner SPECTRUM_AP
    **
    **   Revision 1.2 (COMPLETE)
    **     Created:  20-SEP-2016 14:52:25      CCBSSJ (Vishnusimman Manivannan)
    **       RT6741676 - XXPA2592 - Modified to handle Special Characters while
    **       generating Report and Order XML - updated after Functional Testing
    **
    **   Revision 1.1 (COMPLETE)
    **     Created:  01-SEP-2016 02:08:54      CCBSSJ (Vishnusimman Manivannan)
    **       RT6741676 - XXPA2592 - Modified to handle Special Characters while
    **       generating Report and Order XML
    **
    **   Revision 1.0.14 (COMPLETE)
    **     Created:  26-MAY-2016 01:19:15      CCBSSJ (Vishnusimman Manivannan)
    **       CR22563 - XXPA2381 - Phase 3B W3 - HPQC22294 Added additional logic
    **       to append customer po number with tso number
    **
    **   Revision 1.0.13 (COMPLETE)
    **     Created:  20-MAY-2016 02:23:27      CCBSSJ (Vishnusimman Manivannan)
    **       CR22563 - XXPA2381 - Phase 3B W3 - HPQC#21953 Logic to derive
    **       Organization/Operating unit id for project updates
    **
    **   Revision 1.0.12 (COMPLETE)
    **     Created:  29-APR-2016 11:36:45      CCBSSJ (Vishnusimman Manivannan)
    **       CR22563 - XXPA2592 - Phase 3B W3 - HPQC#21731 Add Invoice/Revenue
    **       Limit for Agreement Templates
    **
    **   Revision 1.0.11 (COMPLETE)
    **     Created:  27-APR-2016 08:44:44      CCBSSJ (Vishnusimman Manivannan)
    **       CR22563 - XXPA2592 - Phase 3B W3 Concurrent Program submission as
    **       part of SMOKE Test Issues
    **
    **   Revision 1.0.10 (COMPLETE)
    **     Created:  19-APR-2016 13:28:04      CCBSSJ (Vishnusimman Manivannan)
    **       Changes for HPQC21314, HPQC21376 and CR23274 XXONT3030 ( XXPA2592 -
    **       Phase 3B W3) - Updated after Functional Testing
    **
    **   Revision 1.0.9 (COMPLETE)
    **     Created:  21-MAR-2016 15:41:50      CCBSSJ (Vishnusimman Manivannan)
    **       Changes for HPQC21314, HPQC21376 and CR23274 XXONT3030 ( XXPA2592 -
    **       Phase 3B W3)
    **
    **   Revision 1.0.8 (COMPLETE)
    **     Created:  06-MAR-2016 13:02:43      CCBSSJ (Vishnusimman Manivannan)
    **       XXPA2592 - XXONT3030 - Phase 3B W3- Added Report Clob data for
    **       CR23274
    **
    **   Revision 1.0.7 (COMPLETE)
    **     Created:  05-MAR-2016 23:13:05      CCBSSJ (Vishnusimman Manivannan)
    **       CR22562 XXPA22563 - Added Validation Logic for Ship Method as part
    **       of SMOKE Test
    **
    **   Revision 1.0.6 (COMPLETE)
    **     Created:  04-JAN-2016 09:22:29      CCBSSJ (Vishnusimman Manivannan)
    **       Deliver to Address Change
    **
    **   Revision 1.0.5 (COMPLETE)
    **     Created:  17-DEC-2015 12:00:49      CCBSSJ (Vishnusimman Manivannan)
    **       HPQC Defect 20664 - XXPA2592 - INT3 Phase3B W3 - Deliver Address
    **       Change
    **
    **   Revision 1.0.4 (COMPLETE)
    **     Created:  04-DEC-2015 00:26:22      CCBSSJ (Vishnusimman Manivannan)
    **       QC 20554 - Fix for removing Deliver to and Ship to address creation
    **       in XXPA2592 - Phase 3B W3
    **
    **   Revision 1.0.3 (COMPLETE)
    **     Created:  13-NOV-2015 05:18:58      CCBSSJ (Vishnusimman Manivannan)
    **       CR22926 , CR22928, CR22534 - XXPA2381 - Phase 3B W3 - Single
    **       Project Approach and Spectrum LA Project Order Orchestration
    **
    **   Revision 1.0.2 (COMPLETE)
    **     Created:  29-OCT-2015 15:25:19      CCBSSJ (Vishnusimman Manivannan)
    **       Spectrum Project Order Orchestration CR22563 and CR22928 - XXPA2592
    **       - Phase 3B W3
    **
    **   Revision 1.0.1 (COMPLETE)
    **     Created:  30-JUL-2015 09:11:16      CCBPNA (Jyotsana Kandpal)
    **       After multiple changes from Func Testing
    **
    **   Revision 1.0 (COMPLETE)
    **     Created:  22-JUN-2015 19:59:06      CCBSSJ (Vishnusimman Manivannan)
    **       Initial revision.
    **
    **
    **
    ** History          :
    ** Date          Who                Description
    ** -----------   ------------------ -------------------------------------------*
    ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                  *
    ** 13-May-2015   Vishnusimman M     RT6741676 Added DBMS_XMLGEN Convert utility*
    **                                  to replace_report_clob, generate_order_xml,*
    **                  				generate_project_xml,generate_report_data  *
    ** 08-NOV-2016   Joydeb Saha        RT#6859721: Modified debugging logic to log based on logging level.
    **                   				This will help reducing the log file size in production.
    ** 09-Nov-2016   Joydeb Saha        Code Merged with changes for CR23505 Addition of New Partner SPECTRUM_AP*
    ** 18-Jan-2017   Joydeb Saha        HPQC#24280: Drop the 'User Item Description' Mapping for Spectrum Model Number
    **                  				for the Bolton Interface with Partner of Spectrum_AP. A new masking key value is introduced.
    ** 04-May-2017   Joydeb Saha      	RT7137886 - Changed generate_project_xml to keep it in SYNC with XSD and XXPA2381.
    ** 18-May-2017   Joydeb Saha      	Merged code 1.3.0.2 (CR23505 code) with 1.4 (Prod fix for RT7137886)
    ** 06-Jul-2017   Joydeb Saha      	Moved branch (1.4.0.1) to Trunk version (1.5)
    ** 20-Jul-2017   Vishnusimman M     CR5963 - submit_xxint_bkg_program is modified to pass proper values to the parameter
    ** 21-Feb-2018   Ashish daga       	Changes for defect # 26717 for invalid country code issue
    ** 30-Oct-2017   Vishnusimman M     CR23783 - Add customer validation to warehouse/OU default logic
    ** 10-JAN-2018   Vishnusimman M   	CR23801 - XXONT1950 - Modify XXONT1950 to Create BPA for new MTO Configuration Items (Light Commercials)
    ** 21-Feb-2018   Ashish daga       	Changes for defect # 26717 for invalid country code issue
    ** 02-Mar-2018   Vishnusimman M     RT7585104 - XXPA2592_EQUIP_ORDER_IN  RETENTION DAYS IS SET TO 120, PLEASE REDUCE TO 60 LIKE OTHER EVENTS
    ** 01-Nov-2018   Vishnusimman M    	CR24018 - Add Arrival Date Type Code for EPL Warehouse orders
    ** 31-Jan-2019   Ranganath T       	RT#8169777 - Changed tag for the payment terms from <PaymentTerm> to <paymentTerm>
    ** 31-Jan-2019   Ranganath T       	RT#8191446  - Added the exception logic when guid for the project creation event is purged
    ** 06-May-2019   Vishnusimman M     CR24082 - Create Billing/Revenue events for SPECTRUM_MEA
    **                                  CR24100 - Bolton to support multi project structure
    **                                  CR23103 - Bolton to populate sales commission on billing lines when applicable
    **                                  CR24104 - Creation of projects only through Spectrum-Bolton integration
    **                                  CR24105 - Supporting new process for milestone billing
    ** 27-Jun-2019   Jyotsana Kandpal   CR24090 - Send Agreement DFF Attribute1 and 2 to XXPA2381 based on XXPA2078 OU level consolidation setup
    ** 21-Aug-2019	 Vishnusimman M     HPQC30256  - Incorrect Event Number sequence for Prepayment Invoice Events
    ** 10-Oct-2019   Vishnusimman M     CR24287 - Update Bolton to pass collector account to XXONT1239
	** 25-Oct-2019   Sachin Kolhe     	Changes for SEP-4548 Lookup/ValueSet/OUOrg Form changes - Effectivity Dates.Enabled Flag Changes
	** 03-Dec-2019   Jai Kumar     	    RT8548644 - Project Task Level has Completion Date since Nov
	** 09-Dec-2019   Roopali Metri      Removed @irco hardcoding as part of MISC JIRA story SEP - 2406
	** 07-Jan-2019   Vishnusimman M     RT8572634 and RT8596434 - Attachment and Project Event sequence fix
	** 31-Jan-2019   Jyotsana Kandpal   CR24421 - Bolt-on to not populate the Virtual Sales location for specific OUs
	** 01-Apr-2020	 Varun R            RT8658437 - XXPA2592 BOLTON TASK_END_DATE IS NULL FOR SPECTRUM_AP PARTNER
    ** 04-Mar-2020   Ravi Alapati       RT8579992 - XXPA2592 - Fix events processing logic to close events properly
    ** 09-Apr-2020   Ravi Alapati       Adding 1.20 changes to 1.18.0.6
	** 16-Jun-2020   Ravi Alapati       19c Upgrade - v$ retrofit changes
    ** 25-Aug-2020 Mousami / Kanak      CR24533 - Bolt-on and Project changes to support Staggered Order Entry process in Asia Snull
    **30-Mar-2021  Kamlesh              CR24595 - map new tag for user_item_desc based on attribute60
	**05-Jun-2023  Sreemanth            CR13475 - attribute42 added for mail for SPECTRUM
	**28-Sep-2023    Ravi Alapati       PTASK0001663 -- break fix for CR13475 enhancments to restore functionality to process multiple
	**                                  ORDER_HEADERs in payload.
	**29-Nov-2023    Sayikrishna R      CR14331(SCTASK0880221)-Removed validation for Project Version in payload sent in by Spectrum_ LA, Spectrum _AP, Spectrum_ MEA
    ***************************************************************************************************/
  --[Start] For Variable Declaration.

  --Global Variable Declaration.
  gv_source_system            xxau_error_headers.source_system%TYPE;
  gv_procedure_name           VARCHAR2(100);
  gv_poo                      VARCHAR2(500);
  gv_source_reference         VARCHAR2(1000) := NULL;
  gv_instance_name            VARCHAR2(1000) := NULL;
  gv_db_name                  VARCHAR2(1000) := NULL;
  gv_namespace                VARCHAR2(2000) := NULL;
  gv_request_type             VARCHAR2(200);
  gv_payload                  CLOB; -- stores payload from XXINT Event. This is an XML message.
  gv_xxpa2381_payload         CLOB; -- stores payload for XXPA2381 XXINT Event. This is an XML message. -- added by Joydeb
  gv_xxont1239_payload        CLOB; -- stores payload for XXONT1239 XXINT Event. This is an XML message. -- added by Joydeb
  gv_xxpa2672_payload         CLOB; -- stores payload for XXONT1239 XXINT Event. This is an XML message. -- added by Joydeb
  gv_guid                     xxint_events_v.guid%TYPE;
  gv_event_id                 xxint_events_v.id%TYPE;
  gv_agr_tbl                  xxpa_proj_in_pkg.g_agr_tbl_t;
  gv_sales_order_header_tbl   g_sales_order_header_tbl_t;
  gv_partner_sync_enabled     VARCHAR2(1);
  gv_project_status_code      VARCHAR2(100);
  gv_agreement_ref            VARCHAR2(200);
  gv_agreement_num            VARCHAR2(200);
  gv_project_num              VARCHAR2(200);
  gv_order_num                VARCHAR2(200);
  gv_prj_version_num          VARCHAR2(200);
  gv_proj_guid                VARCHAR2(2000);
  gv_order_guid               VARCHAR2(2000);
  gv_bill_event_guid          VARCHAR2(2000);
  gv_cust_po_number           VARCHAR2(200);
  gv_proj_status              VARCHAR2(200);
  gv_ship_from_org_id         NUMBER;
  gv_event_current_phase      VARCHAR2(100);
  gv_line_tag_valid           VARCHAR2(1) := 'Y';
  gv_operating_unit           NUMBER;
  gv_carrying_out_org_name    VARCHAR2(250);
  gv_existing_agr_number      pa_agreements_all.agreement_num%type := NULL;
  gv_owning_organization_name VARCHAR2(250);
  gv_owning_organization_code VARCHAR2(250);
  gv_owning_organization_id   VARCHAR2(250);
  gv_user_id                  NUMBER := -1;
  -- Added for CR23505
  g_ship_instr_key_enabled    VARCHAR2(2) := 'N';
  g_ord_hdr_ref_key_enabled   VARCHAR2(2) := 'N';
  g_ord_unique_key_enabled    VARCHAR2(2) := 'N';
  g_price_adj_key_enabled     VARCHAR2(2) := 'N';
  g_Price_adj_reason_code_val VARCHAR2(2000);
  g_Price_adj_reason_key_val  VARCHAR2(2000);

  g_usr_item_desc_key_enabled VARCHAR2(2) := 'N'; --Added by Joydeb as per HPQC#24280

  -- Added for CR24082
  gv_create_proj_events     VARCHAR2(2) := 'N';
  gv_append_cust_po_key_val VARCHAR2(2) := 'N';
  gv_log_level              xxint_event_types.log_level%type := 5;
  gv_custom_proj_flag       VARCHAR2(1) := 'N';---added By Mousami CR24533
  gv_customer_number        VARCHAR2(50);
  gv_attribute42             VARCHAR2(200);--CR13475
  gv1_attribute42             VARCHAR2(200);--CR13475

  --creating record to validate the Sales order amount with task funding
  TYPE gv_so_amount_rec is record(
    order_number varchar2(2400),
    line_num varchar2(2400),
    project_num varchar2(2000),
    task_num varchar2(200),
    unit_price oe_price_atts_iface_all.pricing_attribute8%TYPE,
    ordered_quantity oe_lines_iface_all.ordered_quantity%TYPE,
    operand                      OE_PRICE_ADJS_IFACE_ALL.operand%type,
    arithmetic_operator          OE_PRICE_ADJS_IFACE_ALL.arithmetic_operator%type,
    adjusted_amount   OE_PRICE_ADJS_IFACE_ALL.adjusted_amount%type,
    task_fund number,
    booked_so_amount number,
    remaining_fund number,
    new_so_amount number,
    is_valid varchar2(2)
    );

  TYPE g_so_amount_t IS TABLE OF gv_so_amount_rec INDEX BY BINARY_INTEGER;
  gv_so_amount_tbl g_so_amount_t;
  gv_so_amount_report g_so_amount_t;


  --Added for CR23783 to retrieve address in Value set
  FUNCTION get_formatted_address(p_location_id IN NUMBER) return varchar2 IS
    x_return_status         VARCHAR2(20);
    x_msg_count             NUMBER;
    x_msg_data              VARCHAR2(2000);
    x_formatted_address     VARCHAR2(2000) := NULL;
    x_formatted_lines_cnt   NUMBER;
    x_formatted_address_tbl hz_format_pub.string_tbl_type;
  begin

    hz_format_pub.format_address(
                                 -- input parameters
                                 p_location_id => p_location_id,
                                 p_line_break  => ',',
                                 -- output parameters
                                 x_return_status         => x_return_status,
                                 x_msg_count             => x_msg_count,
                                 x_msg_data              => x_msg_data,
                                 x_formatted_address     => x_formatted_address,
                                 x_formatted_lines_cnt   => x_formatted_lines_cnt,
                                 x_formatted_address_tbl => x_formatted_address_tbl);

    return x_formatted_address;
  exception
    when others then
      return NULL;
  end get_formatted_address;

  /******************************************************************************
  ** Procedure Name  : log_debug
  **
  ** Purpose         : Procedure to log Debug Messages to XXINT Event Log
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ---------------   --------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ** 08-Nov-2016   Joydeb Saha      RT#6859721: Modified debugging logic to log based on logging level.
  **                   This will help reducing the log file size in production.
  ********************************************************************************/
  PROCEDURE log_debug(p_text      VARCHAR2,
                      p_log_level in pls_integer default NULL) IS -- Added parameter by Joydeb as per RT#6859721
  BEGIN
    IF gv_user_id = -1 THEN
      --if event is triggered from PLSQL developer or unix server
      dbms_output.put_line(p_text);
    END IF;
    --    xxau_errors_pkg.write_debug_log(p_module  => gc_interface_name,
    --                                    p_message => p_text);
    --
    --    xxint_xml_util.write_debug(p_text,
    --                               gc_interface_name,
    --                               XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR,--xxint_event_util_site.g_level_event,
    --                               TRUE);

    xxau_errors_pkg.write_debug_log(p_module  => gc_interface_name,
                                    p_message => p_text);
    xxint_xml_util.write_debug(p_text,
                               gc_interface_name,
                               xxint_event_util_site.g_level_event,
                               TRUE);

    --    xxint_xml_util.write_debug('Log Level : '||nvl(p_log_level, gv_log_level)||' : '||p_text,
    --                               gc_interface_name,
    --                               gv_log_level,--nvl(p_log_level, gv_log_level),
    --                               TRUE); -- Commented by Joydeb as per RT#6859721
    --);
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END log_debug;
  /******************************************************************************
  ** Procedure Name  : log_error
  **
  ** Purpose         : Procedure to capture error records for email notification
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ** 08-Nov-2016   Joydeb Saha      RT#6859721: Modified debugging logic to log based on logging level.
  **                   This will help reducing the log file size in production.
  ******************************************************************************/
  PROCEDURE log_error(p_text VARCHAR2) IS
  BEGIN
    log_debug(p_text, XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
    g_error_tbl(g_error_count).error_text := p_text;
    g_error_count := g_error_count + 1;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in log_error Procedure : ' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END log_error;
  /******************************************************************************
  ** Procedure Name  : date_convert
  **
  ** Purpose:  For Converting date
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ******************************************************************************/
  PROCEDURE date_convert(p_in_date IN VARCHAR2, p_out_date OUT DATE) IS
    l_in_date VARCHAR2(2000);
  BEGIN
    --log_debug('Convert Date : ' || p_in_date);
    p_out_date := NULL;
    IF p_out_date is null then
      BEGIN
        SELECT TRUNC(TO_DATE(p_in_date, 'DD-MON-YYYY HH24:MI:SS'))
          INTO p_out_date
          FROM DUAL;
      EXCEPTION
        WHEN OTHERS THEN
          p_out_date := NULL;
      END;
    END IF;
    IF p_out_date is null then
      BEGIN
        SELECT TRUNC(TO_DATE(p_in_date, 'DD-MON-YYYY HH:MI:SS AM'))
          INTO p_out_date
          FROM DUAL;
      EXCEPTION
        WHEN OTHERS THEN
          p_out_date := NULL;
      END;
    END IF;
    IF p_out_date is null then
      BEGIN
        SELECT TRUNC(TO_DATE(p_in_date, 'DD-MON-YYYY'))
          INTO p_out_date
          FROM DUAL;
      EXCEPTION
        WHEN OTHERS THEN
          p_out_date := NULL;
      END;
    END IF;
    IF p_out_date is null then
      BEGIN
        SELECT TRUNC(TO_DATE(p_in_date, 'DD/MM/YYYY'))
          INTO p_out_date
          FROM DUAL;
      EXCEPTION
        WHEN OTHERS THEN
          p_out_date := NULL;
      END;
    END IF;
    IF p_out_date is null then
      BEGIN
        SELECT TRUNC(TO_DATE(p_in_date, 'MM/DD/YYYY'))
          INTO p_out_date
          FROM DUAL;
      EXCEPTION
        WHEN OTHERS THEN
          p_out_date := NULL;
      END;
    END IF;
    IF p_out_date is null then
      BEGIN
        SELECT TRUNC(TO_DATE(p_in_date, 'RRRR-MM-DD"T"HH24:MI:SS'))
        -- Add Trunc for HPQC#16715
          INTO p_out_date
          FROM DUAL;
      EXCEPTION
        WHEN OTHERS THEN
          p_out_date := NULL;
      END;
    END IF;
    IF p_out_date is null then
      p_out_date := p_in_date;
    end if;
    log_debug('Return Convert date(' || p_in_date || ') : ' || p_out_date);
  EXCEPTION
    WHEN OTHERS THEN
      p_out_date := p_in_date;
  END date_convert;
  /******************************************************************************
  ** Procedure Name  : validate_project_event
  **
  ** Purpose:  Procedure to Validate Project Event Creation
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 29-Jun-2019   ccbssj            Initial Version. CR24082                  *
  ******************************************************************************/
  PROCEDURE validate_project_event(p_project_number IN VARCHAR2,
                                   p_task_number    IN VARCHAR2,
                                   p_inventory_item in varchar2) IS
    l_master_org_id number := xxont_common_utility_pkg2.get_master_org(NULL);
    l_event_exists  varchar2(2) := 'N';
  begin

    for i in g_proj_event_data_rec.first .. g_proj_event_data_rec.last loop
      l_event_exists := 'N';
      begin
        select decode(count(1), 0, 'N', 'Y')
          into l_event_exists
          from pa_events
         where event_type = g_proj_event_data_rec(i).P_event_type
           and PM_EVENT_REFERENCE = g_proj_event_data_rec(i)
              .P_PM_EVENT_REFERENCE;
      exception
        when no_data_found then
          l_event_exists := 'N';
        when others then
          log_debug('Exception in Event Validation: ' || SQLERRM);
          l_event_exists := 'N';
      end;

      --If Event Exists Mark event create flag to 'N' to avoid duplicate event creation
      if l_event_exists = 'Y' then
        g_proj_event_data_rec(i).p_create_event_flag := 'N';
      end if;

      --Create Revenue Event only for Tasks which are not available in Project Order Lines
      if g_proj_event_data_rec(i)
       .p_project_number = p_project_number and g_proj_event_data_rec(i)
         .p_task_number = p_task_number and g_proj_event_data_rec(i)
         .P_BILL_TRANS_REV_AMOUNT <> 0 and
          NVL(g_proj_event_data_rec(i).p_create_event_flag, 'Y') = 'Y' THEN
        g_proj_event_data_rec(i).p_create_event_flag := 'N';
      end if;

    end loop;

  exception
    when others then
      log_debug('Exception in Validate Project Event Procedure : ' ||
                SQLERRM);
      log_debug(DBMS_UTILITY.FORMAT_ERROR_STACK || '-' ||
                          DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
  end validate_project_event;

  --Start of Added for CR23274 XXONT3030
  /******************************************************************************
  ** Procedure Name  : get_report_clob
  **
  ** Purpose:  Procedure to update missing G_REPORT_CLOB data in XXINT_EVENT_CLOBS user for XXONT3030
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 29-Feb-2016   ccbssj            Initial Version. CR23274                  *
  ******************************************************************************/
  PROCEDURE get_report_clob(p_event_current_phase VARCHAR2,
                            p_guid                VARCHAR2) IS
    lv_event_current_phase VARCHAR2(20);
    lv_phase01_attempts    NUMBER;
    lv_phase02_attempts    NUMBER;
    lv_phase03_attempts    NUMBER;
    lv_phase04_attempts    NUMBER;
    lv_phase05_attempts    NUMBER;
    lv_check_error_clob    VARCHAR2(1) := 'N';
    l_retcode              VARCHAR2(100) := NULL;
    l_retmesg              VARCHAR2(4000) := NULL;
  BEGIN
    lv_event_current_phase := gv_event_current_phase;
    --
    IF p_guid IS NOT NULL THEN
      gv_guid := p_guid;
    END IF;
    --
    SELECT DECODE(COUNT(1), 0, 'N', 'Y')
      INTO lv_check_error_clob
      FROM xxint_event_clobs
     WHERE guid = gv_guid
       AND clob_code = 'G_ERROR_DATA';
    --
    log_debug('Error Data Exists : ' || lv_check_error_clob);
    IF lv_check_error_clob = 'Y' THEN
      g_error_tbl.delete;
      FOR c_error_data IN (SELECT rownum error_count,
                                  extractvalue(tmp_m.column_value,
                                               '/G_ERROR_DATA/ERROR_DATA',
                                               gv_namespace) AS ERROR_MESSAGE
                             FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'G_ERROR_DATA'))
                                                    .extract('//G_ERROR_DATA',
                                                             gv_namespace))) tmp_m) LOOP
        log_debug('Error Message : ' || gv_event_current_phase);
        g_error_tbl(c_error_data.error_count).error_text := c_error_data.ERROR_MESSAGE;
      END LOOP;
    END IF;
    log_debug('Report Current Phase : ' || lv_event_current_phase);
    --
    IF p_guid IS NOT NULL OR gv_guid IS NOT NULL THEN
      SELECT phase01_attempts,
             phase02_attempts,
             phase03_attempts,
             phase04_attempts,
             phase05_attempts
        INTO lv_phase01_attempts,
             lv_phase02_attempts,
             lv_phase03_attempts,
             lv_phase04_attempts,
             lv_phase05_attempts
        FROM apps.xxint_events
       WHERE event_type = gc_event_type
         AND guid = NVL(p_guid, gv_guid);
    END IF;
    --
    log_debug('Phase Attempts: ' || lv_phase01_attempts || '-' ||
              lv_phase02_attempts || '-' || lv_phase03_attempts || '-' ||
              lv_phase04_attempts || '-' || lv_phase05_attempts);
    --
    --
    IF lv_phase01_attempts <> 0 OR p_event_current_phase = 'PHASE01' THEN
      gv_event_current_phase := 'PHASE01';
      xxint_event_api_pub.lock_event(x_retcode => l_retcode,
                                     x_retmesg => l_retmesg,
                                     p_guid    => gv_guid);
      log_debug('Calling ' || gv_event_current_phase || 'Generete Data');
      generate_report_data;
      xxint_event_api_pub.unlock_event(p_guid => gv_guid);
    END IF;
    --
    IF lv_phase02_attempts <> 0 OR p_event_current_phase = 'PHASE02' THEN
      gv_event_current_phase := 'PHASE02';
      log_debug('Calling ' || gv_event_current_phase || 'Generete Data');
      generate_report_data;
    END IF;
    --
    IF lv_phase03_attempts <> 0 OR p_event_current_phase = 'PHASE03' THEN
      gv_event_current_phase := 'PHASE03';
      log_debug('Calling ' || gv_event_current_phase || 'Generete Data');
      generate_report_data;
    END IF;
    --
    IF lv_phase04_attempts <> 0 OR p_event_current_phase = 'PHASE04' THEN
      gv_event_current_phase := 'PHASE04';
      log_debug('Calling ' || gv_event_current_phase || 'Generete Data');
      generate_report_data;
    END IF;
    --
    IF lv_phase05_attempts <> 0 OR p_event_current_phase = 'PHASE05' THEN
      gv_event_current_phase := 'PHASE05';
      log_debug('Calling ' || gv_event_current_phase || 'Generete Data');
      generate_report_data;
    END IF;
    --
    gv_event_current_phase := lv_event_current_phase;
    --
  END get_report_clob;
  /******************************************************************************
  ** Procedure Name  : get_report_clob
  **
  ** Purpose:  Procedure to get G_REPORT_CLOB data to g_report_rec variable
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 29-Feb-2016   ccbssj            Initial Version. CR23274                  *
  ******************************************************************************/
  PROCEDURE get_report_clob IS
    lv_report_clob_flag VARCHAR2(2);
  BEGIN
    -- Check if report Clobs is available. Proceed if Report Clob is only
    SELECT DECODE(COUNT(1), 0, 'N', 'Y')
      INTO lv_report_clob_flag
      FROM apps.xxint_event_clobs
     WHERE guid = gv_guid
       AND clob_code = 'G_REPORT_DATA';
    IF lv_report_clob_flag = 'N' THEN
      get_report_clob(NULL, gv_guid);
    END IF;
    --
    --Initialize Report Rec variable
    g_report_rec.delete;
    --
    -- Check if report Clobs is available. Proceed if Report Clob is only
    SELECT DECODE(COUNT(1), 0, 'N', 'Y')
      INTO lv_report_clob_flag
      FROM apps.xxint_event_clobs
     WHERE guid = gv_guid
       AND clob_code = 'G_REPORT_DATA';
    IF lv_report_clob_flag = 'Y' THEN
      FOR c_report_data IN (SELECT rownum l_rownum,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/GUID',
                                                gv_namespace) AS GUID,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/EVENT_CREATION_DATE',
                                                gv_namespace) AS EVENT_CREATION_DATE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/EVENT_STATUS',
                                                gv_namespace) AS EVENT_STATUS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PARTNER_CODE',
                                                gv_namespace) AS PARTNER_CODE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/REQUEST_TYPE',
                                                gv_namespace) AS REQUEST_TYPE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PM_AGREEMENT_REFERENCE',
                                                gv_namespace) AS PM_AGREEMENT_REFERENCE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/AGREEMENT_NUM',
                                                gv_namespace) AS AGREEMENT_NUM,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/AGREEMENT_TYPE',
                                                gv_namespace) AS AGREEMENT_TYPE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PO_AMOUNT',
                                                gv_namespace) AS PO_AMOUNT,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/CURRENCY_CODE',
                                                gv_namespace) AS CURRENCY_CODE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/CUSTOMER_PO_NUMBER',
                                                gv_namespace) AS CUSTOMER_PO_NUMBER,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PM_PRODUCT_CODE',
                                                gv_namespace) AS PM_PRODUCT_CODE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/OWNING_ORGANIZATION_CODE',
                                                gv_namespace) AS OWNING_ORGANIZATION_CODE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/OWNING_ORGANIZATION_NAME',
                                                gv_namespace) AS OWNING_ORGANIZATION_NAME,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/CUSTOMER_NUMBER',
                                                gv_namespace) AS CUSTOMER_NUMBER,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/BILL_TO_PARTY_SITE_ID',
                                                gv_namespace) AS BILL_TO_PARTY_SITE_ID,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PAYMENT_TERMS',
                                                gv_namespace) AS PAYMENT_TERMS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PA_PROJECT_NUMBER',
                                                gv_namespace) AS PA_PROJECT_NUMBER,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/PROJECT_NAME',
                                                gv_namespace) AS PROJECT_NAME,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/DESCRIPTION',
                                                gv_namespace) AS DESCRIPTION,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/START_DATE',
                                                gv_namespace) AS START_DATE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/COMPLETION_DATE',
                                                gv_namespace) AS COMPLETION_DATE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_ORACLE_ORDER_NUMBER',
                                                gv_namespace) AS ORD_ORACLE_ORDER_NUMBER,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_ORACLE_ORDER_STATUS',
                                                gv_namespace) AS ORD_ORACLE_ORDER_STATUS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_ORG_CODE',
                                                gv_namespace) AS ORD_ORG_CODE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_REQUEST_DATE',
                                                gv_namespace) AS ORD_REQUEST_DATE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_TRANSACTIONAL_CURR_CODE',
                                                gv_namespace) AS ORD_TRANSACTIONAL_CURR_CODE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_SHIPPING_METHOD',
                                                gv_namespace) AS ORD_SHIPPING_METHOD,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_FOB',
                                                gv_namespace) AS ORD_FOB,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_FREIGHT_TERMS',
                                                gv_namespace) AS ORD_FREIGHT_TERMS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ORD_ATTRIBUTE19',
                                                gv_namespace) AS ORD_ATTRIBUTE19,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ILC_NAME',
                                                gv_namespace) AS ILC_NAME,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXPA2381_GUID',
                                                gv_namespace) AS XXPA2381_GUID,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXPA2381_PHASE',
                                                gv_namespace) AS XXPA2381_PHASE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXPA2381_STATUS',
                                                gv_namespace) AS XXPA2381_STATUS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXONT1239_GUID',
                                                gv_namespace) AS XXONT1239_GUID,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXONT1239_PHASE',
                                                gv_namespace) AS XXONT1239_PHASE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXONT1239_STATUS',
                                                gv_namespace) AS XXONT1239_STATUS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXPA2672_GUID',
                                                gv_namespace) AS XXPA2672_GUID,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXPA2672_PHASE',
                                                gv_namespace) AS XXPA2672_PHASE,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/XXPA2672_STATUS',
                                                gv_namespace) AS XXPA2672_STATUS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/EVENT_CURRENT_STATUS',
                                                gv_namespace) AS EVENT_CURRENT_STATUS,
                                   extractvalue(tmp_m.column_value,
                                                'REPORT_DATA/ERROR_MESSAGE',
                                                gv_namespace) AS ERROR_MESSAGE
                              FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'G_REPORT_DATA'))
                                                     .extract('//G_REPORT_DATA/REPORT_DATA',
                                                              gv_namespace))) tmp_m) LOOP
        g_report_rec(c_report_data.l_rownum).GUID := c_report_data.GUID;
        g_report_rec(c_report_data.l_rownum).EVENT_STATUS := c_report_data.EVENT_STATUS;
        g_report_rec(c_report_data.l_rownum).PARTNER_CODE := c_report_data.PARTNER_CODE;
        g_report_rec(c_report_data.l_rownum).REQUEST_TYPE := c_report_data.REQUEST_TYPE;
        g_report_rec(c_report_data.l_rownum).PM_AGREEMENT_REFERENCE := c_report_data.PM_AGREEMENT_REFERENCE;
        g_report_rec(c_report_data.l_rownum).AGREEMENT_NUM := c_report_data.AGREEMENT_NUM;
        g_report_rec(c_report_data.l_rownum).AGREEMENT_TYPE := c_report_data.AGREEMENT_TYPE;
        g_report_rec(c_report_data.l_rownum).PO_AMOUNT := c_report_data.PO_AMOUNT;
        g_report_rec(c_report_data.l_rownum).CURRENCY_CODE := c_report_data.CURRENCY_CODE;
        g_report_rec(c_report_data.l_rownum).CUSTOMER_PO_NUMBER := c_report_data.CUSTOMER_PO_NUMBER;
        g_report_rec(c_report_data.l_rownum).PM_PRODUCT_CODE := c_report_data.PM_PRODUCT_CODE;
        g_report_rec(c_report_data.l_rownum).OWNING_ORGANIZATION_CODE := c_report_data.OWNING_ORGANIZATION_CODE;
        g_report_rec(c_report_data.l_rownum).OWNING_ORGANIZATION_NAME := c_report_data.OWNING_ORGANIZATION_NAME;
        g_report_rec(c_report_data.l_rownum).CUSTOMER_NUMBER := c_report_data.CUSTOMER_NUMBER;
        g_report_rec(c_report_data.l_rownum).BILL_TO_PARTY_SITE_ID := c_report_data.BILL_TO_PARTY_SITE_ID;
        g_report_rec(c_report_data.l_rownum).PAYMENT_TERMS := c_report_data.PAYMENT_TERMS;
        g_report_rec(c_report_data.l_rownum).PA_PROJECT_NUMBER := c_report_data.PA_PROJECT_NUMBER;
        g_report_rec(c_report_data.l_rownum).PROJECT_NAME := c_report_data.PROJECT_NAME;
        g_report_rec(c_report_data.l_rownum).DESCRIPTION := c_report_data.DESCRIPTION;
        g_report_rec(c_report_data.l_rownum).ORD_ORACLE_ORDER_NUMBER := c_report_data.ORD_ORACLE_ORDER_NUMBER;
        g_report_rec(c_report_data.l_rownum).ORD_ORACLE_ORDER_STATUS := c_report_data.ORD_ORACLE_ORDER_STATUS;
        g_report_rec(c_report_data.l_rownum).ORD_ORG_CODE := c_report_data.ORD_ORG_CODE;
        g_report_rec(c_report_data.l_rownum).ORD_TRANSACTIONAL_CURR_CODE := c_report_data.ORD_TRANSACTIONAL_CURR_CODE;
        g_report_rec(c_report_data.l_rownum).ORD_SHIPPING_METHOD := c_report_data.ORD_SHIPPING_METHOD;
        g_report_rec(c_report_data.l_rownum).ORD_FOB := c_report_data.ORD_FOB;
        g_report_rec(c_report_data.l_rownum).ORD_FREIGHT_TERMS := c_report_data.ORD_FREIGHT_TERMS;
        g_report_rec(c_report_data.l_rownum).ORD_ATTRIBUTE19 := c_report_data.ORD_ATTRIBUTE19;
        g_report_rec(c_report_data.l_rownum).ILC_NAME := c_report_data.ILC_NAME;
        g_report_rec(c_report_data.l_rownum).XXPA2381_GUID := c_report_data.XXPA2381_GUID;
        g_report_rec(c_report_data.l_rownum).XXPA2381_PHASE := c_report_data.XXPA2381_PHASE;
        g_report_rec(c_report_data.l_rownum).XXPA2381_STATUS := c_report_data.XXPA2381_STATUS;
        g_report_rec(c_report_data.l_rownum).XXONT1239_GUID := c_report_data.XXONT1239_GUID;
        g_report_rec(c_report_data.l_rownum).XXONT1239_PHASE := c_report_data.XXONT1239_PHASE;
        g_report_rec(c_report_data.l_rownum).XXONT1239_STATUS := c_report_data.XXONT1239_STATUS;
        g_report_rec(c_report_data.l_rownum).XXPA2672_GUID := c_report_data.XXPA2672_GUID;
        g_report_rec(c_report_data.l_rownum).XXPA2672_PHASE := c_report_data.XXPA2672_PHASE;
        g_report_rec(c_report_data.l_rownum).XXPA2672_STATUS := c_report_data.XXPA2672_STATUS;
        g_report_rec(c_report_data.l_rownum).EVENT_CURRENT_STATUS := c_report_data.EVENT_CURRENT_STATUS;
        g_report_rec(c_report_data.l_rownum).ERROR_MESSAGE := c_report_data.ERROR_MESSAGE;
        BEGIN
          g_report_rec(c_report_data.l_rownum).EVENT_CREATION_DATE := to_date(c_report_data.EVENT_CREATION_DATE,
                                                                              'DD-MON-YYYY HH24:MI:SS');
          g_report_rec(c_report_data.l_rownum).START_DATE := to_date(c_report_data.START_DATE,
                                                                     'DD-MON-YYYY HH24:MI:SS');
          g_report_rec(c_report_data.l_rownum).COMPLETION_DATE := to_date(c_report_data.COMPLETION_DATE,
                                                                          'DD-MON-YYYY HH24:MI:SS');
          g_report_rec(c_report_data.l_rownum).ORD_REQUEST_DATE := to_date(c_report_data.ORD_REQUEST_DATE,
                                                                           'DD-MON-YYYY HH24:MI:SS');
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      END LOOP;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in get_report_clob :' ||
                SUBSTR(sqlerrm, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END get_report_clob;
  /******************************************************************************
  ** Procedure Name  : replace_report_clob
  **
  ** Purpose:  Procedure to write g_report_rec data to G_REPORT_CLOB CLOB in XXINT_EVENT_CLOBS
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 29-Feb-2016   ccbssj            Initial Version. CR23274                  *
  ******************************************************************************/
  PROCEDURE replace_report_clob IS
    l_report_clob CLOB;
    l_count       NUMBER;
  BEGIN
    l_count := 0;
    FOR i IN 1 .. g_report_rec.count LOOP
      IF l_count = 0 THEN
        l_report_clob := '<G_REPORT_DATA>';
        l_count       := 1;
      END IF;
      dbms_lob.append(l_report_clob, '<REPORT_DATA>');
      dbms_lob.append(l_report_clob,
                      '<GUID>' || g_report_rec(i).GUID || '</GUID>');
      dbms_lob.append(l_report_clob,
                      '<EVENT_CREATION_DATE>' ||
                      TO_CHAR(g_report_rec(i).EVENT_CREATION_DATE,
                              'DD-MON-YYYY HH24:MI:SS') ||
                      '</EVENT_CREATION_DATE>');
      dbms_lob.append(l_report_clob,
                      '<EVENT_STATUS>' || g_report_rec(i).EVENT_STATUS ||
                      '</EVENT_STATUS>');
      dbms_lob.append(l_report_clob,
                      '<PARTNER_CODE>' || g_report_rec(i).PARTNER_CODE ||
                      '</PARTNER_CODE>');
      dbms_lob.append(l_report_clob,
                      '<REQUEST_TYPE>' || g_report_rec(i).REQUEST_TYPE ||
                      '</REQUEST_TYPE>');
      dbms_lob.append(l_report_clob,
                      '<PM_AGREEMENT_REFERENCE>' ||
                      dbms_xmlgen.convert(g_report_rec(i)
                                          .PM_AGREEMENT_REFERENCE,
                                          0) || '</PM_AGREEMENT_REFERENCE>');
      dbms_lob.append(l_report_clob,
                      '<AGREEMENT_NUM>' ||
                      dbms_xmlgen.convert(g_report_rec(i).AGREEMENT_NUM, 0) ||
                      '</AGREEMENT_NUM>');
      dbms_lob.append(l_report_clob,
                      '<AGREEMENT_TYPE>' || g_report_rec(i).AGREEMENT_TYPE ||
                      '</AGREEMENT_TYPE>');
      dbms_lob.append(l_report_clob,
                      '<PO_AMOUNT>' || g_report_rec(i).PO_AMOUNT ||
                      '</PO_AMOUNT>');
      dbms_lob.append(l_report_clob,
                      '<CURRENCY_CODE>' || g_report_rec(i).CURRENCY_CODE ||
                      '</CURRENCY_CODE>');
      dbms_lob.append(l_report_clob,
                      '<CUSTOMER_PO_NUMBER>' ||
                      dbms_xmlgen.convert(g_report_rec(i).CUSTOMER_PO_NUMBER,
                                          0) || '</CUSTOMER_PO_NUMBER>');
      dbms_lob.append(l_report_clob,
                      '<PM_PRODUCT_CODE>' || g_report_rec(i)
                      .PM_PRODUCT_CODE || '</PM_PRODUCT_CODE>');
      dbms_lob.append(l_report_clob,
                      '<OWNING_ORGANIZATION_CODE>' || g_report_rec(i)
                      .OWNING_ORGANIZATION_CODE ||
                       '</OWNING_ORGANIZATION_CODE>');
      dbms_lob.append(l_report_clob,
                      '<OWNING_ORGANIZATION_NAME>' ||
                      dbms_xmlgen.convert(g_report_rec(i)
                                          .OWNING_ORGANIZATION_NAME,
                                          0) ||
                      '</OWNING_ORGANIZATION_NAME>');
      dbms_lob.append(l_report_clob,
                      '<CUSTOMER_NUMBER>' || g_report_rec(i)
                      .CUSTOMER_NUMBER || '</CUSTOMER_NUMBER>');
      dbms_lob.append(l_report_clob,
                      '<BILL_TO_PARTY_SITE_ID>' || g_report_rec(i)
                      .BILL_TO_PARTY_SITE_ID || '</BILL_TO_PARTY_SITE_ID>');
      dbms_lob.append(l_report_clob,
                      '<PAYMENT_TERMS>' || g_report_rec(i).PAYMENT_TERMS ||
                      '</PAYMENT_TERMS>');
      dbms_lob.append(l_report_clob,
                      '<PA_PROJECT_NUMBER>' || g_report_rec(i)
                      .PA_PROJECT_NUMBER || '</PA_PROJECT_NUMBER>');
      dbms_lob.append(l_report_clob,
                      '<PROJECT_NAME>' ||
                      dbms_xmlgen.convert(g_report_rec(i).PROJECT_NAME, 0) ||
                      '</PROJECT_NAME>');
      dbms_lob.append(l_report_clob,
                      '<DESCRIPTION>' ||
                      dbms_xmlgen.convert(g_report_rec(i).DESCRIPTION, 0) ||
                      '</DESCRIPTION>');
      dbms_lob.append(l_report_clob,
                      '<START_DATE>' ||
                      TO_CHAR(g_report_rec(i).START_DATE,
                              'DD-MON-YYYY HH24:MI:SS') || '</START_DATE>');
      dbms_lob.append(l_report_clob,
                      '<PROJECT_STATUS>' || g_report_rec(i).PROJECT_STATUS ||
                      '</PROJECT_STATUS>');
      dbms_lob.append(l_report_clob,
                      '<COMPLETION_DATE>' ||
                      TO_CHAR(g_report_rec(i).COMPLETION_DATE,
                              'DD-MON-YYYY HH24:MI:SS') ||
                      '</COMPLETION_DATE>');
      dbms_lob.append(l_report_clob,
                      '<ORD_ORACLE_ORDER_NUMBER>' || g_report_rec(i)
                      .ORD_ORACLE_ORDER_NUMBER ||
                       '</ORD_ORACLE_ORDER_NUMBER>');
      dbms_lob.append(l_report_clob,
                      '<ORD_ORACLE_ORDER_STATUS>' || g_report_rec(i)
                      .ORD_ORACLE_ORDER_STATUS ||
                       '</ORD_ORACLE_ORDER_STATUS>');
      dbms_lob.append(l_report_clob,
                      '<ORD_ORG_CODE>' || g_report_rec(i).ORD_ORG_CODE ||
                      '</ORD_ORG_CODE>');
      dbms_lob.append(l_report_clob,
                      '<ORD_REQUEST_DATE>' ||
                      TO_CHAR(g_report_rec(i).ORD_REQUEST_DATE,
                              'DD-MON-YYYY HH24:MI:SS') ||
                      '</ORD_REQUEST_DATE>');
      dbms_lob.append(l_report_clob,
                      '<ORD_TRANSACTIONAL_CURR_CODE>' || g_report_rec(i)
                      .ORD_TRANSACTIONAL_CURR_CODE ||
                       '</ORD_TRANSACTIONAL_CURR_CODE>');
      dbms_lob.append(l_report_clob,
                      '<ORD_SHIPPING_METHOD>' ||
                      dbms_xmlgen.convert(g_report_rec(i)
                                          .ORD_SHIPPING_METHOD,
                                          0) || '</ORD_SHIPPING_METHOD>');
      dbms_lob.append(l_report_clob,
                      '<ORD_FOB>' ||
                      dbms_xmlgen.convert(g_report_rec(i).ORD_FOB, 0) ||
                      '</ORD_FOB>');
      dbms_lob.append(l_report_clob,
                      '<ORD_FREIGHT_TERMS>' ||
                      dbms_xmlgen.convert(g_report_rec(i).ORD_FREIGHT_TERMS,
                                          0) || '</ORD_FREIGHT_TERMS>');
      dbms_lob.append(l_report_clob,
                      '<ORD_ATTRIBUTE19>' ||
                      dbms_xmlgen.convert(g_report_rec(i).ORD_ATTRIBUTE19,
                                          0) || '</ORD_ATTRIBUTE19>');
      dbms_lob.append(l_report_clob,
                      '<ILC_NAME>' ||
                      dbms_xmlgen.convert(g_report_rec(i).ILC_NAME, 0) ||
                      '</ILC_NAME>');
      dbms_lob.append(l_report_clob,
                      '<XXPA2381_GUID>' || g_report_rec(i).XXPA2381_GUID ||
                      '</XXPA2381_GUID>');
      dbms_lob.append(l_report_clob,
                      '<XXPA2381_PHASE>' || g_report_rec(i).XXPA2381_PHASE ||
                      '</XXPA2381_PHASE>');
      dbms_lob.append(l_report_clob,
                      '<XXPA2381_STATUS>' || g_report_rec(i)
                      .XXPA2381_STATUS || '</XXPA2381_STATUS>');
      dbms_lob.append(l_report_clob,
                      '<XXONT1239_GUID>' || g_report_rec(i).XXONT1239_GUID ||
                      '</XXONT1239_GUID>');
      dbms_lob.append(l_report_clob,
                      '<XXONT1239_PHASE>' || g_report_rec(i)
                      .XXONT1239_PHASE || '</XXONT1239_PHASE>');
      dbms_lob.append(l_report_clob,
                      '<XXONT1239_STATUS>' || g_report_rec(i)
                      .XXONT1239_STATUS || '</XXONT1239_STATUS>');
      dbms_lob.append(l_report_clob,
                      '<XXPA2672_GUID>' || g_report_rec(i).XXPA2672_GUID ||
                      '</XXPA2672_GUID>');
      dbms_lob.append(l_report_clob,
                      '<XXPA2672_PHASE>' || g_report_rec(i).XXPA2672_PHASE ||
                      '</XXPA2672_PHASE>');
      dbms_lob.append(l_report_clob,
                      '<XXPA2672_STATUS>' || g_report_rec(i)
                      .XXPA2672_STATUS || '</XXPA2672_STATUS>');
      dbms_lob.append(l_report_clob,
                      '<EVENT_CURRENT_STATUS>' || g_report_rec(i)
                      .EVENT_CURRENT_STATUS || '</EVENT_CURRENT_STATUS>');
      IF g_report_rec(i).ORD_ORACLE_ORDER_NUMBER IS NOT NULL THEN
        dbms_lob.append(l_report_clob, '<ERROR_MESSAGE></ERROR_MESSAGE>');
      ELSE
        dbms_lob.append(l_report_clob, '<ERROR_MESSAGE>');
        IF g_report_rec(i).error_message IS NOT NULL THEN
          dbms_lob.append(l_report_clob,
                          dbms_xmlgen.convert(g_report_rec(i).error_message,
                                              0) || '. ');
        END IF;
        IF g_error_tbl.count > 0 THEN
          FOR l_error_cnt IN 1 .. g_error_tbl.count LOOP
            dbms_lob.append(l_report_clob,
                            dbms_xmlgen.convert(g_error_tbl(l_error_cnt)
                                                .error_text,
                                                0) || '. ');
          END LOOP;
        END IF;
        dbms_lob.append(l_report_clob, '</ERROR_MESSAGE>');
      END IF;
      dbms_lob.append(l_report_clob, '</REPORT_DATA>');
    END LOOP;
    IF l_count <> 0 THEN
      dbms_lob.append(l_report_clob, '</G_REPORT_DATA>');
      xxint_event_api_pub.replace_clob(gv_guid,
                                       'G_REPORT_DATA',
                                       l_report_clob);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in Replace_report_clob :' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END replace_report_clob;
  /******************************************************************************
  ** Procedure Name  : generate_report_data
  **
  ** Purpose:  Procedure to generate/update g_report_rec in different phases of xxint event
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 29-Feb-2016   ccbssj            Initial Version. CR23274                  *
  ******************************************************************************/
  PROCEDURE generate_report_data IS
    l_ilc_name            VARCHAR2(2000);
    l_event_creation_date XXINT_EVENTS.CREATION_DATE%TYPE := sysdate;
    l_event_status        XXINT_EVENTS.ATTRIBUTE3%TYPE;
    l_error_count         NUMBER;
    l_proj_rev_count      NUMBER;
    l_pjm_count           NUMBER;
    l_error_message       VARCHAR2(2000);
    l_order_clob_flag     VARCHAR2(1) := 'N';
    CURSOR c_report_data IS
      SELECT rownum l_rownum,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/CONTROL_AREA/PARTNER_CODE',
                          gv_namespace) AS PARTNER_CODE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/ORDER_TYPE',
                          gv_namespace) AS REQUEST_TYPE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/PM_AGREEMENT_REFERENCE',
                          gv_namespace) AS PM_AGREEMENT_REFERENCE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/AGREEMENT_NUM',
                          gv_namespace) AS AGREEMENT_NUM,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/AGREEMENT_TYPE',
                          gv_namespace) AS AGREEMENT_TYPE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/PO_AMOUNT',
                          gv_namespace) AS PO_AMOUNT,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CURRENCY_CODE',
                          gv_namespace) AS CURRENCY_CODE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CUSTOMER_PO_NUMBER',
                          gv_namespace) AS CUSTOMER_PO_NUMBER,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/PM_PRODUCT_CODE',
                          gv_namespace) AS PM_PRODUCT_CODE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/OWNING_ORGANIZATION_CODE',
                          gv_namespace) AS OWNING_ORGANIZATION_CODE,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/OWNING_ORGANIZATION_NAME',
                          gv_namespace) AS OWNING_ORGANIZATION_NAME,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CUSTOMER_INFO/CUSTOMER_NUMBER',
                          gv_namespace) AS CUSTOMER_NUMBER,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CUSTOMER_INFO/BILL_TO_PARTY_SITE_ID',
                          gv_namespace) AS BILL_TO_PARTY_SITE_ID,
             extractvalue(tmp_m.column_value,
                          'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CUSTOMER_INFO/PAYMENT_TERMS',
                          gv_namespace) AS PAYMENT_TERMS,
             DECODE(extractvalue(tmp_m.column_value,
                                 'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/ORDER_TYPE',
                                 gv_namespace),
                    'P',
                    extract(tmp_m.column_value,
                            'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_PROJECTS',
                            gv_namespace),
                    NULL) G_PROJECTS,
             extract(tmp_m.column_value,
                     'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_ORDER',
                     gv_namespace) G_ORDER,
             xxint_event_api_pub.get_event_clob(gv_guid,
                                                'G_PROJ_EVENT_GUID') G_PROJ_EVENT_GUID
        FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                               .extract('//EBS_PROJECT_ORDER', gv_namespace))) tmp_m;
  BEGIN
    log_debug('In Event Report Clob');
    g_report_rec.delete;
    --
    BEGIN
      SELECT creation_date, attribute3
        INTO l_event_creation_date, l_event_status
        FROM xxint_events
       WHERE guid = gv_guid;
    EXCEPTION
      WHEN OTHERS THEN
        log_debug('Exception in Event Creation Date ' ||
                  SUBSTR(SQLERRM, 1, 200),
                  XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
    END;
    IF gv_event_current_phase <> 'PHASE01' THEN
      log_debug('Callling Report Clobs Data Read');
      get_report_clob;
    END IF;
    -- If PHASE01 then generate the G_REPORT_DATA clob for first time.
    -- If other phases read the G_REPORT_DATA clob and update values according to the phases
    IF gv_event_current_phase = 'PHASE01' THEN
      FOR c1_data IN c_report_data LOOP
        if c1_data.g_order is not null then
          FOR c3_data IN (SELECT rownum l_rownum,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/ORG_CODE',
                                              gv_namespace) AS ORG_CODE,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/REQUEST_DATE',
                                              gv_namespace) AS REQUEST_DATE,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/TRANSACTIONAL_CURR_CODE',
                                              gv_namespace) AS TRANSACTIONAL_CURR_CODE,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/SHIPPING_METHOD',
                                              gv_namespace) AS SHIPPING_METHOD,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/FOB',
                                              gv_namespace) AS FOB,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/FREIGHT_TERMS',
                                              gv_namespace) AS FREIGHT_TERMS,
                                 extractvalue(tmp_m.column_value,
                                              'ORDER_HEADER/ATTRIBUTE19',
                                              gv_namespace) AS ATTRIBUTE19,
                                 extract(tmp_m.column_value,
                                         'ORDER_HEADER/G_ORDER_LINE',
                                         gv_namespace) G_ORDER_LINE
                            FROM TABLE(xmlsequence(c1_data.g_order.extract('//G_ORDER/ORDER_HEADER',
                                                                           gv_namespace))) tmp_m) LOOP
            FOR c4_data IN (SELECT extract(tmp_m.column_value,
                                           'ORDER_LINE/G_ADDITIONAL_ATTRS',
                                           gv_namespace) G_ADDITIONAL_ATTRS
                              FROM TABLE(xmlsequence(c3_data.G_ORDER_LINE.extract('//G_ORDER_LINE/ORDER_LINE',
                                                                                  gv_namespace))) tmp_m) LOOP
              BEGIN
                SELECT extractvalue(tmp_m.column_value,
                                    'ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                    gv_namespace) AS PAYMENT_TERMS
                  INTO l_ilc_name
                  FROM TABLE(xmlsequence(c4_data.G_ADDITIONAL_ATTRS.extract('//G_ADDITIONAL_ATTRS/ADDITIONAL_ATTRIBUTE',
                                                                            gv_namespace))) tmp_m
                 WHERE extractvalue(tmp_m.column_value,
                                    'ADDITIONAL_ATTRIBUTE/ATTRIBUTE_NAME',
                                    gv_namespace) = 'GLOBAL_ATTRIBUTE15';
                EXIT;
                log_debug('ILC Name : ' || l_ilc_name);
              EXCEPTION
                WHEN OTHERS THEN
                  NULL;
              END;
            END LOOP;
            g_report_rec(c3_data.l_rownum).GUID := gv_guid;
            g_report_rec(c3_data.l_rownum).EVENT_CREATION_DATE := l_EVENT_CREATION_DATE;
            g_report_rec(c3_data.l_rownum).EVENT_STATUS := l_event_status;
            g_report_rec(c3_data.l_rownum).PARTNER_CODE := c1_data.PARTNER_CODE;
            g_report_rec(c3_data.l_rownum).REQUEST_TYPE := c1_data.REQUEST_TYPE;
            g_report_rec(c3_data.l_rownum).PM_AGREEMENT_REFERENCE := c1_data.PM_AGREEMENT_REFERENCE;
            g_report_rec(c3_data.l_rownum).AGREEMENT_NUM := c1_data.AGREEMENT_NUM;
            g_report_rec(c3_data.l_rownum).AGREEMENT_TYPE := c1_data.AGREEMENT_TYPE;
            g_report_rec(c3_data.l_rownum).PO_AMOUNT := c1_data.PO_AMOUNT;
            g_report_rec(c3_data.l_rownum).CURRENCY_CODE := c1_data.CURRENCY_CODE;
            g_report_rec(c3_data.l_rownum).CUSTOMER_PO_NUMBER := c1_data.CUSTOMER_PO_NUMBER;
            g_report_rec(c3_data.l_rownum).PM_PRODUCT_CODE := c1_data.PM_PRODUCT_CODE;
            g_report_rec(c3_data.l_rownum).OWNING_ORGANIZATION_CODE := c1_data.OWNING_ORGANIZATION_CODE;
            g_report_rec(c3_data.l_rownum).OWNING_ORGANIZATION_NAME := c1_data.OWNING_ORGANIZATION_NAME;
            g_report_rec(c3_data.l_rownum).CUSTOMER_NUMBER := c1_data.CUSTOMER_NUMBER;
            g_report_rec(c3_data.l_rownum).BILL_TO_PARTY_SITE_ID := c1_data.BILL_TO_PARTY_SITE_ID;
            g_report_rec(c3_data.l_rownum).PAYMENT_TERMS := c1_data.PAYMENT_TERMS;
            g_report_rec(c3_data.l_rownum).PROJECT_STATUS := NULL;
            g_report_rec(c3_data.l_rownum).ORD_ORACLE_ORDER_NUMBER := NULL;
            g_report_rec(c3_data.l_rownum).ORD_ORACLE_ORDER_STATUS := NULL;
            g_report_rec(c3_data.l_rownum).ORD_ORG_CODE := c3_data.ORG_CODE;
            g_report_rec(c3_data.l_rownum).ORD_TRANSACTIONAL_CURR_CODE := c3_data.TRANSACTIONAL_CURR_CODE;
            g_report_rec(c3_data.l_rownum).ORD_SHIPPING_METHOD := c3_data.SHIPPING_METHOD;
            g_report_rec(c3_data.l_rownum).ORD_FOB := c3_data.FOB;
            g_report_rec(c3_data.l_rownum).ORD_FREIGHT_TERMS := c3_data.FREIGHT_TERMS;
            g_report_rec(c3_data.l_rownum).ORD_ATTRIBUTE19 := c3_data.ATTRIBUTE19;
            g_report_rec(c3_data.l_rownum).ILC_NAME := l_ILC_NAME;
            g_report_rec(c3_data.l_rownum).XXPA2381_GUID := NULL;
            g_report_rec(c3_data.l_rownum).XXPA2381_PHASE := NULL;
            g_report_rec(c3_data.l_rownum).XXPA2381_STATUS := NULL;
            g_report_rec(c3_data.l_rownum).XXONT1239_GUID := NULL;
            g_report_rec(c3_data.l_rownum).XXONT1239_PHASE := NULL;
            g_report_rec(c3_data.l_rownum).XXONT1239_STATUS := NULL;
            g_report_rec(c3_data.l_rownum).XXPA2672_GUID := NULL;
            g_report_rec(c3_data.l_rownum).XXPA2672_PHASE := NULL;
            g_report_rec(c3_data.l_rownum).XXPA2672_STATUS := NULL;
            g_report_rec(c3_data.l_rownum).EVENT_CURRENT_STATUS := NULL;
            g_report_rec(c3_data.l_rownum).ERROR_MESSAGE := NULL;
            --Date Columns
            date_convert(c3_data.REQUEST_DATE,
                         g_report_rec(c3_data.l_rownum).ORD_REQUEST_DATE);
            --g_report_rec(c3_data.l_rownum).ORD_REQUEST_DATE:= c3_data.REQUEST_DATE;
            IF c1_data.g_projects IS NOT NULL THEN
              FOR c2_data IN (SELECT extractvalue(tmp_m.column_value,
                                                  'PROJECT/PA_PROJECT_NUMBER',
                                                  gv_namespace) AS PA_PROJECT_NUMBER,
                                     extractvalue(tmp_m.column_value,
                                                  'PROJECT/PROJECT_NAME',
                                                  gv_namespace) AS PROJECT_NAME,
                                     extractvalue(tmp_m.column_value,
                                                  'PROJECT/DESCRIPTION',
                                                  gv_namespace) AS DESCRIPTION,
                                     extractvalue(tmp_m.column_value,
                                                  'PROJECT/START_DATE',
                                                  gv_namespace) AS START_DATE,
                                     extractvalue(tmp_m.column_value,
                                                  'PROJECT/COMPLETION_DATE',
                                                  gv_namespace) AS COMPLETION_DATE
                                FROM TABLE(xmlsequence(c1_data.g_projects.extract('//G_PROJECTS/PROJECT',
                                                                                  gv_namespace))) tmp_m) LOOP
                g_report_rec(c3_data.l_rownum).PA_PROJECT_NUMBER := c2_data.PA_PROJECT_NUMBER;
                g_report_rec(c3_data.l_rownum).PROJECT_NAME := c2_data.PROJECT_NAME;
                g_report_rec(c3_data.l_rownum).DESCRIPTION := c2_data.DESCRIPTION;
                --Date Columns
                date_convert(c2_data.START_DATE,
                             g_report_rec(c3_data.l_rownum).START_DATE);
                --g_report_rec(c3_data.l_rownum).START_DATE:= c2_data.START_DATE;
                date_convert(c2_data.COMPLETION_DATE,
                             g_report_rec(c3_data.l_rownum).COMPLETION_DATE);
                --g_report_rec(c3_data.l_rownum).COMPLETION_DATE:= c2_data.COMPLETION_DATE;
              END LOOP;
            END IF;
            BEGIN
              --Update XXINT Event DFF
              xxint_event_api_pub.update_event(p_guid        => gv_guid,
                                               p_attribute13 => c3_data.ORG_CODE,
                                               p_attribute14 => l_ILC_NAME);
            EXCEPTION
              WHEN OTHERS THEN
                log_debug('Error in Updating Event Attributes after processing all records ' ||
                          SQLERRM,
                          XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
            END;
          END LOOP;

        ELSE
          --project only orders
          g_report_rec(c1_data.l_rownum).GUID := gv_guid;
          g_report_rec(c1_data.l_rownum).EVENT_CREATION_DATE := l_EVENT_CREATION_DATE;
          g_report_rec(c1_data.l_rownum).EVENT_STATUS := l_event_status;
          g_report_rec(c1_data.l_rownum).PARTNER_CODE := c1_data.PARTNER_CODE;
          g_report_rec(c1_data.l_rownum).REQUEST_TYPE := c1_data.REQUEST_TYPE;
          g_report_rec(c1_data.l_rownum).PM_AGREEMENT_REFERENCE := c1_data.PM_AGREEMENT_REFERENCE;
          g_report_rec(c1_data.l_rownum).AGREEMENT_NUM := c1_data.AGREEMENT_NUM;
          g_report_rec(c1_data.l_rownum).AGREEMENT_TYPE := c1_data.AGREEMENT_TYPE;
          g_report_rec(c1_data.l_rownum).PO_AMOUNT := c1_data.PO_AMOUNT;
          g_report_rec(c1_data.l_rownum).CURRENCY_CODE := c1_data.CURRENCY_CODE;
          g_report_rec(c1_data.l_rownum).CUSTOMER_PO_NUMBER := c1_data.CUSTOMER_PO_NUMBER;
          g_report_rec(c1_data.l_rownum).PM_PRODUCT_CODE := c1_data.PM_PRODUCT_CODE;
          g_report_rec(c1_data.l_rownum).OWNING_ORGANIZATION_CODE := c1_data.OWNING_ORGANIZATION_CODE;
          g_report_rec(c1_data.l_rownum).OWNING_ORGANIZATION_NAME := c1_data.OWNING_ORGANIZATION_NAME;
          g_report_rec(c1_data.l_rownum).CUSTOMER_NUMBER := c1_data.CUSTOMER_NUMBER;
          g_report_rec(c1_data.l_rownum).BILL_TO_PARTY_SITE_ID := c1_data.BILL_TO_PARTY_SITE_ID;
          g_report_rec(c1_data.l_rownum).PAYMENT_TERMS := c1_data.PAYMENT_TERMS;
          g_report_rec(c1_data.l_rownum).PROJECT_STATUS := NULL;
          g_report_rec(c1_data.l_rownum).ORD_ORACLE_ORDER_NUMBER := NULL;
          g_report_rec(c1_data.l_rownum).ORD_ORACLE_ORDER_STATUS := NULL;
          g_report_rec(c1_data.l_rownum).ORD_ORG_CODE := NULL;
          g_report_rec(c1_data.l_rownum).ORD_TRANSACTIONAL_CURR_CODE := NULL;
          g_report_rec(c1_data.l_rownum).ORD_SHIPPING_METHOD := NULL;
          g_report_rec(c1_data.l_rownum).ORD_FOB := NULL;
          g_report_rec(c1_data.l_rownum).ORD_FREIGHT_TERMS := NULL;
          g_report_rec(c1_data.l_rownum).ORD_ATTRIBUTE19 := NULL;
          g_report_rec(c1_data.l_rownum).ILC_NAME := NULL;
          g_report_rec(c1_data.l_rownum).XXPA2381_GUID := NULL;
          g_report_rec(c1_data.l_rownum).XXPA2381_PHASE := NULL;
          g_report_rec(c1_data.l_rownum).XXPA2381_STATUS := NULL;
          g_report_rec(c1_data.l_rownum).XXONT1239_GUID := NULL;
          g_report_rec(c1_data.l_rownum).XXONT1239_PHASE := NULL;
          g_report_rec(c1_data.l_rownum).XXONT1239_STATUS := NULL;
          g_report_rec(c1_data.l_rownum).XXPA2672_GUID := NULL;
          g_report_rec(c1_data.l_rownum).XXPA2672_PHASE := NULL;
          g_report_rec(c1_data.l_rownum).XXPA2672_STATUS := NULL;
          g_report_rec(c1_data.l_rownum).EVENT_CURRENT_STATUS := NULL;
          g_report_rec(c1_data.l_rownum).ERROR_MESSAGE := NULL;
          g_report_rec(c1_data.l_rownum).ORD_REQUEST_DATE := NULL;
          --Date Columns
          --g_report_rec(c3_data.l_rownum).ORD_REQUEST_DATE:= c3_data.REQUEST_DATE;
          IF c1_data.g_projects IS NOT NULL THEN
            FOR c2_data IN (SELECT extractvalue(tmp_m.column_value,
                                                'PROJECT/PA_PROJECT_NUMBER',
                                                gv_namespace) AS PA_PROJECT_NUMBER,
                                   extractvalue(tmp_m.column_value,
                                                'PROJECT/PROJECT_NAME',
                                                gv_namespace) AS PROJECT_NAME,
                                   extractvalue(tmp_m.column_value,
                                                'PROJECT/DESCRIPTION',
                                                gv_namespace) AS DESCRIPTION,
                                   extractvalue(tmp_m.column_value,
                                                'PROJECT/START_DATE',
                                                gv_namespace) AS START_DATE,
                                   extractvalue(tmp_m.column_value,
                                                'PROJECT/COMPLETION_DATE',
                                                gv_namespace) AS COMPLETION_DATE
                              FROM TABLE(xmlsequence(c1_data.g_projects.extract('//G_PROJECTS/PROJECT',
                                                                                gv_namespace))) tmp_m) LOOP
              g_report_rec(c1_data.l_rownum).PA_PROJECT_NUMBER := c2_data.PA_PROJECT_NUMBER;
              g_report_rec(c1_data.l_rownum).PROJECT_NAME := c2_data.PROJECT_NAME;
              g_report_rec(c1_data.l_rownum).DESCRIPTION := c2_data.DESCRIPTION;
              --Date Columns
              date_convert(c2_data.START_DATE,
                           g_report_rec(c1_data.l_rownum).START_DATE);
              date_convert(c2_data.COMPLETION_DATE,
                           g_report_rec(c1_data.l_rownum).COMPLETION_DATE);
            END LOOP;
          END IF;
        END IF;
      END LOOP;
    ELSIF gv_event_current_phase = 'PHASE02' THEN
      --Project Event will be created or Project/Order Validation will be complete.
      --Need to update only the PROJECT_GUID column in this phase
      FOR i IN 1 .. g_report_rec.count LOOP
        g_report_rec(i).xxpa2381_guid := gv_proj_guid;
        g_report_rec(i).EVENT_STATUS := l_event_status;
      END LOOP;
    ELSIF gv_event_current_phase = 'PHASE03' THEN
      --Project event XXPA2381 Event Status, Project Approval and PJM Count to be validated in this phase
      log_debug(g_report_rec.count);
      FOR i IN 1 .. g_report_rec.count LOOP
        g_report_rec(i).project_status := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                                       p_attribute_name => 'ATTRIBUTE10');
        g_report_rec(i).xxpa2381_guid := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                                      p_attribute_name => 'ATTRIBUTE9');

        g_report_rec(i).xxpa2672_guid := xxint_event_api_pub.get_event_clob(gv_guid,
                                                                            'G_PROJ_EVENT_GUID');
        if g_report_rec(i).xxpa2672_guid is not null then
          begin
            select current_phase, current_status
              into g_report_rec(i).xxpa2672_phase,
                   g_report_rec(i).xxpa2672_status
              from xxint_events
             where guid = g_report_rec(i).xxpa2672_guid;
          exception
            when others then
              NULL;
          end;
        end if;
        begin
          SELECT attribute5,
                 current_phase,
                 DECODE(NVL(attribute5, 'SUCCESS'),
                        'SUCCESS',
                        NULL,
                        last_process_msg)
            INTO g_report_rec(i).xxpa2381_status,
                 g_report_rec(i).xxpa2381_phase,
                 g_report_rec(i).error_message
            FROM apps.xxint_events
           WHERE event_type = gc_prj_cre_event_type
             AND guid = g_report_rec(i).xxpa2381_guid;
        exception
          when others then
            null;
        end;
        g_report_rec(i).EVENT_STATUS := l_event_status;
        g_report_rec(i).project_status := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                                       p_attribute_name => 'ATTRIBUTE10');
        SELECT COUNT(1)
          INTO l_proj_rev_count
          FROM pa_agreements_all pa
         WHERE agreement_num = gv_agreement_num ;
           --AND NVL(attribute10, 'XX') = NVL(gv_prj_version_num, 'XX');-- Commented for  CR14331 changes by SAYIKRISHNA R
        IF g_report_rec(i).project_status = 'APPROVED' THEN
          IF l_proj_rev_count = 1 THEN
            SELECT COUNT(1)
              INTO l_pjm_count
              FROM pjm_project_parameters pjm, apps.pa_projects_all ppa
             WHERE pjm.project_id = ppa.project_id
               AND ppa.segment1 = gv_project_num;
            IF l_pjm_count = 0 THEN
              l_error_message := 'Project is not added Project Manufacturing Organization';
            END IF;
         /* ELSE
            l_error_message := 'Project Approved but Version Name doesnt Match'; */ -- Commented for  CR14331 changes by SAYIKRISHNA R
          END IF;
        ELSE
          l_error_message := 'Project is not yet Approved.';
        END IF;
        g_report_rec(i).error_message := l_error_message;
      END LOOP;
    ELSIF gv_event_current_phase = 'PHASE04' OR
          gv_event_current_phase = 'PHASE05' THEN
      --Order Event will be created in this Phase. Verify the G_ORDER_DATA Clob and get the XXONT1239 GUID and add it to the Clob
      SELECT DECODE(COUNT(1), 0, 'N', 'Y')
        INTO l_order_clob_flag
        FROM apps.xxint_event_clobs
       WHERE guid = gv_guid
         AND clob_code = 'G_ORDER_DATA_CLOB';
      FOR i IN 1 .. g_report_rec.count LOOP
        IF gv_event_current_phase = 'PHASE04' THEN
          g_report_rec(i).project_status := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                                         p_attribute_name => 'ATTRIBUTE10');
        END IF;
        BEGIN
          BEGIN
            SELECT extractvalue(tmp_m.column_value,
                                'G_ORDER_DATA/GUID',
                                NULL) AS GUID,
                   extractvalue(tmp_m.column_value,
                                'G_ORDER_DATA/ORACLE_ORDER_NUMBER',
                                NULL) AS ORACLE_ORDER_NUMBER
              INTO g_report_rec(i).xxont1239_guid,
                   g_report_rec(i).ORD_ORACLE_ORDER_NUMBER
              FROM TABLE(xmlsequence(xmlType(xxint_event_api_pub.get_event_clob(gv_guid, 'G_ORDER_DATA_CLOB'))
                                     .extract('//G_ORDER/G_ORDER_DATA',
                                              NULL))) tmp_m
             WHERE extractvalue(tmp_m.column_value,
                                'G_ORDER_DATA/ORDER_NUMBER',
                                NULL) LIKE g_report_rec(i)
                  .ORD_ATTRIBUTE19 || '_' || g_report_rec(i).ILC_NAME || '%'
                OR extractvalue(tmp_m.column_value,
                                'G_ORDER_DATA/ORDER_NUMBER',
                                NULL) LIKE g_report_rec(i)
                  .ORD_ATTRIBUTE19 || '%'
                OR extractvalue(tmp_m.column_value,
                                'G_ORDER_DATA/ORDER_REF',
                                NULL) = g_report_rec(i).ORD_ATTRIBUTE19;
          EXCEPTION
            WHEN no_data_found THEN
              BEGIN
                SELECT order_number, tp_attribute1
                  INTO g_report_rec(i).ORD_ORACLE_ORDER_NUMBER,
                       g_report_rec(i).xxont1239_guid
                  FROM oe_order_headers_all
                 WHERE attribute19 = g_report_rec(i).ORD_ATTRIBUTE19
                    OR attribute19 LIKE g_report_rec(i)
                      .ORD_ATTRIBUTE19 || '_' || g_report_rec(i).ILC_NAME || '%'
                    OR attribute8 = g_report_rec(i).ORD_ATTRIBUTE19;
              EXCEPTION
                WHEN OTHERS THEN
                  NULL;
              END;
            WHEN OTHERS THEN
              NULL;
          END;
          IF g_report_rec(i).ORD_ORACLE_ORDER_NUMBER IS NULL THEN
            BEGIN
              SELECT order_number
                INTO g_report_rec(i).ORD_ORACLE_ORDER_NUMBER
                FROM oe_order_headers_all
               WHERE tp_attribute1 = g_report_rec(i).xxont1239_guid;
            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
          END IF;
          IF g_report_rec(i).ORD_ORACLE_ORDER_NUMBER IS NULL THEN
            BEGIN
              SELECT order_number, tp_attribute1
                INTO g_report_rec(i).ORD_ORACLE_ORDER_NUMBER,
                     g_report_rec(i).xxont1239_guid
                FROM oe_order_headers_all
               WHERE attribute19 = g_report_rec(i).ORD_ATTRIBUTE19
                  OR attribute19 LIKE g_report_rec(i)
                    .ORD_ATTRIBUTE19 || '_' || g_report_rec(i).ILC_NAME || '%'
                  OR attribute8 = g_report_rec(i).ORD_ATTRIBUTE19;
            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
          END IF;
          IF g_report_rec(i).xxont1239_guid IS NOT NULL THEN
            SELECT current_phase, current_status
              INTO g_report_rec(i).xxont1239_phase,
                   g_report_rec(i).xxont1239_status
              FROM apps.xxint_events
             WHERE guid = g_report_rec(i).xxont1239_guid;
          END IF;

          begin

            select to_char(clob_content)
              into g_report_rec(i).xxpa2672_guid
              from xxint_event_clobs
             where guid = gv_guid
               and clob_code = 'G_PROJ_EVENT_GUID';

          exception
            when others then
              null;
          end;

          --          g_report_rec(i).xxpa2672_guid := xxint_event_api_pub.get_event_clob(gv_guid,
          --                                                                              'G_PROJ_EVENT_GUID');

          if g_report_rec(i).xxpa2672_guid is not null then
            begin
              select current_phase, current_status
                into g_report_rec(i).xxpa2672_phase,
                     g_report_rec(i).xxpa2672_status
                from xxint_events
               where guid = g_report_rec(i).xxpa2672_guid;

              if g_report_rec(i).xxpa2672_status = 'ERROR' then
                g_report_rec(i).error_message := 'Error while creating project Events';
              elsif g_report_rec(i).xxpa2672_status = 'READY' then
                g_report_rec(i).xxpa2672_status := 'Event Submitted';
              else
                g_report_rec(i).xxpa2672_status := 'Event Created';
              end if;

            exception
              when others then
                NULL;
            end;
          end if;
          IF g_report_rec(i).ORD_ORACLE_ORDER_NUMBER IS NOT NULL THEN
            g_report_rec(i).EVENT_STATUS := 'ORDER_COMPLETED';
          ELSE
            g_report_rec(i).error_message := l_error_message;
          END IF;

        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      END LOOP;
    END IF;
    replace_report_clob;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END generate_report_data;
  --End of Added for CR23274 XXONT3030
  /******************************************************************************
  ** Function Name  : submit_xxint_bkg_program
  **
  ** Purpose:  Function to submit XXINT Event Background Process Program
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 26-Apr-2015   Vishnusimman M   Initial Version. CR 22563                 *
  ******************************************************************************/
  FUNCTION submit_xxint_bkg_program(p_guid                       in VARCHAR2,
                                    p_event_phase                IN VARCHAR2,
                                    p_event_interval             IN VARCHAR2,
                                    p_event_type                 IN VARCHAR2,
                                    p_event_owner                IN VARCHAR2,
                                    p_override_next_attempt_time IN VARCHAR2,
                                    p_lock_timeout_sec           IN VARCHAR2)
    RETURN NUMBER IS
    l_request_id NUMBER;
  BEGIN
    --Following code is modified by Vishnu for CR5963
    l_request_id := fnd_request.submit_request('XXINT', --program-application-code
                                               'XXINT_EVENT_BACKGROUND_PROCESS', --program-short-name
                                               'XXINT_EVENT_BACKGROUND_PROCESS submitted for GUID=' ||
                                               p_guid, --description
                                               TO_CHAR(sysdate + (3 / 3600),
                                                       'DD-MON-YYYY HH24:MI:SS'), --start-time
                                               false, --sub-request
                                               nvl(p_event_interval, ''), --current phase when like
                                               nvl(p_event_type,
                                                   gc_event_type), --event-type-like
                                               nvl(p_event_phase, CHR(0)), --current-phase-like
                                               nvl(p_guid, CHR(10)), --guid
                                               'Y', --force reprocess errors
                                               'Y', --ignore fault group status
                                               '1', --exit after this many events
                                               nvl(p_event_owner, ''), --current phase who like
                                               '', --current phase what like
                                               '', --current phase how like
                                               '', --p_concatenated_segments
                                               '', --p_attribute1
                                               '', --p_attribute2
                                               '', --p_attribute3
                                               '', --p_attribute4
                                               '', --p_attribute5
                                               '', --p_attribute6
                                               '', --p_attribute7
                                               '', --p_attribute8
                                               '', --p_attribute9
                                               '', --p_attribute10
                                               '', --p_attribute11
                                               '', --p_attribute12
                                               '', --p_attribute13
                                               '', --p_attribute14
                                               '', --p_attribute15
                                               nvl(p_override_next_attempt_time,
                                                   'Y'), --ignore next attempt date
                                               XXINT_EVENT_UTIL_SITE.G_DEFAULT_LOCK_TIMEOUT_SEC, --lock timeout sec.
                                               XXINT_EVENT_API_PUB.get_default_bg_proces_mode(XXINT_EVENT_API_PUB.get_event_record(p_guid)),
                                               chr(0) --end of parameters
                                               );
    log_debug('Concurrent Request_id for ' || p_event_phase ||
              ' Process :' || l_request_id);
    return l_request_id;
  exception
    when others then
      log_debug('Exception while submitting the concurrent Program : ' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      return null;
  END;
  /******************************************************************************
  ** Procedure Name  : get_carrying_out_org_name
  **
  ** Purpose:  Procedure to get Owning/Carrying Out Organization name for Projects/Deliver to site creation
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ******************************************************************************/
  PROCEDURE get_carrying_out_org_name(p_owning_organization_code IN OUT VARCHAR2,
                                      p_owning_organization_name IN OUT VARCHAR2,
                                      p_owning_organization_id   IN OUT VARCHAR2) IS
    x_return_status  VARCHAR2(2000);
    x_return_message VARCHAR2(2000);
  BEGIN
    IF p_owning_organization_code IS NULL AND
       p_owning_organization_name IS NULL AND
       p_owning_organization_id IS NULL THEN
      log_debug('Owning Organization Information is not available');
    ELSE

      xxpa_proj_in_pkg.derive_organization_idcd(p_organization_code => p_owning_organization_code,
                                                p_organization_name => p_owning_organization_name,
                                                p_organization_id   => p_owning_organization_id,
                                                x_return_status     => x_return_status,
                                                x_return_message    => x_return_message);

      if x_return_message is not null then
        log_debug('Derivation of Organization_id Return Message : ' ||
                  x_return_message);
      end if;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in get_carrying_out_org_name :' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END;
  /******************************************************************************
  ** Procedure Name  : get_salesrep_id_num
  **
  ** Purpose:  Procedure to get Sales Rep Id/Number
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ******************************************************************************/
  PROCEDURE get_salesrep_id_num(p_employee_number IN VARCHAR2,
                                p_salesrep_num    IN OUT ra_salesreps_all.salesrep_number%type,
                                p_salesrep_id     IN OUT ra_salesreps_all.salesrep_number%type) IS

    l_derive_salesrep             varchar2(2) := 'Y';
    l_derive_salesbranch_key_name xxint_event_type_key_vals.key_name%Type := 'DERIVE_SALES_BRANCH';

  BEGIN
    log_debug('In Get Sales Rep Id Function :');
    log_debug('Operating Unit : ' || gv_operating_unit);
    IF p_salesrep_num IS NOT NULL OR p_salesrep_id IS NOT NULL OR
       p_employee_number IS NOT NULL THEN
      BEGIN
        SELECT salesrep_id, salesrep_number
          INTO p_salesrep_id, p_salesrep_num
          FROM ra_salesreps_all
         WHERE salesrep_id = NVL(p_salesrep_id, salesrep_id)
           AND salesrep_number =
               NVL(NVL(p_salesrep_num, p_employee_number), salesrep_number)
           AND org_id = gv_operating_unit
           AND status = 'A'
           AND SYSDATE BETWEEN NVL(START_DATE_ACTIVE, SYSDATE - 1) AND
               NVL(END_DATE_ACTIVE, SYSDATE + 1)
           AND rownum = 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          log_debug('Exception while deriving Sales Rep ID 1' ||
                    SUBSTR(SQLERRM, 1, 200),
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
        WHEN OTHERS THEN
          log_debug('Exception while deriving Sales Rep ID 2' ||
                    SUBSTR(SQLERRM, 1, 200),
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      END;
    END IF;

    if gv_request_type = 'S' then
      BEGIN
        select key_value
          into l_derive_salesrep
          from xxint_event_type_key_vals
         where event_type = gc_event_type
           and key_type = gc_key_type
           and key_type_value = gv_source_system
           and key_name = l_derive_salesbranch_key_name;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_derive_salesrep := 'Y';
        WHEN OTHERS THEN
          l_derive_salesrep := 'Y';
      END;
    else
      l_derive_salesrep := 'Y';
    end if;

    IF NVL(l_derive_salesrep, 'Y') = 'Y' THEN
      IF gv_carrying_out_org_name IS NULL THEN
        log_debug('Before Calling get_carrying_out_org_name. p_owning_organization_code => ' ||
                  gv_owning_organization_code || chr(10) ||
                  'p_owning_organization_name => ' ||
                  gv_owning_organization_name || chr(10) ||
                  'p_owning_organization_id => ' ||
                  gv_owning_organization_id);
        --
        get_carrying_out_org_name(p_owning_organization_code => gv_owning_organization_code,
                                  p_owning_organization_name => gv_owning_organization_name,
                                  p_owning_organization_id   => gv_owning_organization_id);
        --
        log_debug('After Calling get_carrying_out_org_name. p_owning_organization_code => ' ||
                  gv_owning_organization_code || chr(10) ||
                  'p_owning_organization_name => ' ||
                  gv_owning_organization_name || chr(10) ||
                  'p_owning_organization_id => ' ||
                  gv_owning_organization_id);
      END IF;
      -- sales Rep is not available from the payload get the Salesrep based on the lookup XXPA2592_PA_ORG_BRANCH_MAPPING
      IF p_salesrep_num IS NULL AND p_salesrep_id IS NULL THEN
        BEGIN
          SELECT tag, meaning
            INTO p_salesrep_num, p_salesrep_id
            FROM apps.fnd_lookup_values_vl
           WHERE lookup_type = 'XXPA2592_PA_ORG_BRANCH_MAPPING'
             AND upper(description) LIKE
                 upper(NVL(gv_carrying_out_org_name,
                           gv_owning_organization_name))
             AND sysdate BETWEEN start_date_active AND
                 NVL(end_date_active, sysdate + 1)
             AND ENABLED_FLAG = 'Y';
        EXCEPTION
          WHEN no_data_found THEN
            log_debug('Sales Rep Configuration not available in lookup XXPA2592_PA_ORG_BRANCH_MAPPING for Org :' ||
                      gv_carrying_out_org_name,
                      XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
          WHEN OTHERS THEN
            log_debug('Exception while deriving Sales Rep ID 4' ||
                      SUBSTR(SQLERRM, 1, 200),
                      XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
        END;
      END IF;
    end if;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in get_salesrep_id_num procedure' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR);
  END get_salesrep_id_num;
  /******************************************************************************
  ** Procedure Name  : set_global_variables
  **
  ** Purpose:  For defaulting Global variables used across different Phases of the Event
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563
  ** 20-Aug-2020   Mousami Bhandary    Modified as part of CR24355--added Custom_Prject_entry flag logic
  ******************************************************************************/
  PROCEDURE set_global_variables(p_guid IN VARCHAR2) IS
    l_event_history_count NUMBER;
    l_order_count         NUMBER := 0;
  BEGIN
    -- Initialize variables
    g_error_tbl.DELETE;
    g_error_count := 1;
    gv_guid       := p_guid;
    gv_user_id    := FND_GLOBAL.USER_ID;
    gv_payload    := xxint_event_api_pub.get_event_clob(gv_guid,
                                                        'HTTP_RECEIVE_XML_PAYLOAD_IN');
    -- Remove Empty Tags from input XML
    BEGIN
      SELECT to_clob(deletexml(xmltype(gv_payload), '//*[not(node())]'))
        INTO gv_payload
        FROM dual;
    EXCEPTION
      WHEN OTHERS THEN
        gv_payload := xxint_event_api_pub.get_event_clob(gv_guid,
                                                         'HTTP_RECEIVE_XML_PAYLOAD_IN');
    END;
    --Set Log Level for Event to Print Logs
    BEGIN
      select log_level
        into gv_log_level
        from xxint_event_types
       where event_type = 'XXPA2592_EQUIP_ORDER_IN';

	  /* commented out for 19c DB Upgrade, db_unique_name will have a value of EBSPRD after
	     19c upgrade.
      select value
        into gv_db_name
        from v$parameter
       where name = 'db_unique_name';
	   */
       gv_db_name := xxxxau3842_branding_util.get_db_name;
    exception
      when others then
        gv_log_level := 5;
        gv_db_name   := gv_instance_name;
    END;


    -- Get Event Id for email notification Tracking
    SELECT id INTO gv_event_id FROM apps.xxint_events WHERE guid = gv_guid;
    -- PTASK0001663 fetch attribute42 -- if there are multiple order headers fetch the first one.
	-- why is get event attriute values reading the payload again from DB and not using gv_payload from above ? 
	-- there is no clear explanation to this question in documetnation, going to ignore gv_payload and will be rereading from db for PTASK0001663

    SELECT xmlquery('//EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_ORDER/ORDER_HEADER[1]/ATTRIBUTE42/text()' PASSING xmltype(xxint_event_api_pub.get_event_clob(gv_guid,'HTTP_RECEIVE_XML_PAYLOAD_IN')) RETURNING CONTENT).getStringVal()
	INTO gv_attribute42
	FROM dual
	; 

    log_debug('gv_attribute42:' || gv_attribute42);

    --Get Event Attribute Values
    SELECT extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/CONTROL_AREA/PARTNER_CODE',
                        gv_namespace),
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/CONTROL_AREA/INSTANCE_NAME',
                        gv_namespace),
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/CONTROL_AREA/EXTERNAL_MESSAGE_ID',
                        gv_namespace),
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/CONTROL_AREA/REQUEST_TYPE',
                        gv_namespace),
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CUSTOMER_PO_NUMBER',
                        gv_namespace) cust_po_number,
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/PM_AGREEMENT_REFERENCE',
                        gv_namespace) agreement_ref,
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/AGREEMENT_NUM',
                        gv_namespace) agreement_num,
           extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_PROJECTS/PROJECT/PA_PROJECT_NUMBER',
                        gv_namespace) project_num,
           -- Only 200 Characters can be stored in the variable for Partner sales order number ref. For remaining data refer G_ORDER_DATA_CLOB
           SUBSTR((SELECT LISTAGG(extractvalue(tmp.column_value,
                                              '/ATTRIBUTE19'),
                                 '|') WITHIN GROUP(ORDER BY 1) AS aa
                    FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(p_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                                           .extract('//EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_ORDER/ORDER_HEADER/ATTRIBUTE19'))) tmp),
                  1,
                  149) ORDER_NUM,
           NVL(extractvalue(tmp_m.column_value,
                            'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_PROJECTS/PROJECT/PROJ_REV_VERSION_NUMBER',
                            gv_namespace),
               extractvalue(tmp_m.column_value,
                            'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/VERSION_NUMBER',
                            gv_namespace)) project_version_name,
				extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/CUSTOMER_INFO/CUSTOMER_NUMBER',
                        gv_namespace) customer_number
                --extractvalue(tmp_m.column_value,--'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_PROJECTS/PROJECT/COMPLETION_DATE',
                --        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_ORDER/ORDER_HEADER/ATTRIBUTE42',--CR13475
                --        gv_namespace) gv1_attribute42--CR13475
      INTO gv_source_system,
           gv_instance_name,
           gv_source_reference,
           gv_request_type,
           gv_cust_po_number,
           gv_agreement_ref,
           gv_agreement_num,
           gv_project_num,
           gv_order_num,
           gv_prj_version_num,
		   gv_customer_number ---added By Mousami CR24533
           --gv_attribute42--CR13475
      FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(p_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                             .extract('//EBS_PROJECT_ORDER', gv_namespace))) tmp_m;
    gv_proj_guid   := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                   p_attribute_name => 'ATTRIBUTE9');
    gv_order_guid  := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                   p_attribute_name => 'ATTRIBUTE11');
    gv_proj_status := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                   p_attribute_name => 'ATTRIBUTE10');

    gv_bill_event_guid := xxint_event_api_pub.get_event_clob(gv_guid,
                                                             gc_proj_event_guid_clob_code);

    --Added for CR23505

    g_ship_instr_key_enabled := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                    p_key_type       => gc_key_type,
                                                                    p_key_type_value => gv_source_system,
                                                                    p_key_name       => gc_masking_keyname,
                                                                    p_key_value      => gc_ship_instr_key_val);

    g_ord_hdr_ref_key_enabled := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                     p_key_type       => gc_key_type,
                                                                     p_key_type_value => gv_source_system,
                                                                     p_key_name       => gc_masking_keyname,
                                                                     p_key_value      => gc_ord_hdr_ref_key_val);

    g_ord_unique_key_enabled := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                    p_key_type       => gc_key_type,
                                                                    p_key_type_value => gv_source_system,
                                                                    p_key_name       => gc_masking_keyname,
                                                                    p_key_value      => gc_ord_unique_key_val);

    g_price_adj_key_enabled := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                   p_key_type       => gc_key_type,
                                                                   p_key_type_value => gv_source_system,
                                                                   p_key_name       => gc_masking_keyname,
                                                                   p_key_value      => gc_price_adj_key_val,
                                                                   p_attribute1     => gc_Price_adj_reason_key_val);
    --Added by Joydeb as per HPQC#24280
    g_usr_item_desc_key_enabled := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                       p_key_type       => gc_key_type,
                                                                       p_key_type_value => gv_source_system,
                                                                       p_key_name       => gc_masking_keyname,
                                                                       p_key_value      => gc_usr_item_desc_key_val);

    gv_create_proj_events := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                 p_key_type       => gc_key_type,
                                                                 p_key_type_value => gv_source_system,
                                                                 p_key_name       => gc_create_events_key_val,
                                                                 p_key_value      => 'Y');

    gv_append_cust_po_key_val := xxint_event_type_utils.valid_config(p_event_type     => gc_event_type,
                                                                     p_key_type       => gc_key_type,
                                                                     p_key_type_value => gv_source_system,
                                                                     p_key_name       => gc_masking_keyname,
                                                                     p_key_value      => gc_append_po_key_val);

    if g_price_adj_key_enabled = 'Y' THEN
      BEGIN
        SELECT attribute2, nvl(attribute3, 'MISC')
          into g_Price_adj_reason_key_val, g_Price_adj_reason_code_val
          FROM XXINT_EVENT_TYPE_KEY_VALS
         WHERE event_type = gc_event_type
           AND key_type = gc_key_type
           and key_type_value = gv_source_system
           and key_name = gc_masking_keyname
           and key_value = gc_price_adj_key_val
           and attribute1 = gc_Price_adj_reason_key_val;
      EXCEPTION
        WHEN OTHERS THEN
          g_Price_adj_reason_key_val  := NULL;
          g_Price_adj_reason_code_val := NULL;
      END;
    ELSE
      g_Price_adj_reason_key_val  := NULL;
      g_Price_adj_reason_code_val := NULL;
    END IF;

    --End of Added for CR23505
    IF NVL(gv_event_current_phase, 'PHASE01') = 'PHASE01' THEN
      log_debug('Source System            : ' || gv_source_system);
      log_debug('Instance Name            : ' || gv_instance_name);
      log_debug('Source System reference  : ' || gv_source_reference);
      log_debug('Request Type             : ' || gv_request_type);
      log_debug('Customer PO Number       : ' || gv_cust_po_number);
      log_debug('Agreement Reference      : ' || gv_agreement_ref);
      log_debug('Agreement Number         : ' || gv_agreement_num);
      log_debug('Project Number           : ' || gv_project_num);
      log_debug('Order Number             : ' || gv_order_num);
      log_debug('Project Version Number   : ' || gv_prj_version_num);

      --Clean Up XXAU Interface History Table for Closed Events
      BEGIN
        DELETE apps.xxau_interface_history
         WHERE interface_name LIKE 'XXPA2592%'
           AND EXISTS
         (SELECT 1
                  FROM apps.xxint_events
                 WHERE id = SUBSTR(REPLACE(interface_name, 'XXPA2592'),
                                   0,
                                   instr(REPLACE(interface_name, 'XXPA2592'),
                                         'PHASE') - 1)
                   AND current_status = 'CLOSED');
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF;

     IF NVL(gv_event_current_phase, 'PHASE01') = 'PHASE04' AND gv_operating_unit is null and gv_request_type = 'P' THEN
        begin
        select org_id into gv_operating_unit
        from pa_projects_all where segment1 = gv_project_num;
        exception
          when others then
            null;
        end;
     END IF;

    -- Clean Interface History for previous phases of the current event
    BEGIN
      SELECT COUNT(1)
        INTO l_event_history_count
        FROM xxau_interface_history
       WHERE interface_name LIKE gc_interface_name || gv_event_id || '%'
         AND interface_name <>
             gc_interface_name || gv_event_id || gv_event_current_phase;

      log_debug('Interface Email History Count : ' ||
                l_event_history_count);
      log_debug('Interface Email History Key : ' || gc_interface_name ||
                gv_event_id || gv_event_current_phase);

      IF l_event_history_count > 0 THEN
        DELETE xxau_interface_history
         WHERE interface_name LIKE gc_interface_name || gv_event_id || '%'
           AND interface_name <>
               gc_interface_name || gv_event_id || gv_event_current_phase;
        COMMIT;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        log_debug('No Interface History Record',
                  XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
    END;

  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in Global Variables Assignment : ' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END set_global_variables;
  /******************************************************************************
  ** Procedure Name  : send_email_notification
  **
  ** Purpose:  For defaulting Global variables used across different Phases of the Event
  **
  ** Procedure History:
  ** Date         Who               Description
  ** ---------    ---------------   ----------------------------------------
  ** 13-May-2015  ccbssj            Initial Version. CR 22563                 *
  ******************************************************************************/
  PROCEDURE send_email_notification(p_message_code  IN VARCHAR2,
                                    p_error_message IN VARCHAR2,
                                    p_attachment in varchar2 default null) IS  --added attachment for CR24533
    l_email_body          VARCHAR2(10000);
    l_email_subject       VARCHAR2(1000);
    l_email_to            VARCHAR2(2000);
    l_email_return        NUMBER;
    l_email_ret_msg       VARCHAR2(2000);
    l_event_creation_date VARCHAR2(2000);
    l_event_id            NUMBER;
    l_email_notif_count   NUMBER;
    l_count               NUMBER;
    l_message_code        VARCHAR2(200);
    l_send_email_flag     VARCHAR2(20) := 'Y';
    l_msg_count           NUMBER := 1;
    l_error_clob          CLOB;
	l_email_domain        VARCHAR2(2000) := NULL; -- Added for Misc JIRA Story SEP - 2406

  BEGIN
    l_message_code := p_message_code;
    BEGIN
      SELECT TO_CHAR(creation_date, 'DD-MON-YYYY HH24:MI:SS')
        INTO l_event_creation_date
        FROM xxint_events
       WHERE guid = gv_guid;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    -- fnd_global.apps_initialize(46764, 51551, 20019);
    IF gv_proj_guid IS NULL THEN
      gv_proj_guid := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
                                                                   p_attribute_name => 'ATTRIBUTE9');
    END IF;
    /*
    if gv_order_guid is null then
    gv_order_guid := xxint_event_api_pub.event_field_value_as_vc2(p_guid           => gv_guid,
    p_attribute_name => 'ATTRIBUTE11');
    end if;
    */
    IF g_error_tbl.COUNT > 0 THEN
      IF NVL(gv_request_type, 'P') = 'P' THEN
        l_email_subject := 'Project Order Status : ' || gv_agreement_ref || '-' ||
                           gv_project_num || '-' || gv_order_num ||
                           '- ERROR';
      ELSE
        l_email_subject := 'Standard Order Status : ' || gv_agreement_ref || '-' ||
                           gv_project_num || '-' || gv_order_num ||
                           '- ERROR';
      END IF;
    ELSE
      IF NVL(gv_request_type, 'P') = 'P' THEN
        l_email_subject := 'Project Order Status : ' || gv_agreement_ref || '-' ||
                           gv_project_num || '-' || gv_order_num;
      ELSE
        l_email_subject := 'Standard Order Status : ' || gv_agreement_ref || '-' ||
                           gv_project_num || '-' || gv_order_num;
      END IF;
    END IF;
    l_email_body := 'Hi All,' || chr(10) ||
                    '      Please find below the Project Sales Order Status' ||
                    chr(10);
    IF gv_guid IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Event GUID              : ' || gv_guid;
    END IF;
    --
    IF l_event_creation_date IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Event Creation Date     : ' || l_event_creation_date;
    END IF;
    --
    IF gv_agreement_num IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Agreement Ref Number    : ' || gv_agreement_num;
    END IF;
    --
    IF gv_project_num IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Project Number          : ' || gv_project_num;
    END IF;
    --
    IF gv_order_num IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Sales Order Ref Number  : ' || gv_order_num;
    END IF;
    --
    IF gv_cust_po_number IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Customer PO Number      : ' || gv_cust_po_number;
    END IF;
    --
    IF gv_prj_version_num IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Project Version Number  : ' || gv_prj_version_num;
    END IF;
    IF gv_proj_guid IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) ||
                      'Project GUID            : ' || gv_proj_guid;
    END IF;
    IF gv_order_guid IS NOT NULL THEN
      l_email_body := l_email_body || chr(10) || 'Order GUID            : ' ||
                      gv_order_guid;
    END IF;

    IF gv_bill_event_guid is not null then
      l_email_body := l_email_body || chr(10) ||
                      'Billing Event GUID            : ' ||
                      gv_bill_event_guid;

    end if;

    --Get Order Status
    FOR c_order_data IN 1 .. g_order_data_rec.count LOOP
      IF g_order_data_rec(c_order_data).oracle_order_number IS NOT NULL THEN
        IF g_order_data_rec(c_order_data).email_date IS NULL THEN
          l_email_body := l_email_body || chr(10) ||
                          'Order Created for Spectrum Order Number (' ||
                          NVL(g_order_data_rec(c_order_data).order_ref,
                              g_order_data_rec(c_order_data).order_number) ||
                          '). Oracle Order Number    : ' || g_order_data_rec(c_order_data)
                         .oracle_order_number;
          g_order_data_rec(c_order_data).email_date := sysdate;
        END IF;
      END IF;
    END LOOP;
    IF NVL(l_message_code, 'XX') = gc_error OR g_error_tbl.COUNT > 0 THEN
      l_email_body := l_email_body || chr(10) || 'Error Details    : ';
      IF p_error_message IS NOT NULL THEN
        l_email_body := l_email_body || chr(10) || l_msg_count || '. ' ||
                        p_error_message;
        l_msg_count  := l_msg_count + 1;
      END IF;
    ELSE
      IF p_error_message IS NOT NULL THEN
        l_email_body := l_email_body || chr(10) || 'Progress Details    : ' ||
                        p_error_message;
      END IF;
    END IF;
    IF g_error_tbl.COUNT > 0 THEN
      l_message_code := gc_error;
      l_error_clob   := '<G_ERROR_DATA><PHASE>' || gv_event_current_phase ||
                        '</PHASE><ERROR_DATA>';
      FOR error_count IN 1 .. g_error_tbl.COUNT LOOP
        dbms_lob.append(l_error_clob,
                        chr(10) || l_msg_count || '. ' || g_error_tbl(error_count)
                        .error_text);
        IF LENGTH(l_email_body) < 10000 AND g_error_tbl(error_count)
          .error_text IS NOT NULL THEN
          l_email_body := l_email_body || chr(10) || l_msg_count || '. ' || g_error_tbl(error_count)
                         .error_text;
          l_msg_count  := l_msg_count + 1;
        END IF;
      END LOOP;
      dbms_lob.append(l_error_clob, '</ERROR_DATA></G_ERROR_DATA>');
      xxint_event_api_pub.replace_clob(gv_guid,
                                       'G_ERROR_DATA',
                                       l_error_clob);
    ELSE
      DELETE FROM xxint_event_clobs_v
       WHERE guid = gv_guid
         AND clob_code = 'G_ERROR_DATA';
    END IF;
    SELECT listagg(key_value, ',') within GROUP(ORDER BY 1) AS aa
      INTO l_email_to
      FROM xxint_event_type_key_vals
     WHERE event_type = gc_event_type
       AND key_type = gc_key_type
       AND key_type_value = gv_source_system
       AND key_name = gc_email_keyname
       AND status = 'ACTIVE';

    log_debug('Email Notification : ' || l_email_to);
    log_debug('gv_attribute42 : ' || gv_attribute42);--CR13475
    log_debug('gv_project_num : ' || gv_project_num);
    log_debug('gv_proj_status : ' || gv_proj_status);

    l_email_notif_count := 0;
    l_send_email_flag   := 'N';
    IF NVL(p_message_code, 'XX') = gc_error THEN
      SELECT COUNT(1)
        INTO l_email_notif_count
        FROM apps.xxau_interface_history
       WHERE interface_name =
             gc_interface_name || gv_event_id || gv_event_current_phase
         AND LAST_RUN_DATE > sysdate - 1;
      SELECT COUNT(1)
        INTO l_count
        FROM apps.xxau_interface_history
       WHERE interface_name =
             gc_interface_name || gv_event_id || gv_event_current_phase;
      IF l_email_notif_count = 0 THEN
        l_send_email_flag := 'Y';
        IF l_count = 0 THEN
          INSERT INTO apps.xxau_interface_history
          VALUES
            (gc_interface_name || gv_event_id || gv_event_current_phase,
             sysdate);
        ELSE
          UPDATE apps.xxau_interface_history
             SET last_run_date = sysdate
           WHERE interface_name =
                 gc_interface_name || gv_event_id || gv_event_current_phase;
        END IF;
      END IF;
    ELSE
      l_send_email_flag := 'Y';
    END IF;
    log_debug('Email Notification Count in 24 hrs : ' ||
              l_email_notif_count);
    log_debug('Email Notification Count : ' || l_count);
    log_debug('Email Flag :' || l_send_email_flag);

	l_email_domain := xxxxau3842_branding_util.f_get_lookup_desc('XXXXAU3842_COMMONCOMPANY_EMAIL' , 'NO_REP-EQUIP_UPDATE'); -- Added for Misc JIRA story for SEP -2406


    ---for testing
   /* open lv_refcur for
    select * from XX_TEST_SO_AMT_VALIDATION;

     xxau_delim_file_util.p_refcur_to_file(o_errbuf         => lv_errbuf,
                                                     o_retcode        => lv_retcode,
                                                     o_clob           => lv_result,
                                                     io_refcursor     => lv_refcur,
                                                     iv_no_data_msg   => NULL,
                                                     ib_encl_quotes   => TRUE,
                                                     iv_date_format   => NULL,
                                                     ib_copy_conc_out => TRUE);

      xx_pk_xml_util.p_clob_to_os_file(p_clob       => lv_result,
                                             iv_file_name => lv_file_name,
                                             iv_dir_name  => lv_temp_dir);

       log_debug('Directory path');

        SELECT directory_path || '/' || lv_file_name
            INTO   lv_attachment
            FROM   all_directories
            WHERE  directory_name = lv_temp_dir;

          log_debug('Directory path - '|| lv_attachment);*/
    --for testing


    IF NVL(l_send_email_flag, 'Y') = 'Y' THEN
    
      l_email_return := xx_pk_email.f_send_email(--sender       => 'no-reply.equiporderupdates@irco.com', -- Commented below for SEP - 2406
                                                 sender       => l_email_domain, -- Added email variable for Misc JIRA story for SEP -2406
												 recipient    => l_email_to||';'||gv_attribute42,------CR13475
                                                 subject      => l_email_subject,
                                                 BODY         => l_email_body,
                                                 errormessage => l_email_ret_msg,
                                                 Attachments  => p_attachment, --added attachment for CR24533
                                                 --replyto      => 'no-reply.equiporderupdates@irco.com'); -- Commented below for SEP - 2406
												 replyto      => l_email_domain); -- Added email variable for Misc JIRA story for SEP -2406
      log_debug('Email Return Message XXXX : ' || l_email_return || '-' ||
                l_email_ret_msg);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Email Notification Error :' || SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END send_email_notification;
  /******************************************************************************
  ** Procedure Name  : xxont_item_matching
  **
  ** Purpose:  This procedure will be used match the 40 dgt item to find the
  **           15 dgt * item and if it does not exist, it will create the same.
  **
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------       ----------------   ----------------------------------------
  ** 19-Jun-15       Ashish Daga        Created new
  ******************************************************************************/
  PROCEDURE xxont_item_matching(p_40_dgt_item    IN VARCHAR2,
                                p_15_dgt_item    IN OUT VARCHAR2,
                                p_price_list     IN VARCHAR2,
                                p_list_price     IN VARCHAR2,
                                p_pricing_date   IN DATE,
                                p_product_family IN VARCHAR2,
                                p_product_code   IN VARCHAR2,
                                p_status         IN OUT VARCHAR2,
                                p_error_message  IN OUT VARCHAR2) IS
    l_status         VARCHAR2(240);
    l_error_message  VARCHAR2(2400);
    l_15_dgt_item    VARCHAR2(240);
    l_order_source   VARCHAR2(240);
    l_product_family VARCHAR2(240);
    l_product_code   VARCHAR2(240);
    l_operating_unit HR_OPERATING_UNITS.NAME%TYPE; --Added for CR23801
  BEGIN
    l_product_family := p_product_family;
    l_product_code   := p_product_code;
    l_order_source   := gv_source_system;
    xxont_wt_configitem_match.xxont_item_match_proc(p_entity_id           => l_order_source,
                                                    p_partner_item_number => p_40_dgt_item,
                                                    p_product_family      => l_product_family,
                                                    p_oracle_item_number  => l_15_dgt_item,
                                                    p_item_exists         => l_status,
                                                    p_error_msg           => l_error_message);
    IF l_status = 'NOT_EXIST' THEN
      log_debug('Time before New Item Creation : ' ||
                TO_CHAR(SYSDATE, 'DD-MM-YYYY HH:MI:SS AM'));
      xxont_15dgt_item_create_pkg.xxont_15dgt_item_create_proc(p_item_number    => p_40_dgt_item,
                                                               p_product_code   => l_product_code,
                                                               p_product_family => l_product_family,
                                                               p_return         => l_error_message,
                                                               p_15dgt_item     => p_15_dgt_item,
                                                               p_source_system  => l_order_source,
                                                               p_debug_level    => 1,
                                                               p_calling_system => 'XXINT_EVENT');
      log_debug('Item Creation Status ' || l_error_message);
      IF (l_error_message IS NULL OR l_error_message = 'S') THEN
        log_debug('15 DGT Item # Genearted : ' || P_15_DGT_ITEM);
        log_debug('Calling Item Enrichment program ');

        --Added for CR23801
        if gv_operating_unit is not null then
          begin
            select name
              into l_operating_unit
              from hr_operating_units
             where organization_id = gv_operating_unit;
          exception
            when others then
              l_operating_unit := NULL;
          end;
        end if;
        --End of Added for CR23801

        xxont_15dgt_item_create_pkg.xxont_item_creation_enrichment(p_15dgt_item_number => p_15_dgt_item,
                                                                   p_40dgt_item_number => p_40_dgt_item,
                                                                   p_product_family    => l_product_family,
                                                                   p_product_code      => l_product_code,
                                                                   p_status            => l_status,
                                                                   p_error_message     => l_error_message,
                                                                   p_source_system     => l_order_source,
                                                                   p_list_price        => p_list_price,
                                                                   p_price_list_name   => p_price_list,
                                                                   p_debug_level       => 1,
                                                                   p_calling_system    => 'XXINT_EVENT',
                                                                   p_ship_from_org_id  => gv_ship_from_org_id, --Added for CR23801
                                                                   p_operating_unit    => L_OPERATING_UNIT --Added for CR23801
                                                                   );
        COMMIT;
        log_debug('After Enrichment Program Status : ' || l_status);
        IF (l_status = 'S') THEN
          p_status := 'S';
          log_debug('Item Creation And Enrichment process Completed Successfully ');
        ELSE
          p_status := 'E';
          log_error('Error in Item Enrichment ' || l_error_message);
          p_error_message := l_error_message;
        END IF;
      ELSE
        p_status := 'E';
        log_error('Error in Item Creation ' || l_error_message);
        p_error_message := l_error_message;
      END IF;
      log_debug('Time After New Item Creation process completed : ' ||
                TO_CHAR(SYSDATE, 'DD-MM-YYYY HH:MI:SS AM'));
    ELSIF l_status = 'ERROR' THEN
      p_status        := 'E';
      p_error_message := l_error_message;
    ELSE
      p_status      := 'S';
      p_15_dgt_item := l_15_dgt_item;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Abnormal Error in Item Match Program ' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END xxont_item_matching;
  /******************************************************************************
  ** Procedure Name  : xxont_create_deliverto_site
  ** Purpose:  For Deriving Oracle site use id ID - Deliver To
  **
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------            ----------------   ------------------------------------
  ** 01-Jul-15            Jyotsana Kandpal   Created new
  ******************************************************************************/
  PROCEDURE xxont_create_deliverto_site(p_site_code                 IN VARCHAR2,
                                        p_execution_mode            IN VARCHAR2,
                                        p_cust_account_id           IN NUMBER,
                                        p_address_string1           IN VARCHAR2,
                                        p_address_string2           IN VARCHAR2,
                                        p_address4                  IN VARCHAR2,
                                        p_org_id                    IN NUMBER,
                                        x_create_cust_site_rec_type IN OUT xxont_validate_create_site.create_cust_site_rec_type,
                                        x_cust_site_use_rec         IN OUT hz_cust_account_site_v2pub.cust_site_use_rec_type) IS
    p_create_cust_site_rec_type xxont_validate_create_site.create_cust_site_rec_type;
    p_location_rec_type         hz_location_v2pub.location_rec_type;
    x_location_rec_type         hz_location_v2pub.location_rec_type;
    p_cust_acct_site_rec        hz_cust_account_site_v2pub.cust_acct_site_rec_type;
    p_cust_site_use_rec         hz_cust_account_site_v2pub.cust_site_use_rec_type;
    l_cust_site_use_rec         hz_cust_account_site_v2pub.cust_site_use_rec_type;
    l_return_status             VARCHAR2(1000) := NULL;
    l_msg_count                 NUMBER := 0;
    l_msg_data                  VARCHAR2(1000) := NULL;
    l_err_msg                   VARCHAR2(4000) := NULL;
    l_object_number             NUMBER := 1;
    /* Cursor to get the site ownership */
    CURSOR cur_site_onrshp IS
      SELECT description
        FROM oe_lookups
       WHERE lookup_type = 'XXONT_SOURCE_SITE_OWNERSHIP'
         AND rownum = 1; --Write partner specific logic if lookupcode is created accordingly
  BEGIN
    gv_procedure_name := 'xxont_create_deliverto_site';
    gv_poo            := 'Creating New Deliver To Site';
    log_debug(gv_procedure_name || '.' || gv_poo);
    log_debug('  ');
    p_create_cust_site_rec_type.p_cust_account_id := p_cust_account_id;
    p_create_cust_site_rec_type.p_called_from     := 'DB';
    p_create_cust_site_rec_type.p_execution_mode  := p_execution_mode;
    p_location_rec_type.address1                  := SUBSTR(p_address_string1,
                                                            1,
                                                            instr(p_address_string1,
                                                                  '|',
                                                                  1,
                                                                  1) - 1);
    --log_debug('Address1:' || p_location_rec_type.address1);
    p_location_rec_type.address2 := SUBSTR(p_address_string1,
                                           instr(p_address_string1,
                                                 '|',
                                                 1,
                                                 1) + 1,
                                           instr(p_address_string1,
                                                 '|',
                                                 1,
                                                 2) - 1 -
                                           instr(p_address_string1,
                                                 '|',
                                                 1,
                                                 1));
    --log_debug('Address2:' || p_location_rec_type.address2);
    p_location_rec_type.address3 := SUBSTR(p_address_string1,
                                           instr(p_address_string1,
                                                 '|',
                                                 1,
                                                 2) + 1);
    --log_debug('Address3:' || p_location_rec_type.address3);
    p_location_rec_type.address4 := p_address4;
    p_location_rec_type.city     := SUBSTR(p_address_string2,
                                           1,
                                           instr(p_address_string2,
                                                 '|',
                                                 1,
                                                 1) - 1);
    --log_debug('City:' || p_location_rec_type.city);
    p_location_rec_type.state := SUBSTR(p_address_string2,
                                        instr(p_address_string2, '|', 1, 1) + 1,
                                        instr(p_address_string2, '|', 1, 2) - 1 -
                                        instr(p_address_string2, '|', 1, 1));
    --log_debug('State:' || p_location_rec_type.state);
    p_location_rec_type.province := SUBSTR(p_address_string2,
                                           instr(p_address_string2,
                                                 '|',
                                                 1,
                                                 2) + 1,
                                           instr(p_address_string2,
                                                 '|',
                                                 1,
                                                 3) - 1 -
                                           instr(p_address_string2,
                                                 '|',
                                                 1,
                                                 2));
    --log_debug('province:' || p_location_rec_type.province);
    p_location_rec_type.postal_code := SUBSTR(p_address_string2,
                                              instr(p_address_string2,
                                                    '|',
                                                    1,
                                                    3) + 1,
                                              instr(p_address_string2,
                                                    '|',
                                                    1,
                                                    4) - 1 -
                                              instr(p_address_string2,
                                                    '|',
                                                    1,
                                                    3));
    --log_debug('postal_code:' || p_location_rec_type.postal_code);
    p_location_rec_type.country := SUBSTR(p_address_string2,
                                          instr(p_address_string2, '|', 1, 4) + 1);
    --log_debug('country code:' || p_location_rec_type.country);
    --p_location_rec_type.county            := p_proj_loc_rec.p_county;
    p_cust_site_use_rec.site_use_code     := p_site_code;
    p_cust_site_use_rec.org_id            := p_org_id;
    p_location_rec_type.created_by_module := 'CUST_INTERFACE';
    -- Site Ownesrship
    OPEN cur_site_onrshp;
    LOOP
      FETCH cur_site_onrshp
        INTO p_cust_acct_site_rec.attribute1;
      EXIT WHEN cur_site_onrshp%NOTFOUND;
    END LOOP;
    CLOSE cur_site_onrshp;
    xxont_validate_create_site.xxont_valid_create_site_main(p_create_cust_site_rec_type,
                                                            p_location_rec_type,
                                                            x_location_rec_type,
                                                            p_cust_acct_site_rec,
                                                            p_cust_site_use_rec);
    IF p_cust_site_use_rec.site_use_id IS NULL THEN
      x_create_cust_site_rec_type.x_ret_code    := fnd_api.g_ret_sts_error;
      x_create_cust_site_rec_type.x_ret_message := p_create_cust_site_rec_type.x_ret_message;
    ELSE
      log_debug(' After Calling Global Site Creation Procedure: (' ||
                p_site_code || ')SITE_USE_ID ' ||
                p_cust_site_use_rec.site_use_id);
      log_debug(' X_RET_CODE ' || p_create_cust_site_rec_type.x_ret_code);
      log_debug(' X_PROCESSING_STATUS ' ||
                p_create_cust_site_rec_type.x_processing_status);
      x_cust_site_use_rec         := p_cust_site_use_rec;
      x_create_cust_site_rec_type := p_create_cust_site_rec_type;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      x_create_cust_site_rec_type.x_ret_code    := fnd_api.g_ret_sts_error;
      x_create_cust_site_rec_type.x_ret_message := 'Unhandled Exception in create_deliverto_site .' ||
                                                   SQLERRM;
      log_debug(gv_procedure_name || '.' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END xxont_create_deliverto_site;
  /******************************************************************************
  ** Procedure Name  : parse_transaction
  **
  ** Purpose:  For Parsing the XML
  **
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------            ----------------   -----------------------------------
  ** 13-May-15            Jyotsana Kandpal   Created new
  ******************************************************************************/
  PROCEDURE parse_transaction(p_xml            IN xmltype,
                              x_return_status  OUT VARCHAR2,
                              x_return_message OUT VARCHAR2) IS
    l_xml                      XMLTYPE;
    l_funding_count            NUMBER := 0;
    l_budget_count             NUMBER := 0;
    l_proj_event_count         NUMBER := 0;
    l_operating_unit_code      hr_operating_units.short_code%type;
    l_budget_line_count        NUMBER := 0;
    l_line_tag_part_link_count NUMBER := 0;
    l_line_tag_grp_count       NUMBER := 0;
    l_ord_line_add_attr_count  NUMBER := 0;
    l_partner_masking_enabled  VARCHAR2(20);
    l_event_creation_date      DATE;
    l_ilc_name_updated         VARCHAR2(20) := 'N';
    l_project_number           pa_projects_all.segment1%type;
    l_task_number              pa_tasks.task_number%type;
    l_item_number              varchar2(200) := NULL;
    l_att_count                number;
    l_seq_num                  number;
    l_event_exists             VARCHAR2(2) := 'N';
    l_event_tso_ref            VARCHAR2(200);
    l_prev_event_tso_ref       VARCHAR2(200);
    l_event_tso_ref_count      NUMBER := 1;
    l_add_grouping_tag         VARCHAR2(2) := 'N';
  BEGIN
    gv_procedure_name := 'parse_transaction';
    gv_poo            := 'Start';
    log_debug(gv_procedure_name || '.' || gv_poo);
    x_return_status := 'SUCCESS';
    gv_poo          := 'START CUSTOMER ORDER INFO LOOP';
    SELECT creation_date
      INTO l_event_creation_date
      FROM apps.xxint_events
     WHERE guid = gv_guid;
    gv_agr_tbl.DELETE;
    gv_sales_order_header_tbl.DELETE;
    g_prj_att_tbl.delete;

    FOR l_data IN (SELECT rownum l_cnt, column_value
                     FROM TABLE(xmlsequence(p_xml
                                            .extract('/EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS'))) tmp) LOOP
      BEGIN
        -- Removing Empty Tags from the Input Payload
        SELECT deletexml(l_data.column_value, '//*[not(node())]')
          INTO l_xml
          FROM dual;
      EXCEPTION
        WHEN OTHERS THEN
          log_debug('SQL Exception in Parsing: ' || SQLERRM,
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
          l_xml := l_data.column_value;
      END;
      -- START PROJECT ORDER LOOP
      FOR c_agr_loop IN (SELECT rownum l_agr_cnt,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/ORDER_TYPE',
                                             gv_namespace) AS order_type,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/PM_AGREEMENT_REFERENCE',
                                             gv_namespace) AS pm_agreement_reference,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/AGREEMENT_NUM',
                                             gv_namespace) AS agreement_num,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/AGREEMENT_TYPE',
                                             gv_namespace) AS agreement_type,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/AGREEMENT_DESCRIPTION',
                                             gv_namespace) AS agreement_description,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/PO_AMOUNT',
                                             gv_namespace) AS po_amount,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/CURRENCY_CODE',
                                             gv_namespace) AS currency_code,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/CUSTOMER_PO_NUMBER',
                                             gv_namespace) AS customer_po_number,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/PM_PRODUCT_CODE',
                                             gv_namespace) AS pm_product_code,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/OWNING_ORGANIZATION_ID',
                                             gv_namespace) AS owning_organization_id,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/OWNING_ORGANIZATION_CODE',
                                             gv_namespace) AS owning_organization_code,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/OWNING_ORGANIZATION_NAME',
                                             gv_namespace) AS owning_organization_name,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/JOB_LOCATION_COUNTRY',
                                             gv_namespace) AS job_location_country,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/VERSION_NUMBER',
                                             gv_namespace) AS version_number,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/OWNED_BY_PERSON_NUMBER',
                                             gv_namespace) AS owned_by_person_number,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/OWNED_BY_EBS_USER_NAME',
                                             gv_namespace) AS owned_by_ebs_user_name,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/OWNED_BY_PERSON_ID',
                                             gv_namespace) AS owned_by_person_id,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/CUSTOMER_ID',
                                             gv_namespace) AS customer_id,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/CUSTOMER_NUM',

                                             gv_namespace) AS customer_num,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/TERM_ID',
                                             gv_namespace) AS term_id,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/TERM_NAME',
                                             gv_namespace) AS term_name,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/ATTRIBUTE_CATEGORY',
                                             gv_namespace) AS attribute_category,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute1',
                                             gv_namespace) AS attribute1,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute2',
                                             gv_namespace) AS attribute2,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute3',
                                             gv_namespace) AS attribute3,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute4',
                                             gv_namespace) AS attribute4,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute5',
                                             gv_namespace) AS attribute5,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute6',
                                             gv_namespace) AS attribute6,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute7',
                                             gv_namespace) AS attribute7,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute8',
                                             gv_namespace) AS attribute8,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute9',
                                             gv_namespace) AS attribute9,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute10',
                                             gv_namespace) AS attribute10,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute11',
                                             gv_namespace) AS attribute11,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute12',
                                             gv_namespace) AS attribute12,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute13',
                                             gv_namespace) AS attribute13,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute14',
                                             gv_namespace) AS attribute14,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute15',
                                             gv_namespace) AS attribute15,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute16',
                                             gv_namespace) AS attribute16,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute17',
                                             gv_namespace) AS attribute17,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute18',
                                             gv_namespace) AS attribute18,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute19',
                                             gv_namespace) AS attribute19,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute20',
                                             gv_namespace) AS attribute20,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute21',
                                             gv_namespace) AS attribute21,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute22',
                                             gv_namespace) AS attribute22,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute23',
                                             gv_namespace) AS attribute23,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute24',
                                             gv_namespace) AS attribute24,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/attribute25',
                                             gv_namespace) AS attribute25,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/EXPIRATION_DATE',
                                             gv_namespace) AS expiration_date,
                                extractvalue(tmp_l.column_value,
                                             '/G_PROJECT_ORDERS/START_DATE',
                                             gv_namespace) AS start_date,
                                extract(tmp_l.column_value,
                                        '//CUSTOMER_INFO',
                                        gv_namespace) AS customer_info,
                                extract(tmp_l.column_value,
                                        '//G_SALES_COMMISSION',
                                        gv_namespace) AS g_sales_commission,
                                extract(tmp_l.column_value,
                                        '//G_PROJECTS',
                                        gv_namespace) AS g_projects,
                                extract(tmp_l.column_value,
                                        '//G_ORDER',
                                        gv_namespace) AS g_order,
                                extract(tmp_l.column_value,
                                        '//G_PROJECT_ORDERS/G_ATTACHMENT',
                                        gv_namespace) AS G_AGR_ATTACHMENT --Added for CR24105
                           FROM TABLE(xmlsequence(l_xml.extract('/G_PROJECT_ORDERS',
                                                                gv_namespace))) tmp_l) LOOP
        BEGIN
          log_debug('In Loop Agreement Loop. Start for Agreement Number ' ||
                    c_agr_loop.agreement_num);
          /*************************************************************************************/
          --  Project Agreement Record Type
          /************************************************************************************/
          gv_poo := 'Assignment of XML to Agreement Record Type';
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.pm_agreement_reference := c_agr_loop.pm_agreement_reference;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.agreement_num := c_agr_loop.agreement_num;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.agreement_type := c_agr_loop.agreement_type;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.amount := c_agr_loop.po_amount;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.description := c_agr_loop.agreement_description;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.agreement_currency_code := c_agr_loop.currency_code;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.customer_order_number := c_agr_loop.customer_po_number;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.customer_id := c_agr_loop.customer_id;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.customer_num := c_agr_loop.customer_num;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.term_id := c_agr_loop.term_id;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.term_name := c_agr_loop.term_name;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute_category := c_agr_loop.attribute_category;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute1 := c_agr_loop.attribute1;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute2 := c_agr_loop.attribute2;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute3 := c_agr_loop.attribute3;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute4 := c_agr_loop.attribute4;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute5 := c_agr_loop.attribute5;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute6 := c_agr_loop.attribute6;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute7 := c_agr_loop.attribute7;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute8 := c_agr_loop.attribute8;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute9 := c_agr_loop.attribute9;
          --gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute10 := c_agr_loop.attribute10;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute10 := c_agr_loop.version_number;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute11 := c_agr_loop.attribute11;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute12 := c_agr_loop.attribute12;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute13 := c_agr_loop.attribute13;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute14 := c_agr_loop.attribute14;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute15 := c_agr_loop.attribute15;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute16 := c_agr_loop.attribute16;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute17 := c_agr_loop.attribute17;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute18 := c_agr_loop.attribute18;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute19 := c_agr_loop.attribute19;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute20 := c_agr_loop.attribute20;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute21 := c_agr_loop.attribute21;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute22 := c_agr_loop.attribute22;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute23 := c_agr_loop.attribute23;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute24 := c_agr_loop.attribute24;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute25 := c_agr_loop.attribute25;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.pm_product_code := c_agr_loop.pm_product_code;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.owning_organization_code := c_agr_loop.owning_organization_code;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.owning_organization_name := c_agr_loop.owning_organization_name;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.owning_organization_id := c_agr_loop.owning_organization_id;
          /* Added for Deriving Sales Rep in case of 'S' Sales Order */
          gv_owning_organization_code := c_agr_loop.owning_organization_code;
          gv_owning_organization_name := c_agr_loop.owning_organization_name;
          gv_owning_organization_id   := c_agr_loop.owning_organization_id;
          /*End of Added for Deriving Sales Rep in case of 'S' Sales Order */
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.owned_by_person_id := c_agr_loop.owned_by_person_id;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.owned_by_person_number := c_agr_loop.owned_by_person_number;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.ebs_user_name := c_agr_loop.owned_by_ebs_user_name;
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.update_agreement_allowed := 'N';
          gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.job_location_country := c_agr_loop.job_location_country;
          --gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.start_date := c_agr_loop.start_date;
          --gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.expiration_date := c_agr_loop.expiration_date;
          date_convert(c_agr_loop.start_date,
                       gv_agr_tbl(c_agr_loop.l_agr_cnt)
                       .agr_main_rec.start_date);
          date_convert(c_agr_loop.expiration_date,
                       gv_agr_tbl(c_agr_loop.l_agr_cnt)
                       .agr_main_rec.expiration_date);
          --Added for CR24105
          gv_poo := 'Start of Assignment of XML to Agreement Attachment rec Type';
          log_debug(gv_poo);
          l_att_count := 0;
          /*************************************************************************************/
          --  Project Record Type
          /************************************************************************************/
          FOR c_agr_att_loop IN (SELECT rownum l_prj_cnt,
                                        extractvalue(tmp_l.column_value,
                                                     '/ATTACHMENTS/noteType',
                                                     gv_namespace) AS noteType,
                                        extractvalue(tmp_l.column_value,
                                                     '/ATTACHMENTS/notes',
                                                     gv_namespace) AS notes,
                                        extractvalue(tmp_l.column_value,
                                                     '/ATTACHMENTS/entityName',
                                                     gv_namespace) AS entityName,
                                        extractvalue(tmp_l.column_value,
                                                     '/ATTACHMENTS/seqNumber',
                                                     gv_namespace) AS seqNumber,
                                        extractvalue(tmp_l.column_value,
                                                     '/ATTACHMENTS/title',
                                                     gv_namespace) AS title,
                                        extractvalue(tmp_l.column_value,
                                                     '/ATTACHMENTS/description',
                                                     gv_namespace) AS description,
                                        --                                    gv_agreement_num agreement_num,
                                        --                                        null project_num,
                                        --                                        null task_num,
                                        extract(tmp_l.column_value,
                                                '//G_SRC_ATTRIBUTES',
                                                gv_namespace) AS g_src_attributes
                                   FROM TABLE(xmlsequence(c_agr_loop.G_AGR_ATTACHMENT.extract('//ATTACHMENTS',
                                                                                              gv_namespace))) tmp_l
                                  WHERE gv_request_type = 'P') LOOP
            l_att_count := l_att_count + 1;
            g_prj_att_tbl(l_att_count).noteType := c_agr_att_loop.noteType;
            g_prj_att_tbl(l_att_count).notes := c_agr_att_loop.notes;
            g_prj_att_tbl(l_att_count).entityName := c_agr_att_loop.entityName;
            g_prj_att_tbl(l_att_count).seqNumber := c_agr_att_loop.seqNumber;
            g_prj_att_tbl(l_att_count).title := c_agr_att_loop.title;
            g_prj_att_tbl(l_att_count).description := c_agr_att_loop.description;
            g_prj_att_tbl(l_att_count).agreement_num := gv_agreement_num;
            --            g_prj_att_tbl(l_att_count).project_num := NULL;--c_agr_att_loop.project_num;
            --            g_prj_att_tbl(l_att_count).task_num := NULL;--c_agr_att_loop.task_num;
            log_debug('Notes Current iter: ' || l_att_count);
            log_debug('Notes : ' || g_prj_att_tbl(l_att_count).notes);
            log_debug('agreement_num : ' || g_prj_att_tbl(l_att_count)
                      .agreement_num || '-' || gv_agreement_num);
            log_debug('project_num : ' || g_prj_att_tbl(l_att_count)
                      .project_num || '-' || gv_project_num);
          end loop;

          --End of Added for CR24105
          gv_poo := 'Start of Assignment of XML to Project Record Type';
          log_debug(gv_poo);

          /*************************************************************************************/
          --  Project Record Type
          /************************************************************************************/
          FOR c_prj_loop IN (SELECT rownum l_prj_cnt,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PM_PROJECT_REFERENCE',
                                                 gv_namespace) AS pm_project_reference,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PA_PROJECT_NUMBER',
                                                 gv_namespace) AS pa_project_number,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_NAME',
                                                 gv_namespace) AS project_name,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/LONG_NAME',
                                                 gv_namespace) AS long_name,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/DESCRIPTION',
                                                 gv_namespace) AS description,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/START_DATE',
                                                 gv_namespace) AS start_date,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/COMPLETION_DATE',
                                                 gv_namespace) AS completion_date,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_TYPE',
                                                 gv_namespace) AS project_type,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_TYPE_ORACLE',
                                                 gv_namespace) AS project_type_oracle,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJ_REV_VERSION_NUMBER',
                                                 gv_namespace) AS proj_rev_version_name,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/CUSTOMER_ID',
                                                 gv_namespace) AS customer_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/CUSTOMER_NUM',
                                                 gv_namespace) AS customer_num,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/BILL_TO_CUSTOMER_ID',
                                                 gv_namespace) AS bill_to_customer_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/SHIP_TO_CUSTOMER_ID',
                                                 gv_namespace) AS ship_to_customer_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/BILL_TO_ADDRESS_ID',
                                                 gv_namespace) AS bill_to_address_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/SHIP_TO_ADDRESS_ID',
                                                 gv_namespace) AS ship_to_address_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/CREATED_FROM_PROJECT_ID',
                                                 gv_namespace) AS created_from_project_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/CARRYING_OUT_ORGANIZATION_ID',
                                                 gv_namespace) AS carrying_out_organization_id,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/CARRYING_OUT_ORGANIZATION_CODE',
                                                 gv_namespace) AS carrying_out_organization_code,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/CARRYING_OUT_ORGANIZATION_NAME',
                                                 gv_namespace) AS carrying_out_organization_name,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_STATUS',
                                                 gv_namespace) AS project_status,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_STATUS_CODE',
                                                 gv_namespace) AS project_status_code,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_RELATIONSHIP_CODE',
                                                 gv_namespace) AS project_relationship_code,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_CURRENCY_CODE',
                                                 gv_namespace) AS project_currency_code,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/PROJECT_RATE_TYPE',
                                                 gv_namespace) AS project_rate_type,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE_CATEGORY',
                                                 gv_namespace) AS attribute_category,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE1',
                                                 gv_namespace) AS attribute1,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE2',
                                                 gv_namespace) AS attribute2,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE3',
                                                 gv_namespace) AS attribute3,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE4',
                                                 gv_namespace) AS attribute4,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE5',
                                                 gv_namespace) AS attribute5,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE6',
                                                 gv_namespace) AS attribute6,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE7',
                                                 gv_namespace) AS attribute7,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE8',
                                                 gv_namespace) AS attribute8,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE9',
                                                 gv_namespace) AS attribute9,
                                    extractvalue(tmp_l.column_value,
                                                 '/PROJECT/ATTRIBUTE10',
                                                 gv_namespace) AS attribute10,
                                    extract(tmp_l.column_value,
                                            '//G_PROJECTS_PLAYERS',
                                            gv_namespace) AS g_pa_project_players,
                                    extract(tmp_l.column_value,
                                            '//G_PA_PROJECT_CLASSES',
                                            gv_namespace) AS g_pa_project_classes,
                                    extract(tmp_l.column_value,
                                            '//G_RESERVE_CODES',
                                            gv_namespace) AS g_reserve_codes,
                                    extract(tmp_l.column_value,
                                            '//G_SRC_ATTRIBUTES',
                                            gv_namespace) AS g_src_attributes,
                                    extract(tmp_l.column_value,
                                            '//G_ATTACHMENT',
                                            gv_namespace) AS g_attachment --Added for CR24105
                               FROM TABLE(xmlsequence(c_agr_loop.g_projects.extract('//PROJECT',
                                                                                    gv_namespace))) tmp_l
                              WHERE gv_request_type = 'P') LOOP
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.pa_project_number := c_prj_loop.pa_project_number;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.project_name := c_prj_loop.project_name;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.long_name := c_prj_loop.long_name;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.description := c_prj_loop.description;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_extra_rec.project_type := c_prj_loop.project_type;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_extra_rec.project_type_oracle := c_prj_loop.project_type_oracle;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_extra_rec.proj_rev_version_name := c_prj_loop.proj_rev_version_name;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.attribute10 := NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                             .agr_main_rec.attribute10,
                                                                             c_prj_loop.proj_rev_version_name);
            date_convert(c_prj_loop.start_date,
                         gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                         .prj_main_rec.start_date);
            gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.start_date := NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                            .agr_main_rec.start_date,
                                                                            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                                                            .prj_main_rec.start_date);
            date_convert(c_prj_loop.completion_date,
                         gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                         .prj_main_rec.completion_date);
            --            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.pm_project_reference := NVL(c_prj_loop.pm_project_reference,
            --                                                                                                                      gv_agr_tbl(c_agr_loop.l_agr_cnt)
            --                                                                                                                      .agr_main_rec.pm_agreement_reference);

            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.pm_project_reference := NVL(c_prj_loop.pm_project_reference,
                                                                                                                      c_prj_loop.pa_project_number);

            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.created_from_project_id := c_prj_loop.created_from_project_id;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.carrying_out_organization_id := NVL(c_prj_loop.carrying_out_organization_id,
                                                                                                                              gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                                                              .agr_main_rec.owning_organization_id);
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.project_status_code := c_prj_loop.project_status_code;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.project_relationship_code := c_prj_loop.project_relationship_code;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute_category := c_prj_loop.attribute_category;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute1 := c_prj_loop.attribute1;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute2 := c_prj_loop.attribute2;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute3 := c_prj_loop.attribute3;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute4 := c_prj_loop.attribute4;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute5 := c_prj_loop.attribute5;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute6 := c_prj_loop.attribute6;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute7 := c_prj_loop.attribute7;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute8 := c_prj_loop.attribute8;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute9 := c_prj_loop.attribute9;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.attribute10 := c_prj_loop.attribute10;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.project_currency_code := NVL(c_prj_loop.project_currency_code,
                                                                                                                       gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                                                       .agr_main_rec.agreement_currency_code);
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.project_rate_type := c_prj_loop.project_rate_type;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.customer_id := c_prj_loop.customer_id;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.bill_to_customer_id := c_prj_loop.bill_to_customer_id;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.ship_to_customer_id := c_prj_loop.ship_to_customer_id;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.bill_to_address_id := c_prj_loop.bill_to_address_id;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_main_rec.ship_to_address_id := c_prj_loop.ship_to_address_id;
            gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_extra_rec.carrying_out_organization_code := NVL(c_prj_loop.carrying_out_organization_code,
                                                                                                                                 gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                                                                 .agr_extra_rec.owning_organization_code);
            IF gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
             .prj_extra_rec.carrying_out_organization_code IS NULL THEN
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).prj_extra_rec.carrying_out_organization_name := NVL(c_prj_loop.carrying_out_organization_name,
                                                                                                                                   gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                                                                   .agr_extra_rec.owning_organization_name);
            END IF;
            IF gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
             .prj_extra_rec.carrying_out_organization_name IS NULL THEN
              BEGIN
                SELECT organization_name
                  INTO gv_carrying_out_org_name
                  FROM apps.ORG_ORGANIZATION_DEFINITIONS
                 WHERE upper(organization_code) =
                       UPPER(NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                 .prj_extra_rec.carrying_out_organization_code,
                                 organization_code))
                   AND organization_id =
                       NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                           .prj_main_rec.carrying_out_organization_id,
                           organization_id)
                   AND upper(organization_name) =
                       UPPER(NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                 .prj_extra_rec.carrying_out_organization_name,
                                 organization_name));
              EXCEPTION
                WHEN OTHERS THEN
                  NULL;
              END;
            END IF;
            BEGIN
              SELECT operating_unit
                INTO gv_operating_unit
                FROM apps.ORG_ORGANIZATION_DEFINITIONS
               WHERE upper(organization_code) =
                     UPPER(NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                               .prj_extra_rec.carrying_out_organization_code,
                               organization_code))
                 AND organization_id =
                     NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                         .prj_main_rec.carrying_out_organization_id,
                         organization_id)
                 AND upper(organization_name) =
                     UPPER(NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                               .prj_extra_rec.carrying_out_organization_name,
                               organization_name));
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
--              BEGIN
--              SELECT operating_unit
--                INTO gv_operating_unit
--                FROM apps.ORG_ORGANIZATION_DEFINITIONS
--               WHERE upper(organization_name) =
--                     UPPER(NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
--                               .prj_extra_rec.carrying_out_organization_name,
--                               organization_name));
--              EXCEPTION
--              WHEN OTHERS THEN
--
--                NULL;
--            END;
                NULL;
            WHEN OTHERS THEN

                NULL;
            END;
            gv_poo := 'Start Project SRC Attributes Loop';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Checking G_SRC_ATTRIBUTES
            /************************************************************************************/
            FOR c_proj_src_attr_loop IN (SELECT rownum l_src_attr_cnt,
                                                extractvalue(tmp_l.column_value,
                                                             '/SRC_ATTRIBUTE/NAME',
                                                             gv_namespace) AS NAME,
                                                extractvalue(tmp_l.column_value,
                                                             '/SRC_ATTRIBUTE/VALUE',
                                                             gv_namespace) AS VALUE
                                           FROM TABLE(xmlsequence(c_prj_loop.g_src_attributes.extract('//SRC_ATTRIBUTE',
                                                                                                      gv_namespace))) tmp_l) LOOP
              IF c_proj_src_attr_loop.NAME = 'EXISTING_AGR_NUMBER' THEN
                gv_existing_agr_number := c_proj_src_attr_loop.VALUE;
                log_debug('Existing Agr Number Attr : ' ||
                          gv_existing_agr_number);
              END IF;
            END LOOP;

            --Added for CR24105
            gv_poo := 'Start of Assignment of XML to Project Attachment rec Type';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Project Record Type
            /************************************************************************************/
            FOR c_agr_att_loop IN (SELECT rownum l_prj_cnt,
                                          extractvalue(tmp_l.column_value,
                                                       '/ATTACHMENTS/noteType',
                                                       gv_namespace) AS noteType,
                                          extractvalue(tmp_l.column_value,
                                                       '/ATTACHMENTS/notes',
                                                       gv_namespace) AS notes,
                                          extractvalue(tmp_l.column_value,
                                                       '/ATTACHMENTS/entityName',
                                                       gv_namespace) AS entityName,
                                          extractvalue(tmp_l.column_value,
                                                       '/ATTACHMENTS/seqNumber',
                                                       gv_namespace) AS seqNumber,
                                          extractvalue(tmp_l.column_value,
                                                       '/ATTACHMENTS/title',
                                                       gv_namespace) AS title,
                                          extractvalue(tmp_l.column_value,
                                                       '/ATTACHMENTS/description',
                                                       gv_namespace) AS description,
                                          --                                          null agreement_num,
                                          --                                          c_prj_loop.pa_project_number project_num,
                                          --                                          null task_num,
                                          extract(tmp_l.column_value,
                                                  '//G_SRC_ATTRIBUTES',
                                                  gv_namespace) AS g_src_attributes
                                     FROM TABLE(xmlsequence(c_prj_loop.G_ATTACHMENT.extract('//ATTACHMENTS',
                                                                                            gv_namespace))) tmp_l
                                    WHERE gv_request_type = 'P') LOOP
              l_att_count := l_att_count + 1;
              g_prj_att_tbl(l_att_count).noteType := c_agr_att_loop.noteType;
              g_prj_att_tbl(l_att_count).notes := c_agr_att_loop.notes;
              g_prj_att_tbl(l_att_count).entityName := c_agr_att_loop.entityName;
              g_prj_att_tbl(l_att_count).seqNumber := c_agr_att_loop.seqNumber;
              g_prj_att_tbl(l_att_count).title := c_agr_att_loop.title;
              g_prj_att_tbl(l_att_count).description := c_agr_att_loop.description;
              --              g_prj_att_tbl(l_att_count).agreement_num := NULL;--c_agr_att_loop.agreement_num;
              g_prj_att_tbl(l_att_count).project_num := gv_project_num; --c_agr_att_loop.project_num;
            --              g_prj_att_tbl(l_att_count).task_num := NULL;--c_agr_att_loop.task_num;

            end loop;

            log_debug('After Proj Attachment Count ' || l_att_count || '-' ||
                      g_prj_att_tbl.count);
            --End of Added for CR24105
            gv_poo := 'Start Project Customer Loop';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Project Customer Record Type
            /************************************************************************************/
            FOR c_prj_cust_loop IN (SELECT rownum l_prj_cust_cnt,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/CUSTOMER_NUMBER',
                                                        gv_namespace) AS customer_number,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/BILL_TO_CUSTOMER_ID',
                                                        gv_namespace) AS bill_to_customer_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_CUSTOMER_ID',
                                                        gv_namespace) AS ship_to_customer_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/BILL_TO_ADDRESS_ID',
                                                        gv_namespace) AS bill_to_address_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_ID',
                                                        gv_namespace) AS ship_to_address_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/BILL_TO_PARTY_SITE_ID',
                                                        gv_namespace) AS bill_to_party_site_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/PAYMENT_TERMS',
                                                        gv_namespace) AS payment_terms,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/INV_CURRENCY_CODE',
                                                        gv_namespace) AS inv_currency_code,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_PARTY_SITE_ID',
                                                        gv_namespace) AS ship_to_party_site_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE1',
                                                        gv_namespace) AS ship_to_adress_line1,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE2',
                                                        gv_namespace) AS ship_to_adress_line2,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE3',
                                                        gv_namespace) AS ship_to_adress_line3,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE4',
                                                        gv_namespace) AS ship_to_adress_line4,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_CITY',
                                                        gv_namespace) AS ship_to_adress_city,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_STATE',
                                                        gv_namespace) AS ship_to_adress_state,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_POSTAL_CODE',
                                                        gv_namespace) AS ship_to_adress_postal_code,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_COUNTRY',
                                                        gv_namespace) AS ship_to_adress_country,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_ADDRESS_COUNTY',
                                                        gv_namespace) AS ship_to_adress_county,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/SHIP_TO_PARTY_SITE_NUMBER',
                                                        gv_namespace) AS ship_to_party_site_number,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/BILL_TO_PARTY_SITE_NUMBER',
                                                        gv_namespace) AS bill_to_party_site_number,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/CUSTOMER_ID',
                                                        gv_namespace) AS customer_id,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/PROJECT_RELATIONSHIP_CODE',
                                                        gv_namespace) AS project_relationship_code,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/INV_RATE_TYPE',
                                                        gv_namespace) AS inv_rate_type,
                                           extractvalue(tmp_l.column_value,
                                                        '/CUSTOMER_INFO/INV_EXCHANGE_RATE',
                                                        gv_namespace) AS inv_exchange_rate
                                      FROM TABLE(xmlsequence(c_agr_loop.customer_info.extract('//CUSTOMER_INFO',
                                                                                              gv_namespace))) tmp_l) LOOP
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).bill_to_customer_id := c_prj_cust_loop.bill_to_customer_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).ship_to_customer_id := c_prj_cust_loop.ship_to_customer_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).bill_to_address_id := c_prj_cust_loop.bill_to_address_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).ship_to_address_id := c_prj_cust_loop.ship_to_address_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).inv_currency_code := c_prj_cust_loop.inv_currency_code;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).customer_id := c_prj_cust_loop.customer_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.customer_number := c_prj_cust_loop.customer_number;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.customer_id := NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                               .agr_main_rec.customer_id,
                                                                               gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt)
                                                                               .customer_id);
              gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.customer_num := NVL(gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                .agr_main_rec.customer_num,
                                                                                gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                                                                .g_prj_cust_rec.prj_cust_extra.customer_number);
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.ship_to_address_1 := c_prj_cust_loop.ship_to_adress_line1;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.ship_to_address_2 := c_prj_cust_loop.ship_to_adress_line2;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.ship_to_address_3 := c_prj_cust_loop.ship_to_adress_line3;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.ship_to_address_4 := c_prj_cust_loop.ship_to_adress_line4;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.city := c_prj_cust_loop.ship_to_adress_city;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.county := c_prj_cust_loop.ship_to_adress_county;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.state := c_prj_cust_loop.ship_to_adress_state;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.postal_code := c_prj_cust_loop.ship_to_adress_postal_code;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.country := c_prj_cust_loop.ship_to_adress_country;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.ship_to_party_site_id := c_prj_cust_loop.ship_to_party_site_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.bill_to_party_site_id := c_prj_cust_loop.bill_to_party_site_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.ship_to_party_site_number := c_prj_cust_loop.ship_to_party_site_number;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_extra.bill_to_party_site_number := c_prj_cust_loop.bill_to_party_site_number;
              -- Assign values to Agreement Record Type , since these are present only at Customer Info Tag level
              -- gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.customer_num := c_prj_cust_loop.customer_number;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.term_name := c_prj_cust_loop.payment_terms;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).project_relationship_code := c_prj_cust_loop.project_relationship_code;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).inv_rate_type := c_prj_cust_loop.inv_rate_type;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_cust_rec.prj_cust_tbl(c_prj_cust_loop.l_prj_cust_cnt).inv_exchange_rate := c_prj_cust_loop.inv_exchange_rate;
              log_debug('Project Customer  -> ' || gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                        .g_prj_cust_rec.prj_cust_extra.customer_number);
            END LOOP;
            gv_poo := 'Start Project Credit Receiver Loop';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Project Credit Receiver Record Type
            /************************************************************************************/
            FOR c_prj_crd_recvr_loop IN (SELECT rownum l_crd_recvr_cnt,
                                                extractvalue(tmp_l.column_value,
                                                             '/SALES_COMMISSION/CREDIT_PERCENTAGE',
                                                             gv_namespace) AS credit_percentage,
                                                extractvalue(tmp_l.column_value,
                                                             '/SALES_COMMISSION/EMPLOYEE_NUMBER',
                                                             gv_namespace) AS employee_number,
                                                extractvalue(tmp_l.column_value,
                                                             '/SALES_COMMISSION/CREDIT_TYPE_CODE',
                                                             gv_namespace) AS credit_type_code,
                                                extractvalue(tmp_l.column_value,
                                                             '/SALES_COMMISSION/START_DATE_ACTIVE',
                                                             gv_namespace) AS start_date_active,
                                                extractvalue(tmp_l.column_value,
                                                             '/SALES_COMMISSION/EBS_USER_NAME',
                                                             gv_namespace) AS ebs_user_name
                                           FROM TABLE(xmlsequence(c_agr_loop.g_sales_commission.extract('//SALES_COMMISSION',
                                                                                                        gv_namespace))) tmp_l) LOOP
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_crd_recver_tbl(c_prj_crd_recvr_loop.l_crd_recvr_cnt).credit_percentage := c_prj_crd_recvr_loop.credit_percentage;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_crd_recver_tbl(c_prj_crd_recvr_loop.l_crd_recvr_cnt).employee_number := c_prj_crd_recvr_loop.employee_number;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_crd_recver_tbl(c_prj_crd_recvr_loop.l_crd_recvr_cnt).credit_type_code := c_prj_crd_recvr_loop.credit_type_code;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_crd_recver_tbl(c_prj_crd_recvr_loop.l_crd_recvr_cnt).ebs_user_name := c_prj_crd_recvr_loop.ebs_user_name;
              date_convert(c_prj_crd_recvr_loop.start_date_active,
                           gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_crd_recver_tbl(c_prj_crd_recvr_loop.l_crd_recvr_cnt)
                           .start_date_active);
              log_debug('Project Credit Receiver  -> ' || gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_crd_recver_tbl(c_prj_crd_recvr_loop.l_crd_recvr_cnt)
                        .employee_number);
            END LOOP;
            gv_poo := 'After Assignment of XML to Project Credit Receiver Table Type. Start Project Task Loop';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Project Task Record Type
            /************************************************************************************/
            --p_agr_rec.g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec := NULL;
            l_funding_count := 1;
            FOR c_prj_task_loop IN (SELECT rownum l_task_cnt,
                                           task_number,
                                           task_name,
                                           task_attribute1,
                                           reserve_amount,
                                           work_type,
                                           business_offering
                                      FROM (SELECT attribute4 task_number,
                                                   attribute3 task_name,
                                                   attribute5 task_attribute1,
                                                   attribute6 work_type,
                                                   attribute8 business_offering,
                                                   SUM(NVL(extractvalue(tmp_l.column_value,
                                                                        '/RESERVE_CODES/N-CODE_AMOUNT',
                                                                        gv_namespace),
                                                           0)) reserve_amount
                                              FROM xxint_event_type_key_vals a,
                                                   TABLE(xmlsequence(c_prj_loop.g_reserve_codes.extract('//RESERVE_CODES',
                                                                                                        gv_namespace))) tmp_l
                                             WHERE event_type = gc_event_type
                                               AND key_type = gc_key_type
                                               AND key_type_value =
                                                   gv_source_system
                                               AND key_name =
                                                   gc_ncode_keyname
                                               AND key_value =
                                                   extractvalue(tmp_l.column_value,
                                                                '/RESERVE_CODES/N-CODE',
                                                                gv_namespace)
                                               AND upper(attribute2) =
                                                   upper(extractvalue(tmp_l.column_value,
                                                                      '/RESERVE_CODES/N-CODE_DESCRIPTION',
                                                                      gv_namespace))
                                             GROUP BY attribute4,
                                                      attribute3,
                                                      attribute5,
                                                      attribute6,
                                                      attribute8)) LOOP
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(c_prj_task_loop.l_task_cnt).task_name := c_prj_task_loop.task_name;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(c_prj_task_loop.l_task_cnt).pm_task_reference := c_prj_task_loop.task_number;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(c_prj_task_loop.l_task_cnt).pa_task_number := c_prj_task_loop.task_number;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(c_prj_task_loop.l_task_cnt).attribute1 := c_prj_task_loop.task_attribute1;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(c_prj_task_loop.l_task_cnt).attribute9 := c_prj_task_loop.business_offering;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(c_prj_task_loop.l_task_cnt).task_description := c_prj_task_loop.task_name;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.g_prj_task_extra_tbl(c_prj_task_loop.l_task_cnt).reserve_amount := c_prj_task_loop.reserve_amount;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.g_prj_task_extra_tbl(c_prj_task_loop.l_task_cnt).work_type := c_prj_task_loop.work_type;

              /*************************************************************************************/
              --  Adding values in Project Funding Record Type
              /************************************************************************************/
              IF c_prj_task_loop.reserve_amount <> 0 THEN
                gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_main_tbl(l_funding_count).allocated_amount := c_prj_task_loop.reserve_amount;
                gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_main_tbl(l_funding_count).date_allocated := TRUNC(SYSDATE);
                gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_extra_tbl(l_funding_count).pa_project_number := c_prj_loop.pa_project_number;
                gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_extra_tbl(l_funding_count).pa_task_number := c_prj_task_loop.task_number;
                log_debug('Funding Details : ' || l_funding_count);
                log_debug(gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_extra_tbl(l_funding_count)
                          .pa_project_number || '-' || gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_extra_tbl(l_funding_count)
                          .pa_task_number || '-' || gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_main_tbl(l_funding_count)
                          .date_allocated || '-' || gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_funding_rec.prj_funding_main_tbl(l_funding_count)
                          .allocated_amount);
                l_funding_count := l_funding_count + 1;
              END IF;
            END LOOP;

            gv_poo              := 'After Assignment of XML to Project Task Record Type';
            gv_poo              := 'Start Project Funding Loop';
            l_budget_count      := 1;
            l_budget_line_count := 1;
            IF gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
             .g_prj_task_rec.tasks_in_tbl.COUNT > 0 THEN
              FOR task_count IN 1 .. gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                     .g_prj_task_rec.tasks_in_tbl.COUNT LOOP
                IF gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.g_prj_task_extra_tbl(task_count)
                 .reserve_amount > 0 THEN
                  IF task_count = 1 THEN
                    gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_budget_prj_tbl(l_budget_count).budget_version_name := gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                                                                                                                             .prj_extra_rec.proj_rev_version_name;
                    gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_budget_prj_tbl(l_budget_count).budget_type_code := 'AR';
                  END IF;
                  gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_budget_prj_tbl(l_budget_count).g_prj_bud_line_extra_t(l_budget_line_count).task_number := gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.tasks_in_tbl(task_count)
                                                                                                                                                                               .pa_task_number;
                  gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_budget_prj_tbl(l_budget_count).g_budget_line_in_tbl(l_budget_line_count).revenue := gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_task_rec.g_prj_task_extra_tbl(task_count)
                                                                                                                                                                         .reserve_amount;
                  l_budget_line_count := l_budget_line_count + 1;
                END IF;
              END LOOP;
            END IF;
            --Added for CR24082
            --Project Event Data
            --Check if Enable Billing Event is valid for Partner
            if nvl(gv_create_proj_events, 'N') = 'Y' THEN
              begin
                select hou.short_code
                  into l_operating_unit_code
                  from hr_operating_units  hou,
                       fnd_flex_value_sets fs,
                       fnd_flex_values_vl  fv
                 where hou.organization_id = gv_operating_unit
                   and fs.flex_value_set_name =
                       'XXPA2592_ENABLE_BILLLING_EVENT_OU_VS'
                   and fv.flex_value_set_id = fs.flex_value_set_id
                   and fv.flex_value = hou.short_code
				   AND fv.enabled_flag = 'Y'  --Added for SEP-4548 Separation
                   and hou.organization_id = gv_operating_unit;

              exception
                when others then
                  l_operating_unit_code := NULL;
              end;

              l_proj_event_count    := 0;
              l_event_tso_ref_count := 0;

			  --Added for RT8596434 Check Event Grouping Number
              begin
				  select NVL(max(to_number(replace(replace(replace(replace(upper(xxpa.attribute15), 'PRINT'),'HIDE'),'GROUP'),'.'))),0) group_num
				  into l_event_tso_ref_count
				  from pa_agreements_all pa, pa_project_fundings pf, XXPA_EVENTS_EXTRA_INFO xxpa
				  where pa.agreement_num = c_agr_loop.agreement_num
				  and pf.agreement_id = pa.agreement_id
				  and xxpa.project_id = pf.project_id;
			  exception
				when others then
					l_event_tso_ref_count := 0;
			  end;
              --End of Added for RT8596434 Check Event Grouping number

              FOR c_prj_task_loop IN (SELECT rownum l_evt_cnt,
                                             to_number(nvl(extractvalue(tmp_l.column_value,'/RESERVE_CODES/LINE_NUMBER',NULL),1)) LINE_NUMBER,
              NVL((
        SELECT
            extractvalue(tmp.column_value,'/SRC_ATTRIBUTE/VALUE',NULL)
        FROM
            TABLE ( xmlsequence(extract(tmp_l.column_value,'//G_SRC_ATTRIBUTES',NULL).extract('/G_SRC_ATTRIBUTES/SRC_ATTRIBUTE') ) ) tmp
        WHERE
            extractvalue(tmp.column_value,'/SRC_ATTRIBUTE/NAME',NULL) = 'BILL_REFERENCE'
    ),'1') bill_reference,
    NVL((
        SELECT
            extractvalue(tmp.column_value,'/SRC_ATTRIBUTE/VALUE',NULL)
        FROM
            TABLE ( xmlsequence(extract(tmp_l.column_value,'//G_SRC_ATTRIBUTES',NULL).extract('/G_SRC_ATTRIBUTES/SRC_ATTRIBUTE') ) ) tmp
        WHERE
            extractvalue(tmp.column_value,'/SRC_ATTRIBUTE/NAME',NULL) = 'BILL_QUANTITY'
    ),1) BILL_QUANTITY,


                                             A.attribute4 task_number,
                                             A.attribute3 task_name,
                                             A.attribute5 task_attribute1,
                                             A.attribute6 work_type,
                                             A.attribute7 group_event,
                                             extractvalue(tmp_l.column_value,
                                                          '/RESERVE_CODES/N-CODE',
                                                          gv_namespace) N_CODE,
                                             NVL(extractvalue(tmp_l.column_value,
                                                              '/RESERVE_CODES/N-CODE_AMOUNT',
                                                              gv_namespace),
                                                 0) reserve_amount,
                                             fv.attribute1 billing_event_type,
                                             fv.attribute2 revenue_event_type,
                                             fv.attribute3 hold_flag,
                                             nvl(fv.attribute4, 'N') bill_sales_commision_flg,
                                             nvl(fv.attribute5, 'N') rev_sales_commision_flg,
                                             NVL(extractvalue(tmp_l.column_value,
                                                              '/RESERVE_CODES/BILLING_EVENT_DESC',
                                                              gv_namespace),
                                                 extractvalue(tmp_l.column_value,
                                                              '/RESERVE_CODES/N-CODE_DESCRIPTION',
                                                              gv_namespace)) BILLING_EVENT_DESC,
                                             NVL(NVL(extractvalue(tmp_l.column_value,
                                                                  '/RESERVE_CODES/REVENUE_EVENT_DESC',
                                                                  gv_namespace),
                                                     extractvalue(tmp_l.column_value,
                                                                  '/RESERVE_CODES/N-CODE_DESCRIPTION',
                                                                  gv_namespace) ||
                                                     ' Revenue'),
                                                 fv.attribute1 || ' Revenue') REVENUE_EVENT_DESC,
                                             extractvalue(tmp_l.column_value,
                                                          '/RESERVE_CODES/SELLING_LEVEL',
                                                          gv_namespace) SELLING_LEVEL,
                                             extractvalue(tmp_l.column_value,
                                                          '/RESERVE_CODES/SALES_COMMISION',
                                                          gv_namespace) SALES_COMMISION,
                                             extract(tmp_l.column_value,
                                                     '//G_SRC_ATTRIBUTES',
                                                     gv_namespace) AS g_src_attributes
                                        FROM xxint_event_type_key_vals a,
                                             TABLE(xmlsequence(c_prj_loop.g_reserve_codes.extract('//RESERVE_CODES',
                                                                                                  gv_namespace))) tmp_l,
                                             fnd_flex_value_sets fs,
                                             fnd_flex_values_vl fv
                                       WHERE a.event_type = gc_event_type
                                         AND a.key_type = gc_key_type
                                         AND a.key_type_value = gv_source_system
                                         AND a.key_name = gc_ncode_keyname
                                         AND a.key_value = extractvalue(tmp_l.column_value,'/RESERVE_CODES/N-CODE',gv_namespace)
                                         AND upper(a.attribute2) =upper(extractvalue(tmp_l.column_value,'/RESERVE_CODES/N-CODE_DESCRIPTION',gv_namespace))
                                         AND NVL(extractvalue(tmp_l.column_value,'/RESERVE_CODES/N-CODE_AMOUNT',gv_namespace),0) <> 0
                                         AND l_operating_unit_code is not null
                                         and fs.flex_value_set_name = 'XXPA2592_EVENT_TASK_CODE_VS'
                                         and fv.flex_value_set_id = fs.flex_value_set_id
                                         and fv.parent_flex_value_low = l_operating_unit_code
                                         and fv.flex_value = a.attribute5
										 AND fv.enabled_flag = 'Y'  --Added for SEP-4548 Separation
--                                       order by to_number(NVL(extractvalue(tmp_l.column_value,
--                                                                           '/RESERVE_CODES/LINE_NUMBER',
--                                                                           gv_namespace),
--                                                              1))
--order by 3,DECODE(A.ATTRIBUTE7,'HIDE',1,0) --Commented for RT8596434
order by 3,2,DECODE(A.ATTRIBUTE7,'HIDE',1,0) --Added for RT8596434
                                                              ) LOOP

                log_debug('Project Event Data');

                log_debug('Event Exists Flag    :' || l_event_exists);
                log_debug('Billing Event Type   :' ||
                          c_prj_task_loop.billing_event_type);
                log_debug('Revenue Event Type   :' ||
                          c_prj_task_loop.revenue_event_type);
                log_debug('Reserve Amount       :' ||
                          c_prj_task_loop.reserve_amount);
                log_debug('Ref number           : ' ||
                          c_prj_loop.pa_project_number || '.' ||
                          l_proj_event_count);
                log_debug('Curr code            : ' ||
                          NVL(c_prj_loop.project_currency_code,
                              gv_agr_tbl(c_agr_loop.l_agr_cnt)
                              .agr_main_rec.agreement_currency_code));
                log_debug('Curr code            : ' ||
                          c_prj_task_loop.group_event);
                --Billing event
                l_event_exists := 'N';
                BEGIN
                  select decode(count(1), 0, 'N', 'Y')
                    into l_event_exists
                    from pa_events
                   where event_type = c_prj_task_loop.billing_event_type
                     and PM_EVENT_REFERENCE like
                         c_prj_loop.pa_project_number || '.' || '%'
                     and BILL_TRANS_BILL_AMOUNT =
                         c_prj_task_loop.reserve_amount
                     and BILL_TRANS_CURRENCY_CODE =
                         NVL(c_prj_loop.project_currency_code,
                             gv_agr_tbl(c_agr_loop.l_agr_cnt)
                             .agr_main_rec.agreement_currency_code);
                EXCEPTION
                  WHEN OTHERS THEN
                    log_debug('Exception in Project Event Parse : ' ||
                              SQLERRM);
                    l_event_exists := 'N';
                END;

                if c_prj_task_loop.billing_event_type is not null and
                   l_event_exists = 'N' then
                  l_proj_event_count := l_proj_event_count + 1;
                  g_proj_event_data_rec(l_proj_event_count).P_PM_EVENT_REFERENCE := c_prj_loop.pa_project_number || '.' ||
                                                                                   --c_prj_task_loop.TASK_NUMBER || '.' ||
                                                                                    l_proj_event_count;
                  g_proj_event_data_rec(l_proj_event_count).P_TASK_NUMBER := c_prj_task_loop.TASK_NUMBER;
                  g_proj_event_data_rec(l_proj_event_count).P_EVENT_TYPE := c_prj_task_loop.billing_event_type;
                  g_proj_event_data_rec(l_proj_event_count).P_AGREEMENT_NUMBER := gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                  .agr_main_rec.agreement_num;
                  g_proj_event_data_rec(l_proj_event_count).P_DESCRIPTION := c_prj_task_loop.BILLING_EVENT_DESC;
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_HOLD_FLAG := c_prj_task_loop.hold_flag;
                  g_proj_event_data_rec(l_proj_event_count).P_COMPLETION_DATE := SYSDATE;
                  g_proj_event_data_rec(l_proj_event_count).P_PROJECT_NUMBER := c_prj_loop.pa_project_number;
                  g_proj_event_data_rec(l_proj_event_count).P_QUANTITY_BILLED := 1;
                  g_proj_event_data_rec(l_proj_event_count).P_UOM_CODE := 'EA';
                  g_proj_event_data_rec(l_proj_event_count).P_UNIT_PRICE := c_prj_task_loop.reserve_amount;
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_TRANS_BILL_AMOUNT := c_prj_task_loop.reserve_amount;
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_TRANS_REV_AMOUNT := 0;
                  g_proj_event_data_rec(l_proj_event_count).P_TASK_PRODUCT_CODE := c_prj_task_loop.task_attribute1;
                  g_proj_event_data_rec(l_proj_event_count).P_REVENUE_HOLD_FLAG := c_prj_task_loop.HOLD_FLAG;
                  g_proj_event_data_rec(l_proj_event_count).p_calculate_sales_commision := c_prj_task_loop.bill_sales_commision_flg;
                  g_proj_event_data_rec(l_proj_event_count).p_create_event_flag := 'Y';
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_TRANS_CURRENCY_CODE := NVL(c_prj_loop.project_currency_code,
                                                                                              gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                              .agr_main_rec.agreement_currency_code);

                  g_proj_event_data_rec(l_proj_event_count).P_QUANTITY_BILLED := c_prj_task_loop.BILL_QUANTITY;
                  g_proj_event_data_rec(l_proj_event_count).P_UNIT_PRICE := g_proj_event_data_rec(l_proj_event_count).P_UNIT_PRICE /c_prj_task_loop.BILL_QUANTITY;

                  if c_prj_task_loop.bill_reference <> '1' THEN
                     g_proj_event_data_rec(l_proj_event_count).P_ATTRIBUTE2 := c_prj_task_loop.bill_reference;
                     l_event_tso_ref := c_prj_task_loop.bill_reference;
                  END IF;


                 /* FOR c_proj_src_attr_loop IN (SELECT rownum l_src_attr_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/SRC_ATTRIBUTE/NAME',
                                                                   gv_namespace) AS NAME,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/SRC_ATTRIBUTE/VALUE',
                                                                   gv_namespace) AS VALUE
                                                 FROM TABLE(xmlsequence(c_prj_task_loop.g_src_attributes.extract('//SRC_ATTRIBUTE',
                                                                                                                 gv_namespace))) tmp_l) LOOP

                    if c_proj_src_attr_loop.name = 'BILL_QUANTITY' AND
                       c_proj_src_attr_loop.VALUE is not null then
                      g_proj_event_data_rec(l_proj_event_count).P_QUANTITY_BILLED := c_proj_src_attr_loop.VALUE;
                      g_proj_event_data_rec(l_proj_event_count).P_UNIT_PRICE := g_proj_event_data_rec(l_proj_event_count)
                                                                                .P_UNIT_PRICE /
                                                                                 c_proj_src_attr_loop.VALUE;
                    end if;

                    if c_proj_src_attr_loop.name = 'BILL_REFERENCE' AND
                       c_proj_src_attr_loop.VALUE is not null then
                      l_event_tso_ref := c_proj_src_attr_loop.VALUE;
                      g_proj_event_data_rec(l_proj_event_count).P_ATTRIBUTE2 := c_proj_src_attr_loop.VALUE;
                    end if;
                  END LOOP;
*/
                  if l_event_tso_ref is not null AND
                     (nvl(l_prev_event_tso_ref, 'X') <> l_event_tso_ref OR
                     UPPER(TRIM(NVL(c_prj_task_loop.group_event, 'X'))) =
                     'PRINT') THEN
                    l_event_tso_ref_count := l_event_tso_ref_count + 1;
                    l_prev_event_tso_ref  := l_event_tso_ref;
                    if UPPER(TRIM(NVL(c_prj_task_loop.group_event, 'X'))) =
                     'PRINT' THEN
                        l_add_grouping_tag := 'Y';
                     ELSE
                        l_add_grouping_tag := 'N';
                     END IF;
                  end if;

                  if l_event_tso_ref is not null and l_add_grouping_tag = 'Y' then

                    if UPPER(TRIM(NVL(c_prj_task_loop.group_event, 'X'))) =
                       'PRINT' then

                      g_proj_event_data_rec(l_proj_event_count).P_EXT_ATTRIBUTE15 := 'Group' ||
                                                                                     l_event_tso_ref_count ||
                                                                                     '.print';
                    end if;

                    if UPPER(TRIM(NVL(c_prj_task_loop.group_event, 'X'))) =
                       'HIDE' then
                      g_proj_event_data_rec(l_proj_event_count).P_EXT_ATTRIBUTE15 := 'Group' ||
                                                                                     l_event_tso_ref_count ||
                                                                                     '.hide';
                    end if;

                  end if;
                end if;
                --Billing event
                l_event_exists := 'N';
                BEGIN
                  select decode(count(1), 0, 'N', 'Y')
                    into l_event_exists
                    from pa_events
                   where event_type = c_prj_task_loop.revenue_event_type
                     and PM_EVENT_REFERENCE like
                         c_prj_loop.pa_project_number || '.' || '%'
                     and BILL_TRANS_REV_AMOUNT =
                         c_prj_task_loop.reserve_amount
                     and BILL_TRANS_CURRENCY_CODE =
                         NVL(c_prj_loop.project_currency_code,
                             gv_agr_tbl(c_agr_loop.l_agr_cnt)
                             .agr_main_rec.agreement_currency_code);
                EXCEPTION
                  WHEN OTHERS THEN
                    log_debug('Exception in Project Event Parse : ' ||
                              SQLERRM);
                    l_event_exists := 'N';
                END;

                if c_prj_task_loop.revenue_event_type is not null and
                   l_event_exists = 'N' then

                  l_proj_event_count := l_proj_event_count + 1;
                  g_proj_event_data_rec(l_proj_event_count).P_PM_EVENT_REFERENCE := c_prj_loop.pa_project_number || '.' ||
                                                                                   --              c_prj_task_loop.TASK_NUMBER || '.' ||
                                                                                    l_proj_event_count;
                  g_proj_event_data_rec(l_proj_event_count).P_TASK_NUMBER := c_prj_task_loop.TASK_NUMBER;
                  g_proj_event_data_rec(l_proj_event_count).P_EVENT_TYPE := c_prj_task_loop.revenue_event_type;
                  g_proj_event_data_rec(l_proj_event_count).P_AGREEMENT_NUMBER := gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                  .agr_main_rec.agreement_num;
                  g_proj_event_data_rec(l_proj_event_count).P_DESCRIPTION := c_prj_task_loop.REVENUE_EVENT_DESC;
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_HOLD_FLAG := c_prj_task_loop.hold_flag;
                  g_proj_event_data_rec(l_proj_event_count).P_COMPLETION_DATE := SYSDATE;
                  g_proj_event_data_rec(l_proj_event_count).P_PROJECT_NUMBER := c_prj_loop.pa_project_number;
                  --g_proj_event_data_rec(l_proj_event_count).P_QUANTITY_BILLED := 1;
                  --g_proj_event_data_rec(l_proj_event_count).P_UOM_CODE := 'EA'
                  --g_proj_event_data_rec(l_proj_event_count).P_UNIT_PRICE := c_prj_task_loop.reserve_amount;
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_TRANS_BILL_AMOUNT := 0; --c_prj_task_loop.P_BILL_TRANS_BILL_AMOUNT;
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_TRANS_REV_AMOUNT := c_prj_task_loop.reserve_amount;
                  g_proj_event_data_rec(l_proj_event_count).P_REVENUE_HOLD_FLAG := c_prj_task_loop.HOLD_FLAG;
                  g_proj_event_data_rec(l_proj_event_count).P_TASK_PRODUCT_CODE := c_prj_task_loop.task_attribute1;
                  --g_proj_event_data_rec(l_proj_event_count).P_EXT_ATTRIBUTE11 := '5'; --c_prj_task_loop.P_EXT_ATTRIBUTE11;
                  g_proj_event_data_rec(l_proj_event_count).p_calculate_sales_commision := c_prj_task_loop.rev_sales_commision_flg;
                  g_proj_event_data_rec(l_proj_event_count).p_create_event_flag := 'Y';
                  g_proj_event_data_rec(l_proj_event_count).P_BILL_TRANS_CURRENCY_CODE := NVL(c_prj_loop.project_currency_code,
                                                                                              gv_agr_tbl(c_agr_loop.l_agr_cnt)
                                                                                              .agr_main_rec.agreement_currency_code);

                end if;
              END LOOP;
            END IF;
            --End of Added for CR24082

            gv_poo := 'Start Project Players Loop';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Project Players Record Type
            /************************************************************************************/
            FOR c_prj_players_loop IN (SELECT rownum l_player_cnt,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/PERSON_ID',
                                                           gv_namespace) AS person_id,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/PROJECT_ROLE_TYPE',
                                                           gv_namespace) AS project_role_type,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/PROJECT_ROLE_MEANING',
                                                           gv_namespace) AS project_role_meaning,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/START_DATE',
                                                           gv_namespace) AS start_date,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/END_DATE',
                                                           gv_namespace) AS end_date,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/PRJ_PLAYER_EMP_NO',
                                                           gv_namespace) AS prj_player_emp_no,
                                              extractvalue(tmp_l.column_value,
                                                           '/PROJECT_PLAYERS/EBS_USER_NAME',
                                                           gv_namespace) AS ebs_user_name
                                         FROM TABLE(xmlsequence(c_prj_loop.g_pa_project_players.extract('//PROJECT_PLAYERS',
                                                                                                        gv_namespace))) tmp_l) LOOP
              gv_poo := 'Assignment of XML to Project Players Record Type';
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt).person_id := c_prj_players_loop.person_id;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt).project_role_type := c_prj_players_loop.project_role_type;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt).project_role_meaning := c_prj_players_loop.project_role_meaning;
              date_convert(c_prj_players_loop.start_date,
                           gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt)
                           .start_date);
              IF gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt)
               .start_date IS NULL THEN
                gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt).start_date := gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt)
                                                                                                                                                                     .prj_main_rec.start_date;
              END IF;
              date_convert(c_prj_players_loop.end_date,
                           gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_main_tbl(c_prj_players_loop.l_player_cnt)
                           .end_date);
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_extra_tbl(c_prj_players_loop.l_player_cnt).ebs_user_name := c_prj_players_loop.ebs_user_name;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_prj_player_rec.prj_player_extra_tbl(c_prj_players_loop.l_player_cnt).prj_player_emp_no := c_prj_players_loop.prj_player_emp_no;
              -- If Agreement Owner is null then pass Project Manager as the Agreement Owner
              IF gv_agr_tbl(c_agr_loop.l_agr_cnt)
               .agr_main_rec.owned_by_person_id IS NULL AND gv_agr_tbl(c_agr_loop.l_agr_cnt)
                 .agr_extra_rec.owned_by_person_number IS NULL AND gv_agr_tbl(c_agr_loop.l_agr_cnt)
                 .agr_extra_rec.ebs_user_name IS NULL AND
                  c_prj_players_loop.project_role_type = 'PROJECT MANAGER' THEN
                gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_main_rec.owned_by_person_id := c_prj_players_loop.person_id;
                gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.owned_by_person_number := c_prj_players_loop.prj_player_emp_no;
                gv_agr_tbl(c_agr_loop.l_agr_cnt).agr_extra_rec.ebs_user_name := c_prj_players_loop.ebs_user_name;
              END IF;
            END LOOP; --Project PLAYERS END
            gv_poo := 'Assignment of XML to Project Players Record Type complete. Assignment of XML to Project Classificaton';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Project Classification Record Type
            /************************************************************************************/
            FOR c_prj_classes_loop IN (SELECT rownum l_class_cnt,
                                              extractvalue(tmp_l.column_value,
                                                           '/PA_PROJECT_CLASSES/CLASS_CATEGORY',
                                                           gv_namespace) AS class_category,
                                              extractvalue(tmp_l.column_value,
                                                           '/PA_PROJECT_CLASSES/CLASS_CODE',
                                                           gv_namespace) AS class_code,
                                              extractvalue(tmp_l.column_value,
                                                           '/PA_PROJECT_CLASSES/CODE_PERCENTAGE',
                                                           gv_namespace) AS code_percentage
                                         FROM TABLE(xmlsequence(c_prj_loop.g_pa_project_classes.extract('//PA_PROJECT_CLASSES',
                                                                                                        gv_namespace))) tmp_l) LOOP
              gv_poo := 'Assignment of XML to Project Classification Record Type';
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_class_categories_tbl(c_prj_classes_loop.l_class_cnt).class_category := c_prj_classes_loop.class_category;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_class_categories_tbl(c_prj_classes_loop.l_class_cnt).class_code := c_prj_classes_loop.class_code;
              gv_agr_tbl(c_agr_loop.l_agr_cnt).g_prj_tbl(c_prj_loop.l_prj_cnt).g_class_categories_tbl(c_prj_classes_loop.l_class_cnt).code_percentage := c_prj_classes_loop.code_percentage;
            END LOOP;
          END LOOP; -- Project Loop End
          ---- ********************** BEGIN PARSING FOR SALES ORDERS DATA *********************************------
          /*************************************************************************************/
          --  Sales Order Header Record Type
          /************************************************************************************/
          gv_poo := 'Begining Sales Order Data';
          log_debug(gv_poo);
          l_partner_masking_enabled := xxint_event_type_utils.get_key_parm_value(p_event_type     => gc_event_type,
                                                                                 p_key_type       => gc_key_type,
                                                                                 p_key_type_value => gv_source_system,
                                                                                 p_name           => gc_masking_keyname);
          FOR c_sales_orders_loop IN (SELECT rownum l_order_header_cnt,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ORG_CODE',
                                                          gv_namespace) AS org_code,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ORG_ID',
                                                          gv_namespace) AS org_id,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/REQUEST_DATE',
                                                          gv_namespace) AS request_date,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/TRANSACTIONAL_CURR_CODE',
                                                          gv_namespace) AS transactional_curr_code,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/SHIPMENT_PRIORITY',
                                                          gv_namespace) AS shipment_priority,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/FREIGHT_TERMS',
                                                          gv_namespace) AS freight_terms,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/SHIPPING_METHOD',
                                                          gv_namespace) AS shipping_method,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/FOB',
                                                          gv_namespace) AS fob,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/SHIPPING_INSTRUCTIONS',
                                                          gv_namespace) AS shipping_instructions,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ORDERED_DATE',
                                                          gv_namespace) AS ordered_date,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/PRICE_LIST',
                                                          gv_namespace) AS pricelist,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/SALESREP',
                                                          gv_namespace) AS salesrep,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE_CATEGORY',
                                                          gv_namespace) AS attribute_category,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE1',
                                                          gv_namespace) AS attribute1,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE2',
                                                          gv_namespace) AS attribute2,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE3',
                                                          gv_namespace) AS attribute3,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE4',
                                                          gv_namespace) AS attribute4,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE5',
                                                          gv_namespace) AS attribute5,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE6',
                                                          gv_namespace) AS attribute6,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE7',
                                                          gv_namespace) AS attribute7,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE8',
                                                          gv_namespace) AS attribute8,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE9',
                                                          gv_namespace) AS attribute9,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE10',
                                                          gv_namespace) AS attribute10,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE11',
                                                          gv_namespace) AS attribute11,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE12',
                                                          gv_namespace) AS attribute12,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE13',
                                                          gv_namespace) AS attribute13,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE14',
                                                          gv_namespace) AS attribute14,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE15',
                                                          gv_namespace) AS attribute15,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE16',
                                                          gv_namespace) AS attribute16,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE17',
                                                          gv_namespace) AS attribute17,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE18',
                                                          gv_namespace) AS attribute18,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE19',
                                                          gv_namespace) AS attribute19,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ATTRIBUTE20',
                                                          gv_namespace) AS attribute20,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ORDER_TYPE',
                                                          gv_namespace) AS order_type,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/ORGANIZATION_NAME',
                                                          gv_namespace) AS organization_name,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpContext',
                                                          gv_namespace) AS tpcontext,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute1',
                                                          gv_namespace) AS tpattribute1,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute2',
                                                          gv_namespace) AS tpattribute2,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute3',
                                                          gv_namespace) AS tpattribute3,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute4',
                                                          gv_namespace) AS tpattribute4,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute5',
                                                          gv_namespace) AS tpattribute5,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute6',
                                                          gv_namespace) AS tpattribute6,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute7',
                                                          gv_namespace) AS tpattribute7,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute8',
                                                          gv_namespace) AS tpattribute8,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute9',
                                                          gv_namespace) AS tpattribute9,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute10',
                                                          gv_namespace) AS tpattribute10,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute11',
                                                          gv_namespace) AS tpattribute11,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute12',
                                                          gv_namespace) AS tpattribute12,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute13',
                                                          gv_namespace) AS tpattribute13,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute14',
                                                          gv_namespace) AS tpattribute14,
                                             extractvalue(tmp_l.column_value,
                                                          '/ORDER_HEADER/tpAttribute15',
                                                          gv_namespace) AS tpattribute15,
                                             extract(tmp_l.column_value,
                                                     '/ORDER_HEADER/G_ADDITIONAL_ATTRS',
                                                     gv_namespace) AS g_additional_attrs,
                                             extract(tmp_l.column_value,
                                                     '/ORDER_HEADER/G_PRICING_ATTRS',
                                                     gv_namespace) AS g_pricing_attrs,
                                             extract(tmp_l.column_value,
                                                     '/ORDER_HEADER/G_PRICE_ADJS',
                                                     gv_namespace) AS g_price_adjs,
                                             extract(tmp_l.column_value,
                                                     '/ORDER_HEADER/G_SRC_ATTRIBUTES',
                                                     gv_namespace) AS g_src_attributes,
                                             extract(tmp_l.column_value,
                                                     '/ORDER_HEADER/G_ORDER_ATTACHMENTS',
                                                     gv_namespace) AS g_order_attachments,
                                             extract(tmp_l.column_value,
                                                     '//G_ORDER_LINE',
                                                     gv_namespace) AS g_order_line
                                        FROM TABLE(xmlsequence(c_agr_loop.g_order.extract('//ORDER_HEADER',
                                                                                          gv_namespace))) tmp_l) LOOP
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.org_id := c_sales_orders_loop.org_id;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.org_code := c_sales_orders_loop.org_code;
            IF gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
             .g_sales_order_hdr_main_rec.org_id IS NULL AND gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
               .g_sales_order_hdr_main_rec.org_code IS NOT NULL THEN
              BEGIN
                SELECT organization_id
                  INTO gv_operating_unit
                  FROM hr_operating_units
                 WHERE organization_id =
                       NVL(gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                           .g_sales_order_hdr_main_rec.org_code,
                           organization_id)
                   AND short_code = NVL(gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                                        .g_sales_order_hdr_main_rec.org_code,
                                        short_code);
              EXCEPTION
                WHEN OTHERS THEN
                  NULL;
              END;
            END IF;
            date_convert(c_sales_orders_loop.request_date,
                         gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                         .g_sales_order_hdr_main_rec.request_date);
            --gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.request_date := c_sales_orders_loop.request_date;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.transactional_curr_code := c_sales_orders_loop.transactional_curr_code;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.shipment_priority := c_sales_orders_loop.shipment_priority;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.freight_terms := c_sales_orders_loop.freight_terms;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.shipping_method := c_sales_orders_loop.shipping_method;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.fob := c_sales_orders_loop.fob;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.shipping_instructions := c_sales_orders_loop.shipping_instructions;
            --IF gv_source_system = 'SPECTRUM_LA' THEN
            IF g_ship_instr_key_enabled = 'Y' THEN
              --Added for CR23505
              IF gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
               .g_sales_order_hdr_main_rec.shipping_instructions IS NULL THEN
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.shipping_instructions := 'Spectrum Order Number : ' ||
                                                                                                                                      c_sales_orders_loop.attribute19;
              ELSE
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.shipping_instructions := 'Spectrum Order Number : ' ||
                                                                                                                                      c_sales_orders_loop.attribute19 || '.' ||
                                                                                                                                      c_sales_orders_loop.shipping_instructions;
              END IF;
            END IF;
            date_convert(c_sales_orders_loop.ordered_date,
                         gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                         .g_sales_order_hdr_main_rec.ordered_date);
            --gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ordered_date := c_sales_orders_loop.ordered_date;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.pricelist := c_sales_orders_loop.pricelist;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.salesrep := c_sales_orders_loop.salesrep;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute_category := c_sales_orders_loop.attribute_category;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute1 := c_sales_orders_loop.attribute1;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute2 := c_sales_orders_loop.attribute2;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute3 := c_sales_orders_loop.attribute3;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute4 := c_sales_orders_loop.attribute4;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute5 := c_sales_orders_loop.attribute5;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute6 := c_sales_orders_loop.attribute6;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute7 := c_sales_orders_loop.attribute7;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute8 := c_sales_orders_loop.attribute8;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute9 := c_sales_orders_loop.attribute9;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute10 := c_sales_orders_loop.attribute10;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute11 := c_sales_orders_loop.attribute11;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute12 := c_sales_orders_loop.attribute12;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute13 := c_sales_orders_loop.attribute13;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute14 := c_sales_orders_loop.attribute14;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute15 := c_sales_orders_loop.attribute15;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute16 := c_sales_orders_loop.attribute16;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute17 := c_sales_orders_loop.attribute17;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute18 := c_sales_orders_loop.attribute18;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute19 := c_sales_orders_loop.attribute19;
            /*if nvl(l_partner_masking_enabled,'N') = 'Y' THEN
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute19 := c_sales_orders_loop.attribute19||to_char(nvl(gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.request_date,l_event_creation_date),'_MON-YYYY');
            else
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute19 := c_sales_orders_loop.attribute19;
            end if;
            log_debug('Attribute 19 : ' || gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
            .g_sales_order_hdr_main_rec.attribute19);
            */
            --IF gv_source_system = 'SPECTRUM_LA'
            IF g_ord_hdr_ref_key_enabled = 'Y' --Added for CR23505
               AND gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
              .g_sales_order_hdr_main_rec.attribute8 IS NULL THEN
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute8 := c_sales_orders_loop.attribute19;
            END IF;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute20 := c_sales_orders_loop.attribute20;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.order_type := c_sales_orders_loop.order_type;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.organization_name := c_sales_orders_loop.organization_name;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpcontext := c_sales_orders_loop.tpcontext;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute1 := c_sales_orders_loop.tpattribute1;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute2 := c_sales_orders_loop.tpattribute2;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute3 := c_sales_orders_loop.tpattribute3;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute4 := c_sales_orders_loop.tpattribute4;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute5 := c_sales_orders_loop.tpattribute5;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute6 := c_sales_orders_loop.tpattribute6;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute7 := c_sales_orders_loop.tpattribute7;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute8 := c_sales_orders_loop.tpattribute8;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute9 := c_sales_orders_loop.tpattribute9;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute10 := c_sales_orders_loop.tpattribute10;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute11 := c_sales_orders_loop.tpattribute11;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute12 := c_sales_orders_loop.tpattribute12;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute13 := c_sales_orders_loop.tpattribute13;
            gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.tpattribute14 := c_sales_orders_loop.tpattribute14;
            /*************************************************************************************/
            --  Sales Order Customer Info -- Sales Order Header Record Type
            /************************************************************************************/
            gv_poo := 'Adding Customer Data to Sales Order Group';
            log_debug(gv_poo);
            FOR c_so_cust_loop IN (SELECT rownum l_cust_cnt,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/CUSTOMER_NUMBER',
                                                       gv_namespace) AS customer_number,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/BILL_TO_CUSTOMER_ID',
                                                       gv_namespace) AS bill_to_customer_id,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_CUSTOMER_ID',
                                                       gv_namespace) AS ship_to_customer_id,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/BILL_TO_PARTY_SITE_ID',
                                                       gv_namespace) AS bill_to_party_site_id,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/PAYMENT_TERMS',
                                                       gv_namespace) AS payment_terms,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_PARTY_SITE_ID',
                                                       gv_namespace) AS ship_to_party_site_id,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE1',
                                                       gv_namespace) AS ship_to_adress_line1,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE2',
                                                       gv_namespace) AS ship_to_adress_line2,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE3',
                                                       gv_namespace) AS ship_to_adress_line3,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_LINE4',
                                                       gv_namespace) AS ship_to_adress_line4,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_CITY',
                                                       gv_namespace) AS ship_to_adress_city,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_STATE',
                                                       gv_namespace) AS ship_to_adress_state,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_POSTAL_CODE',
                                                       gv_namespace) AS ship_to_adress_postal_code,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_COUNTRY',
                                                       gv_namespace) AS ship_to_adress_country,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_ADDRESS_COUNTY',
                                                       gv_namespace) AS ship_to_adress_county,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/SHIP_TO_PARTY_SITE_NUMBER',
                                                       gv_namespace) AS ship_to_party_site_number,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/BILL_TO_PARTY_SITE_NUMBER',
                                                       gv_namespace) AS bill_to_party_site_number,
                                          extractvalue(tmp_l.column_value,
                                                       '/CUSTOMER_INFO/CUSTOMER_ID',
                                                       gv_namespace) AS customer_id
                                     FROM TABLE(xmlsequence(c_agr_loop.customer_info.extract('//CUSTOMER_INFO',
                                                                                             gv_namespace))) tmp_l) LOOP
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.customer_number := c_so_cust_loop.customer_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.bill_to_customer_id := c_so_cust_loop.bill_to_customer_id;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_customer_id := c_so_cust_loop.ship_to_customer_id;
              /*   gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.bill_to_address_id := c_so_cust_loop.bill_to_address_id;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_address_id := c_so_cust_loop.ship_to_address_id;
              */
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.bill_to_party_site_id := c_so_cust_loop.bill_to_party_site_id;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.payment_terms := c_so_cust_loop.payment_terms;
              --gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.inv_currency_code := c_so_cust_loop.inv_currency_code;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_party_site_id := c_so_cust_loop.ship_to_party_site_id;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_line1 := c_so_cust_loop.ship_to_adress_line1;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_line2 := c_so_cust_loop.ship_to_adress_line2;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_line3 := c_so_cust_loop.ship_to_adress_line3;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_line4 := c_so_cust_loop.ship_to_adress_line4;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_city := c_so_cust_loop.ship_to_adress_city;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_state := c_so_cust_loop.ship_to_adress_state;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_postal_code := c_so_cust_loop.ship_to_adress_postal_code;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_country := c_so_cust_loop.ship_to_adress_country;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_adress_county := c_so_cust_loop.ship_to_adress_county;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.ship_to_party_site_number := c_so_cust_loop.ship_to_party_site_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.bill_to_party_site_number := c_so_cust_loop.bill_to_party_site_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.customer_id := c_so_cust_loop.customer_id;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.customer_po_number := gv_agr_tbl(1)
                                                                                                                                 .agr_main_rec.customer_order_number;
              log_debug('Sales Order Customer  -> ' || gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                        .g_sales_order_hdr_main_rec.customer_number);
            END LOOP;
            /*************************************************************************************/
            --  Sales Order Header Additional Attributes Record Type
            /************************************************************************************/
            gv_poo := 'Parsing Additional Attribute Values - Header Level';
            log_debug(gv_poo);
            FOR c_ord_header_add_attr_loop IN (SELECT rownum l_add_attr_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_NAME',
                                                                   gv_namespace) AS attribute_name,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                                                   gv_namespace) AS attribute_value
                                                 FROM TABLE(xmlsequence(c_sales_orders_loop.g_additional_attrs.extract('//ADDITIONAL_ATTRIBUTE',
                                                                                                                       gv_namespace))) tmp_l
                                                WHERE trim(extractvalue(tmp_l.column_value,
                                                                        '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                                                        gv_namespace)) IS NOT NULL) LOOP
              IF trim(c_ord_header_add_attr_loop.attribute_value) IS NOT NULL THEN
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_add_attr_line_tbl_h(c_ord_header_add_attr_loop.l_add_attr_cnt).attribute_name := c_ord_header_add_attr_loop.attribute_name;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_add_attr_line_tbl_h(c_ord_header_add_attr_loop.l_add_attr_cnt).attribute_value := c_ord_header_add_attr_loop.attribute_value;
              END IF;
            END LOOP;
            /*************************************************************************************/
            --  Sales Order Header Pricing Attributes Record Type
            /************************************************************************************/
            gv_poo := 'Parsing Pricing Attribute Values - Header Level';
            log_debug(gv_poo);
            FOR c_ord_header_prc_attr_loop IN (SELECT rownum l_prc_attr_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/CONTEXT',
                                                                   gv_namespace) AS CONTEXT,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE1',
                                                                   gv_namespace) AS attribute1,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE2',
                                                                   gv_namespace) AS attribute2,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE3',
                                                                   gv_namespace) AS attribute3,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE4',
                                                                   gv_namespace) AS attribute4,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE5',
                                                                   gv_namespace) AS attribute5,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE6',
                                                                   gv_namespace) AS attribute6,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE7',
                                                                   gv_namespace) AS attribute7,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE8',
                                                                   gv_namespace) AS attribute8,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE9',
                                                                   gv_namespace) AS attribute9,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE10',
                                                                   gv_namespace) AS attribute10,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE11',
                                                                   gv_namespace) AS attribute11,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE12',
                                                                   gv_namespace) AS attribute12,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE13',
                                                                   gv_namespace) AS attribute13,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE14',
                                                                   gv_namespace) AS attribute14,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE15',
                                                                   gv_namespace) AS attribute15,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_CONTEXT',
                                                                   gv_namespace) AS pricing_context,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE1',
                                                                   gv_namespace) AS pricing_attribute1,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE2',
                                                                   gv_namespace) AS pricing_attribute2,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE3',
                                                                   gv_namespace) AS pricing_attribute3,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE4',
                                                                   gv_namespace) AS pricing_attribute4,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE5',
                                                                   gv_namespace) AS pricing_attribute5,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE6',
                                                                   gv_namespace) AS pricing_attribute6,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE7',
                                                                   gv_namespace) AS pricing_attribute7,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE8',
                                                                   gv_namespace) AS pricing_attribute8,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE9',
                                                                   gv_namespace) AS pricing_attribute9,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE10',
                                                                   gv_namespace) AS pricing_attribute10,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE11',
                                                                   gv_namespace) AS pricing_attribute11,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE12',
                                                                   gv_namespace) AS pricing_attribute12,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE13',
                                                                   gv_namespace) AS pricing_attribute13,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE14',
                                                                   gv_namespace) AS pricing_attribute14,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE15',
                                                                   gv_namespace) AS pricing_attribute15
                                                 FROM TABLE(xmlsequence(c_sales_orders_loop.g_pricing_attrs.extract('//PRICE_ATTR_LINES',
                                                                                                                    gv_namespace))) tmp_l) LOOP
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).CONTEXT := c_ord_header_prc_attr_loop.CONTEXT;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute1 := c_ord_header_prc_attr_loop.attribute1;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute2 := c_ord_header_prc_attr_loop.attribute2;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute3 := c_ord_header_prc_attr_loop.attribute3;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute4 := c_ord_header_prc_attr_loop.attribute4;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute5 := c_ord_header_prc_attr_loop.attribute5;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute6 := c_ord_header_prc_attr_loop.attribute6;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute7 := c_ord_header_prc_attr_loop.attribute7;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute8 := c_ord_header_prc_attr_loop.attribute8;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute9 := c_ord_header_prc_attr_loop.attribute9;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute10 := c_ord_header_prc_attr_loop.attribute10;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute11 := c_ord_header_prc_attr_loop.attribute11;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute12 := c_ord_header_prc_attr_loop.attribute12;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute13 := c_ord_header_prc_attr_loop.attribute13;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute14 := c_ord_header_prc_attr_loop.attribute14;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).attribute15 := c_ord_header_prc_attr_loop.attribute15;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_context := c_ord_header_prc_attr_loop.pricing_context;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute1 := c_ord_header_prc_attr_loop.pricing_attribute1;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute2 := c_ord_header_prc_attr_loop.pricing_attribute2;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute3 := c_ord_header_prc_attr_loop.pricing_attribute3;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute4 := c_ord_header_prc_attr_loop.pricing_attribute4;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute5 := c_ord_header_prc_attr_loop.pricing_attribute5;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute6 := c_ord_header_prc_attr_loop.pricing_attribute6;

              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute7 := c_ord_header_prc_attr_loop.pricing_attribute7;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute8 := c_ord_header_prc_attr_loop.pricing_attribute8;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute9 := c_ord_header_prc_attr_loop.pricing_attribute9;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute10 := c_ord_header_prc_attr_loop.pricing_attribute10;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute11 := c_ord_header_prc_attr_loop.pricing_attribute11;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute12 := c_ord_header_prc_attr_loop.pricing_attribute12;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute13 := c_ord_header_prc_attr_loop.pricing_attribute13;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute14 := c_ord_header_prc_attr_loop.pricing_attribute14;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_attr_line_tbl_h(c_ord_header_prc_attr_loop.l_prc_attr_cnt).pricing_attribute15 := c_ord_header_prc_attr_loop.pricing_attribute15;
            END LOOP;

            /*************************************************************************************/
            --  Sales Order Header Pricing Adjustment Record Type
            /************************************************************************************/
            gv_poo := 'Parsing Pricing Adjustment Values - Header Level';
            log_debug(gv_poo);
            --
            FOR c_ord_header_prc_adj_loop IN (SELECT rownum l_prc_adj_cnt,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ORIG_SYS_DISCOUNT_REF',
                                                                  gv_namespace) AS ORIG_SYS_DISCOUNT_REF,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_SEQUENCE',
                                                                  gv_namespace) AS CHANGE_SEQUENCE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_REQUEST_CODE',
                                                                  gv_namespace) AS CHANGE_REQUEST_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AUTOMATIC_FLAG',
                                                                  gv_namespace) AS AUTOMATIC_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CONTEXT',
                                                                  gv_namespace) AS CONTEXT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE1',
                                                                  gv_namespace) AS ATTRIBUTE1,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE2',
                                                                  gv_namespace) AS ATTRIBUTE2,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE3',
                                                                  gv_namespace) AS ATTRIBUTE3,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE4',
                                                                  gv_namespace) AS ATTRIBUTE4,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE5',
                                                                  gv_namespace) AS ATTRIBUTE5,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE6',
                                                                  gv_namespace) AS ATTRIBUTE6,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE7',
                                                                  gv_namespace) AS ATTRIBUTE7,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE8',
                                                                  gv_namespace) AS ATTRIBUTE8,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE9',
                                                                  gv_namespace) AS ATTRIBUTE9,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE10',
                                                                  gv_namespace) AS ATTRIBUTE10,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE11',
                                                                  gv_namespace) AS ATTRIBUTE11,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE12',
                                                                  gv_namespace) AS ATTRIBUTE12,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE13',
                                                                  gv_namespace) AS ATTRIBUTE13,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE14',
                                                                  gv_namespace) AS ATTRIBUTE14,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE15',
                                                                  gv_namespace) AS ATTRIBUTE15,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_HEADER_ID',
                                                                  gv_namespace) AS LIST_HEADER_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_NAME',
                                                                  gv_namespace) AS LIST_NAME,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_LINE_ID',
                                                                  gv_namespace) AS LIST_LINE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_LINE_TYPE_CODE',
                                                                  gv_namespace) AS LIST_LINE_TYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIER_MECHANISM_TYPE_CODE',
                                                                  gv_namespace) AS MODIFIER_MECHANISM_TYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIED_FROM',
                                                                  gv_namespace) AS MODIFIED_FROM,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIED_TO',
                                                                  gv_namespace) AS MODIFIED_TO,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/UPDATED_FLAG',
                                                                  gv_namespace) AS UPDATED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/UPDATE_ALLOWED',
                                                                  gv_namespace) AS UPDATE_ALLOWED,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/APPLIED_FLAG',
                                                                  gv_namespace) AS APPLIED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_REASON_CODE',
                                                                  gv_namespace) AS CHANGE_REASON_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_REASON_TEXT',
                                                                  gv_namespace) AS CHANGE_REASON_TEXT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/DISCOUNT_ID',
                                                                  gv_namespace) AS DISCOUNT_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/DISCOUNT_LINE_ID',
                                                                  gv_namespace) AS DISCOUNT_LINE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/DISCOUNT_NAME',
                                                                  gv_namespace) AS DISCOUNT_NAME,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PERCENT',
                                                                  gv_namespace) AS PERCENT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/OPERATION_CODE',
                                                                  gv_namespace) AS OPERATION_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/OPERAND',
                                                                  gv_namespace) AS OPERAND,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ARITHMETIC_OPERATOR',
                                                                  gv_namespace) AS ARITHMETIC_OPERATOR,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PRICING_PHASE_ID',
                                                                  gv_namespace) AS PRICING_PHASE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ADJUSTED_AMOUNT',
                                                                  gv_namespace) AS ADJUSTED_AMOUNT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIER_NAME',
                                                                  gv_namespace) AS MODIFIER_NAME,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_LINE_NUMBER',
                                                                  gv_namespace) AS LIST_LINE_NUMBER,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/VERSION_NUMBER',
                                                                  gv_namespace) AS VERSION_NUMBER,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INVOICED_FLAG',
                                                                  gv_namespace) AS INVOICED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ESTIMATED_FLAG',
                                                                  gv_namespace) AS ESTIMATED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INC_IN_SALES_PERFORMANCE',
                                                                  gv_namespace) AS INC_IN_SALES_PERFORMANCE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHARGE_TYPE_CODE',
                                                                  gv_namespace) AS CHARGE_TYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHARGE_SUBTYPE_CODE',
                                                                  gv_namespace) AS CHARGE_SUBTYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CREDIT_OR_CHARGE_FLAG',
                                                                  gv_namespace) AS CREDIT_OR_CHARGE_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INCLUDE_ON_RETURNS_FLAG',
                                                                  gv_namespace) AS INCLUDE_ON_RETURNS_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/COST_ID',
                                                                  gv_namespace) AS COST_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/TAX_CODE',
                                                                  gv_namespace) AS TAX_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PARENT_ADJUSTMENT_ID',
                                                                  gv_namespace) AS PARENT_ADJUSTMENT_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_CONTEXT',
                                                                  gv_namespace) AS AC_CONTEXT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE1',
                                                                  gv_namespace) AS AC_ATTRIBUTE1,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE2',
                                                                  gv_namespace) AS AC_ATTRIBUTE2,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE3',
                                                                  gv_namespace) AS AC_ATTRIBUTE3,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE4',
                                                                  gv_namespace) AS AC_ATTRIBUTE4,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE5',
                                                                  gv_namespace) AS AC_ATTRIBUTE5,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE6',
                                                                  gv_namespace) AS AC_ATTRIBUTE6,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE7',
                                                                  gv_namespace) AS AC_ATTRIBUTE7,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE8',
                                                                  gv_namespace) AS AC_ATTRIBUTE8,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE9',
                                                                  gv_namespace) AS AC_ATTRIBUTE9,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE10',
                                                                  gv_namespace) AS AC_ATTRIBUTE10,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE11',
                                                                  gv_namespace) AS AC_ATTRIBUTE11,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE12',
                                                                  gv_namespace) AS AC_ATTRIBUTE12,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE13',
                                                                  gv_namespace) AS AC_ATTRIBUTE13,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE14',
                                                                  gv_namespace) AS AC_ATTRIBUTE14,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE15',
                                                                  gv_namespace) AS AC_ATTRIBUTE15,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/OPERAND_PER_PQTY',
                                                                  gv_namespace) AS OPERAND_PER_PQTY,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ADJUSTED_AMOUNT_PER_PQTY',
                                                                  gv_namespace) AS ADJUSTED_AMOUNT_PER_PQTY,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PRICE_ADJUSTMENT_ID',
                                                                  gv_namespace) AS PRICE_ADJUSTMENT_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/TAX_RATE_ID',
                                                                  gv_namespace) AS TAX_RATE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ERROR_FLAG',
                                                                  gv_namespace) AS ERROR_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INTERFACE_STATUS',
                                                                  gv_namespace) AS INTERFACE_STATUS,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/STATUS_FLAG',
                                                                  gv_namespace) AS STATUS_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/SOLD_TO_ORG',
                                                                  gv_namespace) AS SOLD_TO_ORG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/SOLD_TO_ORG_ID',
                                                                  gv_namespace) AS SOLD_TO_ORG_ID
                                                FROM TABLE(xmlsequence(c_sales_orders_loop.g_price_adjs.extract('//PRICE_ADJ_LINE',
                                                                                                                gv_namespace))) tmp_l) LOOP
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ORIG_SYS_DISCOUNT_REF := c_ord_header_prc_adj_loop.ORIG_SYS_DISCOUNT_REF;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CHANGE_SEQUENCE := c_ord_header_prc_adj_loop.CHANGE_SEQUENCE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CHANGE_REQUEST_CODE := c_ord_header_prc_adj_loop.CHANGE_REQUEST_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AUTOMATIC_FLAG := c_ord_header_prc_adj_loop.AUTOMATIC_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CONTEXT := c_ord_header_prc_adj_loop.CONTEXT;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE1 := c_ord_header_prc_adj_loop.ATTRIBUTE1;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE2 := c_ord_header_prc_adj_loop.ATTRIBUTE2;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE3 := c_ord_header_prc_adj_loop.ATTRIBUTE3;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE4 := c_ord_header_prc_adj_loop.ATTRIBUTE4;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE5 := c_ord_header_prc_adj_loop.ATTRIBUTE5;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE6 := c_ord_header_prc_adj_loop.ATTRIBUTE6;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE7 := c_ord_header_prc_adj_loop.ATTRIBUTE7;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE8 := c_ord_header_prc_adj_loop.ATTRIBUTE8;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE9 := c_ord_header_prc_adj_loop.ATTRIBUTE9;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE10 := c_ord_header_prc_adj_loop.ATTRIBUTE10;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE11 := c_ord_header_prc_adj_loop.ATTRIBUTE11;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE12 := c_ord_header_prc_adj_loop.ATTRIBUTE12;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE13 := c_ord_header_prc_adj_loop.ATTRIBUTE13;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE14 := c_ord_header_prc_adj_loop.ATTRIBUTE14;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE15 := c_ord_header_prc_adj_loop.ATTRIBUTE15;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).LIST_HEADER_ID := c_ord_header_prc_adj_loop.LIST_HEADER_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).LIST_NAME := c_ord_header_prc_adj_loop.LIST_NAME;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).LIST_LINE_ID := c_ord_header_prc_adj_loop.LIST_LINE_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).LIST_LINE_TYPE_CODE := c_ord_header_prc_adj_loop.LIST_LINE_TYPE_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).MODIFIER_MECHANISM_TYPE_CODE := c_ord_header_prc_adj_loop.MODIFIER_MECHANISM_TYPE_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).MODIFIED_FROM := c_ord_header_prc_adj_loop.MODIFIED_FROM;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).MODIFIED_TO := c_ord_header_prc_adj_loop.MODIFIED_TO;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).UPDATED_FLAG := c_ord_header_prc_adj_loop.UPDATED_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).UPDATE_ALLOWED := c_ord_header_prc_adj_loop.UPDATE_ALLOWED;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).APPLIED_FLAG := c_ord_header_prc_adj_loop.APPLIED_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CHANGE_REASON_CODE := c_ord_header_prc_adj_loop.CHANGE_REASON_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CHANGE_REASON_TEXT := c_ord_header_prc_adj_loop.CHANGE_REASON_TEXT;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).DISCOUNT_ID := c_ord_header_prc_adj_loop.DISCOUNT_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).DISCOUNT_LINE_ID := c_ord_header_prc_adj_loop.DISCOUNT_LINE_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).DISCOUNT_NAME := c_ord_header_prc_adj_loop.DISCOUNT_NAME;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).PERCENT := c_ord_header_prc_adj_loop.PERCENT;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).OPERATION_CODE := c_ord_header_prc_adj_loop.OPERATION_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).OPERAND := c_ord_header_prc_adj_loop.OPERAND;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ARITHMETIC_OPERATOR := c_ord_header_prc_adj_loop.ARITHMETIC_OPERATOR;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).PRICING_PHASE_ID := c_ord_header_prc_adj_loop.PRICING_PHASE_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ADJUSTED_AMOUNT := c_ord_header_prc_adj_loop.ADJUSTED_AMOUNT;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).MODIFIER_NAME := c_ord_header_prc_adj_loop.MODIFIER_NAME;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).LIST_LINE_NUMBER := c_ord_header_prc_adj_loop.LIST_LINE_NUMBER;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).VERSION_NUMBER := c_ord_header_prc_adj_loop.VERSION_NUMBER;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).INVOICED_FLAG := c_ord_header_prc_adj_loop.INVOICED_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ESTIMATED_FLAG := c_ord_header_prc_adj_loop.ESTIMATED_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).INC_IN_SALES_PERFORMANCE := c_ord_header_prc_adj_loop.INC_IN_SALES_PERFORMANCE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CHARGE_TYPE_CODE := c_ord_header_prc_adj_loop.CHARGE_TYPE_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CHARGE_SUBTYPE_CODE := c_ord_header_prc_adj_loop.CHARGE_SUBTYPE_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).CREDIT_OR_CHARGE_FLAG := c_ord_header_prc_adj_loop.CREDIT_OR_CHARGE_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).INCLUDE_ON_RETURNS_FLAG := c_ord_header_prc_adj_loop.INCLUDE_ON_RETURNS_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).COST_ID := c_ord_header_prc_adj_loop.COST_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).TAX_CODE := c_ord_header_prc_adj_loop.TAX_CODE;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).PARENT_ADJUSTMENT_ID := c_ord_header_prc_adj_loop.PARENT_ADJUSTMENT_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_CONTEXT := c_ord_header_prc_adj_loop.AC_CONTEXT;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE1 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE1;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE2 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE2;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE3 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE3;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE4 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE4;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE5 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE5;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE6 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE6;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE7 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE7;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE8 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE8;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE9 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE9;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE10 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE10;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE11 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE11;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE12 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE12;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE13 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE13;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE14 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE14;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE15 := c_ord_header_prc_adj_loop.AC_ATTRIBUTE15;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).OPERAND_PER_PQTY := c_ord_header_prc_adj_loop.OPERAND_PER_PQTY;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ADJUSTED_AMOUNT_PER_PQTY := c_ord_header_prc_adj_loop.ADJUSTED_AMOUNT_PER_PQTY;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).PRICE_ADJUSTMENT_ID := c_ord_header_prc_adj_loop.PRICE_ADJUSTMENT_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).TAX_RATE_ID := c_ord_header_prc_adj_loop.TAX_RATE_ID;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).ERROR_FLAG := c_ord_header_prc_adj_loop.ERROR_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).INTERFACE_STATUS := c_ord_header_prc_adj_loop.INTERFACE_STATUS;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).STATUS_FLAG := c_ord_header_prc_adj_loop.STATUS_FLAG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).SOLD_TO_ORG := c_ord_header_prc_adj_loop.SOLD_TO_ORG;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_prc_adj_rec_tbl_h(c_ord_header_prc_adj_loop.l_prc_adj_cnt).SOLD_TO_ORG_ID := c_ord_header_prc_adj_loop.SOLD_TO_ORG_ID;
            END LOOP;
            /*************************************************************************************/
            --  Sales Order Header Dynamic SRC Attributes Record Type
            /************************************************************************************/
            gv_poo := 'Parsing SRC Attributes - Header Level';
            log_debug(gv_poo);
            --
            FOR c_ord_header_src_attr_loop IN (SELECT rownum l_src_attr_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/SRC_ATTRIBUTE/NAME',
                                                                   gv_namespace) AS NAME,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/SRC_ATTRIBUTE/VALUE',
                                                                   gv_namespace) AS VALUE
                                                 FROM TABLE(xmlsequence(c_sales_orders_loop.g_src_attributes.extract('//SRC_ATTRIBUTE',
                                                                                                                     gv_namespace))) tmp_l) LOOP
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_src_attributes_tbl_h(c_ord_header_src_attr_loop.l_src_attr_cnt).NAME := c_ord_header_src_attr_loop.NAME;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_src_attributes_tbl_h(c_ord_header_src_attr_loop.l_src_attr_cnt).VALUE := c_ord_header_src_attr_loop.VALUE;
              if c_ord_header_src_attr_loop.NAME = 'COLLECT_ACCOUNT_NUMBER' THEN
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.packingInstructions:= c_ord_header_src_attr_loop.VALUE;
              END IF;
            END LOOP;
            gv_poo := 'Parsing Order Attachments - Header Level';
            log_debug(gv_poo);
            /*************************************************************************************/
            --  Sales Order Header Attachments Record Type
            /************************************************************************************/
            FOR c_ord_header_attach_loop IN (SELECT rownum l_attach_cnt,
                                                    extractvalue(tmp_l.column_value,
                                                                 '/ORDER_ATTACHMENTS/LINE_NUMBER',
                                                                 gv_namespace) AS line_number,
                                                    extractvalue(tmp_l.column_value,
                                                                 '/ORDER_ATTACHMENTS/ATTACHMENT_TYPE',
                                                                 gv_namespace) AS attachment_type,
                                                    extractvalue(tmp_l.column_value,
                                                                 '/ORDER_ATTACHMENTS/SHORT_TEXT',
                                                                 gv_namespace) AS short_text
                                               FROM TABLE(xmlsequence(c_sales_orders_loop.g_order_attachments.extract('//ORDER_ATTACHMENTS',
                                                                                                                      gv_namespace))) tmp_l) LOOP
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_attachment_tbl_h(c_ord_header_attach_loop.l_attach_cnt).line_number := c_ord_header_attach_loop.line_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_attachment_tbl_h(c_ord_header_attach_loop.l_attach_cnt).attachment_type := c_ord_header_attach_loop.attachment_type;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_order_attachment_tbl_h(c_ord_header_attach_loop.l_attach_cnt).short_text := c_ord_header_attach_loop.short_text;
            END LOOP;
            /* Start of Added for HPQC21314 */
            /*************************************************************************************/
            --  Sales Credit Record Type
            /************************************************************************************/
            gv_poo := 'Parsing Sales Credit';
            log_debug(gv_poo);
            FOR c_sales_credit_loop IN (SELECT rownum l_sales_credit_count,
                                               extractvalue(tmp_l.column_value,
                                                            '/SALES_COMMISSION/CREDIT_PERCENTAGE',
                                                            gv_namespace) AS credit_percentage,
                                               extractvalue(tmp_l.column_value,
                                                            '/SALES_COMMISSION/EMPLOYEE_NUMBER',
                                                            gv_namespace) AS employee_number,
                                               extractvalue(tmp_l.column_value,
                                                            '/SALES_COMMISSION/CREDIT_TYPE_CODE',
                                                            gv_namespace) AS credit_type_code,
                                               extractvalue(tmp_l.column_value,
                                                            '/SALES_COMMISSION/START_DATE_ACTIVE',
                                                            gv_namespace) AS start_date_active,
                                               extractvalue(tmp_l.column_value,
                                                            '/SALES_COMMISSION/EBS_USER_NAME',
                                                            gv_namespace) AS ebs_user_name
                                          FROM TABLE(xmlsequence(c_agr_loop.g_sales_commission.extract('//SALES_COMMISSION',
                                                                                                       gv_namespace))) tmp_l) LOOP
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_credit_hdr_tbl(c_sales_credit_loop.l_sales_credit_count).percent := c_sales_credit_loop.credit_percentage;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_credit_hdr_tbl(c_sales_credit_loop.l_sales_credit_count).EMPLOYEE_NUMBER := c_sales_credit_loop.EMPLOYEE_NUMBER;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_credit_hdr_tbl(c_sales_credit_loop.l_sales_credit_count).salesCreditType := c_sales_credit_loop.credit_type_code;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_credit_hdr_tbl(c_sales_credit_loop.l_sales_credit_count).EBS_USER_NAME := c_sales_credit_loop.EBS_USER_NAME;
            END LOOP;
            /* End of Start of Added for HPQC21314 */
            /*************************************************************************************/
            --  Sales Order Line Record Type
            /************************************************************************************/
            gv_poo := 'Parsing Sales Order Line';
            log_debug(gv_poo);

            FOR c_sales_order_line_loop IN (SELECT rownum l_order_line_cnt,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/LINE_NUMBER',
                                                                gv_namespace) AS line_number,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/INVENTORY_ITEM',
                                                                gv_namespace) AS inventory_item,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ORDERED_QUANTITY',
                                                                gv_namespace) AS ordered_quantity,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ORDERED_QUANTITY_UOM',
                                                                gv_namespace) AS ordered_quantity_uom,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/SHIP_FROM_ORG_ID',
                                                                gv_namespace) AS ship_from_org_id,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/FOB',
                                                                gv_namespace) AS fob,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/SHIPMENT_PRIORITY',
                                                                gv_namespace) AS shipment_priority,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/REQUEST_DATE',
                                                                gv_namespace) AS request_date,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/PROJECT_NUMBER',
                                                                gv_namespace) AS project_number,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/TASK_NUMBER',
                                                                gv_namespace) AS task_number,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE_CATEGORY',
                                                                gv_namespace) AS attribute_category,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE1',
                                                                gv_namespace) AS attribute1,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE2',
                                                                gv_namespace) AS attribute2,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE3',
                                                                gv_namespace) AS attribute3,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE4',
                                                                gv_namespace) AS attribute4,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE5',
                                                                gv_namespace) AS attribute5,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE6',
                                                                gv_namespace) AS attribute6,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE7',
                                                                gv_namespace) AS attribute7,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE8',
                                                                gv_namespace) AS attribute8,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE9',
                                                                gv_namespace) AS attribute9,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE10',
                                                                gv_namespace) AS attribute10,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE11',
                                                                gv_namespace) AS attribute11,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE12',
                                                                gv_namespace) AS attribute12,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE13',
                                                                gv_namespace) AS attribute13,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE14',
                                                                gv_namespace) AS attribute14,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE15',
                                                                gv_namespace) AS attribute15,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE16',
                                                                gv_namespace) AS attribute16,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE17',
                                                                gv_namespace) AS attribute17,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE18',
                                                                gv_namespace) AS attribute18,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE19',
                                                                gv_namespace) AS attribute19,
                                                   extractvalue(tmp_l.column_value,
                                                                '/ORDER_LINE/ATTRIBUTE20',
                                                                gv_namespace) AS attribute20,
                                                   extract(tmp_l.column_value,
                                                           '/ORDER_LINE/G_ADDITIONAL_ATTRS',
                                                           gv_namespace) AS g_additional_attrs_line,
                                                   extract(tmp_l.column_value,
                                                           '/ORDER_LINE/G_PRICING_ATTRS',
                                                           gv_namespace) AS g_pricing_attrs_line,
                                                   extract(tmp_l.column_value,
                                                           '/ORDER_LINE/G_PRICE_ADJS',
                                                           gv_namespace) AS g_price_adjs,
                                                   extract(tmp_l.column_value,
                                                           '/ORDER_LINE/G_SRC_ATTRIBUTES',
                                                           gv_namespace) AS g_src_attributes_line,
                                                   extract(tmp_l.column_value,
                                                           '/ORDER_LINE/G_ORDER_ATTACHMENTS',
                                                           gv_namespace) AS g_order_attachments_line
                                              FROM TABLE(xmlsequence(c_sales_orders_loop.g_order_line.extract('//ORDER_LINE',
                                                                                                              gv_namespace))) tmp_l) LOOP
              l_project_number := null;
              l_task_number := null;
              l_item_number := NULL;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.line_number := c_sales_order_line_loop.line_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.inventory_item := c_sales_order_line_loop.inventory_item;
              l_item_number := c_sales_order_line_loop.inventory_item;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.ordered_quantity := c_sales_order_line_loop.ordered_quantity;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.ordered_quantity_uom := c_sales_order_line_loop.ordered_quantity_uom;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.ship_from_org_id := c_sales_order_line_loop.ship_from_org_id;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.fob := c_sales_order_line_loop.fob;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.shipment_priority := c_sales_order_line_loop.shipment_priority;
              date_convert(c_sales_order_line_loop.request_date,
                           gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt)
                           .g_sales_order_line_main_rec.request_date);
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.project_number := c_sales_order_line_loop.project_number;
              l_project_number := c_sales_order_line_loop.project_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.task_number := c_sales_order_line_loop.task_number;
              l_task_number := c_sales_order_line_loop.task_number;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute_category := c_sales_order_line_loop.attribute_category;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute1 := c_sales_order_line_loop.attribute1;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute2 := c_sales_order_line_loop.attribute2;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute3 := c_sales_order_line_loop.attribute3;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute4 := c_sales_order_line_loop.attribute4;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute5 := c_sales_order_line_loop.attribute5;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute6 := c_sales_order_line_loop.attribute6;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute7 := c_sales_order_line_loop.attribute7;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute8 := c_sales_order_line_loop.attribute8;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute9 := c_sales_order_line_loop.attribute9;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute10 := c_sales_order_line_loop.attribute10;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute11 := c_sales_order_line_loop.attribute11;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute12 := c_sales_order_line_loop.attribute12;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute13 := c_sales_order_line_loop.attribute13;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute14 := c_sales_order_line_loop.attribute14;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute15 := c_sales_order_line_loop.attribute15;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute16 := c_sales_order_line_loop.attribute16;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute17 := c_sales_order_line_loop.attribute17;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute18 := c_sales_order_line_loop.attribute18;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute19 := c_sales_order_line_loop.attribute19;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_sales_order_line_main_rec.attribute20 := c_sales_order_line_loop.attribute20;
              /*************************************************************************************/
              --  Sales Order Line - Additional Attributes Record Type
              /************************************************************************************/
              gv_poo := 'Parsing Sales Order Line Additional DFF Values';
              log_debug(gv_poo);
              l_line_tag_part_link_count := 0;
              SELECT COUNT(DISTINCT extractvalue(tmp_l.column_value,
                                        '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                        gv_namespace))
                INTO l_line_tag_part_link_count
                FROM TABLE(xmlsequence(c_sales_order_line_loop.g_additional_attrs_line.extract('//ADDITIONAL_ATTRIBUTE',
                                                                                               gv_namespace))) tmp_l
               WHERE trim(extractvalue(tmp_l.column_value,
                                       '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                       gv_namespace)) IS NOT NULL
                 AND upper(NVL(trim(extractvalue(tmp_l.column_value,
                                                 '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_TYPE',
                                                 gv_namespace)),
                               'X')) = 'LINETAGS'
                 AND upper(NVL(trim(extractvalue(tmp_l.column_value,
                                                 '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_NAME',
                                                 gv_namespace)),
                               'X')) = 'PARTNER_LINE_TAG_LINK';
              IF l_line_tag_part_link_count = 0 OR
                 l_line_tag_part_link_count = gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt)
                .g_sales_order_line_main_rec.ordered_quantity THEN
                gv_line_tag_valid := 'Y';
              ELSE
                gv_line_tag_valid := 'N';
                log_error('Line Tagging Partner Line tag Link is not unique or invalid. Order Line Quantity : ' || gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt)
                          .g_sales_order_line_main_rec.ordered_quantity ||
                          '. Unique Partner Line Tag Link Count : ' ||
                          l_line_tag_part_link_count);
              END IF;
              log_debug('Group Tagging Count : ' ||
                        l_line_tag_part_link_count);
              l_line_tag_grp_count := 0;
              SELECT COUNT(DISTINCT extractvalue(tmp_l.column_value,
                                        '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_GROUP',
                                        NULL))
                INTO l_line_tag_grp_count
                FROM TABLE(xmlsequence(c_sales_order_line_loop.g_additional_attrs_line.extract('//ADDITIONAL_ATTRIBUTE',
                                                                                               gv_namespace))) tmp_l
               WHERE trim(extractvalue(tmp_l.column_value,
                                       '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                       gv_namespace)) IS NOT NULL
                 AND upper(NVL(trim(extractvalue(tmp_l.column_value,
                                                 '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_TYPE',
                                                 gv_namespace)),
                               'X')) = 'LINETAGS';
              log_debug('Group Tagging Count : ' || l_line_tag_grp_count);
              IF l_line_tag_grp_count = 0 OR
                 l_line_tag_grp_count = gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt)
                .g_sales_order_line_main_rec.ordered_quantity THEN
                gv_line_tag_valid := 'Y';
              ELSE
                gv_line_tag_valid := 'N';
                log_error('Line Tagging Group is not unique or invalid. Order Line Quantity : ' || gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt)
                          .g_sales_order_line_main_rec.ordered_quantity ||
                          '. Unique Group Count : ' ||
                          l_line_tag_grp_count);
              END IF;
              l_ord_line_add_attr_count := 0;
              l_ilc_name_updated        := 'N';
              FOR c_ord_line_add_attr_loop IN (SELECT rownum l_add_attr_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_TYPE',
                                                                   gv_namespace) AS attribute_type,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_GROUP',
                                                                   gv_namespace) AS attribute_group,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_NAME',
                                                                   gv_namespace) AS attribute_name,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                                                   gv_namespace) AS attribute_value
                                                 FROM TABLE(xmlsequence(c_sales_order_line_loop.g_additional_attrs_line.extract('//ADDITIONAL_ATTRIBUTE',
                                                                                                                                gv_namespace))) tmp_l
                                                WHERE trim(extractvalue(tmp_l.column_value,
                                                                        '/ADDITIONAL_ATTRIBUTE/ATTRIBUTE_VALUE',
                                                                        gv_namespace)) IS NOT NULL) LOOP
                l_ord_line_add_attr_count := c_ord_line_add_attr_loop.l_add_attr_cnt; --ATTRIBUTE12
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(c_ord_line_add_attr_loop.l_add_attr_cnt).attribute_type := c_ord_line_add_attr_loop.attribute_type;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(c_ord_line_add_attr_loop.l_add_attr_cnt).attribute_group := c_ord_line_add_attr_loop.attribute_group;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(c_ord_line_add_attr_loop.l_add_attr_cnt).attribute_name := c_ord_line_add_attr_loop.attribute_name;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(c_ord_line_add_attr_loop.l_add_attr_cnt).attribute_value := c_ord_line_add_attr_loop.attribute_value;
                IF c_ord_line_add_attr_loop.attribute_name =
                   'GLOBAL_ATTRIBUTE15' AND
                  --gv_source_system = 'SPECTRUM_LA' AND
                   g_ord_unique_key_enabled = 'Y' AND --Added for CR23505
                   l_ilc_name_updated = 'N' AND gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(c_ord_line_add_attr_loop.l_add_attr_cnt)
                  .attribute_value IS NOT NULL THEN
                  l_ilc_name_updated := 'Y';
                  gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute19 := c_sales_orders_loop.attribute19 ||
                                                                                                                              ' | ' || gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(c_ord_line_add_attr_loop.l_add_attr_cnt)
                                                                                                                             .attribute_value ||
                                                                                                                              ' | ' ||
                                                                                                                              TO_CHAR(NVL(gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                                                                                                                                          .g_sales_order_hdr_main_rec.request_date,
                                                                                                                                          l_event_creation_date),
                                                                                                                                      'MON-YYYY');
                END IF;
              END LOOP;
              --Add order Ref Number to Additional Attributes
              --The following code is commented by Joydeb as per HPQC#24280
              /*gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(l_ord_line_add_attr_count + 1).attribute_type := NULL;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(l_ord_line_add_attr_count + 1).attribute_group := NULL;
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(l_ord_line_add_attr_count + 1).attribute_name := 'ATTRIBUTE12';
              gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_add_attr_line_tbl_l(l_ord_line_add_attr_count + 1).attribute_value := c_sales_orders_loop.attribute19;*/
              IF l_ilc_name_updated = 'N' AND
                --gv_source_system = 'SPECTRUM_LA' THEN
                 g_ord_unique_key_enabled = 'Y' THEN
                -- Added for CR23505
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_hdr_main_rec.attribute19 := c_sales_orders_loop.attribute19 ||
                                                                                                                            ' | UNDEFINED | ' ||
                                                                                                                            TO_CHAR(NVL(gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt)
                                                                                                                                        .g_sales_order_hdr_main_rec.request_date,
                                                                                                                                        l_event_creation_date),
                                                                                                                                    'MON-YYYY');
              END IF;
              /*************************************************************************************/
              --  Sales Order Line Pricing Attributes Record Type
              /************************************************************************************/
              gv_poo := 'Parsing Pricing Attribute Values - Line Level';
              log_debug(gv_poo);
              FOR c_ord_line_prc_attr_loop IN (SELECT rownum l_prc_attr_line_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/CONTEXT',
                                                                   gv_namespace) AS CONTEXT,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE1',
                                                                   gv_namespace) AS attribute1,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE2',
                                                                   gv_namespace) AS attribute2,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE3',
                                                                   gv_namespace) AS attribute3,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE4',
                                                                   gv_namespace) AS attribute4,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE5',
                                                                   gv_namespace) AS attribute5,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE6',
                                                                   gv_namespace) AS attribute6,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE7',
                                                                   gv_namespace) AS attribute7,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE8',
                                                                   gv_namespace) AS attribute8,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE9',
                                                                   gv_namespace) AS attribute9,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE10',
                                                                   gv_namespace) AS attribute10,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE11',
                                                                   gv_namespace) AS attribute11,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE12',
                                                                   gv_namespace) AS attribute12,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE13',
                                                                   gv_namespace) AS attribute13,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE14',
                                                                   gv_namespace) AS attribute14,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/ATTRIBUTE15',
                                                                   gv_namespace) AS attribute15,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_CONTEXT',
                                                                   gv_namespace) AS pricing_context,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE1',
                                                                   gv_namespace) AS pricing_attribute1,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE2',
                                                                   gv_namespace) AS pricing_attribute2,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE3',
                                                                   gv_namespace) AS pricing_attribute3,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE4',
                                                                   gv_namespace) AS pricing_attribute4,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE5',
                                                                   gv_namespace) AS pricing_attribute5,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE6',
                                                                   gv_namespace) AS pricing_attribute6,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE7',
                                                                   gv_namespace) AS pricing_attribute7,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE8',
                                                                   gv_namespace) AS pricing_attribute8,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE9',
                                                                   gv_namespace) AS pricing_attribute9,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE10',
                                                                   gv_namespace) AS pricing_attribute10,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE11',
                                                                   gv_namespace) AS pricing_attribute11,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE12',
                                                                   gv_namespace) AS pricing_attribute12,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE13',
                                                                   gv_namespace) AS pricing_attribute13,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE14',
                                                                   gv_namespace) AS pricing_attribute14,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/PRICE_ATTR_LINES/PRICING_ATTRIBUTE15',
                                                                   gv_namespace) AS pricing_attribute15
                                                 FROM TABLE(xmlsequence(c_sales_order_line_loop.g_pricing_attrs_line.extract('//PRICE_ATTR_LINES',
                                                                                                                             gv_namespace))) tmp_l) LOOP
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).CONTEXT := c_ord_line_prc_attr_loop.CONTEXT;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute1 := c_ord_line_prc_attr_loop.attribute1;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute2 := c_ord_line_prc_attr_loop.attribute2;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute3 := c_ord_line_prc_attr_loop.attribute3;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute4 := c_ord_line_prc_attr_loop.attribute4;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute5 := c_ord_line_prc_attr_loop.attribute5;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute6 := c_ord_line_prc_attr_loop.attribute6;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute7 := c_ord_line_prc_attr_loop.attribute7;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute8 := c_ord_line_prc_attr_loop.attribute8;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute9 := c_ord_line_prc_attr_loop.attribute9;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute10 := c_ord_line_prc_attr_loop.attribute10;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute11 := c_ord_line_prc_attr_loop.attribute11;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute12 := c_ord_line_prc_attr_loop.attribute12;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute13 := c_ord_line_prc_attr_loop.attribute13;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute14 := c_ord_line_prc_attr_loop.attribute14;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).attribute15 := c_ord_line_prc_attr_loop.attribute15;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_context := c_ord_line_prc_attr_loop.pricing_context;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute1 := c_ord_line_prc_attr_loop.pricing_attribute1;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute2 := c_ord_line_prc_attr_loop.pricing_attribute2;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute3 := c_ord_line_prc_attr_loop.pricing_attribute3;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute4 := c_ord_line_prc_attr_loop.pricing_attribute4;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute5 := c_ord_line_prc_attr_loop.pricing_attribute5;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute6 := c_ord_line_prc_attr_loop.pricing_attribute6;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute7 := c_ord_line_prc_attr_loop.pricing_attribute7;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute8 := c_ord_line_prc_attr_loop.pricing_attribute8;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute9 := c_ord_line_prc_attr_loop.pricing_attribute9;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute10 := c_ord_line_prc_attr_loop.pricing_attribute10;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute11 := c_ord_line_prc_attr_loop.pricing_attribute11;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute12 := c_ord_line_prc_attr_loop.pricing_attribute12;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute13 := c_ord_line_prc_attr_loop.pricing_attribute13;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute14 := c_ord_line_prc_attr_loop.pricing_attribute14;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_attr_line_tbl_l(c_ord_line_prc_attr_loop.l_prc_attr_line_cnt).pricing_attribute15 := c_ord_line_prc_attr_loop.pricing_attribute15;
                --                if c_ord_line_prc_attr_loop.pricing_attribute6 is not null then
              --                  gv_sales_percent := c_ord_line_prc_attr_loop.pricing_attribute6;
              --                end if;
              --                l_selling_level := c_ord_line_prc_attr_loop.pricing_attribute6;
              --                l_pricing_group := c_ord_line_prc_attr_loop.pricing_attribute4;
              END LOOP;
              /*************************************************************************************/
              --  Sales Order Line Pricing Adjustment Record Type
              /************************************************************************************/
              gv_poo := 'Parsing Pricing Adjustment Values - Line Level';
              log_debug(gv_poo);
              FOR c_ord_line_prc_adj_loop IN (SELECT rownum l_prc_adj_cnt,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ORIG_SYS_DISCOUNT_REF',
                                                                  gv_namespace) AS ORIG_SYS_DISCOUNT_REF,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_SEQUENCE',
                                                                  gv_namespace) AS CHANGE_SEQUENCE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_REQUEST_CODE',
                                                                  gv_namespace) AS CHANGE_REQUEST_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AUTOMATIC_FLAG',
                                                                  gv_namespace) AS AUTOMATIC_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CONTEXT',
                                                                  gv_namespace) AS CONTEXT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE1',
                                                                  gv_namespace) AS ATTRIBUTE1,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE2',
                                                                  gv_namespace) AS ATTRIBUTE2,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE3',
                                                                  gv_namespace) AS ATTRIBUTE3,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE4',
                                                                  gv_namespace) AS ATTRIBUTE4,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE5',
                                                                  gv_namespace) AS ATTRIBUTE5,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE6',
                                                                  gv_namespace) AS ATTRIBUTE6,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE7',
                                                                  gv_namespace) AS ATTRIBUTE7,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE8',
                                                                  gv_namespace) AS ATTRIBUTE8,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE9',
                                                                  gv_namespace) AS ATTRIBUTE9,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE10',
                                                                  gv_namespace) AS ATTRIBUTE10,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE11',
                                                                  gv_namespace) AS ATTRIBUTE11,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE12',
                                                                  gv_namespace) AS ATTRIBUTE12,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE13',
                                                                  gv_namespace) AS ATTRIBUTE13,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE14',
                                                                  gv_namespace) AS ATTRIBUTE14,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ATTRIBUTE15',
                                                                  gv_namespace) AS ATTRIBUTE15,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_HEADER_ID',
                                                                  gv_namespace) AS LIST_HEADER_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_NAME',
                                                                  gv_namespace) AS LIST_NAME,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_LINE_ID',
                                                                  gv_namespace) AS LIST_LINE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_LINE_TYPE_CODE',
                                                                  gv_namespace) AS LIST_LINE_TYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIER_MECHANISM_TYPE_CODE',
                                                                  gv_namespace) AS MODIFIER_MECHANISM_TYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIED_FROM',
                                                                  gv_namespace) AS MODIFIED_FROM,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIED_TO',
                                                                  gv_namespace) AS MODIFIED_TO,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/UPDATED_FLAG',
                                                                  gv_namespace) AS UPDATED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/UPDATE_ALLOWED',
                                                                  gv_namespace) AS UPDATE_ALLOWED,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/APPLIED_FLAG',
                                                                  gv_namespace) AS APPLIED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_REASON_CODE',
                                                                  gv_namespace) AS CHANGE_REASON_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHANGE_REASON_TEXT',
                                                                  gv_namespace) AS CHANGE_REASON_TEXT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/DISCOUNT_ID',
                                                                  gv_namespace) AS DISCOUNT_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/DISCOUNT_LINE_ID',
                                                                  gv_namespace) AS DISCOUNT_LINE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/DISCOUNT_NAME',
                                                                  gv_namespace) AS DISCOUNT_NAME,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PERCENT',
                                                                  gv_namespace) AS PERCENT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/OPERATION_CODE',
                                                                  gv_namespace) AS OPERATION_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/OPERAND',
                                                                  gv_namespace) AS OPERAND,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ARITHMETIC_OPERATOR',
                                                                  gv_namespace) AS ARITHMETIC_OPERATOR,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PRICING_PHASE_ID',
                                                                  gv_namespace) AS PRICING_PHASE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ADJUSTED_AMOUNT',
                                                                  gv_namespace) AS ADJUSTED_AMOUNT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/MODIFIER_NAME',
                                                                  gv_namespace) AS MODIFIER_NAME,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/LIST_LINE_NUMBER',
                                                                  gv_namespace) AS LIST_LINE_NUMBER,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/VERSION_NUMBER',
                                                                  gv_namespace) AS VERSION_NUMBER,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INVOICED_FLAG',
                                                                  gv_namespace) AS INVOICED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ESTIMATED_FLAG',
                                                                  gv_namespace) AS ESTIMATED_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INC_IN_SALES_PERFORMANCE',
                                                                  gv_namespace) AS INC_IN_SALES_PERFORMANCE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHARGE_TYPE_CODE',
                                                                  gv_namespace) AS CHARGE_TYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CHARGE_SUBTYPE_CODE',
                                                                  gv_namespace) AS CHARGE_SUBTYPE_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/CREDIT_OR_CHARGE_FLAG',
                                                                  gv_namespace) AS CREDIT_OR_CHARGE_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INCLUDE_ON_RETURNS_FLAG',
                                                                  gv_namespace) AS INCLUDE_ON_RETURNS_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/COST_ID',
                                                                  gv_namespace) AS COST_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/TAX_CODE',
                                                                  gv_namespace) AS TAX_CODE,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PARENT_ADJUSTMENT_ID',
                                                                  gv_namespace) AS PARENT_ADJUSTMENT_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_CONTEXT',
                                                                  gv_namespace) AS AC_CONTEXT,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE1',
                                                                  gv_namespace) AS AC_ATTRIBUTE1,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE2',
                                                                  gv_namespace) AS AC_ATTRIBUTE2,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE3',
                                                                  gv_namespace) AS AC_ATTRIBUTE3,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE4',
                                                                  gv_namespace) AS AC_ATTRIBUTE4,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE5',
                                                                  gv_namespace) AS AC_ATTRIBUTE5,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE6',
                                                                  gv_namespace) AS AC_ATTRIBUTE6,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE7',
                                                                  gv_namespace) AS AC_ATTRIBUTE7,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE8',
                                                                  gv_namespace) AS AC_ATTRIBUTE8,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE9',
                                                                  gv_namespace) AS AC_ATTRIBUTE9,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE10',
                                                                  gv_namespace) AS AC_ATTRIBUTE10,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE11',
                                                                  gv_namespace) AS AC_ATTRIBUTE11,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE12',
                                                                  gv_namespace) AS AC_ATTRIBUTE12,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE13',
                                                                  gv_namespace) AS AC_ATTRIBUTE13,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE14',
                                                                  gv_namespace) AS AC_ATTRIBUTE14,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/AC_ATTRIBUTE15',
                                                                  gv_namespace) AS AC_ATTRIBUTE15,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/OPERAND_PER_PQTY',
                                                                  gv_namespace) AS OPERAND_PER_PQTY,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ADJUSTED_AMOUNT_PER_PQTY',
                                                                  gv_namespace) AS ADJUSTED_AMOUNT_PER_PQTY,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/PRICE_ADJUSTMENT_ID',
                                                                  gv_namespace) AS PRICE_ADJUSTMENT_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/TAX_RATE_ID',
                                                                  gv_namespace) AS TAX_RATE_ID,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/ERROR_FLAG',
                                                                  gv_namespace) AS ERROR_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/INTERFACE_STATUS',
                                                                  gv_namespace) AS INTERFACE_STATUS,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/STATUS_FLAG',
                                                                  gv_namespace) AS STATUS_FLAG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/SOLD_TO_ORG',
                                                                  gv_namespace) AS SOLD_TO_ORG,
                                                     extractvalue(tmp_l.column_value,
                                                                  '/PRICE_ADJ_LINE/SOLD_TO_ORG_ID',
                                                                  gv_namespace) AS SOLD_TO_ORG_ID
                                                FROM TABLE(xmlsequence(c_sales_order_line_loop.g_price_adjs.extract('//PRICE_ADJ_LINE',
                                                                                                                    gv_namespace))) tmp_l) LOOP
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ORIG_SYS_DISCOUNT_REF := c_ord_line_prc_adj_loop.ORIG_SYS_DISCOUNT_REF;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CHANGE_SEQUENCE := c_ord_line_prc_adj_loop.CHANGE_SEQUENCE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CHANGE_REQUEST_CODE := c_ord_line_prc_adj_loop.CHANGE_REQUEST_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AUTOMATIC_FLAG := c_ord_line_prc_adj_loop.AUTOMATIC_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CONTEXT := c_ord_line_prc_adj_loop.CONTEXT;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE1 := c_ord_line_prc_adj_loop.ATTRIBUTE1;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE2 := c_ord_line_prc_adj_loop.ATTRIBUTE2;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE3 := c_ord_line_prc_adj_loop.ATTRIBUTE3;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE4 := c_ord_line_prc_adj_loop.ATTRIBUTE4;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE5 := c_ord_line_prc_adj_loop.ATTRIBUTE5;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE6 := c_ord_line_prc_adj_loop.ATTRIBUTE6;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE7 := c_ord_line_prc_adj_loop.ATTRIBUTE7;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE8 := c_ord_line_prc_adj_loop.ATTRIBUTE8;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE9 := c_ord_line_prc_adj_loop.ATTRIBUTE9;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE10 := c_ord_line_prc_adj_loop.ATTRIBUTE10;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE11 := c_ord_line_prc_adj_loop.ATTRIBUTE11;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE12 := c_ord_line_prc_adj_loop.ATTRIBUTE12;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE13 := c_ord_line_prc_adj_loop.ATTRIBUTE13;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE14 := c_ord_line_prc_adj_loop.ATTRIBUTE14;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ATTRIBUTE15 := c_ord_line_prc_adj_loop.ATTRIBUTE15;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).LIST_HEADER_ID := c_ord_line_prc_adj_loop.LIST_HEADER_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).LIST_NAME := c_ord_line_prc_adj_loop.LIST_NAME;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).LIST_LINE_ID := c_ord_line_prc_adj_loop.LIST_LINE_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).LIST_LINE_TYPE_CODE := c_ord_line_prc_adj_loop.LIST_LINE_TYPE_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).MODIFIER_MECHANISM_TYPE_CODE := c_ord_line_prc_adj_loop.MODIFIER_MECHANISM_TYPE_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).MODIFIED_FROM := c_ord_line_prc_adj_loop.MODIFIED_FROM;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).MODIFIED_TO := c_ord_line_prc_adj_loop.MODIFIED_TO;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).UPDATED_FLAG := c_ord_line_prc_adj_loop.UPDATED_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).UPDATE_ALLOWED := c_ord_line_prc_adj_loop.UPDATE_ALLOWED;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).APPLIED_FLAG := c_ord_line_prc_adj_loop.APPLIED_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CHANGE_REASON_CODE := c_ord_line_prc_adj_loop.CHANGE_REASON_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CHANGE_REASON_TEXT := c_ord_line_prc_adj_loop.CHANGE_REASON_TEXT;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).DISCOUNT_ID := c_ord_line_prc_adj_loop.DISCOUNT_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).DISCOUNT_LINE_ID := c_ord_line_prc_adj_loop.DISCOUNT_LINE_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).DISCOUNT_NAME := c_ord_line_prc_adj_loop.DISCOUNT_NAME;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).PERCENT := c_ord_line_prc_adj_loop.PERCENT;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).OPERATION_CODE := c_ord_line_prc_adj_loop.OPERATION_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).OPERAND := c_ord_line_prc_adj_loop.OPERAND;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ARITHMETIC_OPERATOR := c_ord_line_prc_adj_loop.ARITHMETIC_OPERATOR;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).PRICING_PHASE_ID := c_ord_line_prc_adj_loop.PRICING_PHASE_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ADJUSTED_AMOUNT := c_ord_line_prc_adj_loop.ADJUSTED_AMOUNT;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).MODIFIER_NAME := c_ord_line_prc_adj_loop.MODIFIER_NAME;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).LIST_LINE_NUMBER := c_ord_line_prc_adj_loop.LIST_LINE_NUMBER;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).VERSION_NUMBER := c_ord_line_prc_adj_loop.VERSION_NUMBER;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).INVOICED_FLAG := c_ord_line_prc_adj_loop.INVOICED_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ESTIMATED_FLAG := c_ord_line_prc_adj_loop.ESTIMATED_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).INC_IN_SALES_PERFORMANCE := c_ord_line_prc_adj_loop.INC_IN_SALES_PERFORMANCE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CHARGE_TYPE_CODE := c_ord_line_prc_adj_loop.CHARGE_TYPE_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CHARGE_SUBTYPE_CODE := c_ord_line_prc_adj_loop.CHARGE_SUBTYPE_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).CREDIT_OR_CHARGE_FLAG := c_ord_line_prc_adj_loop.CREDIT_OR_CHARGE_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).INCLUDE_ON_RETURNS_FLAG := c_ord_line_prc_adj_loop.INCLUDE_ON_RETURNS_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).COST_ID := c_ord_line_prc_adj_loop.COST_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).TAX_CODE := c_ord_line_prc_adj_loop.TAX_CODE;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).PARENT_ADJUSTMENT_ID := c_ord_line_prc_adj_loop.PARENT_ADJUSTMENT_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_CONTEXT := c_ord_line_prc_adj_loop.AC_CONTEXT;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE1 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE1;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE2 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE2;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE3 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE3;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE4 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE4;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE5 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE5;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE6 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE6;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE7 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE7;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE8 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE8;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE9 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE9;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE10 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE10;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE11 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE11;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE12 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE12;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE13 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE13;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE14 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE14;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).AC_ATTRIBUTE15 := c_ord_line_prc_adj_loop.AC_ATTRIBUTE15;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).OPERAND_PER_PQTY := c_ord_line_prc_adj_loop.OPERAND_PER_PQTY;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ADJUSTED_AMOUNT_PER_PQTY := c_ord_line_prc_adj_loop.ADJUSTED_AMOUNT_PER_PQTY;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).PRICE_ADJUSTMENT_ID := c_ord_line_prc_adj_loop.PRICE_ADJUSTMENT_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).TAX_RATE_ID := c_ord_line_prc_adj_loop.TAX_RATE_ID;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).ERROR_FLAG := c_ord_line_prc_adj_loop.ERROR_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).INTERFACE_STATUS := c_ord_line_prc_adj_loop.INTERFACE_STATUS;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).STATUS_FLAG := c_ord_line_prc_adj_loop.STATUS_FLAG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).SOLD_TO_ORG := c_ord_line_prc_adj_loop.SOLD_TO_ORG;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_prc_adj_rec_tbl_l(c_ord_line_prc_adj_loop.l_prc_adj_cnt).SOLD_TO_ORG_ID := c_ord_line_prc_adj_loop.SOLD_TO_ORG_ID;

              END LOOP;

              if nvl(gv_create_proj_events, 'N') = 'Y' THEN
                validate_project_event(p_project_number => l_project_number,
                                       p_task_number    => l_task_number,
                                       p_inventory_item => l_item_number);
              END IF;
              --
              /*************************************************************************************/
              --  Sales Order Line Dynamic SRC Attributes Record Type
              /************************************************************************************/
              FOR c_ord_line_src_attr_loop IN (SELECT rownum l_src_attr_cnt,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/SRC_ATTRIBUTE/NAME',
                                                                   gv_namespace) AS NAME,
                                                      extractvalue(tmp_l.column_value,
                                                                   '/SRC_ATTRIBUTE/VALUE',
                                                                   gv_namespace) AS VALUE
                                                 FROM TABLE(xmlsequence(c_sales_order_line_loop.g_src_attributes_line.extract('//SRC_ATTRIBUTE',
                                                                                                                              gv_namespace))) tmp_l) LOOP
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_src_attributes_tbl_l(c_ord_line_src_attr_loop.l_src_attr_cnt).NAME := c_ord_line_src_attr_loop.NAME;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_src_attributes_tbl_l(c_ord_line_src_attr_loop.l_src_attr_cnt).VALUE := c_ord_line_src_attr_loop.VALUE;
              END LOOP;
              /*************************************************************************************/
              --  Sales Order Line Attachments Record Type
              /************************************************************************************/
              FOR c_ord_line_attach_loop IN (SELECT rownum l_attach_cnt,
                                                    extractvalue(tmp_l.column_value,
                                                                 '/ORDER_ATTACHMENTS/LINE_NUMBER',
                                                                 gv_namespace) AS line_number,
                                                    extractvalue(tmp_l.column_value,
                                                                 '/ORDER_ATTACHMENTS/ATTACHMENT_TYPE',
                                                                 gv_namespace) AS attachment_type,
                                                    extractvalue(tmp_l.column_value,
                                                                 '/ORDER_ATTACHMENTS/SHORT_TEXT',
                                                                 gv_namespace) AS short_text
                                               FROM TABLE(xmlsequence(c_sales_order_line_loop.g_order_attachments_line.extract('//ORDER_ATTACHMENTS',
                                                                                                                               gv_namespace))) tmp_l) LOOP
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_attachment_tbl_l(c_ord_line_attach_loop.l_attach_cnt).line_number := c_ord_line_attach_loop.line_number;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_attachment_tbl_l(c_ord_line_attach_loop.l_attach_cnt).attachment_type := c_ord_line_attach_loop.attachment_type;
                gv_sales_order_header_tbl(c_sales_orders_loop.l_order_header_cnt).g_sales_order_line_tbl(c_sales_order_line_loop.l_order_line_cnt).g_order_attachment_tbl_l(c_ord_line_attach_loop.l_attach_cnt).short_text := c_ord_line_attach_loop.short_text;
              END LOOP;
            END LOOP; -- Sales Order Line Loop Ends
          END LOOP; -- Sales Order Header Loop Ends
        END;
      END LOOP; -- Agreement Loop ends
    END LOOP; -- XML Loop ends
    gv_poo := 'After All Assignments of XML to All Record types and Tables';
    log_debug(gv_procedure_name || '.' || gv_poo);
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status  := gc_error;
      x_return_message := gv_procedure_name || '.' || gv_poo || '.' ||
                          SQLERRM;
      log_debug(x_return_message, XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END parse_transaction;
  /******************************************************************************
  ** Procedure Name  : check_project_event_exists
  **
  ** Purpose:  Function to check if Project exist or Project Event is in Progress
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ******************************************************************************/
  FUNCTION check_project_event_exists RETURN VARCHAR2 IS
    l_retcode             VARCHAR2(100) := NULL;
    l_retmesg             VARCHAR2(4000) := NULL;
    x_return_message      VARCHAR2(1) := 'N';
    l_project_status_code VARCHAR2(2000);
    l_project_exists      VARCHAR2(20) := 'N';
    l_prev_event_status   VARCHAR2(100) := NULL;
    l_prev_proj_status    VARCHAR2(100) := NULL;
    CURSOR c_proj_prev_event IS
      SELECT *
        FROM apps.xxint_events a
       WHERE event_type = gc_event_type
         AND guid <> gv_guid
         and db_name = gv_db_name
         AND attribute1 = gv_source_system
         AND attribute2 = gv_request_type
         AND attribute4 = gv_agreement_num
         AND attribute6 = gv_project_num
            --         AND id < (SELECT id FROM apps.xxint_events WHERE guid = gv_guid);
         AND creation_date < (SELECT creation_date
                                FROM apps.xxint_events
                               WHERE guid = gv_guid);

  BEGIN
    log_debug('Check Project Exists : ' || gv_project_num);
    BEGIN

      BEGIN
        SELECT upper(trim(b.project_status_name))
          INTO l_project_status_code
          FROM apps.pa_projects_all a, PA_PROJECT_STATUSES b
         WHERE segment1 = gv_project_num
           and b.project_status_code = a.project_status_code
           and b.status_type = 'PROJECT';
        l_project_exists := 'Y';
      EXCEPTION
        when no_data_found then
          SELECT project_status_code
            INTO l_project_status_code
            FROM pa_projects_all
           WHERE segment1 = gv_project_num;
          l_project_exists := 'Y';
        when others then
          log_debug('Exception in Project Status Derivation :' ||
                    SUBSTR(SQLERRM, 1, 200),
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      end;
      --      l_project_exists := 'Y';
      log_debug('Project Current Status : ' || l_project_status_code);
      IF gv_proj_status <> l_project_status_code THEN
        send_email_notification(p_message_code  => NULL,
                                p_error_message => 'Project is ' ||
                                                   l_project_status_code);
      END IF;
      gv_proj_status := l_project_status_code;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        log_debug('Project not created',
                  XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      WHEN OTHERS THEN
        log_debug('Project not created',
                  XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
    END;
    --Check any previous events available
    FOR c_prev_data IN c_proj_prev_event LOOP
      IF (c_prev_data.attribute9 IS NULL OR
         c_prev_data.current_status = gc_error OR
         c_prev_data.attribute5 = gc_error) AND
         c_prev_data.current_status <> 'CLOSED' THEN
        --xxint_event_forms_helper.force_event_to_close(p_guid => c_prev_data.guid);
        xxint_event_api_pub.lock_event(x_retcode => l_retcode,
                                       x_retmesg => l_retmesg,
                                       p_guid    => c_prev_data.guid);
        xxint_event_api_pub.update_event(p_guid                => c_prev_data.guid,
                                         p_attribute3          => 'NEW_VERSION_AVAILABLE',
                                         p_user_status_code    => 'FORCE-CLOSE',
                                         p_user_status_message => 'Force closing the event as the latest update was processed with GUID = ' ||
                                                                  gv_guid);
        xxint_event_api_pub.unlock_event(p_guid => c_prev_data.guid);
      ELSE
        SELECT current_status, attribute5
          INTO l_prev_event_status, l_prev_proj_status
          FROM apps.xxint_events
         WHERE guid = c_prev_data.attribute9;
        IF l_prev_event_status = 'CLOSED' OR l_prev_event_status = gc_error THEN
          IF l_prev_proj_status = 'SUCCESS' THEN
            gv_proj_guid     := c_prev_data.attribute9;
            l_project_exists := 'Y';
          ELSIF l_prev_proj_status = gc_error THEN
            --xxint_event_forms_helper.force_event_to_close(p_guid => c_prev_data.guid);
            xxint_event_api_pub.lock_event(x_retcode => l_retcode,
                                           x_retmesg => l_retmesg,
                                           p_guid    => c_prev_data.guid);
            xxint_event_api_pub.update_event(p_guid                => c_prev_data.guid,
                                             p_attribute3          => 'NEW_VERSION_AVAILABLE',
                                             p_user_status_code    => 'FORCE-CLOSE',
                                             p_user_status_message => 'Force closing the event as the latest update was processed with GUID = ' ||
                                                                      gv_guid);
            xxint_event_api_pub.unlock_event(p_guid => c_prev_data.guid);
          END IF;
        ELSIF l_prev_event_status = 'READY' THEN
          log_debug('Waiting for Project Event to Complete');
          gv_proj_guid     := c_prev_data.attribute9;
          l_project_exists := 'Y';
        END IF;
      END IF;
    END LOOP;
    IF l_project_exists = 'Y' THEN
      IF gv_proj_guid IS NULL THEN
        BEGIN
          SELECT attribute9
            INTO gv_proj_guid
            FROM apps.xxint_events
           WHERE id IN
                 (SELECT MAX(id)
                    FROM apps.xxint_events a
                   WHERE event_type = gc_event_type
                     AND guid <> gv_guid
                     AND attribute1 = gv_source_system
                     AND attribute2 = gv_request_type
                     AND attribute4 = gv_agreement_num
                     AND attribute6 = gv_project_num
                     AND EXISTS (SELECT 1
                            FROM apps.xxint_events b
                           WHERE guid = a.attribute9
                             AND attribute5 = 'SUCCESS'));
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            SELECT attribute9
              INTO gv_proj_guid
              FROM apps.xxint_events
             WHERE id IN (SELECT MAX(id)
                            FROM apps.xxint_events a
                           WHERE event_type = gc_event_type
                             AND guid <> gv_guid
                             AND attribute1 = gv_source_system
                             AND attribute2 = gv_request_type
                             AND attribute4 = gv_agreement_num
                             AND attribute6 = gv_project_num);
          WHEN OTHERS THEN
            gv_proj_guid := NULL;
        END;
      END IF;
      xxint_event_api_pub.update_event(p_guid        => gv_guid,
                                       p_attribute3  => 'PROJECT_CREATED',
                                       p_attribute9  => gv_proj_guid,
                                       p_attribute10 => l_project_status_code);
    END IF;
    RETURN l_project_exists;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in check_project_event_exists :' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      RETURN l_project_exists;
  END check_project_event_exists;
  /******************************************************************************
  ** Procedure Name  : check_project_event_exists
  **
  ** Purpose:  Function to check if Agreement exist or Project Event is in Progress
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ******************************************************************************/
  FUNCTION check_agreement_exists(p_guid IN VARCHAR2) RETURN VARCHAR2 IS
    l_agr_exists    VARCHAR2(1);
    l_agreement_num pa_agreements_all.agreement_num%TYPE;
  BEGIN
    SELECT extractvalue(tmp_m.column_value,
                        'EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/AGREEMENT_NUM',
                        gv_namespace) agreement_num
      INTO l_agreement_num
      FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(p_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                             .extract('//EBS_PROJECT_ORDER', gv_namespace))) tmp_m;
    SELECT DECODE(COUNT(1), 0, 'N', 'Y')
      INTO l_agr_exists
      FROM pa_agreements_all
     WHERE agreement_num = l_agreement_num;
    RETURN(l_agr_exists);
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in check_agreement_exists :' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      RETURN('N');
  END check_agreement_exists;
  /******************************************************************************
  ** Procedure Name  : validate_project_info
  **
  ** Purpose:   For validating the Project information in Phase2, before creating XXPA2381 Event
  **
  ** Procedure History:
  ** Date          Who               Description
  ** ---------     ---------------   ----------------------------------------
  ** 13-May-2015   Jyotsana Kandpal   Initial Version. CR 22563                 *
  ******************************************************************************/
  PROCEDURE validate_project_info(x_return_status  OUT VARCHAR2,
                                  x_return_message OUT VARCHAR2) IS
    l_agr_exists            VARCHAR2(1);
    l_prj_exists            VARCHAR2(1);
    l_org_code_exists       VARCHAR2(1);
    l_bill_to_exists        VARCHAR2(1) := 'N';
    l_jlc_exists            VARCHAR2(1);
    l_invalid_ncodes        VARCHAR2(2000);
    l_error_count           NUMBER;
    l_geography_name        VARCHAR2(200);
    l_geography_code        VARCHAR2(20);
    l_job_location_country  VARCHAR2(200);
    l_ou_country_code       VARCHAR2(20);
    lv_sales_channel_exists VARCHAR2(1) := 'N';
    lv_project_class_count  NUMBER;
	l_dont_send_vsalesloc   NUMBER; --Added for CR24421
  BEGIN
    l_error_count     := g_error_tbl.COUNT;
    gv_procedure_name := 'validate_project_info';
    gv_poo            := 'Start';
    x_return_status   := gc_success;
    log_debug(x_return_status);
    log_debug(gv_procedure_name || '.' || gv_poo);
    log_debug('  ');
    FOR agr IN 1 .. gv_agr_tbl.COUNT LOOP
      -- Check for agreement number uniqueness. Skip all other Project Validations if Agreement Number already exists
      log_debug('--Agreement Validation Starts--');
      BEGIN
        IF gv_agr_tbl(agr).agr_main_rec.pm_agreement_reference IS NULL THEN
          log_error('Agreement Reference not provided');
        END IF;
        IF gv_agr_tbl(agr).agr_main_rec.agreement_num IS NULL THEN
          log_error('Agreement Number not provided');
        END IF;
        IF gv_agr_tbl(agr).agr_main_rec.agreement_type IS NULL THEN
          log_error('Agreement Type not provided');
        END IF;
        IF gv_agr_tbl(agr).agr_main_rec.amount IS NULL THEN
          log_error('Agreement PO Amount is mandatory');
        END IF;
        IF gv_agr_tbl(agr).agr_main_rec.agreement_currency_code IS NULL THEN
          log_error('Agreement Currency Code not provided');
        END IF;
        IF gv_agr_tbl(agr).agr_main_rec.customer_num IS NULL THEN
          log_error('Agreement Customer Number is mandatory.');
        END IF;
        IF gv_agr_tbl(agr).agr_extra_rec.term_name IS NULL THEN
          log_error('Agreement Payment Terms Name is mandatory');
        END IF;
        IF gv_agr_tbl(agr).agr_extra_rec.pm_product_code IS NULL THEN
          log_error('Agreement PM_PRODUCT_CODE not provided');
        END IF;
        IF gv_agr_tbl(agr).agr_extra_rec.owning_organization_code IS NULL AND gv_agr_tbl(agr)
           .agr_main_rec.owning_organization_id IS NULL AND gv_agr_tbl(agr)
           .agr_extra_rec.owning_organization_name IS NULL THEN
          log_error('Agreement Owning Organization Code is mandatory');
        END IF;
        SELECT DECODE(COUNT(1), 0, 'N', 'Y')
          INTO l_agr_exists
          FROM pa_agreements_all
         WHERE agreement_num = gv_agr_tbl(agr).agr_main_rec.agreement_num;
        log_debug('Agreement Exists : ' || l_agr_exists);
        -- If EXISTING_AGR_NUMBER passed in G_PROJECT_ORDERS/SRC_ATTRIBUTES then do not create project.
        -- Validate and proceed/close the event based on the output
        IF NVL(gv_existing_agr_number, 'N') <> 'N' AND l_agr_exists = 'N' THEN
          log_error('Existing Agreement Number Passed ' || gv_agr_tbl(agr)
                    .agr_main_rec.agreement_num ||
                    ' doesnt exists in Oracle');
        END IF;
        IF l_agr_exists = 'N' THEN
          -- Check for Owning Org ID/ Code validity
          BEGIN
            get_carrying_out_org_name(p_owning_organization_code => gv_agr_tbl(agr)
                                                                    .agr_extra_rec.owning_organization_code,
                                      p_owning_organization_name => gv_agr_tbl(agr)
                                                                    .agr_extra_rec.owning_organization_name,
                                      p_owning_organization_id   => gv_agr_tbl(agr)
                                                                    .agr_main_rec.owning_organization_id);

            /*
            SELECT DECODE(COUNT(1), 0, 'N', 'Y')
              INTO l_org_code_exists
              FROM mtl_parameters
             WHERE organization_code = gv_agr_tbl(agr)
                  .agr_extra_rec.owning_organization_code;
            IF l_org_code_exists = 'N' THEN
              SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                INTO l_org_code_exists
                FROM hr_all_organization_units   haou,
                     hr_organization_information hoi1,
                     hr_organization_information hoi2
               WHERE upper(haou.NAME) LIKE
                     UPPER(gv_agr_tbl(agr)
                           .agr_extra_rec.owning_organization_name)
                 AND hoi1.organization_id = haou.organization_id
                 AND upper(hoi1.org_information_context) = 'CLASS'
                 AND upper(hoi1.org_information1) = 'PA_EXPENDITURE_ORG'
                 AND upper(hoi1.org_information2) = 'Y'
                 AND hoi2.organization_id = haou.organization_id
                 AND upper(hoi2.org_information_context) =
                     'EXP ORGANIZATION DEFAULTS';
              IF l_org_code_exists = 'N' THEN
                log_error('The Organization Code provided is invalid or does not exist');
              END IF;
            END IF;
            */
            IF gv_agr_tbl(agr).agr_main_rec.owning_organization_id is null THEN
              log_error('The Organization Code provided is invalid or does not exist');
            ELSE
              xxpa_proj_in_pkg.init_apps(gv_agr_tbl(agr)
                                         .agr_main_rec.owning_organization_id,
                                         gv_operating_unit,
                                         x_return_status,
                                         x_return_message);
            END IF;

            log_debug('Owning Org Code/Org_id Validation : ' ||
                      l_org_code_exists);
          END;

        END IF;
        IF x_return_status <> gc_error THEN
          FOR prj IN 1 .. gv_agr_tbl(agr).g_prj_tbl.COUNT LOOP
            -- Check if project number is provided or not
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .prj_main_rec.pa_project_number IS NULL THEN
              log_error('Project Number on the agreement is mandatory');
            END IF;
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .prj_main_rec.project_name IS NULL THEN
              log_error('Project Name on the agreement is mandatory');
            END IF;
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .prj_main_rec.start_date IS NULL THEN
              log_error('Project Start Date is mandatory');
            END IF;
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .prj_main_rec.completion_date IS NULL THEN
              log_error('Project Completion Date is mandatory');
            END IF;
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .prj_extra_rec.project_type IS NULL THEN
              log_error('Project Type is mandatory');
            END IF;
            -- Check for project number uniqueness across partner
            BEGIN
              SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                INTO l_prj_exists
                FROM pa_projects_all
               WHERE segment1 = gv_agr_tbl(agr).g_prj_tbl(prj)
                    .prj_main_rec.pa_project_number
                 AND pm_product_code = gv_source_system;
              log_debug('Project Exists : ' || l_prj_exists);
              IF NVL(gv_existing_agr_number, 'N') <> 'N' AND
                 l_prj_exists = 'N' THEN
                log_error('Existing Project Number Passed ' || gv_agr_tbl(agr).g_prj_tbl(prj)
                          .prj_main_rec.pa_project_number ||
                          ' doesnt exists in Oracle');
              END IF;
              IF l_prj_exists = 'Y' THEN
                log_error('Project Number provided is not unique across Partner ' ||
                          gv_source_system ||
                          '. A project with this number already exists.');
              ELSE
                SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                  INTO l_prj_exists
                  FROM pa_projects_all
                 WHERE name = gv_agr_tbl(agr).g_prj_tbl(prj)
                      .prj_main_rec.project_name;
                IF l_prj_exists = 'Y' THEN
                  log_error('Project Name must be unique. A project with same name already exists.');
                END IF;
              END IF;
            END;

            if gv_operating_unit is null then

              get_carrying_out_org_name(p_owning_organization_code => gv_agr_tbl(agr).g_prj_tbl(prj)
                                                                      .prj_extra_rec.carrying_out_organization_code,
                                        p_owning_organization_name => gv_agr_tbl(agr).g_prj_tbl(prj)
                                                                      .prj_extra_rec.carrying_out_organization_name,
                                        p_owning_organization_id   => gv_agr_tbl(agr).g_prj_tbl(prj)
                                                                      .prj_main_rec.carrying_out_organization_id);
              if gv_agr_tbl(agr).g_prj_tbl(prj)
               .prj_main_rec.carrying_out_organization_id is not null then
                xxpa_proj_in_pkg.init_apps(gv_agr_tbl(agr).g_prj_tbl(prj)
                                           .prj_main_rec.carrying_out_organization_id,
                                           gv_operating_unit,
                                           x_return_status,
                                           x_return_message);
              end if;

            end if;
            log_debug('Before Bill to Validation');
            -- Check for Bill to validity
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_number IS NOT NULL OR gv_agr_tbl(agr).g_prj_tbl(prj)
               .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_id IS NOT NULL THEN
              log_debug('Inside Bill to Validation');
              BEGIN
                SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                  INTO l_bill_to_exists
                  FROM xxont_cust_dtl_v
                 WHERE cust_account_id =
                       NVL(gv_agr_tbl(agr).g_prj_tbl(prj).g_prj_cust_rec.prj_cust_tbl(1)
                           .customer_id,
                           cust_account_id)
                   AND account_number =
                       NVL(gv_agr_tbl(agr).g_prj_tbl(prj)
                           .g_prj_cust_rec.prj_cust_extra.customer_number,
                           account_number)
                   AND party_site_id = NVL(gv_agr_tbl(agr).g_prj_tbl(prj)
                                           .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_id,
                                           party_site_id)
                   AND party_site_number =
                       NVL(gv_agr_tbl(agr).g_prj_tbl(prj)
                           .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_number,
                           party_site_number)
                   AND site_use_code = 'BILL_TO'
                   and su_org_id = gv_operating_unit
                   AND account_status = 'A'
                   AND party_site_status = 'A'
                   AND su_status = 'A';
                IF l_bill_to_exists = 'N' THEN
                  log_error('Could not find Bill-To information. Invalid Bill-To provided.');
                ELSE
                  SELECT cust_account_id
                    INTO gv_agr_tbl(agr).g_prj_tbl(prj).g_prj_cust_rec.prj_cust_tbl(1)
                         .customer_id
                    FROM xxont_cust_dtl_v
                   WHERE cust_account_id =
                         NVL(gv_agr_tbl(agr).g_prj_tbl(prj).g_prj_cust_rec.prj_cust_tbl(1)
                             .customer_id,
                             cust_account_id)
                     AND account_number =
                         NVL(gv_agr_tbl(agr).g_prj_tbl(prj)
                             .g_prj_cust_rec.prj_cust_extra.customer_number,
                             account_number)
                     AND party_site_id = NVL(gv_agr_tbl(agr).g_prj_tbl(prj)
                                             .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_id,
                                             party_site_id)
                     AND party_site_number =
                         NVL(gv_agr_tbl(agr).g_prj_tbl(prj)
                             .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_number,
                             party_site_number)
                     AND site_use_code = 'BILL_TO'
                     and su_org_id = gv_operating_unit;
                END IF;
              END;
            ELSE
              log_error('Bill to information is Mandatory');
            END IF;
            log_debug('Bill To Exists : ' || l_bill_to_exists);
            -- Check for presence of at least one N-Code
            IF gv_agr_tbl(agr).g_prj_tbl(prj)
             .g_prj_task_rec.tasks_in_tbl.COUNT = 0 THEN
              log_error('N-Codes information not present. At least 1 N-code should be sent to generate Project Task.');
            END IF;
            --Added for HPQC 21376 for Sales Channel Addition
            lv_sales_channel_exists := 'N';
            FOR proj_class_count IN 1 .. gv_agr_tbl(agr).g_prj_tbl(prj)
                                         .g_class_categories_tbl.count LOOP
              IF upper(gv_agr_tbl(agr).g_prj_tbl(prj).g_class_categories_tbl(proj_class_count)
                       .class_category) = 'SALES CHANNEL' THEN
                lv_sales_channel_exists := 'Y';
              END IF;
            END LOOP;
            IF lv_sales_channel_exists = 'N' THEN
              --Get Sales Channel Code from Bill To Site Customer Master
              lv_project_class_count := gv_agr_tbl(agr).g_prj_tbl(prj)
                                        .g_class_categories_tbl.count;
              BEGIN
                SELECT pac.class_category, pac.class_code
                  INTO gv_agr_tbl(agr).g_prj_tbl(prj).g_class_categories_tbl(lv_project_class_count + 1)
                       .class_category,
                       gv_agr_tbl(agr).g_prj_tbl(prj).g_class_categories_tbl(lv_project_class_count + 1)
                       .class_code
                  FROM apps.hz_cust_accounts hca, apps.pa_class_codes pac
                 WHERE pac.class_category = 'Sales Channel'
                   AND hca.cust_account_id = gv_agr_tbl(agr).g_prj_tbl(prj).g_prj_cust_rec.prj_cust_tbl(1)
                      .customer_id
                   AND sysdate BETWEEN
                       NVL(pac.start_date_active, sysdate - 1) AND
                       NVL(pac.end_date_active, sysdate + 1)
                   AND upper(pac.class_code) LIKE
                       upper(hca.sales_channel_code) || '%';
              EXCEPTION
                WHEN OTHERS THEN
                  log_debug('Exception while deriving Sales Channel Code : ' ||
                            SUBSTR(SQLERRM, 1, 200),
                            XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
              END;
            END IF;
            --End of Added for HPQC 21376 for Sales Channel Addition
          END LOOP;
        END IF;
        --        ELSE
        --          log_debug('Agreement number' || gv_agr_tbl(agr)
        --                    .agr_main_rec.agreement_num ||
        --                    ' already exists. Proceed to Sales Order Validation for this agreement.');
        --        END IF;
      END;
    END LOOP;
    --Check N-Codes
    BEGIN
      SELECT listagg(extractvalue(tmp_l.column_value,
                                  '/RESERVE_CODES/N-CODE',
                                  gv_namespace),
                     ',') within GROUP(ORDER BY 1) AS aa
        INTO l_invalid_ncodes
        FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                               .extract('//EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_PROJECTS/PROJECT/G_RESERVE_CODES/RESERVE_CODES',
                                        gv_namespace))) tmp_l
       WHERE NOT EXISTS
       (SELECT 1
                FROM xxint_event_type_key_vals
               WHERE event_type = gc_event_type
                 AND key_type = gc_key_type
                 AND key_type_value = gv_source_system
                 AND key_name = gc_ncode_keyname
                 AND key_value = extractvalue(tmp_l.column_value,
                                              '/RESERVE_CODES/N-CODE',
                                              gv_namespace)
                 AND upper(attribute2) =
                     upper(extractvalue(tmp_l.column_value,
                                        '/RESERVE_CODES/N-CODE_DESCRIPTION',
                                        gv_namespace)));
      IF l_invalid_ncodes IS NOT NULL THEN
        x_return_status := gc_error;
        log_error('Invalid N-Codes available in the Payload - ' ||
                  l_invalid_ncodes);
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    -- Check job Location Country.
    -- If the Project Org and Job location OU Country are different then add Virtual sales Location in the Project Classification

	-- Start: CR24421: Changes to not send virtual sales location if the key value parameter is set for the partner and OU

	BEGIN
		SELECT count(1)
		into l_dont_send_vsalesloc
		FROM xxint_event_type_key_vals xxint,
			 hr_operating_units hou
	   WHERE xxint.event_type = gc_event_type
		 AND xxint.key_type = gc_key_type
		 AND xxint.key_type_value = gv_source_system
		 AND xxint.key_name = gc_vsl_key_name
		 AND xxint.key_Value = hou.short_code
		 and hou.organization_id = gv_operating_unit;

	EXCEPTION
	WHEN OTHERS THEN
        l_dont_send_vsalesloc := 0;
	END;

    IF l_dont_send_vsalesloc = 0 THEN
	-- End: CR24421
    BEGIN
      SELECT country
        INTO l_ou_country_code
        FROM apps.hr_organization_units hou, apps.hr_locations hl
       WHERE hou.organization_id = gv_operating_unit
         AND hl.location_id = hou.location_id;
    EXCEPTION
      WHEN OTHERS THEN
        l_ou_country_code := NULL;
    END;
    l_job_location_country := gv_agr_tbl(1)
                              .agr_extra_rec.job_location_country;
    IF NVL(l_ou_country_code, 'XX') <> l_job_location_country AND
       l_job_location_country IS NOT NULL THEN
      -- Check Job Location Country
      SELECT DECODE(COUNT(1), 0, 'N', 'Y')
        INTO l_jlc_exists
        FROM pa_class_codes
       WHERE upper(class_category) = 'VIRTUAL SALES LOCATION'
         AND class_code = l_job_location_country;
      IF l_jlc_exists = 'N' THEN
        BEGIN
          BEGIN
            SELECT geography_name, geography_code
              INTO l_geography_name, l_geography_code
              FROM hz_geographies
             WHERE geography_type = 'COUNTRY_CODE'
               AND (upper(geography_name) = upper(l_job_location_country) OR
                   upper(geography_code) = upper(l_job_location_country));

          EXCEPTION
            WHEN no_data_found THEN
              -- Changes start for defect # 26717
              BEGIN
                SELECT geography_name, geography_code
                  INTO l_geography_name, l_geography_code
                  FROM hz_geographies
                 WHERE geography_type = 'COUNTRY'
                   AND (upper(geography_name) =
                       upper(l_job_location_country) OR
                       upper(geography_code) =
                       upper(l_job_location_country));
              EXCEPTION
                WHEN no_data_found THEN
                  x_return_message := 'Invalid Job Location Country available in the Payload - ' || gv_agr_tbl(1)
                                     .agr_extra_rec.job_location_country;
                  log_error(x_return_message);
                WHEN OTHERS THEN
                  x_return_message := 'Invalid Job Location Country available in the Payload - ' || gv_agr_tbl(1)
                                     .agr_extra_rec.job_location_country;
                  log_error(x_return_message);
              END;
              -- Changes end for defect # 26717
          END;

          SELECT class_code
            INTO gv_agr_tbl(1).agr_extra_rec.job_location_country
            FROM pa_class_codes
           WHERE upper(class_category) = 'VIRTUAL SALES LOCATION'
             AND upper(description) = upper(l_geography_name); -- Added by Joydeb
        EXCEPTION
          WHEN no_data_found THEN
            x_return_message := 'Invalid Job Location Country available in the Payload - ' || gv_agr_tbl(1)
                               .agr_extra_rec.job_location_country;
            log_error(x_return_message);
          WHEN OTHERS THEN
            x_return_message := 'Invalid Job Location Country available in the Payload - ' || gv_agr_tbl(1)
                               .agr_extra_rec.job_location_country;
            log_error(x_return_message);
        END;
      END IF;
    ELSE
      gv_agr_tbl(1).agr_extra_rec.job_location_country := NULL;
    END IF;
    log_debug('Operating Unit :' || gv_operating_unit ||
              '. Job Location Country :' || l_job_location_country ||
              ' Carrying Out Organization Country :' || l_ou_country_code);
    --
	-- Start: Added for CR24421
	ELSE
	    gv_agr_tbl(1).agr_extra_rec.job_location_country := NULL;
	END IF;
	-- End: Added for CR24421
    IF l_error_count <> g_error_tbl.COUNT THEN
      x_return_status := gc_error;
    END IF;
    gv_poo := 'After performing all Project Validations';
    log_debug(gv_procedure_name || '.' || ' Completed');
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status  := gc_error;
      x_return_message := gv_procedure_name || '.' || gv_poo || '.' ||
                          SQLERRM;
      log_debug(gv_procedure_name || '.' || gv_poo || '.' ||
                x_return_message,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END validate_project_info;
  /*
  ** Procedure Name  : get_warehouse_info
  ** Purpose:  For Getting order line warehouse derivation in phase2 and phase4
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------            ----------------   ----------------------------------------
  ** 27-Oct-17            Vishnusimman M   Created new
  */
  PROCEDURE get_default_warehouse(p_spectrum_factory_code IN VARCHAR2,
                                  p_ou_name               IN VARCHAR2,
                                  p_party_site_number     IN VARCHAR2,
                                  p_factory_mode          OUT VARCHAR2,
                                  p_oracle_factory_code   OUT VARCHAR2,
                                  p_order_line_dwh        OUT VARCHAR2,
                                  p_cust_number           OUT VARCHAR2,
                                  p_cust_account_id       OUT VARCHAR2,
                                  p_factory_desc          OUT VARCHAR2) IS
    CURSOR c_la_source(p_spectrum_factory_code VARCHAR2,
                       p_ou_name               VARCHAR2,
                       p_party_site_number     VARCHAR2) is
      SELECT flv.tag,
             flv.attribute2,
             flv.attribute3,
             flv.attribute4,
             hca.cust_account_id,
             flv.attribute5
        FROM fnd_lookup_values_vl flv, apps.hz_cust_accounts hca
       WHERE flv.lookup_type = 'XXPA2592_MFG_ORG_MAPPING'
         AND flv.enabled_flag = 'Y'
         AND hca.account_number(+) = flv.attribute4
         AND flv.description = gv_source_system
         AND flv.attribute1 = p_spectrum_factory_code
         AND NVL(flv.ATTRIBUTE6, 'N') = nvl(p_ou_name, 'N')
         AND nvl(flv.attribute7, 'XX') = nvl(p_party_site_number, 'XX')
         AND SYSDATE BETWEEN NVL(flv.start_date_active, SYSDATE - 1) AND
             NVL(flv.end_date_active, SYSDATE + 1);
    CURSOR c_non_la_source(p_ou_name varchar2) is
      SELECT mtl.organization_id, mtl.organization_code
        FROM apps.fnd_lookup_values_vl fnd,
             apps.hr_operating_units   hou,
             apps.mtl_parameters       mtl
       WHERE fnd.lookup_type = 'XXPA2592_LA_NON_US_SOURCE_ORG'
			AND SYSDATE BETWEEN fnd.start_date_active AND nvl(fnd.end_date_active,SYSDATE)  --Added for SEP-4548 Separation Activity
			AND fnd.enabled_flag = 'Y'  --Added for SEP-4548 Separation Activity
			AND hou.name = fnd.meaning
			AND mtl.organization_code = fnd.tag
			AND hou.name = p_ou_name;
  BEGIN
    log_debug('p_spectrum_factory_code     : ' || p_spectrum_factory_code);
    log_debug('p_ou_name                 : ' || p_ou_name);
    log_debug('p_party_site_number         : ' || p_party_site_number);
    --Get Warehouse based on party site number
    FOR c_la_src_data in c_la_source(p_spectrum_factory_code,
                                     p_ou_name,
                                     p_party_site_number) loop
      p_factory_mode        := c_la_src_data.tag;
      p_oracle_factory_code := c_la_src_data.attribute2;
      p_order_line_dwh      := c_la_src_data.attribute3;
      p_cust_number         := c_la_src_data.attribute4;
      p_cust_account_id     := c_la_src_data.cust_account_id;
      p_factory_desc        := c_la_src_data.attribute5;
      log_debug('Warehouse based on Party Site OU(LA) : ' ||
                p_order_line_dwh);
      exit;
    end loop;
    --Get Warehouse based on OU
    if p_order_line_dwh is null then
      FOR c_la_src_data in c_la_source(p_spectrum_factory_code,
                                       NULL,
                                       p_party_site_number) loop
        p_factory_mode        := c_la_src_data.tag;
        p_oracle_factory_code := c_la_src_data.attribute2;
        p_order_line_dwh      := c_la_src_data.attribute3;
        p_cust_number         := c_la_src_data.attribute4;
        p_cust_account_id     := c_la_src_data.cust_account_id;
        p_factory_desc        := c_la_src_data.attribute5;
        log_debug('Warehouse based on Party Site Non OU(LA) : ' ||
                  p_order_line_dwh);
        exit;
      end loop;
    end if;
    --Get Warehouse based on OU
    if p_order_line_dwh is null then
      FOR c_la_src_data in c_la_source(p_spectrum_factory_code,
                                       p_ou_name,
                                       NULL) loop
        p_factory_mode        := c_la_src_data.tag;
        p_oracle_factory_code := c_la_src_data.attribute2;
        p_order_line_dwh      := c_la_src_data.attribute3;
        p_cust_number         := c_la_src_data.attribute4;
        p_cust_account_id     := c_la_src_data.cust_account_id;
        p_factory_desc        := c_la_src_data.attribute5;
        log_debug('Warehouse based on Operating Unit code(LA) : ' ||
                  p_order_line_dwh);
        exit;
      end loop;
    end if;
    --Get Warehouse based on Factory Source
    if p_order_line_dwh is null then
      FOR c_la_src_data in c_la_source(p_spectrum_factory_code, NULL, NULL) loop
        p_factory_mode        := c_la_src_data.tag;
        p_oracle_factory_code := c_la_src_data.attribute2;
        p_order_line_dwh      := c_la_src_data.attribute3;
        p_cust_number         := c_la_src_data.attribute4;
        p_cust_account_id     := c_la_src_data.cust_account_id;
        p_factory_desc        := c_la_src_data.attribute5;
        log_debug('Warehouse based on Factory Source LA  : ' ||
                  p_order_line_dwh);
        exit;
      end loop;
    end if;
    --Get Warehouse based on non- LA source
    if p_order_line_dwh is null then
      FOR c_la_src_data in c_non_la_source(p_ou_name) loop
        p_order_line_dwh := c_la_src_data.organization_code;
        log_debug('Warehouse based on Factory Source NON-LA Source : ' ||
                  p_order_line_dwh);
        exit;
      end loop;
    end if;

  EXCEPTION
    WHEN OTHERS THEN
      log_debug('Exception in Warehouse Derivation : ' || SQLERRM);
  END get_default_warehouse;

  /*
  ** Procedure Name  : validate_sales_order_info
  ** Purpose:  For validating the Sales Order information in Phase2
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------            ----------------   ----------------------------------------
  ** 18-Jun-15            Jyotsana Kandpal   Created new
  */
  PROCEDURE validate_sales_order_info(x_return_status  OUT VARCHAR2,
                                      x_return_message OUT VARCHAR2) IS
    l_order_number_exists       VARCHAR2(20);
    l_cust_po_number_exists     VARCHAR2(20);
    l_cust_po_append_exists     VARCHAR2(20); --Added for Defect 22294
    l_bill_to_exists            VARCHAR2(20) := 'N';
    l_subzero_qty               VARCHAR2(1);
    l_subzero_qty_line_num      NUMBER;
    l_40_dgt_item               VARCHAR2(32767);
    l_15_dgt_item               VARCHAR2(32767);
    l_list_price                NUMBER DEFAULT NULL;
    l_pricing_date              DATE;
    l_product_family            VARCHAR2(32767);
    l_product_code              VARCHAR2(32767);
    l_status                    VARCHAR2(32767);
    l_error_message             VARCHAR2(32767);
    l_valid_item_code           VARCHAR2(1);
    l_deliver_to_org_code       VARCHAR2(2000);
    l_deliver_to_org_id         NUMBER;
    l_frt_fwd_name              fnd_lookup_values.meaning%TYPE;
    l_factory_mode              VARCHAR2(2000);
    l_oracle_factory_code       VARCHAR2(2000);
    l_order_line_dwh            VARCHAR2(2000);
    l_factory_desc              VARCHAR2(2000);
    l_ou_name                   fnd_lookup_values.description%TYPE;
    l_ou_id                     fnd_lookup_values.tag%TYPE;
    l_cust_number               fnd_lookup_values.attribute1%TYPE;
    l_cust_account_id           hz_cust_accounts.cust_account_id%TYPE;
    l_xml_src_from_id           fnd_lookup_values.lookup_code%TYPE;
    l_xml_frt_fwd_name          fnd_lookup_values.meaning%TYPE;
    l_xml_frt_fwd_address1      VARCHAR2(1000);
    l_xml_frt_fwd_address2      VARCHAR2(1000);
    l_xml_product_family        VARCHAR2(1000);
    l_xml_product_code          VARCHAR2(1000);
    x_create_cust_site_rec_type xxont_validate_create_site.create_cust_site_rec_type;
    x_cust_site_use_rec         hz_cust_account_site_v2pub.cust_site_use_rec_type;
    l_delv_attr_added           VARCHAR2(1) := 'N';
    l_org_id                    NUMBER;
    l_org_code                  VARCHAR2(200);
    l_org_name                  hr_operating_units.name%type;
    l_iface_error_flag          VARCHAR2(1) := 'N';
    l_attribute19_valid         VARCHAR2(1) := 'Y';
    l_ilc_name                  VARCHAR2(200); --Added for HPQC 20664
    l_ilc_exists                VARCHAR2(1) := 'Y'; --Added for HPQC 20664
    l_del_addr_key_exists       VARCHAR2(1) := 'Y'; --Added for HPQC 20664
    l_del_addr                  VARCHAR2(240) := NULL;
    l_crd_date_attr             VARCHAR2(240) := NULL;
    l_crd_date_added_flag       VARCHAR2(2) := 'N';
    l_shipmethod_attr           VARCHAR2(240) := NULL;
    l_shipmethod_added_flag     VARCHAR2(2) := 'N';
    l_line_addl_attr_count      NUMBER;
    lv_def_sales_credit_type    VARCHAR2(200);
    lv_sales_credit_total       NUMBER := 0;
  BEGIN
    gv_procedure_name := 'validate_sales_order_info';
    gv_poo            := 'Start';
    x_return_status   := gc_success;
    log_debug(gv_procedure_name || '.' || gv_poo);
    -- Validate Unique ATTRIBUTE19 for each Order
    BEGIN
      SELECT DECODE(COUNT(extractvalue(tmp_m.column_value,
                                       '/ORDER_HEADER/ATTRIBUTE19',
                                       NULL)),
                    COUNT(DISTINCT extractvalue(tmp_m.column_value,
                                       '/ORDER_HEADER/ATTRIBUTE19',
                                       NULL)),
                    'Y',
                    'N') attribute19_valid
        INTO l_attribute19_valid
        FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                               .extract('//EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_ORDER/ORDER_HEADER',
                                        NULL))) tmp_m;
    EXCEPTION
      WHEN OTHERS THEN
        l_attribute19_valid := 'Y';
        log_debug('Validate Distinct ATTRIBUTE19 Exception : ' || SQLERRM,
                  XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
    END;
    -- Check for sales order number uniqueness in sales orders table
    IF gv_sales_order_header_tbl.COUNT > 0 THEN
      FOR l_ord_count IN 1 .. gv_sales_order_header_tbl.COUNT LOOP
        l_org_code := gv_sales_order_header_tbl(l_ord_count)
                      .g_sales_order_hdr_main_rec.org_code;
        l_org_id   := gv_sales_order_header_tbl(l_ord_count)
                      .g_sales_order_hdr_main_rec.org_id;
        IF l_org_id IS NULL AND l_org_code IS NULL THEN
          log_error('Order Org Id/Org Code is missing');
        ELSE
          IF l_org_id IS NULL OR l_org_code IS NULL THEN
            BEGIN
              SELECT organization_id, short_code, name
                INTO gv_sales_order_header_tbl(l_ord_count)
                     .g_sales_order_hdr_main_rec.org_id,
                     gv_sales_order_header_tbl(l_ord_count)
                     .g_sales_order_hdr_main_rec.org_code,
                     l_org_name
                FROM apps.hr_operating_units
               WHERE short_code = NVL(gv_sales_order_header_tbl(l_ord_count)
                                      .g_sales_order_hdr_main_rec.org_code,
                                      short_code) --l_org_code
                 AND organization_id =
                     NVL(gv_sales_order_header_tbl(l_ord_count)
                         .g_sales_order_hdr_main_rec.org_id,
                         organization_id);
              l_org_id := gv_sales_order_header_tbl(l_ord_count)
                          .g_sales_order_hdr_main_rec.org_id;
              IF gv_operating_unit IS NULL THEN
                gv_operating_unit := l_org_id;
              END IF;
            EXCEPTION
              WHEN no_data_found THEN
                log_error('Org code (' || l_org_code || ') is not valid');
              WHEN OTHERS THEN
                log_error('Org code (' || l_org_code || ') is not valid');
            END;
          END IF;
        END IF;
        log_debug('Operating Unit Name : ' || l_org_name);
        log_debug('Attribute19 : ' || gv_sales_order_header_tbl(l_ord_count)
                  .g_sales_order_hdr_main_rec.attribute19);
        -- Check if Attribute19, i.e. Sales Order number has been provided or not
        IF gv_sales_order_header_tbl(l_ord_count)
         .g_sales_order_hdr_main_rec.attribute19 IS NULL THEN
          log_error('Attribute19 (Sales Order Number) is mandatory on Sales Order.');
        ELSE
          SELECT DECODE(COUNT(1), 0, 'N', 'Y')
            INTO l_order_number_exists
            FROM oe_order_headers_all
           WHERE attribute19 = gv_sales_order_header_tbl(l_ord_count)
                .g_sales_order_hdr_main_rec.attribute19;
          log_debug('Sales Order Exists : ' || l_order_number_exists);
          IF l_order_number_exists = 'Y' THEN
            log_error('Sales Order Number ' || gv_sales_order_header_tbl(l_ord_count)
                      .g_sales_order_hdr_main_rec.attribute19 ||
                      ' already exists in the system');
          ELSE
            -- Check for sales order number uniqueness in orders interface table
            SELECT DECODE(COUNT(1), 0, 'N', 'Y')
              INTO l_order_number_exists
              FROM oe_headers_iface_all
             WHERE attribute19 = gv_sales_order_header_tbl(l_ord_count)
                  .g_sales_order_hdr_main_rec.attribute19;
            IF l_order_number_exists = 'Y' THEN
              SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                INTO l_iface_error_flag
                FROM oe_headers_iface_all
               WHERE attribute19 = gv_sales_order_header_tbl(l_ord_count)
                    .g_sales_order_hdr_main_rec.attribute19
                 AND NVL(error_flag, 'N') = 'Y';
            END IF;
            log_debug('Sales Order Exists in iFace Table: ' ||
                      l_order_number_exists);
            IF l_order_number_exists = 'Y' AND
               NVL(l_iface_error_flag, 'N') <> 'Y' THEN
              log_error('An Order with Sales Order Number ' || gv_sales_order_header_tbl(l_ord_count)
                        .g_sales_order_hdr_main_rec.attribute19 ||
                        ' is lying in Order Import already');
            END IF;
          END IF;
        END IF;
        -- Check if Customer PO Number is provided or not
        IF gv_sales_order_header_tbl(l_ord_count)
         .g_sales_order_hdr_main_rec.customer_po_number IS NULL THEN
          log_error('Customer PO Number is mandatory on Sales Order');
        ELSE
          -- Check for Customer PO number uniqueness
          SELECT DECODE(COUNT(1), 0, 'N', 'Y')
            INTO l_cust_po_number_exists
            FROM oe_order_headers_all
           WHERE upper(cust_po_number) =
                 upper(gv_sales_order_header_tbl(l_ord_count)
                       .g_sales_order_hdr_main_rec.customer_po_number);
          log_debug('Customer PO Exists : ' || l_cust_po_number_exists);
          IF l_cust_po_number_exists = 'Y' THEN
            log_debug('A Sales Order with Customer PO Number: ' || gv_sales_order_header_tbl(l_ord_count)
                      .g_sales_order_hdr_main_rec.customer_po_number ||
                      ' already exists in the system.');
          END IF;
          --Added for Defect 22294
          SELECT DECODE(COUNT(1), 0, 'N', 'Y')
            INTO l_cust_po_append_exists
            FROM XXINT_EVENT_TYPE_KEY_VALS xxint,
                 apps.hr_operating_units   hou
           WHERE xxint.event_type = gc_event_type
             AND xxint.key_type = gc_key_type
             AND xxint.key_type_value = gv_source_system
             AND xxint.key_name = gc_operating_unit_code
             AND xxint.attribute2 = 'CUST_PO_NUMBER'
             AND xxint.status = 'ACTIVE'
             AND hou.short_code = xxint.key_value
             and hou.short_code = gv_sales_order_header_tbl(l_ord_count)
                .g_sales_order_hdr_main_rec.org_code;

          IF NVL(l_cust_po_append_exists, 'N') = 'Y' and gv_sales_order_header_tbl(l_ord_count)
            .g_sales_order_hdr_main_rec.attribute8 is not null THEN
            gv_sales_order_header_tbl(l_ord_count).g_sales_order_hdr_main_rec.customer_po_number := gv_sales_order_header_tbl(l_ord_count)
                                                                                                    .g_sales_order_hdr_main_rec.attribute8 ||
                                                                                                     ' - ' || gv_sales_order_header_tbl(l_ord_count)
                                                                                                    .g_sales_order_hdr_main_rec.customer_po_number;
          END IF;
          --End of Added for Defect 22294
        END IF;
        -- Check if Customer Request Date is provided or not
        IF gv_sales_order_header_tbl(l_ord_count)
         .g_sales_order_hdr_main_rec.request_date IS NULL THEN
          log_error('Sales Order Request Date is mandatory');
        END IF;
        -- Check for Bill to validity
        IF gv_sales_order_header_tbl(l_ord_count)
         .g_sales_order_hdr_main_rec.bill_to_party_site_number IS NOT NULL OR gv_sales_order_header_tbl(l_ord_count)
           .g_sales_order_hdr_main_rec.bill_to_party_site_id IS NOT NULL THEN
          BEGIN
            /*  SELECT DECODE(COUNT(1), 0, 'N', 'Y')
              INTO l_bill_to_exists
              FROM xxont_cust_dtl_v
             WHERE cust_account_id = NVL(gv_sales_order_header_tbl(l_ord_count)
                                         .g_sales_order_hdr_main_rec.customer_id,
                                         cust_account_id)
               AND account_number = NVL(gv_sales_order_header_tbl(l_ord_count)
                                        .g_sales_order_hdr_main_rec.customer_number,
                                        account_number)
               AND party_site_id = NVL(gv_sales_order_header_tbl(l_ord_count)
                                       .g_sales_order_hdr_main_rec.bill_to_party_site_id,
                                       party_site_id)
               AND party_site_number =
                   NVL(gv_sales_order_header_tbl(l_ord_count)
                       .g_sales_order_hdr_main_rec.bill_to_party_site_number,
                       party_site_number)
               AND account_status = 'A'
               AND party_site_status = 'A'
               AND su_status = 'A'
               AND site_use_code = 'BILL_TO' -- Added for CR23783
               and su_org_id = gv_sales_order_header_tbl(l_ord_count)
                  .g_sales_order_hdr_main_rec.org_id;
            */

            BEGIN
              SELECT party_site_number
                INTO gv_sales_order_header_tbl(l_ord_count)
                     .g_sales_order_hdr_main_rec.bill_to_party_site_number
                FROM xxont_cust_dtl_v
               WHERE cust_account_id =
                     NVL(gv_sales_order_header_tbl(l_ord_count)
                         .g_sales_order_hdr_main_rec.customer_id,
                         cust_account_id)
                 AND account_number = NVL(gv_sales_order_header_tbl(l_ord_count)
                                          .g_sales_order_hdr_main_rec.customer_number,
                                          account_number)
                 AND party_site_id = NVL(gv_sales_order_header_tbl(l_ord_count)
                                         .g_sales_order_hdr_main_rec.bill_to_party_site_id,
                                         party_site_id)
                 AND party_site_number =
                     NVL(gv_sales_order_header_tbl(l_ord_count)
                         .g_sales_order_hdr_main_rec.bill_to_party_site_number,
                         party_site_number)
                 AND account_status = 'A'
                 AND party_site_status = 'A'
                 AND su_status = 'A'
                 and site_use_code = 'BILL_TO'
                 and su_org_id = gv_sales_order_header_tbl(l_ord_count)
                    .g_sales_order_hdr_main_rec.org_id;
              l_bill_to_exists := 'Y';
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                l_bill_to_exists := 'N';
              WHEN TOO_MANY_ROWS THEN
                if gv_sales_order_header_tbl(l_ord_count)
                 .g_sales_order_hdr_main_rec.bill_to_party_site_number is null then
                  SELECT party_site_number
                    INTO gv_sales_order_header_tbl(l_ord_count)
                         .g_sales_order_hdr_main_rec.bill_to_party_site_number
                    FROM xxont_cust_dtl_v
                   WHERE cust_account_id =
                         NVL(gv_sales_order_header_tbl(l_ord_count)
                             .g_sales_order_hdr_main_rec.customer_id,
                             cust_account_id)
                     AND account_number =
                         NVL(gv_sales_order_header_tbl(l_ord_count)
                             .g_sales_order_hdr_main_rec.customer_number,
                             account_number)
                     AND party_site_id = NVL(gv_sales_order_header_tbl(l_ord_count)
                                             .g_sales_order_hdr_main_rec.bill_to_party_site_id,
                                             party_site_id)
                     AND party_site_number =
                         NVL(gv_sales_order_header_tbl(l_ord_count)
                             .g_sales_order_hdr_main_rec.bill_to_party_site_number,
                             party_site_number)
                     AND account_status = 'A'
                     AND party_site_status = 'A'
                     AND su_status = 'A'
                     and site_use_code = 'BILL_TO'
                     and su_org_id = gv_sales_order_header_tbl(l_ord_count)
                        .g_sales_order_hdr_main_rec.org_id
                     and rownum = 1;
                  l_bill_to_exists := 'Y';
                end if;
              WHEN OTHERS THEN
                log_debug('Exception in Bill To Party Site Number Derivation ' ||
                          SQLERRM);
            END;

            IF l_bill_to_exists = 'N' THEN
              log_error('Could not find Bill-To information. Invalid Bill-To provided');
            ELSE
              --Start of Added for CR23783
              log_debug('Bill to Party Site Number : ' || gv_sales_order_header_tbl(l_ord_count)
                        .g_sales_order_hdr_main_rec.bill_to_party_site_number);
              -- End of Added for CR23783
            END IF;

            -- Derive Sales Rep ID
            get_salesrep_id_num(NULL,
                                gv_sales_order_header_tbl(l_ord_count)
                                .g_sales_order_hdr_main_rec.salesrep,
                                gv_sales_order_header_tbl(l_ord_count)
                                .g_sales_order_hdr_main_rec.salesrepId);
            log_debug('Sales Rep number - Sales Rep ID : ' || gv_sales_order_header_tbl(l_ord_count)
                      .g_sales_order_hdr_main_rec.salesrep || '-' || gv_sales_order_header_tbl(l_ord_count)
                      .g_sales_order_hdr_main_rec.salesrepId);
            /* Changes for Sales Credit Added for HPQC21314 */
            IF gv_sales_order_header_tbl(l_ord_count)
             .g_sales_credit_hdr_tbl.count > 0 THEN
              lv_def_sales_credit_type := xxint_event_type_utils.get_key_parm_value(p_event_type     => gc_event_type,
                                                                                    p_key_type       => gc_key_type,
                                                                                    p_key_type_value => gv_source_system,
                                                                                    p_name           => gc_sales_credit_type_code);
              log_debug('Default Sales Credit : ' ||
                        lv_def_sales_credit_type);
              FOR c_sales_credit_loop IN 1 .. gv_sales_order_header_tbl(l_ord_count)
                                              .g_sales_credit_hdr_tbl.count LOOP
                log_debug('Sales Credit Detials : ' || gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                          .employee_number || '-' || gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                          .salesrep || '-' || gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                          .salesrepId);
                BEGIN
                  get_salesrep_id_num(gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                                      .employee_number,
                                      gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                                      .salesrep,
                                      gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                                      .salesrepId);
                  SELECT name, sales_credit_type_id
                    INTO gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                         .salesCreditType,
                         gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                         .salesCreditTypeId
                    FROM OE_SALES_CREDIT_TYPES
                   WHERE upper(name) = upper(NVL(lv_def_sales_credit_type,
                                                 NVL(gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                                                     .salesCreditType,
                                                     name)))
                     AND sales_credit_type_id =
                         NVL(gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                             .salesCreditTypeId,
                             sales_credit_type_id);
                  lv_sales_credit_total := lv_sales_credit_total + gv_sales_order_header_tbl(l_ord_count).g_sales_credit_hdr_tbl(c_sales_credit_loop)
                                          .percent;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                    log_debug('Exception while deriving Sales Rep ID 1' ||
                              SUBSTR(SQLERRM, 1, 200),
                              XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
                  WHEN OTHERS THEN
                    log_debug('Exception while deriving Sales Rep ID 2' ||
                              SUBSTR(SQLERRM, 1, 200),
                              XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
                END;
              END LOOP;
            END IF;
            /* End of Changes for Sales Credit Added for HPQC21314 */
            /****************************************************************************************
            SALES ORDER LINE VALIDATION
            ****************************************************************************************/
            -- Proceed with Order Line Level Validations
            gv_poo := 'Beginning Order Line Level Validations';
            log_debug(gv_procedure_name || '.' || gv_poo);
            -- Check for Ordered Quantity Positive value
            l_subzero_qty := 'N';
            FOR ol_cnt IN 1 .. gv_sales_order_header_tbl(l_ord_count)
                               .g_sales_order_line_tbl.COUNT LOOP
              IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
               .g_sales_order_line_main_rec.ordered_quantity <= 0
              --or gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.ordered_quantity is null
               THEN
                l_subzero_qty          := 'Y';
                l_subzero_qty_line_num := ol_cnt;
                EXIT;
              END IF;
            END LOOP;
            IF l_subzero_qty = 'Y' THEN
              log_error('Sales Order Line Number:' ||
                        l_subzero_qty_line_num ||
                        ' has a negative or zero ordered quantity. Ordered Quantity should be positive');
            END IF;
            /* Commented for CR24287
            --Get the additional Attr numbers for CRD Date and Ship Method Attribute
            BEGIN
              SELECT attribute1, attribute2
                INTO l_crd_date_attr, l_shipmethod_attr
                FROM apps.fnd_lookup_values_vl
               WHERE lookup_type = 'XXPA2592_LA_NON_US_SOURCE_ORG'
                 AND NVL(enabled_flag, 'N') = 'Y'
                 AND sysdate BETWEEN start_date_active AND
                     NVL(end_date_active, sysdate + 1)
                 AND view_application_id = 660
                 AND meaning = l_org_name;
            EXCEPTION
              WHEN OTHERS THEN
                l_crd_date_attr   := NULL;
                l_shipmethod_attr := NULL;
            END;
            log_debug('Request Date Attribute : ' || l_crd_date_attr);
            log_debug('Shipmethod Attribute : ' || l_shipmethod_attr);
            --End of Get the additional Attr numbers for CRD Date and Ship Method Attribute
            End of Commented for CR24287*/
            -- Check for Inventory Item Validity/Creation
            FOR ol_cnt IN 1 .. gv_sales_order_header_tbl(l_ord_count)
                               .g_sales_order_line_tbl.COUNT LOOP
              -- Get Values from Additional Attributes for 40 Digit Item Creation and Deliver to Address Creation
              -- Fetch Line Level attributes for further use
              log_debug('Before calling Line level additional attributes for derivation:' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                        .g_order_add_attr_line_tbl_l.COUNT);
              l_crd_date_added_flag := 'N';
              FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                       .g_order_add_attr_line_tbl_l.COUNT LOOP
                log_debug('Attribute Name - Value : ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                          .attribute_name || '-' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                          .attribute_value);
                IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'ATTRIBUTE3' THEN
                  l_xml_src_from_id := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                       .attribute_value;
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'ATTRIBUTE9' THEN
                  l_xml_frt_fwd_name := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                        .attribute_value;
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'ATTRIBUTE16' THEN
                  l_xml_frt_fwd_address1 := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                            .attribute_value;
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'ATTRIBUTE17' THEN
                  l_xml_frt_fwd_address2 := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                            .attribute_value;
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'GLOBAL_ATTRIBUTE15' THEN
                  l_ilc_name := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                .attribute_value;
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'GLOBAL_ATTRIBUTE14' THEN
                  log_debug('Product Family/Code information in XML:' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                            .attribute_value);
                  l_xml_product_family := SUBSTR(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                 .attribute_value,
                                                 1,
                                                 instr(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                       .attribute_value,
                                                       '|',
                                                       1,
                                                       1) - 1);
                  l_xml_product_code   := SUBSTR(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                 .attribute_value,
                                                 instr(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                       .attribute_value,
                                                       '|',
                                                       1,
                                                       1) + 1);
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = l_crd_date_attr AND
                       l_crd_date_attr IS NOT NULL AND
                       NVL(l_crd_date_added_flag, 'N') = 'N'
                and 1=2 --Added for CR24287
                THEN

                  log_debug('Request Date from DFF: ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                            .attribute_value);
                  gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.request_date := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                                                                                                    .attribute_value;
                  /*
                  gv_sales_order_header_tbl(l_ord_count).g_sales_order_hdr_main_rec.request_date := NVL(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                                                                        .attribute_value,
                                                                                                        gv_sales_order_header_tbl(l_ord_count)
                                                                                                        .g_sales_order_hdr_main_rec.request_date);
                  */
                  l_crd_date_added_flag := 'Y';
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'GLOBAL_ATTRIBUTE8' THEN
                  gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value := gv_sales_order_header_tbl(l_ord_count)
                                                                                                                                                     .g_sales_order_hdr_main_rec.shipping_method;
                  l_shipmethod_added_flag := 'Y';
                  log_debug('l_shipmethod_added_flag Pre: ' ||
                            l_shipmethod_added_flag);
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'ATTRIBUTE20' THEN
                  --Added IF condition to mask the user item description as per HPQC#24280
                  IF g_usr_item_desc_key_enabled = 'N'
                  --Added below and condition for CR24595
                  AND gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.user_item_description IS NULL
                  THEN
                    gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.user_item_description := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                                                                                                               .attribute_value;
                  END IF;
                --Added for CR24595 [START]
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'ATTRIBUTE60' THEN
              --IF attribute60 is not null then it will have highest precedence over masking logic for attr20
                 IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value IS NOT NULL  THEN
                    gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.user_item_description := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value;
				 END IF;
                 --Added for CR24595 [END]
                END IF;
              END LOOP;
              l_line_addl_attr_count := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                        .g_order_add_attr_line_tbl_l.COUNT;
              /*Commented for CR24287
              IF NVL(l_shipmethod_added_flag, 'N') = 'N' THEN
                log_debug('l_shipmethod_added_flag Post: ' ||
                          l_shipmethod_added_flag);
                gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1).attribute_name := 'GLOBAL_ATTRIBUTE8';
                gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1).attribute_value := gv_sales_order_header_tbl(l_ord_count)
                                                                                                                                                                 .g_sales_order_hdr_main_rec.shipping_method;
                log_debug(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1)
                          .attribute_name);
                log_debug(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1)
                          .attribute_value);
              END IF;
              End of Commented for CR24287 */
              -- Validate ILC Name
              l_ilc_exists := 'Y';
              IF l_ilc_name IS NOT NULL THEN
                SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                  INTO l_ilc_exists
                  FROM fnd_flex_value_sets a, apps.fnd_flex_values_vl b
                 WHERE flex_value_set_name = 'XXONT_PA_HUB_ILC_NAME'
                   AND b.flex_value_set_id = a.flex_value_set_id
                   AND trim(upper(flex_value)) = trim(upper(l_ilc_name))
                   AND NVL(enabled_flag, 'Y') = 'Y';
              ELSE
                l_ilc_exists := 'Y';
              END IF;
              IF l_ilc_exists = 'N' THEN
                log_error('Order Line Number : ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                          .g_sales_order_line_main_rec.line_number ||
                          'ILC Name (' || l_ilc_name || ') is not valid');
              END IF;
              -- End of Validate ILC Name
              -- Compare the Src from Id with Oracle Quick Code lookup code
              BEGIN
                log_debug('Warehouse Derivation');
                --Start of Added for CR23783
                get_default_warehouse(p_spectrum_factory_code => l_xml_src_from_id,
                                      p_ou_name               => l_org_name,
                                      p_party_site_number     => gv_sales_order_header_tbl(l_ord_count)
                                                                 .g_sales_order_hdr_main_rec.bill_to_party_site_number,
                                      p_factory_mode          => l_factory_mode,
                                      p_oracle_factory_code   => l_oracle_factory_code,
                                      p_order_line_dwh        => l_order_line_dwh,
                                      p_cust_number           => l_cust_number,
                                      p_cust_account_id       => l_cust_account_id,
                                      p_factory_desc          => l_factory_desc);

                IF l_order_line_dwh IS NOT NULL THEN
                  SELECT organization_id
                    INTO gv_ship_from_org_id
                    FROM mtl_parameters
                   WHERE organization_code = l_order_line_dwh;
                  log_debug('Ship From Org ID :' || gv_ship_from_org_id);
                END IF;
                --End of Added for CR23783


                --Added for CR24287
                --Moved Logic below to find warehouse first as its required for POI/POE date population as per new requirement
            BEGIN
              SELECT attribute1, attribute2
                INTO l_crd_date_attr, l_shipmethod_attr
                FROM apps.fnd_lookup_values_vl
               WHERE lookup_type = 'XXPA2592_LA_NON_US_SOURCE_ORG'
                 AND NVL(enabled_flag, 'N') = 'Y'
                 AND sysdate BETWEEN start_date_active AND
                     NVL(end_date_active, sysdate + 1)
                 AND view_application_id = 660
                 AND meaning = l_org_name
                 and nvl(tag,l_order_line_dwh) = l_order_line_dwh;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                    l_crd_date_attr   := NULL;
                    l_shipmethod_attr := NULL;
              WHEN OTHERS THEN
                l_crd_date_attr   := NULL;
                l_shipmethod_attr := NULL;
            END;
            log_debug('Request Date Attribute : ' || l_crd_date_attr);
            log_debug('Shipmethod Attribute : ' || l_shipmethod_attr);


              log_debug('Before calling Line level additional attributes for derivation:' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                        .g_order_add_attr_line_tbl_l.COUNT);

              l_crd_date_added_flag := 'N';

              FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                       .g_order_add_attr_line_tbl_l.COUNT LOOP
                log_debug('Attribute Name - Value : ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                          .attribute_name || '-' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                          .attribute_value);
                IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = l_crd_date_attr AND
                       l_crd_date_attr IS NOT NULL AND
                       NVL(l_crd_date_added_flag, 'N') = 'N'
                THEN

                  log_debug('Request Date from DFF: ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                            .attribute_value);
                  gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.request_date := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                                                                                                                                    .attribute_value;
                  l_crd_date_added_flag := 'Y';
                ELSIF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                 .attribute_name = 'GLOBAL_ATTRIBUTE8' THEN
                  gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value := gv_sales_order_header_tbl(l_ord_count)
                                                                                                                                                     .g_sales_order_hdr_main_rec.shipping_method;
                  l_shipmethod_added_flag := 'Y';
                  log_debug('l_shipmethod_added_flag Pre: ' ||
                            l_shipmethod_added_flag);
                END IF;
              END LOOP;
             --
             IF NVL(l_shipmethod_added_flag, 'N') = 'N' THEN
                log_debug('l_shipmethod_added_flag Post: ' ||
                          l_shipmethod_added_flag);
                gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1).attribute_name := 'GLOBAL_ATTRIBUTE8';
                gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1).attribute_value := gv_sales_order_header_tbl(l_ord_count)
                                                                                                                                                                 .g_sales_order_hdr_main_rec.shipping_method;
                log_debug(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1)
                          .attribute_name);
                log_debug(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_line_addl_attr_count + 1)
                          .attribute_value);
              END IF;

                --End of Added for CR24287

                IF LENGTH(TRIM(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                               .g_sales_order_line_main_rec.inventory_item)) = 40 THEN
                  -- If 40 digit item, call custom matching and creation
                  l_40_dgt_item    := TRIM(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                           .g_sales_order_line_main_rec.inventory_item);
                  l_pricing_date   := TRUNC(SYSDATE);
                  l_list_price     := gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_prc_attr_line_tbl_l(1)
                                      .pricing_attribute1;
                  l_product_family := l_xml_product_family;
                  l_product_code   := l_xml_product_code;
                  log_debug('Item|Pricing Date|Product Family|Product Code|List Price');
                  log_debug(l_40_dgt_item || '|' || l_pricing_date || '|' ||
                            l_product_family || '|' || l_product_code || '|' ||
                            l_list_price);
                  IF l_product_family IS NOT NULL AND
                     l_product_code IS NOT NULL THEN
                    BEGIN
                      xxont_item_matching(p_40_dgt_item    => l_40_dgt_item,
                                          p_15_dgt_item    => l_15_dgt_item,
                                          p_price_list     => NULL, --l_price_list,
                                          p_list_price     => l_list_price,
                                          p_pricing_date   => l_pricing_date,
                                          p_product_family => l_product_family,
                                          p_product_code   => l_product_code,
                                          p_status         => l_status,
                                          p_error_message  => l_error_message);
                      log_debug('Item Matching Status : ' || l_status);
                      log_debug('Item Matching Error Message : ' ||
                                l_error_message);
                      COMMIT;
                      IF l_status = 'S' THEN
                        --l_status <> 'E' THEN changed the condition because l_status doesn't return apt value
                        gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.inventory_item := l_15_dgt_item;
                        log_debug('Item Code created from 40-Digit Item:' ||
                                  l_15_dgt_item);
                      ELSE
                        log_error('Could not generate match/create item number for item:' ||
                                  l_40_dgt_item || 'Error Message: ' ||
                                  l_error_message);
                      END IF;
                    EXCEPTION
                      WHEN OTHERS THEN
                        log_error('Could not generate match/create item number for item:' ||
                                  l_40_dgt_item);
                    END;
                  ELSE
                    log_error('Could not find Product Family and Product Code information in the XML');
                  END IF;
                END IF;

                /* Commented for CR23783
                -- Compare the Src from Id with Oracle Quick Code lookup code
                BEGIN
                  log_debug('Warehouse Derivation');
                  log_debug('Spectrum Factory code : ' || l_xml_src_from_id);
                  BEGIN
                    SELECT flv.tag,
                           flv.attribute2,
                           flv.attribute3,
                           flv.attribute4,
                           hca.cust_account_id,
                           flv.attribute5
                      INTO l_factory_mode,
                           l_oracle_factory_code,
                           l_order_line_dwh,
                           l_cust_number,
                           l_cust_account_id,
                           l_factory_desc
                      FROM fnd_lookup_values_vl  flv,
                           apps.hz_cust_accounts hca
                     WHERE flv.lookup_type = 'XXPA2592_MFG_ORG_MAPPING'
                       AND flv.enabled_flag = 'Y'
                       AND hca.account_number(+) = flv.attribute4
                       AND flv.description = gv_source_system
                       AND flv.attribute1 = l_xml_src_from_id
                       AND SYSDATE BETWEEN
                           NVL(flv.start_date_active, SYSDATE - 1) AND
                           NVL(flv.end_date_active, SYSDATE + 1)
                       AND NVL(flv.ATTRIBUTE6, 'N') = l_org_name
                       AND rownum = 1;
                    log_debug('Data Warehouse Operating Unit Level :' ||
                              l_order_line_dwh);
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                      SELECT flv.tag,
                             flv.attribute2,
                             flv.attribute3,
                             flv.attribute4,
                             hca.cust_account_id,
                             flv.attribute5
                        INTO l_factory_mode,
                             l_oracle_factory_code,
                             l_order_line_dwh,
                             l_cust_number,
                             l_cust_account_id,
                             l_factory_desc
                        FROM fnd_lookup_values_vl  flv,
                             apps.hz_cust_accounts hca
                       WHERE flv.lookup_type = 'XXPA2592_MFG_ORG_MAPPING'
                         AND flv.enabled_flag = 'Y'
                         AND hca.account_number(+) = flv.attribute4
                         AND flv.description = gv_source_system
                         AND flv.attribute1 = l_xml_src_from_id
                         AND SYSDATE BETWEEN
                             NVL(flv.start_date_active, SYSDATE - 1) AND
                             NVL(flv.end_date_active, SYSDATE + 1)
                         AND flv.ATTRIBUTE6 IS NULL
                         AND rownum = 1;
                      log_debug('Data Warehouse Non-Operating Unit Level :' ||
                                l_order_line_dwh);
                    WHEN OTHERS THEN
                      NULL;
                  END;
                  End of commented for CR23783*/

                BEGIN
                  SELECT hoi2.org_information1, hou.short_code
                    INTO l_deliver_to_org_id, l_deliver_to_org_code
                    FROM hr_all_organization_units   haou,
                         hr_organization_information hoi1,
                         hr_organization_information hoi2,
                         apps.mtl_parameters         mtp,
                         hr_operating_units          hou
                   WHERE mtp.organization_code = l_oracle_factory_code
                     AND haou.organization_id = mtp.organization_id
                     AND hoi1.organization_id = haou.organization_id
                     AND upper(hoi1.org_information_context) = 'CLASS'
                     AND upper(hoi1.org_information1) =
                         'PA_EXPENDITURE_ORG'
                     AND upper(hoi1.org_information2) = 'Y'
                     AND hoi2.organization_id = haou.organization_id
                     AND upper(hoi2.org_information_context) =
                         'EXP ORGANIZATION DEFAULTS'
                     AND hou.organization_id(+) = hoi2.org_information1
                     AND rownum = 1;
                EXCEPTION
                  WHEN OTHERS THEN
                    l_deliver_to_org_id := l_org_id;
                END;
                IF l_deliver_to_org_id IS NULL THEN
                  l_deliver_to_org_id := l_org_id;
                END IF;
                --
                log_debug('Factory Mode :' || l_factory_mode);
                log_debug('Oracle Code : ' || l_oracle_factory_code);
                log_debug('Warehouse Code from Org Map Lookup : ' ||
                          l_order_line_dwh);
                log_debug('Internal Customer Number : ' || l_cust_number);
                log_debug('Internal Customer ID : ' || l_cust_account_id);
                log_debug('Internal Customer Deliver To Org : ' ||
                          l_deliver_to_org_id);
                --
                /* commented for CR23783
                IF l_order_line_dwh IS NOT NULL THEN
                  SELECT organization_id
                    INTO gv_ship_from_org_id
                    FROM mtl_parameters
                   WHERE organization_code = l_order_line_dwh;
                  log_debug('Ship From Org ID :' || gv_ship_from_org_id);
                ELSE
                  -- Update Ship From Org ID if the OU is available in Lookup
                  BEGIN
                    SELECT mtl.organization_id
                      INTO gv_ship_from_org_id
                      FROM apps.fnd_lookup_values_vl fnd,
                           apps.hr_operating_units   hou,
                           apps.mtl_parameters       mtl
                     WHERE lookup_type = 'XXPA2592_LA_NON_US_SOURCE_ORG'
                       AND hou.name = fnd.meaning
                       AND mtl.organization_code = fnd.tag
					   AND fnd.enabled_flag = 'Y'  --Added for SEP-4548 Separation Activity
					   AND SYSDATE BETWEEN fnd.start_date_active AND nvl(fnd.end_date_active,SYSDATE)  --Added for SEP-4548 Separation Activity
                       AND hou.organization_id = gv_sales_order_header_tbl(l_ord_count)
                          .g_sales_order_hdr_main_rec.org_id;
                  EXCEPTION
                    WHEN OTHERS THEN
                      log_debug('Warehouse exception : ' || SQLERRM,
                                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
                  END;
                END IF;
                End of commented for CR23783*/

                log_debug('Ship From Org ID :' || gv_ship_from_org_id);
                IF gv_ship_from_org_id IS NOT NULL THEN
                  gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_sales_order_line_main_rec.ship_from_org_id := gv_ship_from_org_id;
                END IF;
                --Inventory Item Validation Based on the Ship from Org
                SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                  INTO l_valid_item_code
                  FROM mtl_system_items_b msib
                 WHERE msib.segment1 = gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                      .g_sales_order_line_main_rec.inventory_item
                   AND msib.CUSTOMER_ORDER_FLAG = 'Y'
                   AND msib.CUSTOMER_ORDER_ENABLED_FLAG = 'Y'
                   AND msib.organization_id =
                       NVL(NVL(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                               .g_sales_order_line_main_rec.ship_from_org_id,
                               gv_ship_from_org_id),
                           msib.organization_id);
                IF l_valid_item_code = 'N' THEN
                  log_error('Inventory Item Number Provided: ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                            .g_sales_order_line_main_rec.inventory_item ||
                            ' is not valid');
                END IF;
                log_debug('Inventory Item Number Provided: ' || gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                          .g_sales_order_line_main_rec.inventory_item ||
                          ' is valid.');
                --
                IF NVL(l_factory_mode, 'OFFLINE') = 'ONLINE' THEN
                  l_del_addr := NULL;
                  --Added for HPQC 20664
                  SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                    INTO l_del_addr_key_exists
                    FROM XXINT_EVENT_TYPE_KEY_VALS xxint,
                         apps.hr_operating_units   hou
                   WHERE xxint.event_type = gc_event_type
                     AND xxint.key_type = gc_key_type
                     AND xxint.key_type_value = gv_source_system
                     AND xxint.key_name = gc_operating_unit_code
                     AND xxint.attribute2 = 'DELIVER_TO_ADDRESS'
                     AND xxint.status = 'ACTIVE'
                     AND hou.short_code = xxint.key_value;

                  log_debug('Delivery Key Exists : ' ||
                            l_del_addr_key_exists);
                  log_debug('Deliver to Org Code : ' ||
                            l_deliver_to_org_code);

                  if l_deliver_to_org_code is null and
                     l_deliver_to_org_id is not null then
                    begin
                      select short_code
                        into l_deliver_to_org_code
                        from hr_operating_units
                       where organization_id = l_deliver_to_org_id;
                    exception
                      when others then
                        null;
                    end;
                  end if;
                  log_debug('Deliver to Org Code : ' ||
                            l_deliver_to_org_code);
                  IF NVL(l_del_addr_key_exists, 'N') = 'Y' THEN
                    SELECT DECODE(COUNT(1), 0, 'N', 'Y')
                      INTO l_del_addr_key_exists
                      FROM XXINT_EVENT_TYPE_KEY_VALS xxint
                     WHERE xxint.event_type = gc_event_type
                       AND xxint.key_type = gc_key_type
                       AND xxint.key_type_value = gv_source_system
                       AND xxint.key_name = gc_operating_unit_code
                       AND xxint.attribute2 = 'DELIVER_TO_ADDRESS'
                       AND xxint.status = 'ACTIVE'
                       AND xxint.key_value = l_deliver_to_org_code;
                    l_delv_attr_added := 'N';
                    log_debug('Delivery Key Exists 2: ' ||
                              l_del_addr_key_exists);

                    FOR c_deliv_addr_loop IN (SELECT key_value,
                                                     attribute1,
                                                     hou.organization_id
                                                FROM XXINT_EVENT_TYPE_KEY_VALS xxint,
                                                     apps.hr_operating_units   hou
                                               WHERE xxint.event_type =
                                                     gc_event_type
                                                 AND xxint.key_type =
                                                     gc_key_type
                                                 AND xxint.key_type_value =
                                                     gv_source_system
                                                 AND xxint.key_name =
                                                     gc_operating_unit_code
                                                 AND xxint.attribute2 =
                                                     'DELIVER_TO_ADDRESS'
                                                 AND xxint.status = 'ACTIVE'
                                                 AND hou.short_code =
                                                     xxint.key_value
                                                 AND l_del_addr_key_exists = 'Y') LOOP
                      BEGIN
                        -- Setting the Org Context before calling deliver_to_site creation
                        log_debug('Delivery Org ID : ' ||
                                  c_deliv_addr_loop.organization_id);
                        log_debug('l_xml_frt_fwd_address1 : ' ||
                                  l_xml_frt_fwd_address1);
                        log_debug('l_xml_frt_fwd_address2 : ' ||
                                  l_xml_frt_fwd_address2);
                        log_debug('l_xml_frt_fwd_name : ' ||
                                  l_xml_frt_fwd_name);

                        mo_global.init('PA');
                        mo_global.set_policy_context('S',
                                                     c_deliv_addr_loop.organization_id);
                        -- Call Global Cust Account Site Match/Create API to Match/Create Deliver To
                        xxont_create_deliverto_site(p_site_code                 => 'DELIVER_TO',
                                                    p_cust_account_id           => l_cust_account_id,
                                                    p_execution_mode            => 'MATCH_CREATE',
                                                    p_address_string1           => TRIM(l_xml_frt_fwd_address1),
                                                    p_address_string2           => TRIM(l_xml_frt_fwd_address2),
                                                    p_address4                  => TRIM(l_xml_frt_fwd_name),
                                                    p_org_id                    => c_deliv_addr_loop.organization_id,
                                                    x_create_cust_site_rec_type => x_create_cust_site_rec_type,
                                                    x_cust_site_use_rec         => x_cust_site_use_rec);
                        log_debug('Deliver to Creation Status : ' ||
                                  x_create_cust_site_rec_type.x_ret_code);
                      EXCEPTION
                        WHEN OTHERS THEN
                          x_return_status  := gc_error;
                          x_return_message := 'Unhandled Exception while creating Deliver To Site : ' ||
                                              SQLERRM;
                          log_error(x_return_message);
                      END;
                      IF x_create_cust_site_rec_type.x_ret_code <>
                         fnd_api.g_ret_sts_success THEN
                        log_debug('There might be some issue in Deliver to Creation/Match');
                        log_debug('Global Deliver To Creation error ' ||
                                  x_create_cust_site_rec_type.x_processing_status);
                        x_return_message := x_create_cust_site_rec_type.x_ret_message;
                        log_debug(x_return_message);
                        IF l_delv_attr_added = 'N' THEN
                          FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                                   .g_order_add_attr_line_tbl_l.COUNT LOOP
                            IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                             .attribute_name = 'ATTRIBUTE19' --c_deliv_addr_loop.attribute1
                             THEN
                              gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := 'ERROR';
                              l_delv_attr_added := 'Y';
                            END IF;
                          END LOOP;
                          IF l_delv_attr_added = 'N' THEN
                            gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT + 1).attribute_name := 'ATTRIBUTE19';
                            gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := 'ERROR';
                            EXIT;
                          END IF;
                        END IF;
                      ELSE
                        --l_delv_attr_added := 'N';
                        IF l_del_addr IS NULL THEN
                          l_del_addr := c_deliv_addr_loop.organization_id || '~' ||
                                        x_cust_site_use_rec.site_use_id;
                        ELSE
                          l_del_addr := l_del_addr || '|' ||
                                        c_deliv_addr_loop.organization_id || '~' ||
                                        x_cust_site_use_rec.site_use_id;
                        END IF;
                      END IF;
                    END LOOP;
                    IF l_delv_attr_added = 'N' AND l_del_addr IS NOT NULL THEN
                      FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                               .g_order_add_attr_line_tbl_l.COUNT LOOP
                        IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                         .attribute_name = 'ATTRIBUTE18' THEN
                          gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := l_del_addr;
                          l_delv_attr_added := 'Y';
                        END IF;
                      END LOOP;
                      IF l_delv_attr_added = 'N' THEN
                        l_delv_attr_added := 'Y';
                        gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT + 1).attribute_name := 'ATTRIBUTE18';
                        gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := l_del_addr;
                      END IF;
                    END IF;
                    mo_global.set_policy_context('S', l_org_id);
                  ELSE
                    --End of Added for HPQC 20664
                    BEGIN
                      -- Setting the Org Context before calling deliver_to_site creation
                      mo_global.init('PA');
                      IF l_deliver_to_org_id IS NOT NULL THEN
                        mo_global.set_policy_context('S',
                                                     l_deliver_to_org_id);
                      ELSE
                        mo_global.set_policy_context('S', l_org_id);
                      END IF;
                      -- Call Global Cust Account Site Match/Create API to Match/Create Deliver To
                      xxont_create_deliverto_site(p_site_code                 => 'DELIVER_TO',
                                                  p_cust_account_id           => l_cust_account_id,
                                                  p_execution_mode            => 'MATCH_CREATE',
                                                  p_address_string1           => TRIM(l_xml_frt_fwd_address1),
                                                  p_address_string2           => TRIM(l_xml_frt_fwd_address2),
                                                  p_address4                  => TRIM(l_xml_frt_fwd_name),
                                                  p_org_id                    => l_deliver_to_org_id,
                                                  x_create_cust_site_rec_type => x_create_cust_site_rec_type,
                                                  x_cust_site_use_rec         => x_cust_site_use_rec);
                      log_debug('Deliver to Creation Status : ' ||
                                x_create_cust_site_rec_type.x_ret_code);
                      mo_global.set_policy_context('S', l_org_id);
                    EXCEPTION
                      WHEN OTHERS THEN
                        x_return_status  := gc_error;
                        x_return_message := 'Unhandled Exception while creating Deliver To Site : ' ||
                                            SQLERRM;
                        log_error(x_return_message);
                    END;
                    IF x_create_cust_site_rec_type.x_ret_code <>
                       fnd_api.g_ret_sts_success THEN
                      log_debug('There might be some issue in Deliver to Creation/Match');
                      log_debug('Global Deliver To Creation error ' ||
                                x_create_cust_site_rec_type.x_processing_status);
                      x_return_message := x_create_cust_site_rec_type.x_ret_message;
                      log_debug(x_return_message);
                      gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT + 1).attribute_name := 'ATTRIBUTE19';
                      gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := 'ERROR';
                    ELSE
                      -- Set the Deliver To address in Attribute18
                      l_delv_attr_added := 'N';
                      FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                               .g_order_add_attr_line_tbl_l.COUNT LOOP
                        IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                         .attribute_name = 'ATTRIBUTE18' THEN
                          --gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value := x_cust_site_use_rec.cust_acct_site_id;
                          gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value := l_deliver_to_org_id || '~' ||
                                                                                                                                                             x_cust_site_use_rec.site_use_id;
                          l_delv_attr_added := 'Y';
                          gv_poo := 'Order Line DFF Deliver to Site ID' ||
                                    x_cust_site_use_rec.cust_acct_site_id || '-' ||
                                    x_cust_site_use_rec.site_use_id ||
                                    'Added to Attribute 18';
                          log_debug(gv_procedure_name || '.' || gv_poo);
                        END IF;
                      END LOOP;
                      IF l_delv_attr_added = 'N' THEN
                        gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT + 1).attribute_name := 'ATTRIBUTE18';
                        --gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := x_cust_site_use_rec.cust_acct_site_id;
                        gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := l_deliver_to_org_id || '~' ||
                                                                                                                                                                                                                                                      x_cust_site_use_rec.site_use_id;
                        gv_poo := 'Deliver to Site ID' ||
                                  x_cust_site_use_rec.site_use_id ||
                                  'Added to Attribute 18';
                        log_debug(gv_procedure_name || '.' || gv_poo);
                      END IF;
                    END IF;
                  END IF;
                END IF;
                FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                         .g_order_add_attr_line_tbl_l.COUNT LOOP
                  IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                   .attribute_name = 'ATTRIBUTE3' THEN
                    gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value := l_factory_desc;
                  END IF;
                END LOOP;
              EXCEPTION
                WHEN OTHERS THEN
                  log_debug('Exception in Deliver to Site Creation: No matching Quick-code',
                            XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
                  l_delv_attr_added := 'N';
                  FOR l_attr_count IN 1 .. gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt)
                                           .g_order_add_attr_line_tbl_l.COUNT LOOP
                    IF gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count)
                     .attribute_name = 'ATTRIBUTE19' THEN
                      gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(l_attr_count).attribute_value := x_cust_site_use_rec.cust_acct_site_id;
                      l_delv_attr_added := 'Y';
                    END IF;
                  END LOOP;
                  IF l_delv_attr_added = 'N' THEN
                    gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT + 1).attribute_name := 'ATTRIBUTE19';
                    gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l(gv_sales_order_header_tbl(l_ord_count).g_sales_order_line_tbl(ol_cnt).g_order_add_attr_line_tbl_l.COUNT).attribute_value := 'ERROR';
                  END IF;
              END;
            END LOOP;
            --Remove Ship Method once the Ship Method is copied to GLOBAL_ATTRIBUTE8
            IF NVL(l_shipmethod_attr, 'X') = 'X' THEN
              gv_sales_order_header_tbl(l_ord_count).g_sales_order_hdr_main_rec.shipping_method := NULL;
              log_debug('Ship Method Removed from Order Header');
            END IF;
          END;
        ELSE
          x_return_message := 'Bill to information is Mandatory';
          x_return_status  := gc_error;
        END IF;
        -- Check for Employee Number of SalesPerson
      -- SO Line Number validation
      END LOOP;
    END IF;
    IF gv_line_tag_valid = 'N' THEN
      x_return_message := 'Line Tagging Information is invalid. Please review the log file for details';
      log_error(x_return_message);
      x_return_status := gc_error;
    END IF;
    log_debug(gv_procedure_name || '.' || ' Completed');
    -- end of sales order validations
  EXCEPTION
    WHEN OTHERS THEN
      log_debug(gv_procedure_name || '.' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      x_return_status  := gc_error;
      x_return_message := gv_procedure_name || '.' || gv_poo || '.' ||
                          SQLERRM;
  END validate_sales_order_info;

  PROCEDURE generate_event_xml(x_return_status  out varchar2,
                               x_return_message out varchar2) IS
    l_event_count      number := 0;
    lv_api_return_type xxint_event_api_pub.gt_event_api_type;
    l_event_num        number := 10;
  begin
    log_debug('Event Rec Count : ' || g_proj_event_data_rec.count);
    if g_proj_event_data_rec.count > 0 THEN
      begin
        select nvl(max(event_num) + 10 - mod(max(event_num), 10), 10) --nvl(max(event_num), 10) --Modified for HPQC30256
          into l_event_num
          from pa_events pe, pa_projects_all ppa
         where ppa.segment1 = gv_project_num
           and pe.project_id = ppa.project_id;
      exception
        when others then
          l_event_num := 10;
      end;
      log_debug('Event Number : ' || l_event_num);
      ---------------------------------------------------------------
      --generate the sender tags
      ---------------------------------------------------------------
      for i in g_proj_event_data_rec.first .. g_proj_event_data_rec.last loop
        if g_proj_event_data_rec(i).p_create_event_flag = 'Y' THEN
          if l_event_count = 0 then
            gv_xxpa2672_payload := to_clob('<EBS_PROJECT_BILLING_REQUEST>');
            dbms_lob.append(gv_xxpa2672_payload, '<CONTROL_AREA>');
            dbms_lob.append(gv_xxpa2672_payload,
                            '<PARTNER_CODE>' || gv_source_system ||
                            '</PARTNER_CODE>');
            dbms_lob.append(gv_xxpa2672_payload,
                            '<INSTANCE_NAME>' || gv_instance_name ||
                            '</INSTANCE_NAME>');
            dbms_lob.append(gv_xxpa2672_payload,
                            '<REQUEST_TYPE>' || gv_REQUEST_TYPE ||
                            '</REQUEST_TYPE>');
            dbms_lob.append(gv_xxpa2672_payload,
                            '<EXTERNAL_MESSAGE_ID>' || gv_source_reference ||
                            '</EXTERNAL_MESSAGE_ID>');
            dbms_lob.append(gv_xxpa2672_payload, '</CONTROL_AREA>');
            dbms_lob.append(gv_xxpa2672_payload, '<DATA_AREA>');
            dbms_lob.append(gv_xxpa2672_payload, '<G_PA_BILLING_EVENT>');
            l_event_count := 1;
          end if;
          log_debug('Event Number : ' || l_event_num);
          dbms_lob.append(gv_xxpa2672_payload, '<PA_BILLING_EVENT>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PM_EVENT_REFERENCE>' || g_proj_event_data_rec(i)
                          .P_PM_EVENT_REFERENCE || '</P_PM_EVENT_REFERENCE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_TASK_NUMBER>' || g_proj_event_data_rec(i)
                          .P_TASK_NUMBER || '</P_TASK_NUMBER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EVENT_NUMBER>' || l_event_num ||
                          '</P_EVENT_NUMBER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EVENT_TYPE>' || g_proj_event_data_rec(i)
                          .P_EVENT_TYPE || '</P_EVENT_TYPE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_AGREEMENT_NUMBER>' || g_proj_event_data_rec(i)
                          .P_AGREEMENT_NUMBER || '</P_AGREEMENT_NUMBER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_AGREEMENT_TYPE>' || g_proj_event_data_rec(i)
                          .P_AGREEMENT_TYPE || '</P_AGREEMENT_TYPE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_CUSTOMER_NUMBER>' || g_proj_event_data_rec(i)
                          .P_CUSTOMER_NUMBER || '</P_CUSTOMER_NUMBER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_DESCRIPTION>' || g_proj_event_data_rec(i)
                          .P_DESCRIPTION || '</P_DESCRIPTION>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_BILL_HOLD_FLAG>' || g_proj_event_data_rec(i)
                          .P_BILL_HOLD_FLAG || '</P_BILL_HOLD_FLAG>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_COMPLETION_DATE>' || g_proj_event_data_rec(i)
                          .P_COMPLETION_DATE || '</P_COMPLETION_DATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_DESC_FLEX_NAME>' || g_proj_event_data_rec(i)
                          .P_DESC_FLEX_NAME || '</P_DESC_FLEX_NAME>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE_CATEGORY>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE_CATEGORY || '</P_ATTRIBUTE_CATEGORY>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE1>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE1 || '</P_ATTRIBUTE1>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE2>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE2 || '</P_ATTRIBUTE2>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE3>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE3 || '</P_ATTRIBUTE3>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE4>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE4 || '</P_ATTRIBUTE4>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE5>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE5 || '</P_ATTRIBUTE5>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE6>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE6 || '</P_ATTRIBUTE6>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE7>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE7 || '</P_ATTRIBUTE7>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE8>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE8 || '</P_ATTRIBUTE8>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE9>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE9 || '</P_ATTRIBUTE9>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ATTRIBUTE10>' || g_proj_event_data_rec(i)
                          .P_ATTRIBUTE10 || '</P_ATTRIBUTE10>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJECT_NUMBER>' || g_proj_event_data_rec(i)
                          .P_PROJECT_NUMBER || '</P_PROJECT_NUMBER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ORGANIZATION_NAME>' || g_proj_event_data_rec(i)
                          .P_ORGANIZATION_NAME || '</P_ORGANIZATION_NAME>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_INVENTORY_ORG_NAME>' || g_proj_event_data_rec(i)
                          .P_INVENTORY_ORG_NAME || '</P_INVENTORY_ORG_NAME>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_INVENTORY_ITEM_ID>' || g_proj_event_data_rec(i)
                          .P_INVENTORY_ITEM_ID || '</P_INVENTORY_ITEM_ID>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_QUANTITY_BILLED>' || g_proj_event_data_rec(i)
                          .P_QUANTITY_BILLED || '</P_QUANTITY_BILLED>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_UOM_CODE>' || g_proj_event_data_rec(i)
                          .P_UOM_CODE || '</P_UOM_CODE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_UNIT_PRICE>' || g_proj_event_data_rec(i)
                          .P_UNIT_PRICE || '</P_UNIT_PRICE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE1>' || g_proj_event_data_rec(i)
                          .P_REFERENCE1 || '</P_REFERENCE1>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE2>' || g_proj_event_data_rec(i)
                          .P_REFERENCE2 || '</P_REFERENCE2>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE3>' || g_proj_event_data_rec(i)
                          .P_REFERENCE3 || '</P_REFERENCE3>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE4>' || g_proj_event_data_rec(i)
                          .P_REFERENCE4 || '</P_REFERENCE4>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE5>' || g_proj_event_data_rec(i)
                          .P_REFERENCE5 || '</P_REFERENCE5>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE6>' || g_proj_event_data_rec(i)
                          .P_REFERENCE6 || '</P_REFERENCE6>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE7>' || g_proj_event_data_rec(i)
                          .P_REFERENCE7 || '</P_REFERENCE7>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE8>' || g_proj_event_data_rec(i)
                          .P_REFERENCE8 || '</P_REFERENCE8>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE9>' || g_proj_event_data_rec(i)
                          .P_REFERENCE9 || '</P_REFERENCE9>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REFERENCE10>' || g_proj_event_data_rec(i)
                          .P_REFERENCE10 || '</P_REFERENCE10>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_BILL_TRANS_CURRENCY_CODE>' || g_proj_event_data_rec(i)
                          .P_BILL_TRANS_CURRENCY_CODE ||
                           '</P_BILL_TRANS_CURRENCY_CODE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_BILL_TRANS_BILL_AMOUNT>' || g_proj_event_data_rec(i)
                          .P_BILL_TRANS_BILL_AMOUNT ||
                           '</P_BILL_TRANS_BILL_AMOUNT>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_BILL_TRANS_REV_AMOUNT>' || g_proj_event_data_rec(i)
                          .P_BILL_TRANS_REV_AMOUNT ||
                           '</P_BILL_TRANS_REV_AMOUNT>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJECT_RATE_TYPE>' || g_proj_event_data_rec(i)
                          .P_PROJECT_RATE_TYPE || '</P_PROJECT_RATE_TYPE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJECT_RATE_DATE>' || g_proj_event_data_rec(i)
                          .P_PROJECT_RATE_DATE || '</P_PROJECT_RATE_DATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJECT_EXCHANGE_RATE>' || g_proj_event_data_rec(i)
                          .P_PROJECT_EXCHANGE_RATE ||
                           '</P_PROJECT_EXCHANGE_RATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJFUNC_RATE_TYPE>' || g_proj_event_data_rec(i)
                          .P_PROJFUNC_RATE_TYPE || '</P_PROJFUNC_RATE_TYPE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJFUNC_RATE_DATE>' || g_proj_event_data_rec(i)
                          .P_PROJFUNC_RATE_DATE || '</P_PROJFUNC_RATE_DATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROJFUNC_EXCHANGE_RATE>' || g_proj_event_data_rec(i)
                          .P_PROJFUNC_EXCHANGE_RATE ||
                           '</P_PROJFUNC_EXCHANGE_RATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_FUNDING_RATE_TYPE>' || g_proj_event_data_rec(i)
                          .P_FUNDING_RATE_TYPE || '</P_FUNDING_RATE_TYPE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_FUNDING_RATE_DATE>' || g_proj_event_data_rec(i)
                          .P_FUNDING_RATE_DATE || '</P_FUNDING_RATE_DATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_FUNDING_EXCHANGE_RATE>' || g_proj_event_data_rec(i)
                          .P_FUNDING_EXCHANGE_RATE ||
                           '</P_FUNDING_EXCHANGE_RATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ADJUSTING_REVENUE_FLAG>' || g_proj_event_data_rec(i)
                          .P_ADJUSTING_REVENUE_FLAG ||
                           '</P_ADJUSTING_REVENUE_FLAG>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EVENT_ID>' || g_proj_event_data_rec(i)
                          .P_EVENT_ID || '</P_EVENT_ID>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_DELIVERABLE_ID>' || g_proj_event_data_rec(i)
                          .P_DELIVERABLE_ID || '</P_DELIVERABLE_ID>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_ACTION_ID>' || g_proj_event_data_rec(i)
                          .P_ACTION_ID || '</P_ACTION_ID>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_CONTEXT>' || g_proj_event_data_rec(i)
                          .P_CONTEXT || '</P_CONTEXT>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_RECORD_VERSION_NUMBER>' || g_proj_event_data_rec(i)
                          .P_RECORD_VERSION_NUMBER ||
                           '</P_RECORD_VERSION_NUMBER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_BILL_GROUP>' || g_proj_event_data_rec(i)
                          .P_BILL_GROUP || '</P_BILL_GROUP>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_REVENUE_HOLD_FLAG>' || g_proj_event_data_rec(i)
                          .P_REVENUE_HOLD_FLAG || '</P_REVENUE_HOLD_FLAG>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_HEADER_NOTES>' || g_proj_event_data_rec(i)
                          .P_HEADER_NOTES || '</P_HEADER_NOTES>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_SHIP_TO_CUSTOMER>' || g_proj_event_data_rec(i)
                          .P_SHIP_TO_CUSTOMER || '</P_SHIP_TO_CUSTOMER>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_SHIP_TO_ADDRESS_ID>' || g_proj_event_data_rec(i)
                          .P_SHIP_TO_ADDRESS_ID || '</P_SHIP_TO_ADDRESS_ID>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_SHIP_TO_ADDRESS_1>' || g_proj_event_data_rec(i)
                          .P_SHIP_TO_ADDRESS_1 || '</P_SHIP_TO_ADDRESS_1>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_SHIP_TO_ADDRESS_2>' || g_proj_event_data_rec(i)
                          .P_SHIP_TO_ADDRESS_2 || '</P_SHIP_TO_ADDRESS_2>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_SHIP_TO_ADDRESS_3>' || g_proj_event_data_rec(i)
                          .P_SHIP_TO_ADDRESS_3 || '</P_SHIP_TO_ADDRESS_3>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_SHIP_TO_ADDRESS_4>' || g_proj_event_data_rec(i)
                          .P_SHIP_TO_ADDRESS_4 || '</P_SHIP_TO_ADDRESS_4>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_CITY>' || g_proj_event_data_rec(i).P_CITY ||
                          '</P_CITY>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_STATE>' || g_proj_event_data_rec(i).P_STATE ||
                          '</P_STATE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_COUNTY>' || g_proj_event_data_rec(i).P_COUNTY ||
                          '</P_COUNTY>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_PROVINCE>' || g_proj_event_data_rec(i)
                          .P_PROVINCE || '</P_PROVINCE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_POSTAL_CODE>' || g_proj_event_data_rec(i)
                          .P_POSTAL_CODE || '</P_POSTAL_CODE>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_COUNTRY>' || g_proj_event_data_rec(i)
                          .P_COUNTRY || '</P_COUNTRY>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE1>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE1 || '</P_EXT_ATTRIBUTE1>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE2>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE2 || '</P_EXT_ATTRIBUTE2>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE3>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE3 || '</P_EXT_ATTRIBUTE3>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE4>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE4 || '</P_EXT_ATTRIBUTE4>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE5>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE5 || '</P_EXT_ATTRIBUTE5>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE6>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE6 || '</P_EXT_ATTRIBUTE6>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE7>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE7 || '</P_EXT_ATTRIBUTE7>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE8>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE8 || '</P_EXT_ATTRIBUTE8>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE9>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE9 || '</P_EXT_ATTRIBUTE9>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE10>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE10 || '</P_EXT_ATTRIBUTE10>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE11>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE11 || '</P_EXT_ATTRIBUTE11>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE12>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE12 || '</P_EXT_ATTRIBUTE12>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE13>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE13 || '</P_EXT_ATTRIBUTE13>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE14>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE14 || '</P_EXT_ATTRIBUTE14>');
          dbms_lob.append(gv_xxpa2672_payload,
                          '<P_EXT_ATTRIBUTE15>' || g_proj_event_data_rec(i)
                          .P_EXT_ATTRIBUTE15 || '</P_EXT_ATTRIBUTE15>');
          dbms_lob.append(gv_xxpa2672_payload, '</PA_BILLING_EVENT>');
          l_event_num := l_event_num + 10;
        end if;
      end loop;
      if l_event_count = 1 then

        dbms_lob.append(gv_xxpa2672_payload, '</G_PA_BILLING_EVENT>');
        dbms_lob.append(gv_xxpa2672_payload, '</DATA_AREA>');
        dbms_lob.append(gv_xxpa2672_payload,
                        '</EBS_PROJECT_BILLING_REQUEST>');

        BEGIN
          SELECT (deletexml(xmltype(gv_xxpa2672_payload), '//*[not(node())]'))
                 .getClobVal()
            INTO gv_xxpa2672_payload
            FROM dual;
        EXCEPTION
          WHEN OTHERS THEN
            log_debug('Exception while removing Empty Tags in 2381 CLOB :' ||
                      SUBSTR(SQLERRM, 1, 200),
                      XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
          --        NULL;
        END;

        xxint_event_api_pub.create_event(x_api_return_type   => lv_api_return_type,
                                         p_event_type        => gc_prj_ev_event_type,
                                         p_content_clob      => gv_xxpa2672_payload,
                                         p_content_clob_code => 'HTTP_RECEIVE_XML_PAYLOAD_IN');

        gv_bill_event_guid := lv_api_return_type.guid;
        xxint_event_api_pub.replace_clob(gv_guid,
                                         gc_proj_event_guid_clob_code,
                                         to_clob(gv_bill_event_guid));
        log_debug('Event GUID : ' || lv_api_return_type.guid);
      end if;
    end if;

  end generate_event_xml;

  /*
  ** Procedure Name  : generate_project_xml
  **
  ** Purpose:  For generating the XML for XXPA2381
  **
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------            ----------------   ----------------------------------------
  ** 17-Jun-15       Joydeb Saha   Created new
  */
  PROCEDURE generate_project_xml(x_return_status  OUT VARCHAR2,
                                 x_return_message OUT VARCHAR2) IS
    l_budget_count      NUMBER := 0;
    l_budget_line_count NUMBER := 0;
    l_agreement_count   NUMBER := 0;
    l_funding_level     VARCHAR2(20);
    l_amount_allocated  NUMBER := 0;
    l_att_count         NUMBER := 0;
    lv_agr_attribute1   pa_agreements_all.attribute1%TYPE; -- Added for CR24090
    lv_agr_attribute2   pa_agreements_all.attribute2%TYPE; -- Added for CR24090
  BEGIN
    gv_procedure_name := 'generate_project_xml';
    gv_poo            := 'Start';
    log_debug(gv_procedure_name || '.' || gv_poo);
    x_return_status        := 'SUCCESS';
    gv_poo                 := 'START SENDER TAG';
    gv_project_status_code := xxint_event_type_utils.get_key_parm_value(p_event_type     => gc_event_type,
                                                                        p_key_type       => gc_key_type,
                                                                        p_key_type_value => gv_source_system,
                                                                        p_name           => gc_project_status_code);
    log_debug('In Generate Project XML');
    log_debug('Agreement Table Count : ' || gv_agr_tbl.COUNT);
    gv_xxpa2381_payload := '<G_XXPA2381_INT>';
    ---------------------------------------------------------------
    --generate the sender tags
    ---------------------------------------------------------------
    dbms_lob.append(gv_xxpa2381_payload, '<SENDER>');
    dbms_lob.append(gv_xxpa2381_payload,
                    '<ID>' || gv_source_system || '</ID>');
    dbms_lob.append(gv_xxpa2381_payload,
                    '<REFERENCE>' || gv_source_reference || '</REFERENCE>');
    dbms_lob.append(gv_xxpa2381_payload, '</SENDER>');
    ----------------------------------------------------------------
    --Open the Agreement loop
    ---------------------------------------------------------------
    FOR i_agr IN 1 .. gv_agr_tbl.COUNT LOOP
      gv_poo := 'START GENERATING AGREEMENT TAGS';
      log_debug('Customer Number : ' || gv_agr_tbl(i_agr)
                .agr_main_rec.customer_num);
      --Agreement Group Tags
      IF (i_agr = 1) THEN
        dbms_lob.append(gv_xxpa2381_payload, '<G_PA_AGREEMENTS_ALL>');
      END IF;
      dbms_lob.append(gv_xxpa2381_payload, '<PA_AGREEMENTS_ALL>');
      --Agreement main record tags
      dbms_lob.append(gv_xxpa2381_payload,
                      '<PM_AGREEMENT_REFERENCE>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.pm_agreement_reference,
                                          0) || '</PM_AGREEMENT_REFERENCE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<CUSTOMER_ID>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.customer_id || '</CUSTOMER_ID>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<CUSTOMER_NUM>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.customer_num || '</CUSTOMER_NUM>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<AGREEMENT_NUM>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.agreement_num,
                                          0) || '</AGREEMENT_NUM>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<AGREEMENT_TYPE>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.agreement_type || '</AGREEMENT_TYPE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<AMOUNT>' || gv_agr_tbl(i_agr).agr_main_rec.amount ||
                      '</AMOUNT>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<TERM_ID>' || gv_agr_tbl(i_agr).agr_main_rec.term_id ||
                      '</TERM_ID>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<EXPIRATION_DATE>' ||
                      TO_CHAR(gv_agr_tbl(i_agr).agr_main_rec.expiration_date,
                              'DD-MON-YYYY') || '</EXPIRATION_DATE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<DESCRIPTION>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.description,
                                          0) || '</DESCRIPTION>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<OWNED_BY_PERSON_ID>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.owned_by_person_id ||
                       '</OWNED_BY_PERSON_ID>');
      --dbms_lob.append(gv_xxpa2381_payload, '<DESC_FLEX_NAME>' ||gv_agr_tbl(i_agr).agr_main_rec.desc_flex_name ||'</DESC_FLEX_NAME>'||chr(10);
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE_CATEGORY>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.attribute_category ||
                       '</ATTRIBUTE_CATEGORY>');
      --Start: Added for CR24090
      IF gv_agr_tbl(i_agr).agr_main_rec.attribute1 IS NOT NULL THEN
        lv_agr_attribute1 := gv_agr_tbl(i_agr).agr_main_rec.attribute1;
      ELSE
        BEGIN
          select fv.attribute4
            into lv_agr_attribute1
            from fnd_lookup_Values fv, hr_operating_units ou
           where ou.organization_id = gv_operating_unit
             and fv.lookup_type = 'XXPA2078_OU_DETAILS'
             and fv.language = 'US'
             and fv.enabled_flag = 'Y'
			 AND SYSDATE BETWEEN fv.start_date_active AND nvl(fv.end_date_active,SYSDATE)  --Added for SEP-4548 Separation Activity
             and ou.short_code = fv.lookup_code;

        EXCEPTION
          WHEN OTHERS THEN
            lv_agr_attribute1 := NULL;
        END;

      END IF;

      IF gv_agr_tbl(i_agr).agr_main_rec.attribute2 IS NOT NULL THEN
        lv_agr_attribute2 := gv_agr_tbl(i_agr).agr_main_rec.attribute2;
      ELSE
        BEGIN
          select fv.attribute5
            into lv_agr_attribute2
            from fnd_lookup_Values fv, hr_operating_units ou
           where ou.organization_id = gv_operating_unit
             and fv.lookup_type = 'XXPA2078_OU_DETAILS'
             and fv.language = 'US'
             and fv.enabled_flag = 'Y'
			 AND SYSDATE BETWEEN fv.start_date_active AND nvl(fv.end_date_active,SYSDATE)  --Added for SEP-4548 Separation Activity
             and ou.short_code = fv.lookup_code;

        EXCEPTION
          WHEN OTHERS THEN
            lv_agr_attribute2 := NULL;
        END;

      END IF;
      -- End: Added for CR24090
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE1>' ||
                      dbms_xmlgen.convert(lv_agr_attribute1) ||
                      '</ATTRIBUTE1>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE2>' ||
                      dbms_xmlgen.convert(lv_agr_attribute2) ||
                      '</ATTRIBUTE2>');

      --      dbms_lob.append(gv_xxpa2381_payload,
      --                      '<ATTRIBUTE1>' ||
      --                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
      --                                          .agr_main_rec.attribute1,
      --                                          0) || '</ATTRIBUTE1>');
      --      dbms_lob.append(gv_xxpa2381_payload,
      --                      '<ATTRIBUTE2>' ||
      --                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
      --                                          .agr_main_rec.attribute2,
      --                                          0) || '</ATTRIBUTE2>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE3>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute3,
                                          0) || '</ATTRIBUTE3>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE4>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute4,
                                          0) || '</ATTRIBUTE4>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE5>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute5,
                                          0) || '</ATTRIBUTE5>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE6>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute6,
                                          0) || '</ATTRIBUTE6>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE7>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute7,
                                          0) || '</ATTRIBUTE7>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE8>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute8,
                                          0) || '</ATTRIBUTE8>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE9>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute9,
                                          0) || '</ATTRIBUTE9>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE10>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute10,
                                          0) || '</ATTRIBUTE10>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<OWNING_ORGANIZATION_ID>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.owning_organization_id ||
                       '</OWNING_ORGANIZATION_ID>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<AGREEMENT_CURRENCY_CODE>' || gv_agr_tbl(i_agr)
                      .agr_main_rec.agreement_currency_code ||
                       '</AGREEMENT_CURRENCY_CODE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<CUSTOMER_ORDER_NUMBER>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.customer_order_number,
                                          0) || '</CUSTOMER_ORDER_NUMBER>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<START_DATE>' ||
                      TO_CHAR(gv_agr_tbl(i_agr).agr_main_rec.start_date,
                              'DD-MON-YYYY') || '</START_DATE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE11>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute11,
                                          0) || '</ATTRIBUTE11>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE12>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute12,
                                          0) || '</ATTRIBUTE12>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE13>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute13,
                                          0) || '</ATTRIBUTE13>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE14>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute14,
                                          0) || '</ATTRIBUTE14>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE15>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute15,
                                          0) || '</ATTRIBUTE15>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE16>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute16,
                                          0) || '</ATTRIBUTE16>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE17>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute17,
                                          0) || '</ATTRIBUTE17>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE18>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute18,
                                          0) || '</ATTRIBUTE18>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE19>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute19,
                                          0) || '</ATTRIBUTE19>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE20>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute20,
                                          0) || '</ATTRIBUTE20>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE21>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute21,
                                          0) || '</ATTRIBUTE21>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE22>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute22,
                                          0) || '</ATTRIBUTE22>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE23>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute23,
                                          0) || '</ATTRIBUTE23>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE24>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute24,
                                          0) || '</ATTRIBUTE24>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<ATTRIBUTE25>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_main_rec.attribute25,
                                          0) || '</ATTRIBUTE25>');
      --Agreement extra record tags
      dbms_lob.append(gv_xxpa2381_payload,
                      '<PM_PRODUCT_CODE>' || gv_agr_tbl(i_agr)
                      .agr_extra_rec.pm_product_code || '</PM_PRODUCT_CODE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<TERM_NAME>' || gv_agr_tbl(i_agr)
                      .agr_extra_rec.term_name || '</TERM_NAME>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<OWNED_BY_PERSON_NUMBER>' || gv_agr_tbl(i_agr)
                      .agr_extra_rec.owned_by_person_number ||
                       '</OWNED_BY_PERSON_NUMBER>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<OWNER_EBS_USER_NAME>' || gv_agr_tbl(i_agr)
                      .agr_extra_rec.ebs_user_name ||
                       '</OWNER_EBS_USER_NAME>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<OWNING_ORGANIZATION_CODE>' || gv_agr_tbl(i_agr)
                      .agr_extra_rec.owning_organization_code ||
                       '</OWNING_ORGANIZATION_CODE>');
      dbms_lob.append(gv_xxpa2381_payload,
                      '<OWNING_ORGANIZATION_NAME>' ||
                      dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                          .agr_extra_rec.owning_organization_name,
                                          0) ||
                      '</OWNING_ORGANIZATION_NAME>');
      SELECT COUNT(1)
        INTO l_agreement_count
        FROM apps.pa_agreements_all
       WHERE agreement_num = gv_agr_tbl(i_agr).agr_main_rec.agreement_num;
      IF l_agreement_count > 0 THEN
        dbms_lob.append(gv_xxpa2381_payload,
                        '<UPDATE_AGREEMENT_ALLOWED>Y</UPDATE_AGREEMENT_ALLOWED>');
      ELSE
        dbms_lob.append(gv_xxpa2381_payload,
                        '<UPDATE_AGREEMENT_ALLOWED>' || gv_agr_tbl(i_agr)
                        .agr_extra_rec.update_agreement_allowed ||
                         '</UPDATE_AGREEMENT_ALLOWED>');
      END IF;
      --Added for CR24105
      l_att_count := 0;
      if g_prj_att_tbl.count > 0 then

        for i in g_prj_att_tbl.first .. g_prj_att_tbl.last loop

          if g_prj_att_tbl(i).agreement_num is not null then
            if l_att_count = 0 then
              l_att_count := 1;
              dbms_lob.append(gv_xxpa2381_payload, '<G_ATTACHMENT>');
            end if;
            dbms_lob.append(gv_xxpa2381_payload, '<ATTACHMENTS>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<noteType>' || dbms_xmlgen.convert(g_prj_att_tbl(i).noteType,0) ||
                            '</noteType>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<notes>' || dbms_xmlgen.convert(g_prj_att_tbl(i).notes,0) ||
                            '</notes>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<entityName>' || dbms_xmlgen.convert(g_prj_att_tbl(i).entityName,0) ||
                            '</entityName>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<seqNumber>' || g_prj_att_tbl(i).seqNumber ||
                            '</seqNumber>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<title>' || dbms_xmlgen.convert(g_prj_att_tbl(i).title,0) ||
                            '</title>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<description>' || dbms_xmlgen.convert(g_prj_att_tbl(i).description,0) ||
                            '</description>');
            --            dbms_lob.append(gv_xxpa2381_payload,'<agreement_num>'||g_prj_att_tbl(i).agreement_num||'<agreement_num>');
            --            dbms_lob.append(gv_xxpa2381_payload,'<project_num>'||g_prj_att_tbl(i).project_num||'<project_num>');
            --            dbms_lob.append(gv_xxpa2381_payload,'<task_num>'||g_prj_att_tbl(i).task_num||'<task_num>');
            dbms_lob.append(gv_xxpa2381_payload, '</ATTACHMENTS>');
          end if;
        end loop;
        if l_att_count = 1 then
          l_att_count := 0;
          dbms_lob.append(gv_xxpa2381_payload, '</G_ATTACHMENT>');
        end if;
      end if;
      --End of CR24105
      ----------------------------------
      --Need to check the logic for G_SRC_ATTRIBUTES tag
      ----------------------------------
      -----------------------------------
      --Open the Project loop
      ----------------------------------
      FOR i_prj IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl.COUNT LOOP
        gv_poo := 'START GENERATING PROJECT TAGS';
        --Project Group Tags
        IF (i_prj = 1) THEN
          IF gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
           .prj_extra_rec.proj_rev_version_name IS NOT NULL THEN
            dbms_lob.append(gv_xxpa2381_payload,
                            '<ATTRIBUTE10>' ||
                            dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                                .prj_extra_rec.proj_rev_version_name,
                                                0) || '</ATTRIBUTE10>');
          END IF;
          dbms_lob.append(gv_xxpa2381_payload, '<G_PA_PROJECTS_ALL>');
        END IF;
        dbms_lob.append(gv_xxpa2381_payload, '<PA_PROJECTS_ALL>');
        -- Project main record tags
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PM_PROJECT_REFERENCE>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.pm_project_reference,
                                            0) || '</PM_PROJECT_REFERENCE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PA_PROJECT_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.pa_project_number ||
                         '</PA_PROJECT_NUMBER>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PROJECT_NAME>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.project_name,
                                            0) || '</PROJECT_NAME>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<LONG_NAME>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.long_name,
                                            0) || '</LONG_NAME>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<CREATED_FROM_PROJECT_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.created_from_project_id ||
                         '</CREATED_FROM_PROJECT_ID>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<CARRYING_OUT_ORGANIZATION_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.carrying_out_organization_id ||
                         '</CARRYING_OUT_ORGANIZATION_ID>');
        IF TRUNC(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                 .prj_main_rec.project_status_code) IS NOT NULL THEN
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PROJECT_STATUS_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .prj_main_rec.project_status_code ||
                           '</PROJECT_STATUS_CODE>');
        ELSE
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PROJECT_STATUS_CODE>' ||
                          upper(gv_project_status_code) ||
                          '</PROJECT_STATUS_CODE>');
        END IF;
        dbms_lob.append(gv_xxpa2381_payload,
                        '<DESCRIPTION>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.description,
                                            0) || '</DESCRIPTION>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<START_DATE>' ||
                        TO_CHAR(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                .prj_main_rec.start_date,
                                'DD-MON-YYYY') || '</START_DATE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<COMPLETION_DATE>' ||
                        TO_CHAR(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                .prj_main_rec.completion_date,
                                'DD-MON-YYYY') || '</COMPLETION_DATE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<CUSTOMER_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.customer_id || '</CUSTOMER_ID>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PROJECT_RELATIONSHIP_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.project_relationship_code ||
                         '</PROJECT_RELATIONSHIP_CODE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE_CATEGORY>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.attribute_category ||
                         '</ATTRIBUTE_CATEGORY>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE1>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute1,
                                            0) || '</ATTRIBUTE1>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE2>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute2,
                                            0) || '</ATTRIBUTE2>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE3>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute3,
                                            0) || '</ATTRIBUTE3>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE4>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute4,
                                            0) || '</ATTRIBUTE4>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE5>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute5,
                                            0) || '</ATTRIBUTE5>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE6>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute6,
                                            0) || '</ATTRIBUTE6>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE7>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute7,
                                            0) || '</ATTRIBUTE7>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE8>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute8,
                                            0) || '</ATTRIBUTE8>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE9>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute9,
                                            0) || '</ATTRIBUTE9>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<ATTRIBUTE10>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_main_rec.attribute10,
                                            0) || '</ATTRIBUTE10>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PROJECT_CURRENCY_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.project_currency_code ||
                         '</PROJECT_CURRENCY_CODE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PROJECT_RATE_TYPE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.project_rate_type ||
                         '</PROJECT_RATE_TYPE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<BILL_TO_CUSTOMER_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.bill_to_customer_id ||
                         '</BILL_TO_CUSTOMER_ID>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<SHIP_TO_CUSTOMER_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.ship_to_customer_id ||
                         '</SHIP_TO_CUSTOMER_ID>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<BILL_TO_ADDRESS_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.bill_to_address_id ||
                         '</BILL_TO_ADDRESS_ID>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<SHIP_TO_ADDRESS_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_main_rec.ship_to_address_id ||
                         '</SHIP_TO_ADDRESS_ID>');
        -- Project extra record tags
        dbms_lob.append(gv_xxpa2381_payload,
                        '<TEMPLATE_NAME>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_extra_rec.template_name || '</TEMPLATE_NAME>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<TEMPLATE_NAME_ORACLE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_extra_rec.template_name_oracle ||
                         '</TEMPLATE_NAME_ORACLE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<CARRYING_OUT_ORGANIZATION_CODE>' ||
                        NVL(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                            .prj_extra_rec.carrying_out_organization_code,
                            gv_agr_tbl(i_agr)
                            .agr_extra_rec.owning_organization_code) ||
                        '</CARRYING_OUT_ORGANIZATION_CODE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<CARRYING_OUT_ORGANIZATION_NAME>' ||
                        dbms_xmlgen.convert(NVL(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                                .prj_extra_rec.carrying_out_organization_name,
                                                gv_agr_tbl(i_agr)
                                                .agr_extra_rec.owning_organization_name),
                                            0) ||
                        '</CARRYING_OUT_ORGANIZATION_NAME>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PROJECT_TYPE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_extra_rec.project_type || '</PROJECT_TYPE>');
        BEGIN
          select allowable_funding_level_code
            into l_funding_level
            from pa_project_types_all
           where project_type = gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                .prj_extra_rec.project_type
             and org_id = gv_operating_unit;
        exception
          when others then
            l_funding_level := 'T';
        END;
        dbms_lob.append(gv_xxpa2381_payload,
                        '<PROJECT_TYPE_ORACLE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                        .prj_extra_rec.project_type_oracle ||
                         '</PROJECT_TYPE_ORACLE>');
        dbms_lob.append(gv_xxpa2381_payload,
                        '<G_SRC_ATTRIBUTES><SRC_ATTRIBUTE><NAME>VERSION_NUMBER</NAME><VALUE>' ||
                        dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                            .prj_extra_rec.proj_rev_version_name,
                                            0) ||
                        '</VALUE></SRC_ATTRIBUTE></G_SRC_ATTRIBUTES>'); -- Modified by Joydeb as per RT7137886. The SRC_ATTRIBUTES is changed to SRC_ATTRIBUTE to keep it in sync with XXPA2381
        ----------------------------------
        --Need to check the logic for G_SRC_ATTRIBUTES tag
        ----------------------------------

        --Added for CR24105
        l_att_count := 0;
        if g_prj_att_tbl.count > 0 then
          for i in g_prj_att_tbl.first .. g_prj_att_tbl.last loop

            if g_prj_att_tbl(i).project_num is not null then
              if l_att_count = 0 then
                l_att_count := 1;
                dbms_lob.append(gv_xxpa2381_payload, '<G_ATTACHMENT>');
              end if;
              dbms_lob.append(gv_xxpa2381_payload, '<ATTACHMENTS>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<noteType>' ||  dbms_xmlgen.convert(g_prj_att_tbl(i).noteType,0) ||--Added DBMS_XMLGEN to handle special chars RT8572634
                              '</noteType>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<notes>' || dbms_xmlgen.convert(g_prj_att_tbl(i).notes,0) ||--Added DBMS_XMLGEN to handle special chars RT8572634
                              '</notes>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<entityName>' ||  dbms_xmlgen.convert(g_prj_att_tbl(i).entityName,0) ||--Added DBMS_XMLGEN to handle special chars RT8572634
                              '</entityName>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<seqNumber>' || g_prj_att_tbl(i).seqNumber ||
                              '</seqNumber>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<title>' ||  dbms_xmlgen.convert(g_prj_att_tbl(i).title,0) ||--Added DBMS_XMLGEN to handle special chars RT8572634
                              '</title>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<description>' ||  dbms_xmlgen.convert(g_prj_att_tbl(i)
                              .description,0) || '</description>');--Added DBMS_XMLGEN to handle special chars RT8572634
              --            dbms_lob.append(gv_xxpa2381_payload,'<agreement_num>'||g_prj_att_tbl(i).agreement_num||'<agreement_num>');
              --            dbms_lob.append(gv_xxpa2381_payload,'<project_num>'||g_prj_att_tbl(i).project_num||'<project_num>');
              --            dbms_lob.append(gv_xxpa2381_payload,'<task_num>'||g_prj_att_tbl(i).task_num||'<task_num>');
              dbms_lob.append(gv_xxpa2381_payload, '</ATTACHMENTS>');
            end if;
          end loop;
          if l_att_count = 1 then
            l_att_count := 0;
            dbms_lob.append(gv_xxpa2381_payload, '</G_ATTACHMENT>');
          end if;
        end if;
        --End of CR24105
        ---------------------------------
        --Open the customer loop
        --------------------------------
        FOR i_cust IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                           .g_prj_cust_rec.prj_cust_tbl.COUNT LOOP
          gv_poo := 'START GENERATING CUSTOMER TAGS';
          -- Customer Group Tags
          IF (i_cust = 1) THEN
            dbms_lob.append(gv_xxpa2381_payload,
                            '<G_PA_PROJECT_CUSTOMERS>');
          END IF;
          dbms_lob.append(gv_xxpa2381_payload, '<PA_PROJECT_CUSTOMERS>');
          -- Customer main record tags
          dbms_lob.append(gv_xxpa2381_payload,
                          '<CUSTOMER_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .customer_id || '</CUSTOMER_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PROJECT_RELATIONSHIP_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .project_relationship_code ||
                           '</PROJECT_RELATIONSHIP_CODE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_CUSTOMER_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .bill_to_customer_id || '</BILL_TO_CUSTOMER_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_CUSTOMER_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .ship_to_customer_id || '</SHIP_TO_CUSTOMER_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_ADDRESS_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .bill_to_address_id || '</BILL_TO_ADDRESS_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_ADDRESS_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .ship_to_address_id || '</SHIP_TO_ADDRESS_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<CUSTOMER_BILL_SPLIT>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .customer_bill_split || '</CUSTOMER_BILL_SPLIT>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<INV_RATE_TYPE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .inv_rate_type || '</INV_RATE_TYPE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<INV_CURRENCY_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .inv_currency_code || '</INV_CURRENCY_CODE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<INV_EXCHANGE_RATE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_cust_rec.prj_cust_tbl(i_cust)
                          .inv_exchange_rate || '</INV_EXCHANGE_RATE>');
          -- Customer extra record tags
          dbms_lob.append(gv_xxpa2381_payload,
                          '<CUSTOMER_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.customer_number ||
                           '</CUSTOMER_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_CUSTOMER_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.bill_to_customer_number ||
                           '</BILL_TO_CUSTOMER_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_CUSTOMER_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.ship_to_customer_number ||
                           '</SHIP_TO_CUSTOMER_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_ADDRESS_1>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.ship_to_address_1,
                                              0) || '</SHIP_TO_ADDRESS_1>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_ADDRESS_2>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.ship_to_address_2,
                                              0) || '</SHIP_TO_ADDRESS_2>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_ADDRESS_3>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.ship_to_address_3,
                                              0) || '</SHIP_TO_ADDRESS_3>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_ADDRESS_4>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.ship_to_address_4,
                                              0) || '</SHIP_TO_ADDRESS_4>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<CITY>' || dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                                          .g_prj_cust_rec.prj_cust_extra.city,
                                                          0) || '</CITY>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<STATE>' || dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                                           .g_prj_cust_rec.prj_cust_extra.state,
                                                           0) || '</STATE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<COUNTY>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.county,
                                              0) || '</COUNTY>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PROVINCE>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.province,
                                              0) || '</PROVINCE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<POSTAL_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.postal_code ||
                           '</POSTAL_CODE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<COUNTRY>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                              .g_prj_cust_rec.prj_cust_extra.country,
                                              0) || '</COUNTRY>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_PARTY_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.ship_to_party_id ||
                           '</SHIP_TO_PARTY_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_PARTY_SITE_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.ship_to_party_site_id ||
                           '</SHIP_TO_PARTY_SITE_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_PARTY_SITE_USE_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.ship_to_party_site_use_id ||
                           '</SHIP_TO_PARTY_SITE_USE_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<SHIP_TO_PARTY_SITE_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.ship_to_party_site_number ||
                           '</SHIP_TO_PARTY_SITE_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_PARTY_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.bill_to_party_id ||
                           '</BILL_TO_PARTY_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_PARTY_SITE_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_id ||
                           '</BILL_TO_PARTY_SITE_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_PARTY_SITE_USE_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_use_id ||
                           '</BILL_TO_PARTY_SITE_USE_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILL_TO_PARTY_SITE_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.bill_to_party_site_number ||
                           '</BILL_TO_PARTY_SITE_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BUILDING_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_cust_rec.prj_cust_extra.building_id ||
                           '</BUILDING_ID>');
          ----------------------------------
          --Need to check the logic for G_SRC_ATTRIBUTES tag
          ----------------------------------
          -- Customer Group Tags
          dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECT_CUSTOMERS>');
          IF (i_cust = gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
             .g_prj_cust_rec.prj_cust_tbl.COUNT) THEN
            dbms_lob.append(gv_xxpa2381_payload,
                            '</G_PA_PROJECT_CUSTOMERS>');
          END IF;
        END LOOP; -- End of prj_cust_tbl loop
        ---------------------------------
        --Open the task loop
        --------------------------------
        FOR i_task IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                           .g_prj_task_rec.tasks_in_tbl.COUNT LOOP
          gv_poo := 'START GENERATING TASK TAGS';
          -- Task Group Tags
          IF (i_task = 1) THEN
            dbms_lob.append(gv_xxpa2381_payload, '<G_TASKS>');
          END IF;
          dbms_lob.append(gv_xxpa2381_payload, '<TASKS>');
          --Task main record tags
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PM_TASK_REFERENCE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
                          .pm_task_reference || '</PM_TASK_REFERENCE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<TASK_NAME>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
                                              .task_name,
                                              0) || '</TASK_NAME>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PA_TASK_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
                          .pa_task_number || '</PA_TASK_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<TASK_DESCRIPTION>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
                          .TASK_DESCRIPTION || '</TASK_DESCRIPTION>');

          dbms_lob.append(gv_xxpa2381_payload,
                          '<TASK_START_DATE>' ||
                          TO_CHAR(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                  .prj_main_rec.start_date,
                                  'DD-MON-YYYY') || '</TASK_START_DATE>');
          /*Modified and removed commented line for RT8658437 - XXPA2592 BOLTON TASK_END_DATE IS NULL FOR SPECTRUM_AP PARTNER START*/
		  dbms_lob.append(gv_xxpa2381_payload,
                          '<TASK_COMPLETION_DATE>' ||
                          TO_CHAR(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                  .prj_main_rec.completion_date,
                                  'DD-MON-YYYY') ||
                          '</TASK_COMPLETION_DATE>'); -- Commented for RT8548644
		  /*Modified and removed commented line for RT8658437 - XXPA2592 BOLTON TASK_END_DATE IS NULL FOR SPECTRUM_AP PARTNER END*/
          dbms_lob.append(gv_xxpa2381_payload,
                          '<ATTRIBUTE1>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
                                              .attribute1,
                                              0) || '</ATTRIBUTE1>');
          if gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
           .attribute8 is not null then
            dbms_lob.append(gv_xxpa2381_payload,
                            '<ATTRIBUTE9>' ||
                            dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(i_task)
                                                .attribute9,
                                                0) || '</ATTRIBUTE9>');
          end if;
          BEGIN
            SELECT b.flex_value
              INTO gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                   .prj_main_rec.project_status_code
              FROM apps.fnd_flex_value_sets a, FND_FLEX_VALUES_VL b
             WHERE flex_value_set_name = 'XXPA_TASK_STATUS'
               AND b.flex_value_set_id = a.flex_value_set_id
               AND b.enabled_flag = 'Y'
               AND sysdate BETWEEN start_date_active AND
                   NVL(end_date_active, sysdate + 1)
               AND upper(b.flex_value) =
                   upper(NVL(trim(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                  .prj_main_rec.project_status_code),
                             gv_project_status_code));
          EXCEPTION
            WHEN OTHERS THEN
              log_debug('Exception in Task Status : ' || SQLERRM,
                        XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
          END;
          dbms_lob.append(gv_xxpa2381_payload,
                          '<ATTRIBUTE8>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .prj_main_rec.project_status_code ||
                           '</ATTRIBUTE8>');
          -- Work type tag is missing in the xsd. So commented the below tag
          dbms_lob.append(gv_xxpa2381_payload,
                          '<WORK_TYPE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.g_prj_task_extra_tbl(i_task)
                          .work_type || '</WORK_TYPE>');
          ----------------------------------
          --Need to check the logic for G_SRC_ATTRIBUTES tag
          ----------------------------------
          -- Task Group Tags
          dbms_lob.append(gv_xxpa2381_payload,
                          '<BILLABLE_FLAG>Y</BILLABLE_FLAG><CHARGEABLE_FLAG>Y</CHARGEABLE_FLAG>');
          dbms_lob.append(gv_xxpa2381_payload, '</TASKS>');
          IF (i_task = gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
             .g_prj_task_rec.tasks_in_tbl.COUNT) THEN
            dbms_lob.append(gv_xxpa2381_payload, '</G_TASKS>');
          END IF;
        END LOOP; -- End of tasks_in_tbl loop
        ---------------------------------
        --Open the Project Players loop
        --------------------------------
        FOR i_prp IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                          .g_prj_player_rec.prj_player_main_tbl.COUNT LOOP
          gv_poo := 'START GENERATING PROJECT PLAYER TAGS';
          -- Project Player Group Tags
          IF (i_prp = 1) THEN
            dbms_lob.append(gv_xxpa2381_payload, '<G_PA_PROJECT_PLAYERS>');
          END IF;
          dbms_lob.append(gv_xxpa2381_payload, '<PA_PROJECT_PLAYERS>');
          -- Project player main record tags
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PERSON_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_main_tbl(i_prp)
                          .person_id || '</PERSON_ID>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PROJECT_ROLE_TYPE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_main_tbl(i_prp)
                          .project_role_type || '</PROJECT_ROLE_TYPE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PROJECT_ROLE_MEANING>' ||
                          dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_main_tbl(i_prp)
                                              .project_role_meaning,
                                              0) ||
                          '</PROJECT_ROLE_MEANING>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<START_DATE>' ||
                          TO_CHAR(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_main_tbl(i_prp)
                                  .start_date,
                                  'DD-MON-YYYY') || '</START_DATE>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<END_DATE>' ||
                          TO_CHAR(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_main_tbl(i_prp)
                                  .end_date,
                                  'DD-MON-YYYY') || '</END_DATE>');
          -- Project player extra record tags
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PRJ_PLAYER_EMP_NO>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_extra_tbl(i_prp)
                          .prj_player_emp_no || '</PRJ_PLAYER_EMP_NO>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<EBS_USER_NAME>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_player_rec.prj_player_extra_tbl(i_prp)
                          .ebs_user_name || '</EBS_USER_NAME>');
          ----------------------------------
          --Need to check the logic for G_SRC_ATTRIBUTES tag
          ----------------------------------
          -- Project Palyer Group Tags
          dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECT_PLAYERS>');
          IF (i_prp = gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
             .g_prj_player_rec.prj_player_main_tbl.COUNT) THEN
            dbms_lob.append(gv_xxpa2381_payload, '</G_PA_PROJECT_PLAYERS>');
          END IF;
        END LOOP; -- end of prj_player_main_tbl loop
        ---------------------------------
        --Open the Project Classes loop
        --------------------------------
        IF gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
         .g_class_categories_tbl.COUNT > 0 THEN
          FOR i_pcl IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                            .g_class_categories_tbl.COUNT LOOP
            gv_poo := 'START GENERATING PROJECT CLASSES TAGS';
            --Project Class Group tags
            IF (i_pcl = 1) THEN
              dbms_lob.append(gv_xxpa2381_payload,
                              '<G_PA_PROJECT_CLASSES>');
              IF gv_agr_tbl(i_agr)
               .agr_extra_rec.job_location_country IS NOT NULL THEN
                dbms_lob.append(gv_xxpa2381_payload,
                                '<PA_PROJECT_CLASSES>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<CLASS_CATEGORY>Virtual Sales Location</CLASS_CATEGORY>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<CLASS_CODE>' ||
                                dbms_xmlgen.convert(gv_agr_tbl(i_agr)
                                                    .agr_extra_rec.job_location_country,
                                                    0) || '</CLASS_CODE>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '</PA_PROJECT_CLASSES>');
              END IF;
            END IF;
            dbms_lob.append(gv_xxpa2381_payload, '<PA_PROJECT_CLASSES>');
            -- Project Class main record tags
            dbms_lob.append(gv_xxpa2381_payload,
                            '<CLASS_CATEGORY>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_class_categories_tbl(i_pcl)
                            .class_category || '</CLASS_CATEGORY>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<CLASS_CODE>' ||
                            dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_class_categories_tbl(i_pcl)
                                                .class_code,
                                                0) || '</CLASS_CODE>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<CODE_PERCENTAGE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_class_categories_tbl(i_pcl)
                            .code_percentage || '</CODE_PERCENTAGE>');
            --Project Class Group tags
            dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECT_CLASSES>');
            IF (i_pcl = gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
               .g_class_categories_tbl.COUNT) THEN
              dbms_lob.append(gv_xxpa2381_payload,
                              '</G_PA_PROJECT_CLASSES>');
            END IF;
          END LOOP; -- end of g_class_categories_tbl loop
        END IF;
        ---------------------------------
        --Open the Credit receivers loop
        --------------------------------
        IF gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl.COUNT > 0 THEN
          FOR i_pcr IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                            .g_prj_crd_recver_tbl.COUNT LOOP
            gv_poo := 'START GENERATING CREDIT RECEIVERS TAGS';
            -- Credit Receivers Group Tags
            IF (i_pcr = 1) THEN
              dbms_lob.append(gv_xxpa2381_payload,
                              '<G_PA_CREDIT_RECEIVERS>');
            END IF;
            dbms_lob.append(gv_xxpa2381_payload, '<PA_CREDIT_RECEIVERS>');
            --Credit Receivers main record tags
            dbms_lob.append(gv_xxpa2381_payload,
                            '<PERSON_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                            .person_id || '</PERSON_ID>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<CREDIT_TYPE_CODE>' ||
                            UPPER(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                                  .credit_type_code) ||
                            '</CREDIT_TYPE_CODE>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<START_DATE_ACTIVE>' ||
                            TO_CHAR(NVL(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                                        .start_date_active,
                                        gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                        .prj_main_rec.start_date),
                                    'DD-MON-YYYY') ||
                            '</START_DATE_ACTIVE>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<CREDIT_PERCENTAGE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                            .credit_percentage || '</CREDIT_PERCENTAGE>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<TASK_ID>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                            .task_id || '</TASK_ID>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<END_DATE_ACTIVE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                            .end_date_active || '</END_DATE_ACTIVE>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<EMPLOYEE_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_crd_recver_tbl(i_pcr)
                            .employee_number || '</EMPLOYEE_NUMBER>');
            -- Credit Receivers Group Tags
            dbms_lob.append(gv_xxpa2381_payload, '</PA_CREDIT_RECEIVERS>');
            IF (i_pcr = gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
               .g_prj_crd_recver_tbl.COUNT) THEN
              dbms_lob.append(gv_xxpa2381_payload,
                              '</G_PA_CREDIT_RECEIVERS>');
            END IF;
          END LOOP; -- End of g_prj_crd_recver_tbl loop
        END IF;
        gv_poo := 'START GENERATING BUDGET TAGS';
        IF gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
         .g_budget_prj_tbl.COUNT > 0 AND 1 = 2 THEN
          l_budget_count      := 1;
          l_budget_line_count := 1;
          FOR bud_count IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                .g_budget_prj_tbl.COUNT LOOP
            IF l_budget_count = 1 THEN
              dbms_lob.append(gv_xxpa2381_payload,
                              '<G_PA_PROJECT_BUDGETS>');
            END IF;
            dbms_lob.append(gv_xxpa2381_payload, '<PA_BUDGET_HDR>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<PM_BUDGET_REFERENCE>' ||
                            dbms_xmlgen.convert(gv_project_num, 0) ||
                            '</PM_BUDGET_REFERENCE>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<BUDGET_VERSION_NAME>' ||
                            dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_budget_prj_tbl(bud_count)
                                                .budget_version_name,
                                                0) ||
                            '</BUDGET_VERSION_NAME>');
            dbms_lob.append(gv_xxpa2381_payload,
                            '<BUDGET_TYPE_CODE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_budget_prj_tbl(bud_count)
                            .budget_type_code || '</BUDGET_TYPE_CODE>');
            l_budget_line_count := 1;
            FOR budline_count IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_budget_prj_tbl(bud_count)
                                      .g_budget_line_in_tbl.COUNT LOOP
              IF l_budget_line_count = 1 THEN
                dbms_lob.append(gv_xxpa2381_payload, '<G_PA_BUDGET_LINE>');
                l_budget_line_count := 2;
              END IF;
              dbms_lob.append(gv_xxpa2381_payload, '<PA_BUDGET_LINE>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<TASK_NUMBER>' ||
                              dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_budget_prj_tbl(bud_count).g_prj_bud_line_extra_t(budline_count)
                                                  .task_number,
                                                  0) || '</TASK_NUMBER>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<BUDGET_START_DATE>' ||
                              TO_CHAR(SYSDATE, 'DD-MON-YYYY') ||
                              '</BUDGET_START_DATE>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<REVENUE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_budget_prj_tbl(bud_count).g_budget_line_in_tbl(budline_count)
                              .revenue || '</REVENUE>');
              dbms_lob.append(gv_xxpa2381_payload, '</PA_BUDGET_LINE>');
            END LOOP;
            IF l_budget_line_count = 2 THEN
              dbms_lob.append(gv_xxpa2381_payload, '</G_PA_BUDGET_LINE>');
            END IF;
            dbms_lob.append(gv_xxpa2381_payload, '</PA_BUDGET_HDR>');
            l_budget_count := 2;
          END LOOP;
          IF l_budget_count = 2 THEN
            dbms_lob.append(gv_xxpa2381_payload, '</G_PA_PROJECT_BUDGETS>');
          END IF;
        END IF;
        IF gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
         .g_prj_task_rec.tasks_in_tbl.COUNT > 0 AND 1 = 2 THEN
          l_budget_count := 1;
          FOR c_prj_budget_loop IN 1 .. gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                        .g_prj_task_rec.tasks_in_tbl.COUNT LOOP
            IF NVL(gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.g_prj_task_extra_tbl(c_prj_budget_loop)
                   .reserve_amount,
                   0) > 0 THEN
              IF l_budget_count = 1 THEN
                dbms_lob.append(gv_xxpa2381_payload,
                                '<G_PA_PROJECT_BUDGETS><PA_BUDGET_HDR>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<PM_PROJECT_REFERENCE>' ||
                                dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                                    .prj_main_rec.pm_project_reference,
                                                    0) ||
                                '</PM_PROJECT_REFERENCE>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<BUDGET_VERSION_NAME>' ||
                                dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_tbl(i_prj)
                                                    .prj_extra_rec.proj_rev_version_name,
                                                    0) ||
                                '</BUDGET_VERSION_NAME>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<BUDGET_TYPE_CODE>AR</BUDGET_TYPE_CODE>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<G_PA_BUDGET_LINE><PA_BUDGET_LINE>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<TASK_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(c_prj_budget_loop)
                                .pa_task_number || '</TASK_NUMBER>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<REVENUE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.g_prj_task_extra_tbl(c_prj_budget_loop)
                                .reserve_amount || '</REVENUE>');
                dbms_lob.append(gv_xxpa2381_payload, '</PA_BUDGET_LINE>');
                l_budget_count := 2;
              ELSE
                dbms_lob.append(gv_xxpa2381_payload, '<PA_BUDGET_LINE>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<TASK_NUMBER>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.tasks_in_tbl(c_prj_budget_loop)
                                .pa_task_number || '</TASK_NUMBER>');
                dbms_lob.append(gv_xxpa2381_payload,
                                '<REVENUE>' || gv_agr_tbl(i_agr).g_prj_tbl(i_prj).g_prj_task_rec.g_prj_task_extra_tbl(c_prj_budget_loop)
                                .reserve_amount || '</REVENUE>');
                dbms_lob.append(gv_xxpa2381_payload, '</PA_BUDGET_LINE>');
              END IF;
            END IF;
          END LOOP;
          IF l_budget_count = 2 THEN
            dbms_lob.append(gv_xxpa2381_payload,
                            '</G_PA_BUDGET_LINE></PA_BUDGET_HDR></G_PA_PROJECT_BUDGETS>');
          END IF;
        END IF;
        --Project Group Tags
        dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECTS_ALL>');
        IF (i_prj = gv_agr_tbl(i_agr).g_prj_tbl.COUNT) THEN
          dbms_lob.append(gv_xxpa2381_payload, '</G_PA_PROJECTS_ALL>');
        END IF;
      END LOOP; -- end of g_prj_tbl loop
      -- The funding and the budget is not included as it is not required for thsi interface
      gv_poo := 'START GENERATING FUNDING TAGS';
      log_debug('Funding Main Count   : ' || gv_agr_tbl(i_agr)
                .g_prj_funding_rec.prj_funding_main_tbl.COUNT);
      log_debug('Funding Extra Count  : ' || gv_agr_tbl(i_agr)
                .g_prj_funding_rec.prj_funding_extra_tbl.COUNT);

      --Vishnu

      log_debug('Funding Level :' || l_funding_level);

      if nvl(l_funding_level, 'X') <> 'P' THEN
        IF gv_agr_tbl(i_agr)
         .g_prj_funding_rec.prj_funding_main_tbl.COUNT > 0 THEN
          FOR i_fund IN 1 .. gv_agr_tbl(i_agr)
                             .g_prj_funding_rec.prj_funding_main_tbl.COUNT LOOP
            log_debug(i_fund || '-' || gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_main_tbl(i_fund)
                      .allocated_amount || '-' || gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_extra_tbl(i_fund)
                      .pa_project_number || '-' || gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_extra_tbl(i_fund)
                      .pa_task_number);
          END LOOP;
          l_budget_count := 1;
          FOR i_fund_count IN 1 .. gv_agr_tbl(i_agr)
                                   .g_prj_funding_rec.prj_funding_main_tbl.COUNT LOOP
            IF l_budget_count = 1 THEN
              dbms_lob.append(gv_xxpa2381_payload,
                              '<G_PA_PROJECT_FUNDINGS><PA_PROJECT_FUNDING>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<ALLOCATED_AMOUNT>' || gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_main_tbl(i_fund_count)
                              .allocated_amount || '</ALLOCATED_AMOUNT>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<DATE_ALLOCATED>' ||
                              TO_CHAR(SYSDATE, 'DD-MON-YYYY') ||
                              '</DATE_ALLOCATED>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<PA_PROJECT_NUMBER>' ||
                              dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_extra_tbl(i_fund_count)
                                                  .pa_project_number,
                                                  0) ||
                              '</PA_PROJECT_NUMBER>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<PA_TASK_NUMBER>' ||
                              dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_extra_tbl(i_fund_count)
                                                  .pa_task_number,
                                                  0) || '</PA_TASK_NUMBER>');
              dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECT_FUNDING>');
              l_budget_count := 2;
            ELSE
              dbms_lob.append(gv_xxpa2381_payload, '<PA_PROJECT_FUNDING>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<ALLOCATED_AMOUNT>' || gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_main_tbl(i_fund_count)
                              .allocated_amount || '</ALLOCATED_AMOUNT>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<DATE_ALLOCATED>' ||
                              TO_CHAR(SYSDATE, 'DD-MON-YYYY') ||
                              '</DATE_ALLOCATED>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<PA_PROJECT_NUMBER>' ||
                              dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_extra_tbl(i_fund_count)
                                                  .pa_project_number,
                                                  0) ||
                              '</PA_PROJECT_NUMBER>');
              dbms_lob.append(gv_xxpa2381_payload,
                              '<PA_TASK_NUMBER>' ||
                              dbms_xmlgen.convert(gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_extra_tbl(i_fund_count)
                                                  .pa_task_number,
                                                  0) || '</PA_TASK_NUMBER>');
              dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECT_FUNDING>');
            END IF;
          END LOOP;
          IF l_budget_count = 2 THEN
            dbms_lob.append(gv_xxpa2381_payload,
                            '</G_PA_PROJECT_FUNDINGS>');
          END IF;
        END IF;
      ELSE
        l_amount_allocated := 0;
        l_budget_count     := 1;
        FOR i_fund_count IN 1 .. gv_agr_tbl(i_agr)
                                 .g_prj_funding_rec.prj_funding_main_tbl.COUNT LOOP
          IF l_budget_count = 1 THEN
            dbms_lob.append(gv_xxpa2381_payload, '<G_PA_PROJECT_FUNDINGS>');
            l_budget_count := 2;
          END IF;
          l_amount_allocated := l_amount_allocated + gv_agr_tbl(i_agr).g_prj_funding_rec.prj_funding_main_tbl(i_fund_count)
                               .allocated_amount;
        END LOOP;
        log_debug('Funding Total : ' || l_amount_allocated);
        if l_budget_count = 2 then
          dbms_lob.append(gv_xxpa2381_payload, '<PA_PROJECT_FUNDING>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<ALLOCATED_AMOUNT>' || l_amount_allocated ||
                          '</ALLOCATED_AMOUNT>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<DATE_ALLOCATED>' ||
                          TO_CHAR(SYSDATE, 'DD-MON-YYYY') ||
                          '</DATE_ALLOCATED>');
          dbms_lob.append(gv_xxpa2381_payload,
                          '<PA_PROJECT_NUMBER>' ||
                          dbms_xmlgen.convert(gv_project_num, 0) ||
                          '</PA_PROJECT_NUMBER>');
          dbms_lob.append(gv_xxpa2381_payload, '</PA_PROJECT_FUNDING>');
          dbms_lob.append(gv_xxpa2381_payload, '</G_PA_PROJECT_FUNDINGS>');
        end if;
      END IF;

      --Agreement Group Tags
      dbms_lob.append(gv_xxpa2381_payload, '</PA_AGREEMENTS_ALL>');
      IF (i_agr = gv_agr_tbl.COUNT) THEN
        dbms_lob.append(gv_xxpa2381_payload, '</G_PA_AGREEMENTS_ALL>');
      END IF;
    END LOOP; --- end of gv_agr_tbl loop
    dbms_lob.append(gv_xxpa2381_payload, '</G_XXPA2381_INT>');
    gv_poo := 'After creating the complete XML from Project Txn Record type and Table';
    log_debug(gv_procedure_name || '.' || gv_poo);
    BEGIN
      SELECT (deletexml(xmltype(gv_xxpa2381_payload), '//*[not(node())]'))
             .getClobVal()
        INTO gv_xxpa2381_payload
        FROM dual;
    EXCEPTION
      WHEN OTHERS THEN
        log_debug('Exception while removing Empty Tags in 2381 CLOB :' ||
                  SUBSTR(SQLERRM, 1, 200),
                  XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      --        NULL;
    END;
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status  := gc_error;
      x_return_message := gv_procedure_name || '.' || gv_poo || '.' ||
                          SQLERRM;
      x_return_message := x_return_message ||
                          DBMS_UTILITY.FORMAT_ERROR_STACK || '-' ||
                          DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      log_debug(x_return_message, XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END generate_project_xml;
  /*
  ** Procedure Name  : generate_order_xml
  **
  ** Purpose:  For generating the XML for XXONT1239
  **
  ** Procedure History:
  ** Date                 Who                Description
  ** ---------            ----------------   ----------------------------------------
  ** 18-Jun-15       Joydeb Saha   Created new
  */
  PROCEDURE generate_order_xml(x_return_status  OUT VARCHAR2,
                               x_return_message OUT VARCHAR2,
                               x_guid           OUT VARCHAR2) IS
    l_ou_id             hr_operating_units.organization_id%TYPE;
    l_ou_name           hr_operating_units.NAME%TYPE;
    l_ou_code           VARCHAR2(200);
    l_attr_count        NUMBER := 0;
    g_xxont1239_payload CLOB; -- stores payload for XXONT1239 XXINT Event. This is an XML message. -- added by Joydeb
    lv_api_return_type  xxint_event_api_pub.gt_event_api_type;
    l_order_count       NUMBER := 0;
    l_order_status_clob CLOB;
    --    l_partner_masking_enabled VARCHAR2(20):= 'N';
    l_task_number  pa_tasks.task_number%TYPE; -- Added by Joydeb as per RT#6859721
    l_org_key_name varchar2(22) := 'ORGANIZATION_CODE'; --Added for CR24018
  BEGIN
    gv_procedure_name := 'generate_order_xml';
    gv_poo            := 'Start';
    log_debug(gv_procedure_name || '.' || gv_poo);
    x_return_status := 'SUCCESS';
    gv_poo          := 'START SENDER TAG';
    --------------------------------------------------------------
    --Open Order header loop
    --------------------------------------------------------------
    log_debug('Sales Order Count : ' || gv_sales_order_header_tbl.COUNT);
    FOR i_oh IN 1 .. gv_sales_order_header_tbl.COUNT LOOP
      gv_poo := 'START GENERATING ORDER HEADER MAIN TAGS';
      --g_xxont1239_payload.delete;
      g_xxont1239_payload := '<G_OH>';
      ---------------------------------------------------------------
      --generate the sender tags
      ---------------------------------------------------------------
      dbms_lob.append(g_xxont1239_payload, '<SENDER>');
      dbms_lob.append(g_xxont1239_payload,
                      '<ID>' || gv_source_system || '</ID>');
      dbms_lob.append(g_xxont1239_payload,
                      '<REFERENCE>' ||
                      dbms_xmlgen.convert(gv_source_reference, 0) ||
                      '</REFERENCE>');
      dbms_lob.append(g_xxont1239_payload, '</SENDER>');
      dbms_lob.append(g_xxont1239_payload, '<OH>');
      --Generate order header tags
      dbms_lob.append(g_xxont1239_payload,
                      '<orderSource>' || gv_source_system ||
                      '</orderSource>');
      l_ou_id   := gv_sales_order_header_tbl(i_oh)
                   .g_sales_order_hdr_main_rec.org_id;
      l_ou_code := gv_sales_order_header_tbl(i_oh)
                   .g_sales_order_hdr_main_rec.org_code;
      IF l_ou_code IS NOT NULL AND l_ou_id IS NULL THEN
        SELECT organization_id
          INTO l_ou_id
          FROM apps.hr_operating_units
         WHERE short_code = l_ou_code;
      END IF;
      dbms_lob.append(g_xxont1239_payload,
                      '<orgId>' || l_ou_id || '</orgId>');
      BEGIN
        SELECT NAME
          INTO l_ou_name
          FROM hr_operating_units
         WHERE organization_id = NVL(gv_sales_order_header_tbl(i_oh)
                                     .g_sales_order_hdr_main_rec.org_id,
                                     l_ou_id);
      EXCEPTION
        WHEN OTHERS THEN
          l_ou_name := NULL;
      END;
      IF gv_request_type = 'P' THEN
        BEGIN
          SELECT NAME
            INTO gv_sales_order_header_tbl(i_oh)
                 .g_sales_order_hdr_main_rec.ordertype
            FROM apps.oe_transaction_types_tl
           WHERE transaction_type_id IN
                 (SELECT transaction_type_id
                    FROM apps.oe_transaction_types_all
                   WHERE transaction_type_code = 'ORDER'
                     AND org_id = NVL(gv_sales_order_header_tbl(i_oh)
                                      .g_sales_order_hdr_main_rec.org_id,
                                      l_ou_id))
             AND LANGUAGE = 'US'
             AND NAME LIKE 'Project%';
        EXCEPTION
          WHEN OTHERS THEN
            gv_sales_order_header_tbl(i_oh).g_sales_order_hdr_main_rec.ordertype := NULL;
        END;
        dbms_lob.append(g_xxont1239_payload,
                        '<orderType>' || gv_sales_order_header_tbl(i_oh)
                        .g_sales_order_hdr_main_rec.ordertype ||
                         '</orderType>');
      END IF;
      BEGIN
        dbms_lob.append(g_xxont1239_payload,
                        '<requestDate>' || REPLACE(TO_CHAR(gv_sales_order_header_tbl(i_oh)
                                                           .g_sales_order_hdr_main_rec.request_date,
                                                           'YYYY-MM-DD HH:MI:SS'),
                                                   ' ',
                                                   'T') || '</requestDate>');
      EXCEPTION
        WHEN OTHERS THEN
          dbms_lob.append(g_xxont1239_payload,
                          '<requestDate>' || gv_sales_order_header_tbl(i_oh)
                          .g_sales_order_hdr_main_rec.request_date ||
                           '</requestDate>');
      END;
      dbms_lob.append(g_xxont1239_payload,
                      '<transactionalCurrCode>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.transactional_curr_code ||
                       '</transactionalCurrCode>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipmentPriority>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.shipment_priority ||
                       '</shipmentPriority>');
      dbms_lob.append(g_xxont1239_payload,
                      '<freightTerms>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.freight_terms,
                                          0) || '</freightTerms>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shippingMethod>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.shipping_method,
                                          0) || '</shippingMethod>');
      dbms_lob.append(g_xxont1239_payload,
                      '<fobPoint>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.fob || '</fobPoint>'); -- Check if the FOB will be mapped to forbPoint or fobPointCode
      dbms_lob.append(g_xxont1239_payload,
                      '<shippingInstructions>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.shipping_instructions,
                                          0) || '</shippingInstructions>');
      BEGIN
        dbms_lob.append(g_xxont1239_payload,
                        '<orderedDate>' || REPLACE(TO_CHAR(gv_sales_order_header_tbl(i_oh)
                                                           .g_sales_order_hdr_main_rec.ordered_date,
                                                           'YYYY-MM-DD HH:MI:SS'),
                                                   ' ',
                                                   'T') || '</orderedDate>');
      EXCEPTION
        WHEN OTHERS THEN
          dbms_lob.append(g_xxont1239_payload,
                          '<requestDate>' || gv_sales_order_header_tbl(i_oh)
                          .g_sales_order_hdr_main_rec.ordered_date ||
                           '</requestDate>');
      END;
      dbms_lob.append(g_xxont1239_payload,
                      '<priceList>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.pricelist ||
                       '</priceList>');
      IF gv_sales_order_header_tbl(i_oh)
       .g_sales_order_hdr_main_rec.salesrep IS NOT NULL THEN
        dbms_lob.append(g_xxont1239_payload,
                        '<salesrep>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                            .g_sales_order_hdr_main_rec.salesrep,
                                            0) || '</salesrep>');
      END IF;
      IF gv_sales_order_header_tbl(i_oh)
       .g_sales_order_hdr_main_rec.salesrepId IS NOT NULL THEN
        dbms_lob.append(g_xxont1239_payload,
                        '<salesrepId>' || gv_sales_order_header_tbl(i_oh)
                        .g_sales_order_hdr_main_rec.salesrepId ||
                         '</salesrepId>');
      END IF;
      if gv_sales_order_header_tbl(i_oh).g_sales_order_hdr_main_rec.packingInstructions is not null then
        dbms_lob.append(g_xxont1239_payload,
                        '<packingInstructions>' || gv_sales_order_header_tbl(i_oh).g_sales_order_hdr_main_rec.packingInstructions ||
                         '</packingInstructions>');
      end if;

      dbms_lob.append(g_xxont1239_payload,
                      '<context>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.attribute_category ||
                       '</context>'); -- Check if attribute_category will be mapped to context tag or not
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute1>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute1,
                                          0) || '</attribute1>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute2>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute2,
                                          0) || '</attribute2>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute3>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute3,
                                          0) || '</attribute3>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute4>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute4,
                                          0) || '</attribute4>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute5>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute5,
                                          0) || '</attribute5>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute6>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute6,
                                          0) || '</attribute6>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute7>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute7,
                                          0) || '</attribute7>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute8>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute8,
                                          0) || '</attribute8>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute9>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute9,
                                          0) || '</attribute9>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute10>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute10,
                                          0) || '</attribute10>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute11>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute11,
                                          0) || '</attribute11>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute12>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute12,
                                          0) || '</attribute12>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute13>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute13,
                                          0) || '</attribute13>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute14>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute14,
                                          0) || '</attribute14>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute15>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute15,
                                          0) || '</attribute15>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute16>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute16,
                                          0) || '</attribute16>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute17>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute17,
                                          0) || '</attribute17>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute18>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute18,
                                          0) || '</attribute18>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute19>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute19,
                                          0) || '</attribute19>');
      dbms_lob.append(g_xxont1239_payload,
                      '<attribute20>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute20,
                                          0) || '</attribute20>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpContext>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.tpcontext ||
                       '</tpContext>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute1>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute1,
                                          0) || '</tpAttribute1>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute2>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute2,
                                          0) || '</tpAttribute2>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute3>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute3,
                                          0) || '</tpAttribute3>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute4>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute4,
                                          0) || '</tpAttribute4>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute5>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute5,
                                          0) || '</tpAttribute5>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute6>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute6,
                                          0) || '</tpAttribute6>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute7>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute7,
                                          0) || '</tpAttribute7>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute8>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute8,
                                          0) || '</tpAttribute8>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute9>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute9,
                                          0) || '</tpAttribute9>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute10>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute10,
                                          0) || '</tpAttribute10>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute11>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute11,
                                          0) || '</tpAttribute11>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute12>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute12,
                                          0) || '</tpAttribute12>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute13>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute13,
                                          0) || '</tpAttribute13>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute14>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute14,
                                          0) || '</tpAttribute14>');
      dbms_lob.append(g_xxont1239_payload,
                      '<tpAttribute15>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.tpattribute15,
                                          0) || '</tpAttribute15>');
      dbms_lob.append(g_xxont1239_payload,
                      '<customerNumber>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.customer_number ||
                       '</customerNumber>');
      dbms_lob.append(g_xxont1239_payload,
                      '<invoiceCustomerId>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.bill_to_customer_id ||
                       '</invoiceCustomerId>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToCustomerId>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.ship_to_customer_id ||
                       '</shipToCustomerId>');
      dbms_lob.append(g_xxont1239_payload,
                      '<invoiceToPartySiteId>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.bill_to_party_site_id ||
                       '</invoiceToPartySiteId>');
      dbms_lob.append(g_xxont1239_payload,
                      '<paymentTerm>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.payment_terms ||
                       '</paymentTerm>'); -- Changed for the RT#8169777
      dbms_lob.append(g_xxont1239_payload,
                      '<customerPaymentTerm>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.payment_terms ||
                       '</customerPaymentTerm>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToPartySiteId>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.ship_to_party_site_id ||
                       '</shipToPartySiteId>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToAddress1>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_line1,
                                          0) || '</shipToAddress1>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToAddress2>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_line2,
                                          0) || '</shipToAddress2>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToAddress3>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_line3,
                                          0) || '</shipToAddress3>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToAddress4>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_line4,
                                          0) || '</shipToAddress4>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToCity>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_city,
                                          0) || '</shipToCity>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToState>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_state,
                                          0) || '</shipToState>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToPostalCode>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.ship_to_adress_postal_code ||
                       '</shipToPostalCode>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToCountry>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_country,
                                          0) || '</shipToCountry>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToCounty>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.ship_to_adress_county,
                                          0) || '</shipToCounty>');
      dbms_lob.append(g_xxont1239_payload,
                      '<shipToPartyNumber>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.ship_to_party_site_number ||
                       '</shipToPartyNumber>');
      dbms_lob.append(g_xxont1239_payload,
                      '<invoiceToPartyNumber>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.bill_to_party_site_number ||
                       '</invoiceToPartyNumber>');
      dbms_lob.append(g_xxont1239_payload,
                      '<customerId>' || gv_sales_order_header_tbl(i_oh)
                      .g_sales_order_hdr_main_rec.customer_id ||
                       '</customerId>');
      --Modified for Defect 22294
      --dbms_lob.append(g_xxont1239_payload, '<customerPoNumber>' || gv_cust_po_number || '</customerPoNumber>');
      --End of Modified for Defect 22294

      --      dbms_lob.append(g_xxont1239_payload,
      --                      '<customerPoNumber>' ||
      --                      dbms_xmlgen.convert(nvl(gv_sales_order_header_tbl(i_oh)
      --                                              .g_sales_order_hdr_main_rec.customer_po_number,
      --                                              gv_cust_po_number),
      --                                          0) || '</customerPoNumber>');

      if gv_append_cust_po_key_val = 'Y' THEN
        dbms_lob.append(g_xxont1239_payload,
                        '<customerPoNumber>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                            .g_sales_order_hdr_main_rec.attribute8 || '-' ||
                                             nvl(gv_sales_order_header_tbl(i_oh)
                                                 .g_sales_order_hdr_main_rec.customer_po_number,
                                                 gv_cust_po_number),
                                            0) || '</customerPoNumber>');

      ELSE
        dbms_lob.append(g_xxont1239_payload,
                        '<customerPoNumber>' ||
                        dbms_xmlgen.convert(nvl(gv_sales_order_header_tbl(i_oh)
                                                .g_sales_order_hdr_main_rec.customer_po_number,
                                                gv_cust_po_number),
                                            0) || '</customerPoNumber>');
      END IF;

      --Added for CR24018
      log_debug('Ship From Org ID - Generate Order XML ' ||
                gv_ship_from_org_id);
      gv_ship_from_org_id := NULL;
      if gv_ship_from_org_id is null then
        FOR i_ol IN 1 .. gv_sales_order_header_tbl(i_oh)
                         .g_sales_order_line_tbl.COUNT LOOP
          if gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
           .g_sales_order_line_main_rec.ship_from_org_id is not null then
            gv_ship_from_org_id := gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                   .g_sales_order_line_main_rec.ship_from_org_id;
            exit;
          end if;
        end loop;
        log_debug('Ship From Org ID - Generate Order XML Line Level : ' ||
                  gv_ship_from_org_id);
      end if;

      for c_addl_data in (select x.attribute2
                            from xxint_event_type_key_vals x,
                                 mtl_parameters            mtp
                           where x.event_type = gc_event_type
                             and x.key_type = gc_key_type
                             and x.key_type_value = gv_source_system
                             and x.key_name = l_org_key_name
                             and x.key_value = mtp.organization_code
                             and mtp.organization_id = gv_ship_from_org_id
                             and gv_ship_from_org_id is not null
                             and x.attribute1 = 'INCLUDE_IN_XXONT1239'
                             and x.attribute3 = 'HEADER'
                             and x.status = 'ACTIVE') loop
        dbms_lob.append(g_xxont1239_payload, c_addl_data.attribute2);
      end loop;
      --End of Added for CR24018

      ----------------------------------------------------------
      --Open the order header additional attribute loop
      ---------------------------------------------------------
      log_debug('Order Header Additional Attribute Count : ' || gv_sales_order_header_tbl(i_oh)
                .g_order_add_attr_line_tbl_h.COUNT);
      IF gv_sales_order_header_tbl(i_oh)
       .g_order_add_attr_line_tbl_h.COUNT > 0 THEN
        l_attr_count := 0;
        FOR i_oh_att IN 1 .. gv_sales_order_header_tbl(i_oh)
                             .g_order_add_attr_line_tbl_h.COUNT LOOP
          gv_poo := 'START GENERATING ORDER HEADER ADDITIONAL ATTRIBUTES TAGS';
          -- additional attribute Group Tags
          IF trim(gv_sales_order_header_tbl(i_oh).g_order_add_attr_line_tbl_h(i_oh_att)
                  .attribute_value) IS NOT NULL THEN
            IF (l_attr_count = 0) THEN
              dbms_lob.append(g_xxont1239_payload, '<g_additional_attrs>');
              dbms_lob.append(g_xxont1239_payload,
                              '<XX_ADDITIONAL_ATTRIBUTES>');
              l_attr_count := l_attr_count + 1;
            END IF;
            dbms_lob.append(g_xxont1239_payload, '<ATTRIBUTE>');
            -- Additional attribute Main tags
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute_name>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_add_attr_line_tbl_h(i_oh_att)
                                                .attribute_name,
                                                0) || '</attribute_name>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute_value>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_add_attr_line_tbl_h(i_oh_att)
                                                .attribute_value,
                                                0) || '</attribute_value>');
            -- additional attribute Group Tags
            dbms_lob.append(g_xxont1239_payload, '</ATTRIBUTE>');
          END IF;
          IF (i_oh_att = gv_sales_order_header_tbl(i_oh)
             .g_order_add_attr_line_tbl_h.COUNT AND l_attr_count <> 0) THEN
            dbms_lob.append(g_xxont1239_payload,
                            '</XX_ADDITIONAL_ATTRIBUTES>');
            dbms_lob.append(g_xxont1239_payload, '</g_additional_attrs>');
          END IF;
        END LOOP; -- end of order header g_order_add_attr_line_tbl loop
      END IF;
      ----------------------------------------------------------
      --Open the order header pricing attribute loop
      ---------------------------------------------------------
      log_debug('Pricing Attribute Count : ' || gv_sales_order_header_tbl(i_oh)
                .g_order_prc_attr_line_tbl_h.COUNT);
      IF gv_sales_order_header_tbl(i_oh)
       .g_order_prc_attr_line_tbl_h.COUNT > 0 THEN
        FOR i_oh_pat IN 1 .. gv_sales_order_header_tbl(i_oh)
                             .g_order_prc_attr_line_tbl_h.COUNT LOOP
          gv_poo := 'START GENERATING ORDER HEADER PRICING ATTRIBUTES TAGS';
          -- Order header pricing attribute Group Tags
          IF (i_oh_pat = 1) THEN
            dbms_lob.append(g_xxont1239_payload, '<g_price_attrs>');
          END IF;
          dbms_lob.append(g_xxont1239_payload, '<price_attr_line>');
          --Order header pricing attributes main tags
          dbms_lob.append(g_xxont1239_payload,
                          '<context>' || gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                          .CONTEXT || '</context>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute1>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute1,
                                              0) || '</attribute1>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute2>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute2,
                                              0) || '</attribute2>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute3>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute3,
                                              0) || '</attribute3>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute4>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute4,
                                              0) || '</attribute4>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute5>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute5,
                                              0) || '</attribute5>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute6>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute6,
                                              0) || '</attribute6>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute7>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute7,
                                              0) || '</attribute7>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute8>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute8,
                                              0) || '</attribute8>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute9>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute9,
                                              0) || '</attribute9>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute10>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute10,
                                              0) || '</attribute10>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute11>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute11,
                                              0) || '</attribute11>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute12>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute12,
                                              0) || '</attribute12>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute13>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute13,
                                              0) || '</attribute13>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute14>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute14,
                                              0) || '</attribute14>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute15>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .attribute15,
                                              0) || '</attribute15>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_context>' || gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                          .pricing_context || '</pricing_context>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute1>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute1,
                                              0) || '</pricing_attribute1>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute2>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute2,
                                              0) || '</pricing_attribute2>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute3>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute3,
                                              0) || '</pricing_attribute3>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute4>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute4,
                                              0) || '</pricing_attribute4>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute5>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute5,
                                              0) || '</pricing_attribute5>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute6>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute6,
                                              0) || '</pricing_attribute6>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute7>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute7,
                                              0) || '</pricing_attribute7>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute8>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute8,
                                              0) || '</pricing_attribute8>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute9>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute9,
                                              0) || '</pricing_attribute9>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute10>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute10,
                                              0) ||
                          '</pricing_attribute10>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute11>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute11,
                                              0) ||
                          '</pricing_attribute11>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute12>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute12,
                                              0) ||
                          '</pricing_attribute12>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute13>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute13,
                                              0) ||
                          '</pricing_attribute13>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute14>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_attr_line_tbl_h(i_oh_pat)
                                              .pricing_attribute14,
                                              0) ||
                          '</pricing_attribute14>');
          -- Order header pricing attribute Group Tags
          dbms_lob.append(g_xxont1239_payload, '</price_attr_line>');
          IF (i_oh_pat = gv_sales_order_header_tbl(i_oh)
             .g_order_prc_attr_line_tbl_h.COUNT) THEN
            dbms_lob.append(g_xxont1239_payload, '</g_price_attrs>');
          END IF;
        END LOOP; -- end of order header g_order_prc_attr_line_tbl_h loop
      END IF;
      ----------------------------------------------------------
      --Open the order header pricing Adjustment loop
      ---------------------------------------------------------
      log_debug('Order Header Pricing Adjustment Count : ' || gv_sales_order_header_tbl(i_oh)
                .g_order_prc_adj_rec_tbl_h.COUNT);
      IF gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h.COUNT > 0 THEN
        FOR i_oh_padj IN 1 .. gv_sales_order_header_tbl(i_oh)
                              .g_order_prc_adj_rec_tbl_h.COUNT LOOP
          gv_poo := 'START GENERATING ORDER HEADER PRICING ATTRIBUTES TAGS';
          -- Order header pricing attribute Group Tags
          IF (i_oh_padj = 1) THEN
            dbms_lob.append(g_xxont1239_payload, '<g_price_adjs>');
          END IF;
          dbms_lob.append(g_xxont1239_payload, '<price_adj_line>');
          dbms_lob.append(g_xxont1239_payload,
                          '<orig_sys_discount_ref>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ORIG_SYS_DISCOUNT_REF,
                                              0) ||
                          '</orig_sys_discount_ref>');
          dbms_lob.append(g_xxont1239_payload,
                          '<change_sequence>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CHANGE_SEQUENCE || '</change_sequence>');
          dbms_lob.append(g_xxont1239_payload,
                          '<change_request_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CHANGE_REQUEST_CODE || '</change_request_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<automatic_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .AUTOMATIC_FLAG || '</automatic_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<context>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CONTEXT || '</context>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute1>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE1,
                                              0) || '</attribute1>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute2>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE2,
                                              0) || '</attribute2>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute3>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE3,
                                              0) || '</attribute3>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute4>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE4,
                                              0) || '</attribute4>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute5>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE5,
                                              0) || '</attribute5>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute6>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE6,
                                              0) || '</attribute6>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute7>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE7,
                                              0) || '</attribute7>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute8>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE8,
                                              0) || '</attribute8>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute9>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE9,
                                              0) || '</attribute9>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute10>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE10,
                                              0) || '</attribute10>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute11>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE11,
                                              0) || '</attribute11>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute12>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE12,
                                              0) || '</attribute12>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute13>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE13,
                                              0) || '</attribute13>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute14>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE14,
                                              0) || '</attribute14>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute15>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .ATTRIBUTE15,
                                              0) || '</attribute15>');
          dbms_lob.append(g_xxont1239_payload,
                          '<list_header_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .LIST_HEADER_ID || '</list_header_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<list_name>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .LIST_NAME || '</list_name>');
          dbms_lob.append(g_xxont1239_payload,
                          '<list_line_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .LIST_LINE_ID || '</list_line_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<list_line_type_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .LIST_LINE_TYPE_CODE || '</list_line_type_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<modifier_mechanism_type_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .MODIFIER_MECHANISM_TYPE_CODE ||
                           '</modifier_mechanism_type_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<modified_from>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .MODIFIED_FROM || '</modified_from>');
          dbms_lob.append(g_xxont1239_payload,
                          '<modified_to>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .MODIFIED_TO || '</modified_to>');
          dbms_lob.append(g_xxont1239_payload,
                          '<updated_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .UPDATED_FLAG || '</updated_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<update_allowed>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .UPDATE_ALLOWED || '</update_allowed>');
          dbms_lob.append(g_xxont1239_payload,
                          '<applied_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .APPLIED_FLAG || '</applied_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<change_reason_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CHANGE_REASON_CODE || '</change_reason_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<change_reason_text>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .CHANGE_REASON_TEXT,
                                              0) || '</change_reason_text>');
          dbms_lob.append(g_xxont1239_payload,
                          '<discount_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .DISCOUNT_ID || '</discount_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<discount_line_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .DISCOUNT_LINE_ID || '</discount_line_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<discount_name>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .DISCOUNT_NAME,
                                              0) || '</discount_name>');
          dbms_lob.append(g_xxont1239_payload,
                          '<percent>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .PERCENT || '</percent>');
          dbms_lob.append(g_xxont1239_payload,
                          '<operation_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .OPERATION_CODE || '</operation_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<operand>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .OPERAND || '</operand>');
          dbms_lob.append(g_xxont1239_payload,
                          '<arithmetic_operator>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .ARITHMETIC_OPERATOR || '</arithmetic_operator>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_phase_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .PRICING_PHASE_ID || '</pricing_phase_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<adjusted_amount>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .ADJUSTED_AMOUNT || '</adjusted_amount>');
          dbms_lob.append(g_xxont1239_payload,
                          '<modifier_name>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .MODIFIER_NAME,
                                              0) || '</modifier_name>');
          dbms_lob.append(g_xxont1239_payload,
                          '<list_line_number>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .LIST_LINE_NUMBER || '</list_line_number>');
          dbms_lob.append(g_xxont1239_payload,
                          '<version_number>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .VERSION_NUMBER || '</version_number>');
          dbms_lob.append(g_xxont1239_payload,
                          '<invoiced_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .INVOICED_FLAG || '</invoiced_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<estimated_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .ESTIMATED_FLAG || '</estimated_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<inc_in_sales_performance>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .INC_IN_SALES_PERFORMANCE ||
                           '</inc_in_sales_performance>');
          dbms_lob.append(g_xxont1239_payload,
                          '<charge_type_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CHARGE_TYPE_CODE || '</charge_type_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<charge_subtype_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CHARGE_SUBTYPE_CODE || '</charge_subtype_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<credit_or_charge_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .CREDIT_OR_CHARGE_FLAG ||
                           '</credit_or_charge_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<include_on_returns_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .INCLUDE_ON_RETURNS_FLAG ||
                           '</include_on_returns_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<cost_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .COST_ID || '</cost_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<tax_code>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .TAX_CODE || '</tax_code>');
          dbms_lob.append(g_xxont1239_payload,
                          '<parent_adjustment_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .PARENT_ADJUSTMENT_ID || '</parent_adjustment_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_context>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .AC_CONTEXT || '</ac_context>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute1>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE1,
                                              0) || '</ac_attribute1>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute2>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE2,
                                              0) || '</ac_attribute2>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute3>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE3,
                                              0) || '</ac_attribute3>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute4>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE4,
                                              0) || '</ac_attribute4>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute5>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE5,
                                              0) || '</ac_attribute5>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute6>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE6,
                                              0) || '</ac_attribute6>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute7>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE7,
                                              0) || '</ac_attribute7>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute8>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE8,
                                              0) || '</ac_attribute8>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute9>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE9,
                                              0) || '</ac_attribute9>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute10>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE10,
                                              0) || '</ac_attribute10>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute11>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE11,
                                              0) || '</ac_attribute11>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute12>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE12,
                                              0) || '</ac_attribute12>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute13>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE13,
                                              0) || '</ac_attribute13>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute14>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE14,
                                              0) || '</ac_attribute14>');
          dbms_lob.append(g_xxont1239_payload,
                          '<ac_attribute15>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                                              .AC_ATTRIBUTE15,
                                              0) || '</ac_attribute15>');
          dbms_lob.append(g_xxont1239_payload,
                          '<operand_per_pqty>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .OPERAND_PER_PQTY || '</operand_per_pqty>');
          dbms_lob.append(g_xxont1239_payload,
                          '<adjusted_amount_per_pqty>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .ADJUSTED_AMOUNT_PER_PQTY ||
                           '</adjusted_amount_per_pqty>');
          dbms_lob.append(g_xxont1239_payload,
                          '<price_adjustment_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .PRICE_ADJUSTMENT_ID || '</price_adjustment_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<tax_rate_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .TAX_RATE_ID || '</tax_rate_id>');
          dbms_lob.append(g_xxont1239_payload,
                          '<error_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .ERROR_FLAG || '</error_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<interface_status>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .INTERFACE_STATUS || '</interface_status>');
          dbms_lob.append(g_xxont1239_payload,
                          '<status_flag>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .STATUS_FLAG || '</status_flag>');
          dbms_lob.append(g_xxont1239_payload,
                          '<sold_to_org>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .SOLD_TO_ORG || '</sold_to_org>');
          dbms_lob.append(g_xxont1239_payload,
                          '<sold_to_org_id>' || gv_sales_order_header_tbl(i_oh).g_order_prc_adj_rec_tbl_h(i_oh_padj)
                          .SOLD_TO_ORG_ID || '</sold_to_org_id>');

          dbms_lob.append(g_xxont1239_payload, '</price_adj_line>');
          IF (i_oh_padj = gv_sales_order_header_tbl(i_oh)
             .g_order_prc_adj_rec_tbl_h.COUNT) THEN
            dbms_lob.append(g_xxont1239_payload, '</g_price_adjs>');
          END IF;
        END LOOP;
      END IF;
      /* The g_src_attributes_tbl loop is not opened as the columns of this does not match with the G_SC group tags of the XXONT1239 xml*/
      ----------------------------------------------------------
      --Open the order header order attachment loop
      ---------------------------------------------------------
      log_debug('Order Attachment count : ' || gv_sales_order_header_tbl(i_oh)
                .g_order_attachment_tbl_h.COUNT);
      IF gv_sales_order_header_tbl(i_oh).g_order_attachment_tbl_h.COUNT > 0 THEN
        FOR i_oh_amt IN 1 .. gv_sales_order_header_tbl(i_oh)
                             .g_order_attachment_tbl_h.COUNT LOOP
          gv_poo := 'START GENERATING ORDER HEADER ATTACHMENT TAGS';
          -- Order header attachment Group Tags
          IF (i_oh_amt = 1) THEN
            dbms_lob.append(g_xxont1239_payload, '<G_AT_H>');
          END IF;
          dbms_lob.append(g_xxont1239_payload, '<O_AH>');
          -- Order header attachment main Tags
          dbms_lob.append(g_xxont1239_payload,
                          '<lineNumber>' || gv_sales_order_header_tbl(i_oh).g_order_attachment_tbl_h(i_oh_amt)
                          .line_number || '</lineNumber>');
          dbms_lob.append(g_xxont1239_payload,
                          '<noteType>' || gv_sales_order_header_tbl(i_oh).g_order_attachment_tbl_h(i_oh_amt)
                          .attachment_type || '</noteType>'); -- Need to check the mapping for document id
          dbms_lob.append(g_xxont1239_payload,
                          '<notes>' || dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_order_attachment_tbl_h(i_oh_amt)
                                                           .short_text,
                                                           0) || '</notes>');
          -- Order header attachment Group Tags
          dbms_lob.append(g_xxont1239_payload, '</O_AH>');
          IF (i_oh_amt = gv_sales_order_header_tbl(i_oh)
             .g_order_attachment_tbl_h.COUNT) THEN
            dbms_lob.append(g_xxont1239_payload, '</G_AT_H>');
          END IF;
        END LOOP; --end of order header g_order_attachment_tbl loop
      END IF;
      ----------------------------------------------------------
      --Open the order line loop
      ---------------------------------------------------------
      log_debug('Order Line Count  : ' || gv_sales_order_header_tbl(i_oh)
                .g_sales_order_line_tbl.COUNT);
      FOR i_ol IN 1 .. gv_sales_order_header_tbl(i_oh)
                       .g_sales_order_line_tbl.COUNT LOOP
        gv_poo := 'START GENERATING ORDER LINE TAGS';
        log_debug('Order Line NUmber ' || i_ol);
        --Order line group tags
        IF (i_ol = 1) THEN
          dbms_lob.append(g_xxont1239_payload, '<G_OL>');
        END IF;
        dbms_lob.append(g_xxont1239_payload, '<OL>');
        -- Order line main tags
        dbms_lob.append(g_xxont1239_payload,
                        '<lineNumber>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                        .g_sales_order_line_main_rec.line_number ||
                         '</lineNumber>');
        log_debug('Line Number ' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                  .g_sales_order_line_main_rec.line_number);
        dbms_lob.append(g_xxont1239_payload,
                        '<inventoryItem>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                        .g_sales_order_line_main_rec.inventory_item ||
                         '</inventoryItem>');
        dbms_lob.append(g_xxont1239_payload,
                        '<orderedQuantity>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                        .g_sales_order_line_main_rec.ordered_quantity ||
                         '</orderedQuantity>');
        dbms_lob.append(g_xxont1239_payload,
                        '<orderQuantityUom>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                        .g_sales_order_line_main_rec.ordered_quantity_uom ||
                         '</orderQuantityUom>');
        log_debug('Ship From Org_id : ' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                  .g_sales_order_line_main_rec.ship_from_org_id || '-' ||
                  gv_ship_from_org_id);
        dbms_lob.append(g_xxont1239_payload,
                        '<shipFromOrgId>' ||
                        NVL(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                            .g_sales_order_line_main_rec.ship_from_org_id,
                            gv_ship_from_org_id) || '</shipFromOrgId>');
        log_debug('Deliver To Org_id : ' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                  .g_sales_order_line_main_rec.deliverToOrgId);
        IF gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
         .g_sales_order_line_main_rec.deliverToOrgId IS NOT NULL THEN
          dbms_lob.append(g_xxont1239_payload,
                          '<deliverToOrgId>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                          .g_sales_order_line_main_rec.deliverToOrgId ||
                           '</deliverToOrgId>');
        END IF;
        dbms_lob.append(g_xxont1239_payload,
                        '<fobPoint>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.fob,
                                            0) || '</fobPoint>'); -- Need to check the mapping
        dbms_lob.append(g_xxont1239_payload,
                        '<shipmentPriority>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                        .g_sales_order_line_main_rec.shipment_priority ||
                         '</shipmentPriority>');
        BEGIN
          dbms_lob.append(g_xxont1239_payload,
                          '<requestDate>' ||
                          REPLACE(TO_CHAR(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                          .g_sales_order_line_main_rec.request_date,
                                          'YYYY-MM-DD HH:MI:SS'),
                                  ' ',
                                  'T') || '</requestDate>');
        EXCEPTION
          WHEN OTHERS THEN
            dbms_lob.append(g_xxont1239_payload,
                            '<requestDate>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                            .g_sales_order_line_main_rec.request_date ||
                             '</requestDate>');
        END;
        IF gv_request_type = 'P' THEN
          dbms_lob.append(g_xxont1239_payload,
                          '<project>' ||
                          dbms_xmlgen.convert(NVL(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                                  .g_sales_order_line_main_rec.project_number,
                                                  gv_project_num),
                                              0) || '</project>'); ---- Modified by Joydeb as per RT#6859721
          --Added by Joydeb as per RT#6859721. Sometimes partner does not send the leading 0 in task number. So validate the task number to get the correct task number from database
          BEGIN
            SELECT task_number
              INTO l_task_number
              FROM pa_projects_all pa, pa_tasks pt
             WHERE pa.project_id = pt.project_id
               AND pa.segment1 = NVL(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                     .g_sales_order_line_main_rec.project_number,
                                     gv_project_num)
               AND LTRIM(pt.task_number, 0) =
                   LTRIM(NVL(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_sales_order_line_main_rec.task_number,
                             '010'),
                         0);
          EXCEPTION
            WHEN OTHERS THEN
              l_task_number := '010';
          END;
          dbms_lob.append(g_xxont1239_payload,
                          '<task>' || l_task_number || '</task>'); -- Replaced hardcoded '010' with l_task_number as per RT#6859721
        END IF;
        dbms_lob.append(g_xxont1239_payload,
                        '<linePoContext>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                        .g_sales_order_line_main_rec.attribute_category ||
                         '</linePoContext>'); -- Need to check the mapping
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute1>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute1,
                                            0) || '</attribute1>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute2>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute2,
                                            0) || '</attribute2>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute3>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute3,
                                            0) || '</attribute3>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute4>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute4,
                                            0) || '</attribute4>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute5>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute5,
                                            0) || '</attribute5>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute6>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute6,
                                            0) || '</attribute6>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute7>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute7,
                                            0) || '</attribute7>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute8>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute8,
                                            0) || '</attribute8>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute9>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute9,
                                            0) || '</attribute9>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute10>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute10,
                                            0) || '</attribute10>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute11>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute11,
                                            0) || '</attribute11>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute12>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute12,
                                            0) || '</attribute12>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute13>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute13,
                                            0) || '</attribute13>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute14>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute14,
                                            0) || '</attribute14>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute15>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute15,
                                            0) || '</attribute15>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute16>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute16,
                                            0) || '</attribute16>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute17>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute17,
                                            0) || '</attribute17>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute18>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute18,
                                            0) || '</attribute18>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute19>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute19,
                                            0) || '</attribute19>');
        dbms_lob.append(g_xxont1239_payload,
                        '<attribute20>' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.attribute20,
                                            0) || '</attribute20>');
        dbms_lob.append(g_xxont1239_payload,
                        '<userItemDescription >' ||
                        dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                            .g_sales_order_line_main_rec.user_item_description,
                                            0) || '</userItemDescription >');

        --Added for CR24018

        for c_addl_data in (select x.attribute2
                              from xxint_event_type_key_vals x,
                                   mtl_parameters            mtp
                             where x.event_type = gc_event_type
                               and x.key_type = gc_key_type
                               and x.key_type_value = gv_source_system
                               and x.key_name = l_org_key_name
                               and x.key_value = mtp.organization_code
                               and mtp.organization_id = gv_ship_from_org_id
                               and gv_ship_from_org_id is not null
                               and x.attribute1 = 'INCLUDE_IN_XXONT1239'
                               and x.attribute3 = 'LINE'
                               and x.status = 'ACTIVE') loop
          dbms_lob.append(g_xxont1239_payload, c_addl_data.attribute2);
        end loop;
        --End of Added for CR24018
        ------------------------------------------------------------
        --Open the line additional attributes loop
        ------------------------------------------------------------
        log_debug('Order Line Additional Attribute Count : ' ||
                  'Line No. ' || i_ol || ' :' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                  .g_order_add_attr_line_tbl_l.COUNT);
        IF gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
         .g_order_add_attr_line_tbl_l.COUNT > 0 THEN
          l_attr_count := 0;
          FOR i_ol_att IN 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                               .g_order_add_attr_line_tbl_l.COUNT LOOP
            gv_poo := 'START GENERATING ORDER LINE ADDITIONAL ATTRIBUTES TAGS';
            -- additional attribute Group Tags
            IF trim(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
                    .attribute_value) IS NOT NULL THEN
              IF (l_attr_count = 0) THEN
                dbms_lob.append(g_xxont1239_payload,
                                '<g_additional_attrs>');
                dbms_lob.append(g_xxont1239_payload,
                                '<XX_ADDITIONAL_ATTRIBUTES>');
                /* commented for QC20554
                dbms_lob.append(g_xxont1239_payload,
                '<ATTRIBUTE><ATTRIBUTE_TYPE></ATTRIBUTE_TYPE><ATTRIBUTE_GROUP></ATTRIBUTE_GROUP><ATTRIBUTE_NAME>ATTRIBUTE12</ATTRIBUTE_NAME><ATTRIBUTE_VALUE>' ||
                gv_order_num ||
                '</ATTRIBUTE_VALUE></ATTRIBUTE>');
                End of commented for QC20554*/
                l_attr_count := l_attr_count + 1;
              END IF;
              dbms_lob.append(g_xxont1239_payload, '<ATTRIBUTE>');
              -- Additional attribute Main tags
              IF gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
               .attribute_type IS NOT NULL THEN
                dbms_lob.append(g_xxont1239_payload,
                                '<attribute_type>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
                                .attribute_type || '</attribute_type>');
              END IF;
              IF gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
               .attribute_group IS NOT NULL THEN
                dbms_lob.append(g_xxont1239_payload,
                                '<attribute_group>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
                                .attribute_group || '</attribute_group>');
              END IF;
              dbms_lob.append(g_xxont1239_payload,
                              '<attribute_name>' ||
                              dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
                                                  .attribute_name,
                                                  0) || '</attribute_name>');
              dbms_lob.append(g_xxont1239_payload,
                              '<attribute_value>' ||
                              dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_add_attr_line_tbl_l(i_ol_att)
                                                  .attribute_value,
                                                  0) ||
                              '</attribute_value>');
              -- additional attribute Group Tags
              dbms_lob.append(g_xxont1239_payload, '</ATTRIBUTE>');
            END IF;
            IF (i_ol_att = gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
               .g_order_add_attr_line_tbl_l.COUNT AND l_attr_count <> 0) THEN
              dbms_lob.append(g_xxont1239_payload,
                              '</XX_ADDITIONAL_ATTRIBUTES>');
              dbms_lob.append(g_xxont1239_payload, '</g_additional_attrs>');
            END IF;
          END LOOP; -- end of order line g_order_add_attr_line_tbl loop
        END IF;
        ----------------------------------------------------------
        --Open the order line pricing attribute loop
        ---------------------------------------------------------
        FOR i_ol_pat IN 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_order_prc_attr_line_tbl_l.COUNT LOOP
          gv_poo := 'START GENERATING ORDER LINE PRICING ATTRIBUTES TAGS';
          -- Order line pricing attribute Group Tags
          IF (i_ol_pat = 1) THEN
            dbms_lob.append(g_xxont1239_payload, '<g_price_attrs>');
          END IF;
          dbms_lob.append(g_xxont1239_payload, '<price_attr_line>');
          --Order header pricing attributes main tags
          dbms_lob.append(g_xxont1239_payload,
                          '<context>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                          .CONTEXT || '</context>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute1>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute1,
                                              0) || '</attribute1>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute2>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute2,
                                              0) || '</attribute2>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute3>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute3,
                                              0) || '</attribute3>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute4>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute4,
                                              0) || '</attribute4>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute5>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute5,
                                              0) || '</attribute5>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute6>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute6,
                                              0) || '</attribute6>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute7>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute7,
                                              0) || '</attribute7>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute8>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute8,
                                              0) || '</attribute8>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute9>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute9,
                                              0) || '</attribute9>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute10>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute10,
                                              0) || '</attribute10>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute11>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute11,
                                              0) || '</attribute11>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute12>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute12,
                                              0) || '</attribute12>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute13>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute13,
                                              0) || '</attribute13>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute14>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute14,
                                              0) || '</attribute14>');
          dbms_lob.append(g_xxont1239_payload,
                          '<attribute15>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .attribute15,
                                              0) || '</attribute15>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_context>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                          .pricing_context || '</pricing_context>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute1>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute1,
                                              0) || '</pricing_attribute1>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute2>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute2,
                                              0) || '</pricing_attribute2>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute3>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute3,
                                              0) || '</pricing_attribute3>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute4>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute4,
                                              0) || '</pricing_attribute4>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute5>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute5,
                                              0) || '</pricing_attribute5>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute6>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute6,
                                              0) || '</pricing_attribute6>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute7>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute7,
                                              0) || '</pricing_attribute7>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute8>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute8,
                                              0) || '</pricing_attribute8>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute9>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute9,
                                              0) || '</pricing_attribute9>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute10>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute10,
                                              0) ||
                          '</pricing_attribute10>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute11>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute11,
                                              0) ||
                          '</pricing_attribute11>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute12>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute12,
                                              0) ||
                          '</pricing_attribute12>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute13>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute13,
                                              0) ||
                          '</pricing_attribute13>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute14>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute14,
                                              0) ||
                          '</pricing_attribute14>');
          dbms_lob.append(g_xxont1239_payload,
                          '<pricing_attribute15>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute15,
                                              0) ||
                          '</pricing_attribute15>');
          -- Order line pricing attribute Group Tags
          dbms_lob.append(g_xxont1239_payload, '</price_attr_line>');
          IF (i_ol_pat = gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
             .g_order_prc_attr_line_tbl_l.COUNT) THEN
            dbms_lob.append(g_xxont1239_payload, '</g_price_attrs>');
          END IF;
        END LOOP; -- end of order line g_order_prc_attr_line_tbl_l loop
        ----------------------------------------------------------
        --Open the order Line pricing Adjustment loop
        ---------------------------------------------------------
        log_debug('Order Line Pricing Adjustment Count : ' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                  .g_order_prc_adj_rec_tbl_l.COUNT);
        IF gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
         .g_order_prc_adj_rec_tbl_l.COUNT > 0 THEN
          FOR i_ol_padj IN 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                                .g_order_prc_adj_rec_tbl_l.COUNT LOOP
            gv_poo := 'START GENERATING ORDER HEADER PRICING ATTRIBUTES TAGS';
            -- Order header pricing attribute Group Tags
            IF (i_ol_padj = 1) THEN
              dbms_lob.append(g_xxont1239_payload, '<g_price_adjs>');
            END IF;
            dbms_lob.append(g_xxont1239_payload, '<price_adj_line>');
            dbms_lob.append(g_xxont1239_payload,
                            '<orig_sys_discount_ref>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .ORIG_SYS_DISCOUNT_REF ||
                             '</orig_sys_discount_ref>');
            dbms_lob.append(g_xxont1239_payload,
                            '<change_sequence>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .CHANGE_SEQUENCE || '</change_sequence>');
            dbms_lob.append(g_xxont1239_payload,
                            '<change_request_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .CHANGE_REQUEST_CODE || '</change_request_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<automatic_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .AUTOMATIC_FLAG || '</automatic_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<context>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .CONTEXT || '</context>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute1>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE1,
                                                0) || '</attribute1>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute2>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE2,
                                                0) || '</attribute2>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute3>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE3,
                                                0) || '</attribute3>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute4>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE4,
                                                0) || '</attribute4>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute5>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE5,
                                                0) || '</attribute5>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute6>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE6,
                                                0) || '</attribute6>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute7>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE7,
                                                0) || '</attribute7>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute8>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE8,
                                                0) || '</attribute8>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute9>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE9,
                                                0) || '</attribute9>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute10>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE10,
                                                0) || '</attribute10>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute11>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE11,
                                                0) || '</attribute11>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute12>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE12,
                                                0) || '</attribute12>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute13>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE13,
                                                0) || '</attribute13>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute14>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE14,
                                                0) || '</attribute14>');
            dbms_lob.append(g_xxont1239_payload,
                            '<attribute15>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .ATTRIBUTE15,
                                                0) || '</attribute15>');
            dbms_lob.append(g_xxont1239_payload,
                            '<list_header_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .LIST_HEADER_ID || '</list_header_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<list_name>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .LIST_NAME || '</list_name>');
            dbms_lob.append(g_xxont1239_payload,
                            '<list_line_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .LIST_LINE_ID || '</list_line_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<list_line_type_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .LIST_LINE_TYPE_CODE || '</list_line_type_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<modifier_mechanism_type_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .MODIFIER_MECHANISM_TYPE_CODE ||
                             '</modifier_mechanism_type_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<modified_from>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .MODIFIED_FROM || '</modified_from>');
            dbms_lob.append(g_xxont1239_payload,
                            '<modified_to>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .MODIFIED_TO || '</modified_to>');
            dbms_lob.append(g_xxont1239_payload,
                            '<updated_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .UPDATED_FLAG || '</updated_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<update_allowed>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .UPDATE_ALLOWED || '</update_allowed>');
            dbms_lob.append(g_xxont1239_payload,
                            '<applied_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .APPLIED_FLAG || '</applied_flag>');
            if gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
             .CHANGE_REASON_CODE is null and gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
               .CHANGE_REASON_TEXT is null and
                g_Price_adj_reason_key_val is not null then
              dbms_lob.append(g_xxont1239_payload,
                              '<change_reason_code>' ||
                              g_Price_adj_reason_code_val ||
                              '</change_reason_code>');
            else
              dbms_lob.append(g_xxont1239_payload,
                              '<change_reason_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                              .CHANGE_REASON_CODE || '</change_reason_code>');
            end if;
            dbms_lob.append(g_xxont1239_payload,
                            '<change_reason_text>' ||
                            dbms_xmlgen.convert(NVL(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                    .CHANGE_REASON_TEXT,
                                                    g_Price_adj_reason_key_val),
                                                0) ||
                            '</change_reason_text>'); -- Added NVL condition as per CR23505
            dbms_lob.append(g_xxont1239_payload,
                            '<discount_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .DISCOUNT_ID || '</discount_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<discount_line_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .DISCOUNT_LINE_ID || '</discount_line_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<discount_name>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .DISCOUNT_NAME,
                                                0) || '</discount_name>');
            dbms_lob.append(g_xxont1239_payload,
                            '<percent>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .PERCENT || '</percent>');
            dbms_lob.append(g_xxont1239_payload,
                            '<operation_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .OPERATION_CODE || '</operation_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<operand>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .OPERAND || '</operand>');
            dbms_lob.append(g_xxont1239_payload,
                            '<arithmetic_operator>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .ARITHMETIC_OPERATOR || '</arithmetic_operator>');
            dbms_lob.append(g_xxont1239_payload,
                            '<pricing_phase_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .PRICING_PHASE_ID || '</pricing_phase_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<adjusted_amount>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .ADJUSTED_AMOUNT || '</adjusted_amount>');
            dbms_lob.append(g_xxont1239_payload,
                            '<modifier_name>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .MODIFIER_NAME,
                                                0) || '</modifier_name>');
            dbms_lob.append(g_xxont1239_payload,
                            '<list_line_number>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .LIST_LINE_NUMBER || '</list_line_number>');
            dbms_lob.append(g_xxont1239_payload,
                            '<version_number>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .VERSION_NUMBER || '</version_number>');
            dbms_lob.append(g_xxont1239_payload,
                            '<invoiced_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .INVOICED_FLAG || '</invoiced_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<estimated_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .ESTIMATED_FLAG || '</estimated_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<inc_in_sales_performance>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .INC_IN_SALES_PERFORMANCE ||
                             '</inc_in_sales_performance>');
            dbms_lob.append(g_xxont1239_payload,
                            '<charge_type_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .CHARGE_TYPE_CODE || '</charge_type_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<charge_subtype_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .CHARGE_SUBTYPE_CODE || '</charge_subtype_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<credit_or_charge_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .CREDIT_OR_CHARGE_FLAG ||
                             '</credit_or_charge_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<include_on_returns_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .INCLUDE_ON_RETURNS_FLAG ||
                             '</include_on_returns_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<cost_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .COST_ID || '</cost_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<tax_code>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .TAX_CODE || '</tax_code>');
            dbms_lob.append(g_xxont1239_payload,
                            '<parent_adjustment_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .PARENT_ADJUSTMENT_ID ||
                             '</parent_adjustment_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_context>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .AC_CONTEXT || '</ac_context>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute1>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE1,
                                                0) || '</ac_attribute1>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute2>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE2,
                                                0) || '</ac_attribute2>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute3>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE3,
                                                0) || '</ac_attribute3>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute4>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE4,
                                                0) || '</ac_attribute4>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute5>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE5,
                                                0) || '</ac_attribute5>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute6>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE6,
                                                0) || '</ac_attribute6>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute7>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE7,
                                                0) || '</ac_attribute7>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute8>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE8,
                                                0) || '</ac_attribute8>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute9>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE9,
                                                0) || '</ac_attribute9>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute10>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE10,
                                                0) || '</ac_attribute10>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute11>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE11,
                                                0) || '</ac_attribute11>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute12>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE12,
                                                0) || '</ac_attribute12>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute13>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE13,
                                                0) || '</ac_attribute13>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute14>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE14,
                                                0) || '</ac_attribute14>');
            dbms_lob.append(g_xxont1239_payload,
                            '<ac_attribute15>' ||
                            dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                                                .AC_ATTRIBUTE15,
                                                0) || '</ac_attribute15>');
            dbms_lob.append(g_xxont1239_payload,
                            '<operand_per_pqty>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .OPERAND_PER_PQTY || '</operand_per_pqty>');
            dbms_lob.append(g_xxont1239_payload,
                            '<adjusted_amount_per_pqty>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .ADJUSTED_AMOUNT_PER_PQTY ||
                             '</adjusted_amount_per_pqty>');
            dbms_lob.append(g_xxont1239_payload,
                            '<price_adjustment_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .PRICE_ADJUSTMENT_ID || '</price_adjustment_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<tax_rate_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .TAX_RATE_ID || '</tax_rate_id>');
            dbms_lob.append(g_xxont1239_payload,
                            '<error_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .ERROR_FLAG || '</error_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<interface_status>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .INTERFACE_STATUS || '</interface_status>');
            dbms_lob.append(g_xxont1239_payload,
                            '<status_flag>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .STATUS_FLAG || '</status_flag>');
            dbms_lob.append(g_xxont1239_payload,
                            '<sold_to_org>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .SOLD_TO_ORG || '</sold_to_org>');
            dbms_lob.append(g_xxont1239_payload,
                            '<sold_to_org_id>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_padj)
                            .SOLD_TO_ORG_ID || '</sold_to_org_id>');
            dbms_lob.append(g_xxont1239_payload, '</price_adj_line>');
            IF (i_ol_padj = gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
               .g_order_prc_adj_rec_tbl_l.COUNT) THEN
              dbms_lob.append(g_xxont1239_payload, '</g_price_adjs>');
            END IF;
          END LOOP;
        END IF;
        /* The g_src_attributes_tbl loop is not opened as the columns of this does not match with the G_SC group tags of the XXONT1239 xml*/
        ----------------------------------------------------------
        --Open the order line order attachment loop
        ---------------------------------------------------------
        FOR i_ol_amt IN 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_order_attachment_tbl_l.COUNT LOOP
          gv_poo := 'START GENERATING ORDER LINE ATTACHMENT TAGS';
          -- Order line attachment Group Tags
          IF (i_ol_amt = 1) THEN
            dbms_lob.append(g_xxont1239_payload, '<G_AT_L>');
          END IF;
          dbms_lob.append(g_xxont1239_payload, '<O_AL>');
          -- Order line attachment main Tags
          dbms_lob.append(g_xxont1239_payload,
                          '<lineNumber>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_attachment_tbl_l(i_ol_amt)
                          .line_number || '</lineNumber>');
          dbms_lob.append(g_xxont1239_payload,
                          '<noteType>' || gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_attachment_tbl_l(i_ol_amt)
                          .attachment_type || '</noteType>'); -- Need to check the mapping for document id
          dbms_lob.append(g_xxont1239_payload,
                          '<notes>' || dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_attachment_tbl_l(i_ol_amt)
                                                           .short_text,
                                                           0) || '</notes>');
          -- Order line attachment Group Tags
          dbms_lob.append(g_xxont1239_payload, '</O_AL>');
          IF (i_ol_amt = gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
             .g_order_attachment_tbl_l.COUNT) THEN
            dbms_lob.append(g_xxont1239_payload, '</G_AT_L>');
          END IF;
        END LOOP; --end of order line g_order_attachment_tbl loop
        --Order line group tags
        dbms_lob.append(g_xxont1239_payload, '</OL>');
        IF (i_ol = gv_sales_order_header_tbl(i_oh)
           .g_sales_order_line_tbl.COUNT) THEN
          dbms_lob.append(g_xxont1239_payload, '</G_OL>');
        END IF;
      END LOOP; -- end of order line g_sales_order_line_tbl loop
      /* Changes for Sales Credit Added for HPQC21314 */
      IF gv_sales_order_header_tbl(i_oh).g_sales_credit_hdr_tbl.count > 0 THEN
        dbms_lob.append(g_xxont1239_payload, '<G_SC>');
        FOR i_sc IN 1 .. gv_sales_order_header_tbl(i_oh)
                         .g_sales_credit_hdr_tbl.count LOOP
          dbms_lob.append(g_xxont1239_payload, '<SC>');
          dbms_lob.append(g_xxont1239_payload,
                          '<salesrepId>' || gv_sales_order_header_tbl(i_oh).g_sales_credit_hdr_tbl(i_sc)
                          .salesrepID || '</salesrepId>');
          dbms_lob.append(g_xxont1239_payload,
                          '<salesrep>' ||
                          dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh).g_sales_credit_hdr_tbl(i_sc)
                                              .salesrep,
                                              0) || '</salesrep>');
          dbms_lob.append(g_xxont1239_payload,
                          '<salesCreditTypeId>' || gv_sales_order_header_tbl(i_oh).g_sales_credit_hdr_tbl(i_sc)
                          .salesCreditTypeId || '</salesCreditTypeId>');
          dbms_lob.append(g_xxont1239_payload,
                          '<salesCreditType>' || gv_sales_order_header_tbl(i_oh).g_sales_credit_hdr_tbl(i_sc)
                          .salesCreditType || '</salesCreditType>');
          dbms_lob.append(g_xxont1239_payload,
                          '<percent>' || gv_sales_order_header_tbl(i_oh).g_sales_credit_hdr_tbl(i_sc)
                          .percent || '</percent>');
          dbms_lob.append(g_xxont1239_payload, '</SC>');
        END LOOP;
        dbms_lob.append(g_xxont1239_payload, '</G_SC>');
      END IF;
      /* End of Changes for Sales Credit Added for HPQC21314 */
      -- End order header tags
      dbms_lob.append(g_xxont1239_payload, '</OH>');
      dbms_lob.append(g_xxont1239_payload, '</G_OH>');
      gv_poo := 'After creating the complete XML from Order header Record type and Table';
      log_debug(gv_procedure_name || '.' || gv_poo);
      BEGIN
        SELECT (deletexml(xmltype(g_xxont1239_payload), '//*[not(node())]'))
               .getClobVal()
          INTO gv_xxont1239_payload
          FROM dual;
      EXCEPTION
        WHEN OTHERS THEN
          gv_xxont1239_payload := g_xxont1239_payload;
          log_debug('Exception while removing Empty Tags in 1239 CLOB :' ||
                    SUBSTR(SQLERRM, 1, 200),
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      END;
      BEGIN
        xxint_event_api_pub.create_event(x_api_return_type   => lv_api_return_type,
                                         p_event_type        => gc_ord_cre_event_type,
                                         p_content_clob      => gv_xxont1239_payload,
                                         p_content_clob_code => 'HTTP_RECEIVE_XML_PAYLOAD_IN');
        --                                         p_attribute14       => gv_guid);
        --
        COMMIT;
        --
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      IF x_guid IS NULL THEN
        x_guid := lv_api_return_type.guid;
      ELSE
        x_guid := x_guid || '|' || lv_api_return_type.guid;
      END IF;
      --Add Clob for Order Data Lookup
      IF l_order_count = 0 THEN
        l_order_status_clob := '<G_ORDER>';
      END IF;
      dbms_lob.append(l_order_status_clob, '<G_ORDER_DATA>');
      --if gv_source_system = 'SPECTRUM_LA' THEN
      dbms_lob.append(l_order_status_clob,
                      '<ORDER_REF>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute8,
                                          0) || '</ORDER_REF>');
      --end if;
      dbms_lob.append(l_order_status_clob,
                      '<ORDER_NUMBER>' ||
                      dbms_xmlgen.convert(gv_sales_order_header_tbl(i_oh)
                                          .g_sales_order_hdr_main_rec.attribute19,
                                          0) || '</ORDER_NUMBER>');
      dbms_lob.append(l_order_status_clob,
                      '<GUID>' || lv_api_return_type.guid || '</GUID>');
      dbms_lob.append(l_order_status_clob, '<ORDER_STATUS></ORDER_STATUS>');
      dbms_lob.append(l_order_status_clob, '<EMAIL_SENT></EMAIL_SENT>');
      dbms_lob.append(l_order_status_clob, '<EMAIL_DATE></EMAIL_DATE>');
      dbms_lob.append(l_order_status_clob, '</G_ORDER_DATA>');
      l_order_count := l_order_count + 1;
      --End of Clob for Order Data Lookup
    END LOOP; -- end of order header loop
    IF l_order_count <> 0 THEN
      dbms_lob.append(l_order_status_clob, '</G_ORDER>');
      xxint_event_api_pub.replace_clob(gv_guid,
                                       'G_ORDER_DATA_CLOB',
                                       l_order_status_clob);
    END IF;
    IF l_order_count > 1 THEN
      x_guid := NULL;
    END IF;
    --End main tag
  EXCEPTION
    WHEN OTHERS THEN
      x_return_status  := gc_error;
      x_return_message := gv_procedure_name || '.' || gv_poo || '.' ||
                          SQLERRM;
      log_debug(x_return_message, XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
  END generate_order_xml;
  /*
  ** Procedure Name  Name: get_response_xml
  **
  ** Purpose:  This procedure is called from Phase1 Procedure to generate the initial Response Payload.
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ----------------   ----------------------------------------
  ** 13-May-15            Jyotsana Kandpal   Created new
  */
  FUNCTION get_response_xml(p_status IN VARCHAR2) RETURN xmltype IS
    l_response_refcur SYS_REFCURSOR;
    l_response_xml    xmltype;
    p_errmsg          VARCHAR2(5000);
  BEGIN
    gv_procedure_name := 'get_response_xml';
    gv_poo            := 'Getting values for Response XML Tags from Cursor';
    IF NVL(p_status, 'XX') = gc_error THEN
      IF g_error_tbl.COUNT > 0 THEN
        FOR error_count IN 1 .. g_error_tbl.COUNT LOOP
          p_errmsg := p_errmsg || g_error_tbl(error_count).error_text || '.';
        END LOOP;
      END IF;
      p_errmsg := 'Validation failed. Please review event log for more details';
    ELSE
      p_errmsg := 'Event Created Successfully';
    END IF;
    OPEN l_response_refcur FOR
      SELECT p_status            status_code,
             p_errmsg            status_message,
             gv_source_reference externalmessageid,
             gv_guid             xxintmessageid
        FROM dual;
    gv_poo         := 'Converting Cursor Query Result to XML';
    l_response_xml := xx_pk_xml_util.p_query_to_xml(iv_main_tag      => 'ProjectCreateUpdateAckResponse',
                                                    iv_row_set_tag   => NULL,
                                                    iv_row_tag       => 'STATUS',
                                                    i_data_cur       => l_response_refcur,
                                                    i_return_type    => xx_pk_xml_util.cv_xml_fragment,
                                                    in_null_handling => gc_display_null_tags);
    CLOSE l_response_refcur;
    RETURN l_response_xml;
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('ERROR IN GET_RESPONSE_XML() ' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      RETURN NULL;
  END get_response_xml;
  --<Start> Added for CR24533
  --procedure to calculate and compare the so amount and task funcding--kanak CR24533 test
   /*
  ** Procedure Name  Name: validate_so_amt
  **
  ** Purpose:  This function is called to validate the task fund , if adequate fund available then only it will proceed with SO craetion.
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ----------------   ----------------------------------------
  ** 03-SEP-2020          Kanak             Created new  to validate the task fund , if adequate fund available then only it will proceed with SO craetion.
  */
  function validate_so_amt return varchar2
  is
  lv_unit_price VARCHAR2(500);
  lv_log_msg              VARCHAR2(500);
  lv_count number;
  i number:=0;
  lv_task_fund number;
  lv_so_amount number:=0;
  lv_so_amount_total number:=0;
  lv_so_line_charge_amt number;
  l_task_valid VARCHAR2(1) := 'Y';
  lv_used_task_fund number :=0;
  lv_invalid_record_count number:=0;
  lv_ref_cur sys_refcursor;
  j number:=0;
  begin
  lv_log_msg:='start of validate_so_amt ';
	       log_debug(lv_log_msg);

    lv_count:= gv_sales_order_header_tbl.COUNT;
    /*lv_log_msg:='header count - '||lv_count;
	log_debug(lv_log_msg);*/
    --inserting the values in the custom record
      IF lv_count > 0 THEN
        --FOR i IN 0 .. lv_count LOOP
          --lv_unit_price := gv_sales_order_header_tbl(i).g_order_prc_attr_line_tbl_h(i).pricing_attribute8;
          FOR i_oh IN 1 .. gv_sales_order_header_tbl.COUNT LOOP
          --inside header loop
                  --i:=i_oh;
				  /*lv_log_msg:='inside header loop ';
				  log_debug(lv_log_msg);
				  lv_log_msg:='line count - '||gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl.COUNT;
				  log_debug(lv_log_msg);*/
                  for i_ol in 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl.COUNT loop
                      --inside order line
					    i:=i_ol;
					    /*lv_log_msg:='inside line loop ';
				        log_debug(lv_log_msg);*/
                        gv_so_amount_tbl(i).order_number :=gv_sales_order_header_tbl(i_oh).g_sales_order_hdr_main_rec.attribute19;
                        gv_so_amount_tbl(i).line_num:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                          .g_sales_order_line_main_rec.line_number;
                        gv_so_amount_tbl(i).project_num:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                          .g_sales_order_line_main_rec.project_number;
                        gv_so_amount_tbl(i).task_num:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                          .g_sales_order_line_main_rec.task_number;
                        gv_so_amount_tbl(i).ordered_quantity:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                          .g_sales_order_line_main_rec.ordered_quantity;


						 /*lv_log_msg:='pricing attribute count - '||gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_order_prc_attr_line_tbl_l.COUNT;
						 log_debug(lv_log_msg);*/
                        FOR i_ol_pat IN 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_order_prc_attr_line_tbl_l.COUNT LOOP
                            ---inside pricing attribute loop
							/*lv_log_msg:='inside pricing attribute loop ';
						    log_debug(lv_log_msg);*/
                            gv_so_amount_tbl(i).unit_price:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_attr_line_tbl_l(i_ol_pat)
                                              .pricing_attribute8;

                        end loop;
						/*lv_log_msg:='pricing adjustment count - '||gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_order_prc_adj_rec_tbl_l.COUNT;
						 log_debug(lv_log_msg);*/
                        FOR i_ol_pat_adj IN 1 .. gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol)
                             .g_order_prc_adj_rec_tbl_l.COUNT LOOP
                             --inside pricing adjustment loop
							/* lv_log_msg:='inside pricing adjustment loop ';
						    log_debug(lv_log_msg);*/
                             gv_so_amount_tbl(i).OPERAND:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_pat_adj)
                                              .OPERAND;
                             gv_so_amount_tbl(i).ARITHMETIC_OPERATOR:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_pat_adj)
                                              .ARITHMETIC_OPERATOR;
                             gv_so_amount_tbl(i).ADJUSTED_AMOUNT:=gv_sales_order_header_tbl(i_oh).g_sales_order_line_tbl(i_ol).g_order_prc_adj_rec_tbl_l(i_ol_pat_adj)
                                              .ADJUSTED_AMOUNT;
                        end loop;
                    end loop;
             end loop;
     end if;
     i:=0;

    ---for each distinct record validating task fund and so amount
    FOR c_distinct_task_rec IN (SELECT DISTINCT extractvalue(tmp_m.column_value,
                                       '/ORDER_LINE/TASK_NUMBER',NULL) task_num,
                                       extractvalue(tmp_m.column_value,
                                       '/ORDER_LINE/PROJECT_NUMBER',NULL) project_num
                                FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'HTTP_RECEIVE_XML_PAYLOAD_IN'))
                               .extract('//EBS_PROJECT_ORDER/DATA_AREA/G_PROJECT_ORDERS/G_ORDER/ORDER_HEADER/G_ORDER_LINE/ORDER_LINE',
                                        NULL))) tmp_m
                                )loop
   /* lv_log_msg:='inside loop ';
    log_debug(lv_log_msg);
    lv_log_msg:='c_distinct_task_rec.project_num '|| c_distinct_task_rec.project_num;
    log_debug(lv_log_msg);
    lv_log_msg:='c_distinct_task_rec.task_num '|| c_distinct_task_rec.task_num;
    log_debug(lv_log_msg);*/

    lv_task_fund:=0;
    lv_so_amount_total:=0;
      --calculating task fund
      begin
          SELECT SUM(ppf.allocated_amount)
              INTO lv_task_fund
              FROM pa_project_fundings ppf ,
              pa_projects_all ppa,
              pa_tasks pt
              WHERE ppf.project_id = ppa.project_id
               AND ppf.task_id = pt.task_id
               and pt.project_id = ppa.project_id
               and ppa.segment1 = c_distinct_task_rec.project_num
               and pt.task_number = c_distinct_task_rec.task_num
               and ppf.BUDGET_TYPE_CODE = 'BASELINE'
                ;
      exception when others then
        lv_task_fund:=0;
      end;

      --calculating the already used task fund for sales order
      begin
        SELECT nvl(sum((ol.ordered_quantity*oopa.pricing_attribute8)+
           SUM(pa.adjusted_amount * ol.ordered_quantity)),0) so_amt
        into lv_used_task_fund
         FROM
             oe_price_adjustments pa,
             oe_order_lines_all ol,
             OE_ORDER_PRICE_ATTRIBS oopa,
             pa_projects_all ppa,
             pa_tasks pt
         WHERE
             pa.line_id = ol.line_id
             AND pa.header_id = ol.header_id
             AND pa.list_line_type_code = 'FREIGHT_CHARGE'
             and oopa.line_id = ol.line_id
             and ppa.project_id = ol.project_id
             and pt.project_id = ppa.project_id
             and pt.task_id = ol.task_id
             and ppa.segment1 = c_distinct_task_rec.project_num
             and pt.task_number = c_distinct_task_rec.task_num
         GROUP BY
             pa.header_id,oopa.pricing_attribute8,ol.ordered_quantity;
      exception when others then
         lv_used_task_fund:=0;
      end;

	  lv_log_msg:='lv_used_task_fund = '||lv_used_task_fund;
             log_debug(lv_log_msg);

    --calculating total so amount for that task
    FOR i IN 1 .. gv_so_amount_tbl.COUNT LOOP
        lv_so_amount:=0;
		lv_so_line_charge_amt:=0;
        if(gv_so_amount_tbl(i).task_num = c_distinct_task_rec.task_num) then
             --calculating sales order amount
			 lv_log_msg:='gv_so_amount_tbl(i).task_num '|| gv_so_amount_tbl(i).task_num;
             log_debug(lv_log_msg);
			 lv_log_msg:='c_distinct_task_rec.task_num '|| c_distinct_task_rec.task_num;
             log_debug(lv_log_msg);
			 lv_log_msg:='gv_so_amount_tbl(i).arithmetic_operator '|| gv_so_amount_tbl(i).arithmetic_operator;
             log_debug(lv_log_msg);
             if(gv_so_amount_tbl(i).arithmetic_operator = 'LUMPSUM') then

				lv_log_msg:='gv_so_amount_tbl(i).OPERAND '|| gv_so_amount_tbl(i).OPERAND;
                log_debug(lv_log_msg);
				lv_so_line_charge_amt:= gv_so_amount_tbl(i).OPERAND;
             else

				lv_log_msg:='gv_so_amount_tbl(i).adjusted_amount '|| gv_so_amount_tbl(i).adjusted_amount;
                log_debug(lv_log_msg);
				lv_log_msg:='gv_so_amount_tbl(i).ordered_quantity '|| gv_so_amount_tbl(i).ordered_quantity;
                log_debug(lv_log_msg);
				lv_so_line_charge_amt:= nvl(gv_so_amount_tbl(i).adjusted_amount,0) * gv_so_amount_tbl(i).ordered_quantity;
             end if;

             lv_log_msg:='lv_so_line_charge_amt '|| lv_so_line_charge_amt;
             log_debug(lv_log_msg);
			 lv_log_msg:='gv_so_amount_tbl(i).unit_price '|| gv_so_amount_tbl(i).unit_price;
             log_debug(lv_log_msg);
			 lv_log_msg:='gv_so_amount_tbl(i).ordered_quantity '|| gv_so_amount_tbl(i).ordered_quantity;
             log_debug(lv_log_msg);

             lv_so_amount:=(gv_so_amount_tbl(i).unit_price * gv_so_amount_tbl(i).ordered_quantity)+ nvl(lv_so_line_charge_amt,0);
			 lv_log_msg:='lv_so_amount '|| lv_so_amount;
             log_debug(lv_log_msg);

             lv_so_amount_total:= lv_so_amount_total+lv_so_amount; --new so amount
     end if;

    end loop;

	lv_log_msg:='lv_so_amount_total '|| lv_so_amount_total;
    log_debug(lv_log_msg);

    INSERT INTO XXPA2592_TASK_FUND_VALID_GTT VALUES (
        c_distinct_task_rec.project_num,
        c_distinct_task_rec.task_num,
        lv_used_task_fund,
        lv_task_fund,
        lv_task_fund - lv_used_task_fund,
        lv_so_amount_total
    );

      if(lv_so_amount_total > (lv_task_fund-lv_used_task_fund)) then
             lv_log_msg:='so amount is greater than task fund ';
             log_debug(lv_log_msg);
             lv_invalid_record_count:=lv_invalid_record_count+1;
         else
             lv_log_msg:='so amount is less than task fund ';
             log_debug(lv_log_msg);
         end if;
      j:=J+1;
end loop;

lv_log_msg:='Number of invalid task fund count = '||lv_invalid_record_count;
             log_debug(lv_log_msg);

  if lv_invalid_record_count > 0 then
  return 'N';
  else return 'Y';
  end if;
 exception when others then
    log_debug('Exception in calcualting the xml so amount :' ||
                SUBSTR(SQLERRM, 1, 200),
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
    return 'N';
  end validate_so_amt;

--<End> Added for CR24533

  /*
  ** Procedure Name  Name: phase1
  **
  ** Purpose:  This procedure is called from XXINT Event XXPA2592_EQUIP_ORDER_IN , Phase 1 Hook.
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ----------------   ----------------------------------------
  ** 13-May-15            Jyotsana Kandpal   Created new
  */
  PROCEDURE phase1(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2) IS
    x_return_status  VARCHAR2(2000) := NULL;
    x_return_message VARCHAR2(4000) := NULL;
    l_response_xml   xmltype;
    l_event_status   VARCHAR2(200);
    lv_request_id    NUMBER; --Added by Joydeb
    l_phase_when     xxint_event_types.phase01_when%TYPE; --Added by Joydeb
    lv_value varchar2(10);
  BEGIN
    gv_event_current_phase := 'PHASE01';
    x_retcode              := 0;
    x_errbuff              := NULL;
    x_return_status        := 'SUCCESS';
    gv_procedure_name      := 'Phase1';
    gv_poo                 := 'Start Phase1 Hook';
    gv_guid                := p_guid;
    log_debug(gv_procedure_name || '.' || gv_poo);
    --SET GLobal Variables
    set_global_variables(p_guid);
    -- Check if Partner is valid
    IF xxint_event_type_utils.valid_partner_code(gv_source_system) THEN
      log_debug('Partner code is Valid');
    ELSE
      x_return_status := gc_error;
      log_error('Partner(' || gv_source_system ||
                ') is not enabled. Please check if the Partner code entered is valid');
      x_return_message := x_return_message || 'Partner(' ||
                          gv_source_system ||
                          ') is not enabled. Please check if the Partner code entered is valid';
    END IF;
    --Check if Parter is enabled for XXPA2592
    gv_partner_sync_enabled := xxint_event_type_utils.get_key_parm_value(p_event_type     => gc_event_type,
                                                                         p_key_type       => gc_key_type,
                                                                         p_key_type_value => gv_source_system,
                                                                         p_name           => gc_enabled_keyname);
    IF NVL(gv_partner_sync_enabled, 'X') = 'Y' THEN
      log_debug('Partner Sync is Enabled');
    ELSE
      x_return_status  := gc_error;
      x_return_message := x_return_message ||
                          'Partner is enabled. Please check if the Partner code entered is valid';
      log_error('Project Order Sync is not enabled. Please check if the Partner code entered is valid');
    END IF;
    -- Check if request type is 'P' or 'S'
    IF nvl(gv_request_type, 'X') NOT IN ('P', 'S') THEN
      x_return_status := gc_error;
      log_error('Please enter a valid request type');
    END IF;
    -- Generate Response XML
    l_response_xml := get_response_xml(x_return_status);
    xxint_event_api_pub.replace_clob(p_guid,
                                     'HTTP_RECEIVE_XML_PAYLOAD_OUT',
                                     l_response_xml.getclobval());
    IF x_return_status = gc_error THEN
      l_event_status := 'PARTNER_VALIDATION_ERROR';
      x_retcode      := -1;
      x_errbuff      := x_return_message;
    ELSE
      l_event_status := 'PARTNER_VALIDATION_COMPLETE';
      x_retcode      := 0;
    END IF;
    --Update Event Attributes
    xxint_event_api_pub.update_event(p_guid       => gv_guid,
                                     p_attribute1 => gv_source_system,
                                     p_attribute2 => gv_request_type,
                                     p_attribute3 => l_event_status,
                                     p_attribute4 => gv_agreement_num,
                                     p_attribute5 => gv_cust_po_number,
                                     p_attribute6 => gv_project_num,
                                     p_attribute7 => gv_order_num,
                                     p_attribute8 => gv_prj_version_num);
    -- Call Email Notification
    send_email_notification(p_message_code  => NULL,
                            p_error_message => NULL);
    -- Call report Rec Update Added for CR23274 XXONT3030
    generate_report_data;
    -- End of Added for CR23274 XXONT3030
    --Added by Joydeb to submit the event background process
    SELECT phase02_when
      INTO l_phase_when
      FROM xxint_event_types
     where event_type = gc_event_type;

    lv_request_id := submit_xxint_bkg_program(p_guid                       => gv_guid,
                                              p_event_phase                => 'PHASE02',
                                              p_event_interval             => l_phase_when,
                                              p_event_type                 => gc_event_type,
                                              p_event_owner                => 'SVC',
                                              p_override_next_attempt_time => 'Y',
                                              p_lock_timeout_sec           => '60');

    --End of addition by Joydeb

  EXCEPTION
    WHEN OTHERS THEN
      log_debug('ERROR IN PHASE1() ' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      x_retcode := -1;
      x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
  END phase1;
  /*
  ** Procedure Name  Name: phase2
  **
  ** Purpose:  This procedure is called from XXINT Event XXPA2592_EQUIP_ORDER_IN , Phase 2 Hook.
  **
  ** Procedure History:
  ** Date                 Who               Description
  ** ---------            ----------------   ----------------------------------------
  ** 13-May-15            Jyotsana Kandpal   Created new
  */
  PROCEDURE phase2(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2) IS
    x_return_status        VARCHAR2(100) DEFAULT gc_success;
    x_return_message       VARCHAR2(4000) := NULL;
    l_project_exists       VARCHAR2(20);
    lv_api_return_type     xxint_event_api_pub.gt_event_api_type;
    l_event_current_status VARCHAR2(200);
    l_tmp_error_count      NUMBER;
    lv_request_id          NUMBER;
    l_phase_when           xxint_event_types.phase01_when%TYPE; --Added by Joydeb
	lv_log_msg              VARCHAR2(500);--added by Mousami CR24533
	l_project_exp EXCEPTION;
    l_task_fund_exception EXCEPTION;
	lv_customer_exists     NUMBER;
    --<start> added for CR24533
  lv_task_fund_valid_flag varchar2(10);
  lv_cust_order_num varchar2(204);
  lv_refcur SYS_REFCURSOR;
  lv_retcode        NUMBER;
  lv_result    CLOB;
  lv_errbuf           VARCHAR2(2000);
  lv_attachment       VARCHAR2(1000);
  lv_temp_dir            VARCHAR2(40) := 'XXDATA_TMP';
  lv_file_name varchar2(100):='XXPA2592_TASK_FUND_VALIDATION_DTLS.xls';
  --<End> added for CR24533
    CURSOR c_check_proj_event IS
      SELECT *
        FROM apps.xxint_events a
       WHERE event_type = gc_event_type
         AND guid <> p_guid
         AND attribute1 = gv_source_system
         AND attribute2 = gv_request_type
         AND attribute4 = gv_agreement_num
         AND attribute6 = gv_project_num
         AND attribute9 IS NOT NULL;
  BEGIN
    gv_event_current_phase := 'PHASE02';
    gv_procedure_name      := 'Phase2';
    gv_poo                 := 'Start:Get Payload and Process it';
    --SET GLobal Variables
    set_global_variables(p_guid);
    -- Parse Transaction
    parse_transaction(p_xml            => xmltype(gv_payload),
                      x_return_status  => x_return_status,
                      x_return_message => x_return_message);


	--Check the custom_prject_entry_flag is enabled for OU Added By Mousami CR24355(Start)
	BEGIN
		 SELECT nvl(attribute9,'N')
          into gv_custom_proj_flag
          FROM XXINT_EVENT_TYPE_KEY_VALS xxint,
		  apps.hr_operating_units   hou
         WHERE xxint.event_type = gc_event_type
           AND xxint.key_type = gc_key_type
           and xxint.key_type_value = gv_source_system
           and xxint.key_name = gc_operating_unit_code
           and xxint.key_value = hou.short_code
		   and hou.organization_id=gv_operating_unit;
		  log_debug('Custom Project Entry Flag : ' || gv_custom_proj_flag);
	EXCEPTION when OTHERS
	then
		gv_custom_proj_flag:='N';
		log_debug('Custom Project Entry Flag : ' || gv_custom_proj_flag);
	END;
	---Added By Mousami CR24355(End)

    -- Validate Projects
    l_project_exists  := check_project_event_exists;
    l_tmp_error_count := g_error_tbl.count;

    IF gv_request_type = 'P' THEN
      IF NVL(l_project_exists, 'X') = 'Y' THEN
        log_debug('Project Exist');
        l_event_current_status := 'PROJECT_CREATED';
        x_retcode              := 1;
	 ELSIF NVL(l_project_exists, 'X') <> 'Y' and gv_custom_proj_flag='Y'
	 THEN
	  lv_log_msg:='Specified Project'||' '|| gv_project_num||' is not existing in R12 and OU is enabled to create Sales Order only';
	  log_debug(lv_log_msg);
  /* send_email_notification(p_message_code  => NULL,
                              p_error_message => lv_log_msg);*/
	 l_event_current_status:='OU_ENABLE_FOR_SALES_ORDER_CREATION';
	 /* xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                       p_attribute3          => l_event_current_status,
                                       p_current_status      => 'CLOSED',
                                       p_user_status_code    => 'FORCE-CLOSE',
                                       p_user_status_message => lv_log_msg);
      x_return_status := gc_error;
      x_retcode := -1;
      x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || lv_log_msg;
	  raise l_project_exp;*/
	 /* log_error(lv_log_msg);
     --- log_debug('Sales Order Validation Status : ' || x_return_message);
      l_event_current_status := 'OU_ENABLE_FOR_SALES_ORDER_CREATION';
      x_retcode              := 1;*/

	  x_return_status  := gc_error;
      x_return_message := x_return_message ||
                          lv_log_msg;
      log_error(lv_log_msg);

	  raise l_project_exp;
      ELSE
        validate_project_info(x_return_status  => x_return_status,
                              x_return_message => x_return_message);
        log_debug('Project Validation Status : ' || x_return_status);
        IF x_return_status = gc_error OR
           l_tmp_error_count <> g_error_tbl.count THEN
          l_event_current_status := 'PROJECT_VALIDATON_ERROR';
        END IF;
      END IF;
    END IF;
    l_tmp_error_count := g_error_tbl.count;

	If NVL(l_project_exists, 'X') = 'Y' and gv_custom_proj_flag='Y'
    THEN
		SELECT count(1)
		into lv_customer_exists
        FROM pa_projects_all proj, pa_project_customers pc, hz_cust_accounts hc
        WHERE 1 = 1
        AND proj.project_id = pc.project_id
        AND pc.customer_id = hc.cust_account_id
        AND proj.segment1=gv_project_num
        AND hc.account_number=gv_customer_number;
		IF(lv_customer_exists=0)
		THEN
		   lv_log_msg:='Customer selected doesn?t match with Project'||' '|| gv_project_num;
	       log_debug(lv_log_msg);
	       x_return_status  := gc_error;
           x_return_message := x_return_message ||
                          lv_log_msg;
           log_error(lv_log_msg);
           raise l_project_exp; --l_cust_exists_exp
		END IF;
		log_debug('Customer Number:-'||gv_customer_number);
	END IF;

  --<Start>adding validation for customer PO number for CR24533
  If NVL(l_project_exists, 'X') = 'Y' and gv_custom_proj_flag= 'Y'
    THEN
  begin
      select CUSTOMER_ORDER_NUMBER
      into lv_cust_order_num
      from PA_AGREEMENTS_ALL
      where agreement_num = gv_agreement_num;
    exception when others then
      lv_cust_order_num:=null;
    end;
    lv_log_msg:='lv_cust_order_num := '||lv_cust_order_num;
	       log_debug(lv_log_msg);
    if(lv_cust_order_num is null or gv_cust_po_number!=lv_cust_order_num ) then
         lv_log_msg:='Customer PO entered doesnot match with Existing Project Customer PO.';
	       log_debug(lv_log_msg);
	       x_return_status  := gc_error;
           x_return_message := x_return_message ||
                          lv_log_msg;
           log_error(lv_log_msg);

	       raise l_project_exp;
    end if;
  end if;
  -- Validate Sales Order --existing
    validate_sales_order_info(x_return_status  => x_return_status,
                              x_return_message => x_return_message);
  ---adding valdation for task funding for CR24533
  If NVL(l_project_exists, 'X') = 'Y' and gv_custom_proj_flag='Y'
    THEN
      lv_task_fund_valid_flag := validate_so_amt;
      lv_log_msg:='lv_task_fund_valid_flag = '||lv_task_fund_valid_flag;
	  log_debug(lv_log_msg);
      if(lv_task_fund_valid_flag = 'N') then
        lv_log_msg:='Total SO value exceeds Task Funding.';
	       log_debug(lv_log_msg);
	       x_return_status  := gc_error;
           x_return_message := x_return_message ||
                          lv_log_msg;
           log_error(lv_log_msg);

	       raise l_task_fund_exception;
      end if;
  end if;
  --<End>adding validation for customer PO number for CR24533
    -- Generate Project XML
    log_debug('Sales Order Validation Status : ' || x_return_status);
    IF x_return_status = gc_error OR l_tmp_error_count <> g_error_tbl.count THEN
      log_error(x_return_message);
      log_debug('Sales Order Validation Status : ' || x_return_message);
      l_event_current_status := 'OM_VALIDATION_ERROR';
      x_retcode              := 1;
    END IF;
    IF g_error_tbl.COUNT = 0 --x_return_status <> gc_error
       AND gv_proj_guid IS NULL AND gv_request_type = 'P' AND
       NVL(l_project_exists, 'X') <> 'Y' -- Manually Created Project
     THEN
      generate_project_xml(x_return_status  => x_return_status,
                           x_return_message => x_return_message);
      log_debug('After successful Project Creation XML Generation');
      IF NVL(x_return_status, 'XX') <> gc_error THEN
        gv_poo := 'Process Transaction - Call Project Creation Interface';
        log_debug(gv_procedure_name || '.' || gv_poo);
        xxint_event_api_pub.create_event(x_api_return_type   => lv_api_return_type,
                                         p_event_type        => gc_prj_cre_event_type,
                                         p_content_clob      => gv_xxpa2381_payload,
                                         p_content_clob_code => 'HTTP_RECEIVE_XML_PAYLOAD_IN');
        --
        COMMIT;
        --
        gv_proj_guid := lv_api_return_type.guid;
        --Added by Joydeb to submit the event background process
        SELECT phase01_when
          INTO l_phase_when
          FROM xxint_event_types
         where event_type = gc_prj_cre_event_type;

        lv_request_id := submit_xxint_bkg_program(p_guid                       => gv_proj_guid,
                                                  p_event_phase                => 'PHASE01',
                                                  p_event_interval             => l_phase_when,
                                                  p_event_type                 => gc_prj_cre_event_type,
                                                  p_event_owner                => 'SVC',
                                                  p_override_next_attempt_time => 'Y',
                                                  p_lock_timeout_sec           => '60');
        --End of addition by Joydeb
        gv_poo := 'After Calling Project Creation Interface. Update XXINT Event DFF with Project Creation GUID';
        log_debug(gv_procedure_name || '.' || gv_poo);
      END IF;
    END IF;
    IF x_return_status = gc_error OR g_error_tbl.COUNT > 0 THEN
      l_event_current_status := NVL(l_event_current_status,
                                    'PRE_VALIDATION_ERROR');
      x_retcode              := 1;
      send_email_notification(p_message_code  => NULL,
                              p_error_message => NULL);
      xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                       p_attribute3          => l_event_current_status,
                                       -- commented out below line for RT8579992
                                       -- p_current_status      => 'CLOSED',
                                       -- RT8579992
                                       p_user_status_code    => 'FORCE-CLOSE',
                                       p_user_status_message => 'Validation Error. Please review the email/log for details');
    ELSE
      x_retcode := 0;
      IF gv_request_type = 'P' THEN
        IF gv_proj_status IS NULL THEN
          l_event_current_status := 'PROJECT_SUBMITTED';
        ELSE
          l_event_current_status := 'PROJECT_CREATED';
        END IF;
      ELSE
        l_event_current_status := 'OM_VALIDATION_COMPLETE';
      END IF;
      xxint_event_api_pub.update_event(p_guid       => gv_guid,
                                       p_attribute3 => l_event_current_status,
                                       p_attribute9 => gv_proj_guid);
      --Added by Joydeb
      SELECT phase03_when
        into l_phase_when
        from xxint_event_types
       where event_type = gc_event_type;
      --End of addition by Joydeb
      lv_request_id := submit_xxint_bkg_program(p_guid                       => gv_guid,
                                                p_event_phase                => 'PHASE03',
                                                p_event_interval             => l_phase_when, --'EVERY_HOUR', --Modified by Joydeb
                                                p_event_type                 => gc_event_type,
                                                p_event_owner                => 'SVC',
                                                p_override_next_attempt_time => 'Y',
                                                p_lock_timeout_sec           => '60');

    END IF;
    -- Call report Rec Update Added for CR23274 XXONT3030
    generate_report_data;
    -- End of Call report Rec Update Added for CR23274 XXONT3030
  EXCEPTION
  ---<Start> added for CR24533
  WHEN l_project_exp THEN
  xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                       p_attribute3          => l_event_current_status,
									   p_current_phase      => 'CLOSED',
                                       p_current_status      => 'CLOSED',
                                       p_user_status_code    => 'FORCE-CLOSE',
                                       p_user_status_message => lv_log_msg);
	send_email_notification(p_message_code  => NULL,
                              p_error_message => NULL);
    x_retcode := -1;
    x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
    when l_task_fund_exception then
       xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                       p_attribute3          => l_event_current_status,
									   p_current_phase      => 'CLOSED',
                                       p_current_status      => 'CLOSED',
                                       p_user_status_code    => 'FORCE-CLOSE',
                                       p_user_status_message => lv_log_msg);

    begin

    open lv_refcur for
    select * from XXPA2592_TASK_FUND_VALID_GTT;


     xxau_delim_file_util.p_refcur_to_file(o_errbuf         => lv_errbuf,
                                                     o_retcode        => lv_retcode,
                                                     o_clob           => lv_result,
                                                     io_refcursor     => lv_refcur,
                                                     iv_no_data_msg   => NULL,
                                                     ib_encl_quotes   => TRUE,
                                                     iv_date_format   => NULL,
                                                     ib_copy_conc_out => TRUE);

     if DBMS_LOB.GETLENGTH(lv_result) > 0 then
       xx_pk_xml_util.p_clob_to_os_file(p_clob       => lv_result,
                                             iv_file_name => lv_file_name,
                                             iv_dir_name  => lv_temp_dir);
     end if;

            SELECT directory_path || '/' || lv_file_name
            INTO   lv_attachment
            FROM   all_directories
            WHERE  directory_name = lv_temp_dir;
     log_debug('Directory path' || '.' || lv_attachment);
     exception when others then
        log_debug('Exception in preparing attachment file. Error' || sqlerrm);
        lv_attachment:=null;
     end  ;

	send_email_notification(p_message_code  => NULL,
                              p_error_message => NULL,
                              p_attachment => lv_attachment);
    x_retcode := -1;
    x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
    ---<end> added for CR24533
    WHEN OTHERS THEN

      log_debug('ERROR IN PHASE2() ' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      x_retcode := -1;
      x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
  END phase2;

  PROCEDURE phase3(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2) IS
    l_proj_create_evt_status VARCHAR2(2000);
    l_last_process_msg       VARCHAR2(2000);
    l_project_number         VARCHAR2(2000);
    l_project_status_code    VARCHAR2(2000);
    l_status_update          VARCHAR2(200);
    x_return_status          VARCHAR2(2000); --S,W,E(S- Approved and completed , W- Waiting for Approval , E-Errors)
    x_return_message         VARCHAR2(2000);
    l_proj_rev_count         NUMBER := 0;
    l_event_rev_version      VARCHAR2(200);
    l_proj_guid              VARCHAR2(2000);
    l_event_status           VARCHAR2(200);
    l_event_progress         VARCHAR2(200);
    --l_agr_exists             VARCHAR2(1);Commented for CR23783 as not used
    l_project_exists      VARCHAR2(20);
    l_event_count         NUMBER;
    l_retcode             VARCHAR2(100) := NULL;
    l_retmesg             VARCHAR2(4000) := NULL;
    l_pjm_count           NUMBER;
    l_event_open_duration NUMBER;
    l_retension_days      NUMBER;
    l_request_id          NUMBER;
    l_phase_when          xxint_event_types.phase01_when%TYPE; -- Added by Joydeb
    l_event_exists        NUMBER; --added for the  RT#8191446
    l_user_status_code    xxint_events.user_status_code%TYPE; --RT8579992 changes
  BEGIN
    gv_event_current_phase := 'PHASE03';
    x_retcode              := -1;
    x_errbuff              := NULL;
    gv_procedure_name      := 'Phase3';
    gv_poo                 := 'Before checking if the event request is of type P or S';
    log_debug(gv_procedure_name || '.' || gv_poo);

    -- RT8579992 changes
    -- fetch USER_STATUS_CODE value of the current event.
    -- if the value is 'FORCE-CLOSE' then complete this phase as success so that the event will progress and get closed properly.

    l_user_status_code := xxint_event_api_pub.EVENT_FIELD_VALUE_AS_VC2 (p_guid =>p_guid,
                                                                  p_attribute_name => 'USER_STATUS_CODE'
                                                                  );
    log_debug('l_user_status_code:'||l_user_status_code);
    -- RT8579992 changes IF condition added
    IF NVL(l_user_status_code,'X') <> 'FORCE-CLOSE'
    THEN
    --SET GLobal Variables
    set_global_variables(p_guid);

    begin
      select --retention_days
       nvl(xxint_event_type_utils.get_key_parm_value(p_event_type     => 'XXPA2592_EQUIP_ORDER_IN',
                                                     p_key_type       => 'GLOBAL',
                                                     p_key_type_value => 'PROJ_STATUS_CHECK_DAYS',
                                                     p_name           => 'NO_OF_DAYS'),
           120) -- Modified for RT7585104
      ,
       phase04_when --Added by Joydeb
        into l_retension_days, l_phase_when --Added by Joydeb
        from apps.xxint_event_types
       where event_type = gc_event_type;

      select round(sysdate - creation_date)
        into l_event_open_duration
        from apps.xxint_events
       where guid = p_guid;
    exception
      when others then
        NULL;
    end;

    IF gv_request_type = 'P' THEN
      --AND l_agr_exists = 'N' THEN
      --l_agr_exists     := check_agreement_exists(p_guid => p_guid);Commented for CR23783 as not used
      l_project_exists := check_project_event_exists;
      BEGIN
        IF gv_proj_guid IS NOT NULL THEN
          -- Started changes for the  RT#8191446 added the Exception block
          SELECT count(1)
            INTO l_event_exists
            FROM apps.xxint_events
           WHERE guid = gv_proj_guid;
          IF l_event_exists > 0 THEN
            BEGIN
              SELECT attribute5, last_process_msg
                INTO l_proj_create_evt_status, l_last_process_msg
                FROM apps.xxint_events
               WHERE guid = gv_proj_guid
                 AND current_status <> 'READY';
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                log_debug('Awaiting Project Event to Complete guid ' ||
                          gv_proj_guid,
                          XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR);
                RAISE;

            END;
          ELSE
            log_debug('Project event  ' || gv_proj_guid ||
                      ' is purged ,checking the base tables',
                      XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR);
          END IF;
          -- Ended changes for the  RT#8191446
        END IF;
        IF l_proj_create_evt_status = gc_error AND
           NVL(l_project_exists, 'X') <> 'Y' THEN
          log_debug('Error in Project Event');
          log_error(l_last_process_msg);
          BEGIN
            x_errbuff := 'Project Event Completed in Error :' ||
                         l_last_process_msg;
            send_email_notification(p_message_code  => gc_error,
                                    p_error_message => x_return_message);
            x_retcode := 1;
            xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                             p_attribute3          => 'ERROR IN PROJ_EVENT',
                                             -- commented out below line for RT8579992
                                             -- p_current_status      => 'CLOSED',
                                             -- RT8579992
                                             p_user_status_code    => 'FORCE-CLOSE',
                                             p_user_status_message => 'Validation Error. Please review the email/log for details');
          EXCEPTION
            WHEN OTHERS THEN
              log_debug('Exception in Phase 3 Close Event : ' || SQLERRM,
                        XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
          END;
        ELSE
          SELECT upper(trim(b.project_status_name))
            INTO l_project_status_code
            FROM apps.pa_projects_all a, PA_PROJECT_STATUSES b
           WHERE segment1 = gv_project_num
             and b.project_status_code = a.project_status_code
             and b.status_type = 'PROJECT';
          log_debug('Project Status : ' || l_project_status_code);
          xxint_event_api_pub.update_event(p_guid        => p_guid,
                                           p_attribute10 => l_project_status_code);
          IF l_project_status_code = 'APPROVED' THEN
            IF l_project_status_code <> gv_proj_status THEN
              send_email_notification(p_message_code  => NULL,
                                      p_error_message => 'Project is Approved');
              gv_proj_status := l_project_status_code;
            END IF;
            SELECT COUNT(1)
              INTO l_proj_rev_count
              FROM pa_agreements_all pa
             WHERE agreement_num = gv_agreement_num ;
               --AND NVL(attribute10, 'XX') = NVL(gv_prj_version_num, 'XX');-- Commented for  CR14331 changes by SAYIKRISHNA R
			   
            IF l_proj_rev_count = 1 THEN
              log_debug('Project Approved and Version Name Matches');
              SELECT COUNT(1)
                INTO l_pjm_count
                FROM pjm_project_parameters pjm, apps.pa_projects_all ppa
               WHERE pjm.project_id = ppa.project_id
                 AND ppa.segment1 = gv_project_num;
              IF l_pjm_count = 0 THEN
                log_debug('Project is not added Project Manufacturing Organization');
                send_email_notification(p_message_code  => gc_error,
                                        p_error_message => 'Project is not added Project Manufacturing Organization');
                xxint_event_api_pub.update_event(p_guid       => gv_guid,
                                                 p_attribute3 => 'PROJ_NOT_IN_PJM');
                x_retcode := 1;
              ELSE

                x_retcode    := 0;
                l_request_id := submit_xxint_bkg_program(p_guid                       => gv_guid,
                                                         p_event_phase                => 'PHASE04',
                                                         p_event_interval             => l_phase_when, --'EVERY_5_MIN', --Added by Joydeb
                                                         p_event_type                 => gc_event_type,
                                                         p_event_owner                => 'SVC',
                                                         p_override_next_attempt_time => 'Y',
                                                         p_lock_timeout_sec           => '60');

              END IF;
            
			ELSE
			-- Below part added for  CR14331 changes by SAYIKRISHNA R
			log_debug('Project Rev count~~~'||l_proj_rev_count);
			 x_retcode    := 0;
                l_request_id := submit_xxint_bkg_program(p_guid                       => gv_guid,
                                                         p_event_phase                => 'PHASE04',
                                                         p_event_interval             => l_phase_when, --'EVERY_5_MIN', --Added by Joydeb
                                                         p_event_type                 => gc_event_type,
                                                         p_event_owner                => 'SVC',
                                                         p_override_next_attempt_time => 'Y',
                                                         p_lock_timeout_sec           => '60');
			/* -- Below Commented for  CR14331 changes by SAYIKRISHNA R
              log_debug('Project Approved and Version Name doesnt Match');
              send_email_notification(p_message_code  => gc_error,
                                      p_error_message => 'Project Revenue Budget Version Mismatch');
              xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                               p_attribute3          => 'REVENUE_VERSION_MISMATCH',
                                               p_user_status_message => 'Project Revenue Budget Version Mismatch');
              x_retcode := 1;
			  */ --above Commented for  CR14331 changes by SAYIKRISHNA R
            END IF;
			
          ELSIF l_project_status_code = 'REJECTED' THEN
            send_email_notification(p_message_code  => gc_error,
                                    p_error_message => 'Project is REJECTED');
            xxint_event_api_pub.update_event(p_guid => gv_guid,
                                             --p_current_status      => 'CLOSED',
                                             p_attribute3          => 'PROJECT_REJECTED',
                                             p_user_status_message => 'Project is Rejected in the Approval Process');
            x_retcode := 1;
            x_errbuff := 'Project is Rejected in the Approval Process';
          ELSIF l_project_status_code = 'CANCELLED' OR
                l_project_status_code = 'CLOSED' THEN
            send_email_notification(p_message_code  => gc_error,
                                    p_error_message => 'Project is Cancelled');
            xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                             -- commented out below line for RT8579992
                                            -- p_current_status      => 'CLOSED',
                                            -- RT8579992
                                             p_user_status_code    => 'FORCE-CLOSE',
                                             p_attribute3          => 'PROJECT_CANCELLED',
                                             p_user_status_message => 'Project is Cancelled');
            x_errbuff := 'Project is Rejected in the Approval Process';
          ELSIF l_event_open_duration > l_retension_days THEN
            send_email_notification(p_message_code  => gc_error,
                                    p_error_message => 'Reached Max Duration of Retention Days');
            xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                             -- commented out below line for RT8579992
                                             -- p_current_status      => 'CLOSED',
                                             -- RT8579992
                                             p_user_status_code    => 'FORCE-CLOSE',
                                             p_attribute3          => 'PROJECT_CANCELLED',
                                             p_user_status_message => 'Project Exceeded max Retention Days');
            x_errbuff := 'Project Exceeded max Retention Days';

          ELSE
            log_debug('Project not Approved and returning 1');
            x_retcode := 1;
          END IF;
        END IF;

      EXCEPTION
        WHEN no_data_found THEN
          x_retcode := 1;
          log_debug('Awaiting Project Event to Complete',
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      END;
    ELSE
      log_debug('Request Type S or Agreement Already Exists: Proceeding to Phase 4');
      x_retcode    := 0;
      l_request_id := submit_xxint_bkg_program(p_guid                       => gv_guid,
                                               p_event_phase                => 'PHASE04',
                                               p_event_interval             => l_phase_when, --'EVERY_5_MIN', --Added by Joydeb
                                               p_event_type                 => gc_event_type,
                                               p_event_owner                => 'SVC',
                                               p_override_next_attempt_time => 'Y',
                                               p_lock_timeout_sec           => '60');

    END IF;
    -- Call report Rec Update Added for CR23274 XXONT3030
    generate_report_data;
    -- End of Call report Rec Update Added for CR23274 XXONT3030
    -- RT8579992 changes
    ELSIF NVL(l_user_status_code,'X')= 'FORCE-CLOSE'
    THEN
        x_retcode    := 0;
    END IF;
    -- RT8579992 changes end
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('ERROR IN PHASE3() ' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      x_retcode := -1;
      x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
  END phase3;
  --
  PROCEDURE phase4(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2) IS
    x_return_status  VARCHAR2(100) DEFAULT gc_success;
    x_return_message VARCHAR2(4000) := NULL;
    l_new_guid       VARCHAR2(2000);
    l_new_ver_count  NUMBER;
    l_phase_when     xxint_event_types.phase01_when%TYPE; -- Added by Joydeb
    lv_request_id    NUMBER; -- Added by Joydeb
    l_user_status_code    xxint_events.user_status_code%TYPE; --RT8579992 changes
  BEGIN
    gv_event_current_phase := 'PHASE04';
    gv_procedure_name      := 'Phase4';
    gv_poo                 := 'Start Phase4: Order Creation phase';
    log_debug(gv_procedure_name || '.' || gv_poo);
    -- RT8579992 changes
    -- fetch USER_STATUS_CODE value of the current event.
    -- if the value is 'FORCE-CLOSE' then complete this phase as success so that the event will progress and get closed properly.

    l_user_status_code := xxint_event_api_pub.EVENT_FIELD_VALUE_AS_VC2 (p_guid =>p_guid,
                                                                  p_attribute_name => 'USER_STATUS_CODE'
                                                                  );
    log_debug('l_user_status_code:'||l_user_status_code);

        -- RT8579992 changes IF condition added
    IF NVL(l_user_status_code,'X') <> 'FORCE-CLOSE'
    THEN
    --Generate the order xml
    --SET GLobal Variables
    set_global_variables(p_guid);
    --    gv_payload := xxint_event_api_pub.get_event_clob(gv_guid,
    --                                                     'HTTP_RECEIVE_XML_PAYLOAD_IN');
    gv_poo := 'Before Parse Transaction Procedure';
    log_debug(gv_poo);
    BEGIN

      parse_transaction(p_xml            => xmltype(gv_payload),
                        x_return_status  => x_return_status,
                        x_return_message => x_return_message);
    EXCEPTION
      WHEN OTHERS THEN
        x_return_status  := gc_error;
        x_return_message := 'Exception in Parse Transaction. ' || SQLERRM;
    END;
    generate_event_xml(x_return_status  => x_return_status,
                       x_return_message => x_return_message);
    --
    --Initiate Operating Unit to refer to Order OU
    gv_operating_unit := NULL;
    --
    -- Need to call Validate Sales order here to populate Inventory Item and Deliver To Site fields.
    BEGIN
      validate_sales_order_info(x_return_status  => x_return_status,
                                x_return_message => x_return_message);
    EXCEPTION
      WHEN OTHERS THEN
        x_return_status  := gc_error;
        x_return_message := 'Exception in Validate Sales Order Info. ' ||
                            SQLERRM;
    END;
    SELECT COUNT(1)
      INTO l_new_ver_count
      FROM apps.xxint_events a
     WHERE event_type = gc_event_type
       AND guid <> gv_guid
       AND attribute1 = gv_source_system
       AND attribute2 = gv_request_type
       AND attribute4 = gv_agreement_num
       AND attribute6 = gv_project_num
       AND attribute7 = gv_order_num
       AND current_phase <> 'CLOSED'
       AND id > (SELECT id FROM apps.xxint_events WHERE guid = gv_guid);
    IF l_new_ver_count = 0 THEN
      BEGIN
        gv_poo := 'Generate the order xml';
        log_debug('In Order Generate XML');
        generate_order_xml(x_return_status  => x_return_status,
                           x_return_message => x_return_message,
                           x_guid           => gv_order_guid);
        log_debug('Generate Order XML Status : ' || x_return_status);
        log_debug('Generate Order XML Message : ' || x_return_message);
      EXCEPTION
        WHEN OTHERS THEN
          x_return_status  := gc_error;
          x_return_message := 'Exception in Process Transaction. ' ||
                              SQLERRM;
          log_debug('Exception in Submit Event : ' || x_return_message,
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      END;
      --Update the event attribute with the order guid
      gv_poo := 'After Processing All Records';
      gv_poo := 'Update XXINT Event DFF';
      BEGIN
        --Update XXINT Event DFF
        xxint_event_api_pub.update_event(p_guid        => gv_guid,
                                         p_attribute3  => 'ORDER_SUBMITTED',
                                         p_attribute11 => gv_order_guid);
        --Added by Joydeb
        SELECT phase05_when
          into l_phase_when
          from xxint_event_types
         where event_type = gc_event_type;

        lv_request_id := submit_xxint_bkg_program(p_guid                       => gv_guid,
                                                  p_event_phase                => 'PHASE05',
                                                  p_event_interval             => l_phase_when,
                                                  p_event_type                 => gc_event_type,
                                                  p_event_owner                => 'SVC',
                                                  p_override_next_attempt_time => 'Y',
                                                  p_lock_timeout_sec           => '60');

        --End of addition by Joydeb
      EXCEPTION
        WHEN OTHERS THEN
          x_return_status  := gc_error;
          x_return_message := 'Error in Updating Event Attributes after processing all records ' ||
                              SQLERRM;
      END;
    ELSE
      BEGIN
        SELECT guid
          INTO l_new_guid
          FROM apps.xxint_events
         WHERE id =
               (SELECT MAX(id)
                  FROM apps.xxint_events a
                 WHERE event_type = gc_event_type
                   AND guid <> gv_guid
                   AND attribute1 = gv_source_system
                   AND attribute2 = gv_request_type
                   AND attribute4 = gv_agreement_num
                   AND attribute6 = gv_project_num
                   AND current_phase <> 'CLOSED'
                   AND id >
                       (SELECT id FROM apps.xxint_events WHERE guid = gv_guid));
      EXCEPTION
        WHEN OTHERS THEN
          log_debug('Exception in finding MAX GUID' || SQLERRM,
                    XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      END;
      x_errbuff := 'Force closing the event as the latest update was processed with GUID = ' ||
                   l_new_guid;
      --Update the event attribute with the order guid
      gv_poo := 'After Processing All Records';
      gv_poo := 'Update XXINT Event DFF';
      BEGIN
        --Update XXINT Event DFF
        xxint_event_api_pub.update_event(p_guid                => gv_guid,
                                         -- commented out below line for RT8579992
                                         --p_current_status      => 'CLOSED',
                                         -- RT8579992
                                         p_user_status_code    => 'FORCE-CLOSE',
                                         p_user_status_message => 'Force closing the event as the latest update was processed with GUID = ' ||
                                                                  l_new_guid,
                                         p_attribute3          => 'NEW_VERSION_AVAILABLE',
                                         p_attribute11         => gv_order_guid);
      EXCEPTION
        WHEN OTHERS THEN
          x_return_status  := gc_error;
          x_return_message := 'Error in Updating Event Attributes after processing all records ' ||
                              SQLERRM;
      END;
    END IF;
    --END IF; -- end of project approval check
    SELECT DECODE(x_return_status, gc_error, 1, 0),
           DECODE(x_return_status,
                  gc_error,
                  x_return_message,
                  'Event phase successfully processed')
      INTO x_retcode, x_errbuff
      FROM dual;
    -- Call report Rec Update Added for CR23274 XXONT3030
    generate_report_data;
    -- End of Call report Rec Update Added for CR23274 XXONT3030
    -- RT8579992 changes
    ELSIF NVL(l_user_status_code,'X')= 'FORCE-CLOSE'
    THEN
        x_retcode    := 0;
    END IF;
    -- RT8579992 changes end
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('ERROR IN PHASE4() ' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      x_retcode := -1;
      x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
  END phase4;

  PROCEDURE phase5(x_retcode IN OUT NUMBER,
                   x_errbuff IN OUT VARCHAR2,
                   p_guid    IN VARCHAR2) IS
    l_order_status_clob      CLOB;
    l_order_status_clob_temp CLOB;
    l_so_event_phase         xxint_events.current_phase%TYPE;
    l_so_event_status        xxint_events.current_status%TYPE;
    l_so_status_code         VARCHAR2(200);
    l_event_status           VARCHAR2(200);
    l_order_created          VARCHAR2(1);
    l_interface_status       VARCHAR2(200);
    l_orig_sys_doc_ref       oe_headers_iface_all.ORIG_SYS_DOCUMENT_REF%TYPE;
    x_return_status          VARCHAR2(100) := gc_success;
    x_return_message         VARCHAR2(4000) := NULL;
    l_error_flag             VARCHAR2(20);
    l_request_id             number;
    l_phase_when             xxint_event_types.phase01_when%TYPE; -- Added by Joydeb
    l_user_status_code    xxint_events.user_status_code%TYPE; --RT8579992 changes
  BEGIN
    x_retcode              := 1;
    gv_event_current_phase := 'PHASE05';
    -- RT8579992 changes
    -- fetch USER_STATUS_CODE value of the current event.
    -- if USER_STATUS_CODE of the event have a value of 'FORCE-CLOSE' then it will not have any G_ORDER_DATA_CLOB in xxint_event_clobs,
    -- so it will throw xml parsing failure; execute the phase05 logic only if USER_STATUS_CODE value is not 'FORCE-CLOSE'
    -- if the value is 'FORCE-CLOSE' then complete this phase as success so that the event will get closed properly.
    -- otherwise, it will have to wait for the max retry limit of phase05 to close the event, which is unnecessary
    l_user_status_code     := xxint_event_api_pub.EVENT_FIELD_VALUE_AS_VC2 (p_guid =>p_guid,
                                                                  p_attribute_name => 'USER_STATUS_CODE'
                                                                  );
    log_debug('l_user_status_code:'||l_user_status_code    );

    IF NVL(l_user_status_code,'X') <> 'FORCE-CLOSE'
    THEN
    -- Set global Variables
    set_global_variables(p_guid);
    l_order_status_clob := xxint_event_api_pub.get_event_clob(gv_guid,
                                                              'G_ORDER_DATA_CLOB');
    g_order_data_rec.delete;
    FOR c_order_data IN (SELECT rownum l_order_count,
                                extractvalue(tmp.column_value,
                                             '/G_ORDER_DATA/ORDER_REF') order_ref,
                                extractvalue(tmp.column_value,
                                             '/G_ORDER_DATA/ORDER_NUMBER') order_number,
                                extractvalue(tmp.column_value,
                                             '/G_ORDER_DATA/ORACLE_ORDER_NUMBER') oracle_order_number,
                                extractvalue(tmp.column_value,
                                             '/G_ORDER_DATA/GUID') guid,
                                extractvalue(tmp.column_value,
                                             '/G_ORDER_DATA/EMAIL_DATE') email_date
                           FROM TABLE(xmlsequence(xmltype(xxint_event_api_pub.get_event_clob(gv_guid, 'G_ORDER_DATA_CLOB'))
                                                  .extract('//G_ORDER/G_ORDER_DATA'))) tmp) LOOP
      g_order_data_rec(c_order_data.l_order_count).order_ref := c_order_data.order_ref;
      g_order_data_rec(c_order_data.l_order_count).order_number := c_order_data.order_number;
      g_order_data_rec(c_order_data.l_order_count).oracle_order_number := c_order_data.oracle_order_number;
      g_order_data_rec(c_order_data.l_order_count).guid := c_order_data.guid;
      g_order_data_rec(c_order_data.l_order_count).email_date := to_date(c_order_data.email_date,
                                                                         'DD-MON-YYYY HH24:MI:SS');
    END LOOP;
    --Status Check
    FOR c_order_data IN 1 .. g_order_data_rec.count LOOP
      SELECT DECODE(COUNT(1), 0, 'N', 'Y')
        INTO l_order_created
        FROM oe_order_headers_all
       WHERE attribute19 = g_order_data_rec(c_order_data).order_number;
      log_debug('Order Created Flag : ' || l_order_created);
      IF l_order_created = 'Y' THEN
        /* Added for HPQC#21731 */
        select current_phase, current_status
          into l_so_event_phase, l_so_event_status
          from apps.xxint_events
         where guid = g_order_data_rec(c_order_data).guid;

        log_debug('SO Event GUID : ' || g_order_data_rec(c_order_data).guid ||
                  ' - ' || 'SO Event Current Phase : ' || l_so_event_phase ||
                  ' - ' || 'SO Event Current Phase : ' ||
                  l_so_event_status);

        IF l_so_event_status <> 'CLOSED' THEN
          l_order_created := 'N';
          --Added by Joydeb
          EXECUTE immediate 'SELECT ' || l_so_event_phase ||
                            '_WHEN from xxint_event_types where event_type = ''' ||
                            gc_ord_cre_event_type || ''''
            INTO l_phase_when;
          --End of addition by Joydeb
          l_request_id := submit_xxint_bkg_program(p_guid                       => g_order_data_rec(c_order_data).guid,
                                                   p_event_phase                => l_so_event_phase,
                                                   p_event_interval             => l_phase_when, --'EVERY_5_MIN', --Modified by Joydeb
                                                   p_event_type                 => gc_ord_cre_event_type,
                                                   p_event_owner                => 'ONT',
                                                   p_override_next_attempt_time => 'Y',
                                                   p_lock_timeout_sec           => '60');

        ELSE
          /* End of Added for HPQC#21731 */
          SELECT order_number
            INTO g_order_data_rec(c_order_data).oracle_order_number
            FROM oe_order_headers_all
           WHERE attribute19 = g_order_data_rec(c_order_data).order_number;
        END IF;
      ELSE
        x_return_status := gc_error;
        BEGIN
          SELECT interface_status, orig_sys_document_ref, error_flag
            INTO l_interface_status, l_orig_sys_doc_ref, l_error_flag
            FROM apps.oe_headers_iface_all
           WHERE order_source = gv_source_system
             AND attribute19 = g_order_data_rec(c_order_data).order_number
             and tp_attribute1 =  g_order_data_rec(c_order_data).guid
             AND rownum = 1;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
        IF NVL(l_error_flag, 'XX') = 'Y' THEN
          x_retcode := 1;
          -- Recording the Order Import Error if the order fails in Order Import
          -- Will be displayed in notification, whenever Order Import Fails
          FOR ord_imp_error IN (SELECT DISTINCT 'LINE' message_level,
                                                opmt.MESSAGE_TEXT,
                                                oli.line_number
                                  FROM oe_processing_msgs      opm,
                                       oe_processing_msgs_tl   opmt,
                                       apps.oe_lines_iface_all oli
                                 WHERE opm.entity_code = 'LINE'
                                   AND opm.transaction_id =
                                       opmt.transaction_id
                                   AND opm.message_status_code = 'OPEN'
                                   AND opm.TYPE = 'ERROR'
                                   AND OLI.ORIG_SYS_LINE_REF(+) =
                                       OPM.ORIGINAL_SYS_DOCUMENT_LINE_REF
                                   AND OPM.ORIGINAL_SYS_DOCUMENT_REF =
                                       l_orig_sys_doc_ref
                                UNION ALL
                                SELECT DISTINCT 'HEADER' Message_level,
                                                opmt.MESSAGE_TEXT,
                                                NULL LINE_NUMBER
                                  FROM oe_processing_msgs    opm,
                                       oe_processing_msgs_tl opmt
                                 WHERE opm.entity_code = 'HEADER'
                                   AND opm.transaction_id =
                                       opmt.transaction_id
                                   AND opm.message_status_code = 'OPEN'
                                   AND opm.TYPE = 'ERROR'
                                   AND OPM.ORIGINAL_SYS_DOCUMENT_REF =
                                       l_orig_sys_doc_ref) LOOP
            IF ord_imp_error.message_level = 'HEADER' THEN
              log_error('Order Header Error : ' ||
                        ord_imp_error.message_text);
            ELSE
              log_error('Order Line Number ' || ord_imp_error.line_number ||
                        ' : ' || ord_imp_error.message_text);
            END IF;
          END LOOP;
        END IF;
      END IF;
    END LOOP;
    --End of Status Check
    IF NVL(x_return_status, 'N') = gc_error OR l_order_created = 'N' THEN
      l_event_status   := 'ORDER_SUBMITTED';
      l_so_status_code := 'NOT CREATED';
      x_retcode        := 1;
      send_email_notification(p_message_code  => gc_error,
                              p_error_message => NULL);
    ELSE
      l_event_status   := 'ORDER_CREATED';
      l_so_status_code := 'CREATED';
      x_retcode        := 0;
      x_errbuff        := 'Phase 5 Completed Successfully';
      send_email_notification(p_message_code  => NULL,
                              p_error_message => 'Order Imported Successfully');
    END IF;
    IF l_event_status IS NOT NULL THEN
      xxint_event_api_pub.update_event(p_guid        => gv_guid,
                                       p_attribute3  => l_event_status,
                                       p_attribute12 => l_so_status_code);
    END IF;
    FOR l_order_count IN 1 .. g_order_data_rec.count LOOP
      IF l_order_count = 1 THEN
        l_order_status_clob_temp := '<G_ORDER>';
      END IF;
      dbms_lob.append(l_order_status_clob_temp, '<G_ORDER_DATA>');
      dbms_lob.append(l_order_status_clob_temp,
                      '<ORDER_REF>' ||
                      dbms_xmlgen.convert(g_order_data_rec(l_order_count)
                                          .order_ref,
                                          0) || '</ORDER_REF>');
      dbms_lob.append(l_order_status_clob_temp,
                      '<ORDER_NUMBER>' ||
                      dbms_xmlgen.convert(g_order_data_rec(l_order_count)
                                          .order_number,
                                          0) || '</ORDER_NUMBER>');
      dbms_lob.append(l_order_status_clob_temp,
                      '<ORACLE_ORDER_NUMBER>' || g_order_data_rec(l_order_count)
                      .oracle_order_number || '</ORACLE_ORDER_NUMBER>');
      dbms_lob.append(l_order_status_clob_temp,
                      '<GUID>' || g_order_data_rec(l_order_count).guid ||
                      '</GUID>');
      dbms_lob.append(l_order_status_clob_temp,
                      '<EMAIL_DATE>' ||
                      TO_CHAR(g_order_data_rec(l_order_count).email_date,
                              'DD-MON-YYYY HH24:MI:SS') || '</EMAIL_DATE>');
      dbms_lob.append(l_order_status_clob_temp, '</G_ORDER_DATA>');
      IF l_order_count = g_order_data_rec.count THEN
        dbms_lob.append(l_order_status_clob_temp, '</G_ORDER>');
      END IF;
    END LOOP;
    xxint_event_api_pub.replace_clob(gv_guid,
                                     'G_ORDER_DATA_CLOB',
                                     l_order_status_clob_temp);
    -- Call report Rec Update Added for CR23274 XXONT3030
    generate_report_data;
    -- End of Call report Rec Update Added for CR23274 XXONT3030
    -- RT8579992 changes
    ELSIF NVL(l_user_status_code,'X') = 'FORCE-CLOSE'
    THEN
        log_debug('completing phase05 of the event as success as new version is available');
        x_retcode := 0;
    END IF;
    -- RT8579992 changes end
  EXCEPTION
    WHEN OTHERS THEN
      log_debug('ERROR IN PHASE5() ' || gv_poo || '.' || SQLERRM,
                XXINT_EVENT_UTIL_SITE.G_LEVEL_ERROR); -- Added parameter for log level as per RT#6859721
      x_retcode := -1;
      x_errbuff := gv_procedure_name || '.' || gv_poo || '.' || SQLERRM;
  END phase5;
END xxpa_equip_order_in_pkg;
/
show errors package body xxpa_equip_order_in_pkg;