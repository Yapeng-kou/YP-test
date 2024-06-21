 SET serveroutput on size 1000000 lines 132 trimout on tab off pages 100

WHENEVER sqlerror exit failure rollback

CREATE OR REPLACE PACKAGE BODY xxap_grni_rep_pkg AS
  /*********************************************************
  ** Title:  Demonstrate creating a custom package body
  ** File:   XXAP_GRNI_REP_PKG.pkb
  ** Description: This script creates a package body
  ** Parameters:  {None.}
  ** Run as:    APPS
  ** Keyword Tracking:
  **   
  **   $Header: xxap/12.0.0/patch/115/sql/XXAP_GRNI_REP_PKG.pkb 1.46 15-JUL-2020 08:58:25 IRIIEB$
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.46 (COMPLETE)
  **     Created:  15-JUL-2020 08:58:25      IRIIEB (Harivardhan Gonchi)
  **       TECH DEBT PM344 XXAP1492 Handle Special Characters
  **   
  **   Revision 1.45 (COMPLETE)
  **     Created:  01-APR-2020 07:51:16      IRIIEB (Harivardhan Gonchi)
  **       RT8730945 - Investigate consignment delete statement that is not
  **       working
  **   
  **   Revision 1.44 (COMPLETE)
  **     Created:  08-JUL-2019 11:26:44      CCCGCW (Harshil Shah)
  **       Added changes for RT#8392110
  **   
  **   Revision 1.43 (COMPLETE)
  **     Created:  29-MAY-2019 10:37:52      CCCGCW (Harshil Shah)
  **       For CR8035 added the below additional changes 
  **       Added a new function for buyer_name.
  **       Changed the logic of
  **       ordered_quantity,quantity_delivered,quantity_billed and
  **       quantity_cancelled
  **       Changed the column name of po_header_closed_status to
  **       po_closed_status and also its logic
  **       Added a new column trane_ref_number in the GTT and added its logic
  **       also.
  **   
  **   Revision 1.42 (COMPLETE)
  **     Created:  22-MAY-2019 18:15:06      CCCGCW (Harshil Shah)
  **       Modified the logic for Unit Price for CR8035
  **   
  **   Revision 1.41 (COMPLETE)
  **     Created:  23-APR-2019 11:58:46      CCCGCW (Harshil Shah)
  **       Added the logic to handle special characters for 5 columns for
  **       CR8035
  **   
  **   Revision 1.40 (COMPLETE)
  **     Created:  16-APR-2019 11:37:47      CCCGCW (Harshil Shah)
  **       Added package changes for CR8035 pertaining to the addition of new
  **       columns in the excel report
  **   
  **   Revision 1.39 (COMPLETE)
  **     Created:  11-APR-2019 13:01:31      CCBNLW (Raju Patel)
  **       CR#8035-Multiple Changes
  **   
  **   Revision 1.38 (COMPLETE)
  **     Created:  10-APR-2019 13:54:08      CCBNLW (Raju Patel)
  **       CR8035, Added the logic to avoid Adjustment period error for 31st
  **       Dec. New 22 columns were added in the GTT as the excel report
  **       output needs those columns
  **   
  **   Revision 1.37 (COMPLETE)
  **     Created:  10-APR-2019 12:11:50      CCBNLW (Raju Patel)
  **       CR#8035-Multiple chnages
  **   
  **   Revision 1.36 (COMPLETE)
  **     Created:  16-AUG-2018 09:53:37      CCBWIL (Soniya Doshi)
  **       RT7844096-Patch retrofit '27538659'
  **   
  **   Revision 1.35 (COMPLETE)
  **     Created:  25-OCT-2017 08:15:00      CCBWIL (Soniya Doshi)
  **       RT6988702-Performance issue
  **   
  **   Revision 1.34 (COMPLETE)
  **     Created:  27-MAR-2017 06:36:44      CCBWIL (Soniya Doshi)
  **       CR5655-Removal of matched lines to have correct Ageing data-Phase 2
  **   
  **   Revision 1.33 (COMPLETE)
  **     Created:  02-MAR-2017 07:22:20      CCBWIL (Soniya Doshi)
  **       CR5655 : by CCBWIL-Soniya Doshi
  **   
  **   Revision 1.32 (COMPLETE)
  **     Created:  08-JUL-2016 08:47:42      CCBWIL (Soniya Doshi)
  **       temporary fix for 6640278
  **   
  **   Revision 1.31 (COMPLETE)
  **     Created:  08-JUL-2016 08:26:50      CCBWIL (Soniya Doshi)
  **       Temporary change for RT 6640278
  **   
  **   Revision 1.30 (COMPLETE)
  **     Created:  26-MAY-2016 06:18:29      CCBWIL (Soniya Doshi)
  **       Changes by soniya for RT# 6402463
  **   
  **   Revision 1.29 (COMPLETE)
  **     Created:  28-APR-2016 06:22:37      CCBWIL (Soniya Doshi)
  **       Changed the logic of Receipt Date for RT# 6402463
  **   
  **   Revision 1.28 (COMPLETE)
  **     Created:  15-FEB-2016 04:53:13      CCAYSC (None)
  **       Changed the logic of Receipt Date for RT# 6402463
  **   
  **   Revision 1.27 (COMPLETE)
  **     Created:  16-SEP-2015 10:23:04      JMARKHAM (None)
  **       Remedy ticket 000000005883048, reduce the number of FULL GC in the
  **       OPP. The XML tag names are reduced in length to 1,2 or 3 character
  **       length.
  **   
  **   Revision 1.26 (COMPLETE)
  **     Created:  30-APR-2014 02:15:09      CCAYSC (None)
  **       Added Org_ID for US orgs
  **   
  **   Revision 1.25 (COMPLETE)
  **     Created:  03-APR-2014 07:31:28      CCAYSC (None)
  **       Added Non_Rec Tax in invoice_num lookup type
  **   
  **   Revision 1.24 (COMPLETE)
  **     Created:  03-APR-2014 07:03:23      CCAYSC (None)
  **       Commented Invoice_Num Cond
  **   
  **   Revision 1.23 (COMPLETE)
  **     Created:  20-MAR-2014 07:02:34      CCAYSC (None)
  **       Made changes for RT# 5063616
  **   
  **   Revision 1.22 (COMPLETE)
  **     Created:  13-FEB-2014 07:12:22      CCAYSC (None)
  **       Added New Logic for PO Num in Miscellaneous query for blank PO NUM
  **       for IRI against RT# 5131175
  **   
  **   Revision 1.21 (COMPLETE)
  **     Created:  22-JAN-2014 08:23:36      CCAYSC (None)
  **       Added PO Num logic to avoid null PO Num
  **   
  **   Revision 1.20 (COMPLETE)
  **     Created:  07-JAN-2014 01:46:30      CCAYSC (None)
  **       Added Vendor Details
  **   
  **   Revision 1.19 (COMPLETE)
  **     Created:  17-DEC-2013 00:20:03      CCAYSC (None)
  **       Added org_id
  **   
  **   Revision 1.18 (COMPLETE)
  **     Created:  12-NOV-2013 01:19:01      CCAYSC (None)
  **       Added item_name in order by against RT#5063616
  **   
  **   Revision 1.17 (COMPLETE)
  **     Created:  12-NOV-2013 01:09:14      CCAYSC (None)
  **       Commneted table PO_DOCUMENT_TYPES_ALL and PER_PEOPLE_X from
  **       Miscellaneous Query and added them in subquery against RT#5063616
  **   
  **   Revision 1.16 (COMPLETE)
  **     Created:  09-OCT-2013 10:47:59      CCBAYA (None)
  **       Added po venodr site table against defect #10074
  **   
  **   Revision 1.15 (COMPLETE)
  **     Created:  22-AUG-2013 15:25:11      CCBAYA (None)
  **       Change PO Doc Type Logic
  **   
  **   Revision 1.14 (COMPLETE)
  **     Created:  20-AUG-2013 16:06:59      CCBAYA (None)
  **       Changes added for Phase 2 requirements
  **   
  **   Revision 1.13 (COMPLETE)
  **     Created:  20-AUG-2013 16:03:27      CCBAYA (None)
  **       Changes added for Phase 2 Requirement
  **   
  **   Revision 1.12 (COMPLETE)
  **     Created:  21-JUN-2013 16:46:37      CCBAYA (None)
  **       RT #4798811
  **   
  **   Revision 1.11 (COMPLETE)
  **     Created:  07-MAY-2013 07:18:18      CCAYSC (None)
  **       Performance Fix
  **   
  **   Revision 1.10 (COMPLETE)
  **     Created:  04-MAR-2013 14:08:20      C-SUDMUKHERJEE (None)
  **       Removed cst_per_end_accruals_temp
  **   
  **   Revision 1.9 (COMPLETE)
  **     Created:  04-MAR-2013 12:18:10      C-SUDMUKHERJEE (None)
  **       Added Outer Join in SQL query
  **   
  **   Revision 1.8 (COMPLETE)
  **     Created:  02-MAR-2013 20:07:18      C-SUDMUKHERJEE (None)
  **       added or gid
  **   
  **   Revision 1.7 (COMPLETE)
  **     Created:  02-MAR-2013 19:51:40      C-SUDMUKHERJEE (None)
  **       Added fix for Org id
  **   
  **   Revision 1.6 (COMPLETE)
  **     Created:  02-MAR-2013 18:31:52      C-SUDMUKHERJEE (None)
  **       Added logic for SOMI Transactions
  **   
  **   Revision 1.5 (COMPLETE)
  **     Created:  26-FEB-2013 20:51:42      C-SUDMUKHERJEE (None)
  **       Correct the logic of Expenditure type
  **   
  **   Revision 1.4 (COMPLETE)
  **     Created:  15-FEB-2013 10:17:52      C-SUDMUKHERJEE (None)
  **       Added fields Expenditure Type ,Packing Slip and and modify the
  **       logic of PPV (defect #6262)  
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  16-JAN-2013 16:52:45      CCAYFY (None)
  **       4
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  16-JAN-2013 14:06:56      CCAYFY (None)
  **       version2
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  11-JAN-2013 14:21:57      CCAYFY (None)
  **       Added columns against defect #4250
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  06-SEP-2012 06:20:08      CCAYSC (None)
  **       Initial revision.
  **   
  **
  ** History:
  ** -----------   ------------------ -------------------------------------------------
  ** 05-Sep-2012  Divya Agarwal   Create
  ** 11-Jan-2013  Vishal Sharma   Added the columns which are used in 11i Report
  **      against defect #4250
  ** 14-Feb-2012  Vishal Sharma   Added fields Expenditure Type ,Packing Slip and
  **      and modify the logic of PPV (defect #6262)
  ** 26-Feb-2013  Vishal Sharma   Correct the logic of Expenditure type
  ** 2-Mar-2013 Vishal Sharma Added logic for SOMI transactions
  ** 07-May-2013  Divya Agarwal   Updated Cursor Query for performance fix against RT# 000000004710029
  ** 20-Jun-2013  Vishal Sharma Remove commented code for Aging Buckets  against RT# 4798811
  ** 20-Aug-13  Vishal Sharma  Added changes for Phase 2 requirement
  ** 21-Aug-2013  Vishal Sharma   Change PO Doc Type logic
  ** 11-Nov-2013  Priya Som Commneted table PO_DOCUMENT_TYPES_ALL and PER_PEOPLE_X from Miscellaneous Query against RT#5063616
  ** 12-DEC-2013  Priya Som Added org_id to show org specific data
  ** 10-Jan-2014  Priya Som Added PO Num null logic to avoid null PO Num
  ** 10-feb-2014  Priya Som Added New Logic for PO Num in Miscellaneous query for blank PO NUM for IRI against RT# 5131175
  ** 20-Feb-2014  Priya Som Commented many tables and added new logic for RT# 5063616
  ** 30-May-2014  Priya Som Added Org id for US orgs,as they dont need non-zero amounts in their Report
  ** 02-Mar-2017  Soniya Doshi    CR5655-Removal of matched lines to have correct Ageing data-phase 1
  ** 23-Mar-2017  Soniya Doshi    CR5655-Removal of matched lines to have correct Ageing data-phase 2
  ** 14-Aug-2017  Soniya Doshi    RT6988702-Performance issue
  ** 09-Apr-2019  Raju Patel      CR#8035-Multiple chnages
  ** 10-Apr-2019  Harshil Shah	   For CR8035, Added the logic to avoid Adjustment period error for 31st Dec.
								   New 22 columns were added in the GTT as the excel report output needs those columns
  ** 17-May-2019  Harshil Shah	   For CR8035, Update the logic of Unit Price
  ** 28-May-2019  Harshil Shah     For CR8035, Added a new function for buyer_name.
  **							   Changed the logic of ordered_quantity,quantity_delivered,quantity_billed and quantity_cancelled
  **							   Changed the column name of po_header_closed_status to po_closed_status and also its logic
  **							   Added a new column trane_ref_number in the GTT and added its logic also.
  ** 01-Jul-2019  Harshil Shah	   Added for RT#8392110 , Distribution charge account was not appearing when the program was ran
  **                               through MOAC responsibility , so contextualized the org through mo_global.set_context_policy	
  ** 01_Apr-2020  Harivardhan G    RT8730945 - Investigate consignment delete statement that is not working
  *************************************************************************************/
  --G_PKG_NAME  CONSTANT VARCHAR2(30) := 'CST_UninvoicedReceipts_PVT';
  --G_LOG_LEVEL CONSTANT NUMBER := FND_LOG.G_CURRENT_RUNTIME_LEVEL;
  g_gl_application_id CONSTANT NUMBER := 101;
  g_po_application_id CONSTANT NUMBER := 201;

  ------------------------------------------------------------------------------
  -- PROCEDURE  :  Start_Process
  -- DESCRIPTION  :   Starting point for Uninvoiced Receipt Report
  ------------------------------------------------------------------------------
  PROCEDURE start_process(errbuf                OUT NOCOPY VARCHAR2,
                          retcode               OUT NOCOPY NUMBER,
                          p_title               IN VARCHAR2,
                          p_org_name            IN VARCHAR2, ---added by Raju For CR#8035 
                          p_accrued_receipts    IN VARCHAR2,
                          p_inc_online_accruals IN VARCHAR2,
                          p_inc_closed_pos      IN VARCHAR2,
                          p_struct_num          IN NUMBER,
                          p_category_from       IN VARCHAR2,
                          p_category_to         IN VARCHAR2,
                          p_min_accrual_amount  IN NUMBER,
                          p_period_name         IN VARCHAR2,
                          p_location            IN VARCHAR2, ---added by Raju  For CR#8035 
                          p_vendor_from         IN VARCHAR2,
                          p_vendor_to           IN VARCHAR2,
                          p_orderby             IN NUMBER,
                          p_qty_precision       IN NUMBER,
                          --Added for CR5655-Removal of matched lines to have correct Ageing data
                          p_exclude_receipt_matched     IN VARCHAR2,
                          p_exclude_matched_consignment IN VARCHAR2,
                          p_exclude_po_matched          IN VARCHAR2,
                          p_run_data_fix                IN VARCHAR2 ---added by Raju  For CR#8035 
                          ) IS
    --l_api_name    CONSTANT VARCHAR2(30) := 'Start_Process';
    --l_api_version CONSTANT NUMBER := 1.0;
    l_return_status VARCHAR2(1);
    --l_full_name CONSTANT VARCHAR2(60) := G_PKG_NAME || '.' || l_api_name;
    --l_module    CONSTANT VARCHAR2(60) := 'cst.plsql.' || l_full_name;
  
    /* Log Severities*/
    /* 6- UNEXPECTED */
    /* 5- ERROR   */
    /* 4- EXCEPTION  */
    /* 3- EVENT   */
    /* 2- PROCEDURE  */
    /* 1- STATEMENT  */
  
    /* In general, we should use the following:
    G_LOG_LEVEL   CONSTANT NUMBER := FND_LOG.G_CURRENT_RUNTIME_LEVEL;
    l_uLog  CONSTANT BOOLEAN := FND_LOG.TEST(FND_LOG.LEVEL_UNEXPECTED, l_module) AND (FND_LOG.LEVEL_UNEXPECTED >= G_LOG_LEVEL);
    l_errorLog    CONSTANT BOOLEAN := l_uLog AND (FND_LOG.LEVEL_ERROR >= G_LOG_LEVEL);
    l_exceptionLog CONSTANT BOOLEAN := l_errorLog AND (FND_LOG.LEVEL_EXCEPTION >= G_LOG_LEVEL);
    l_eventLog    CONSTANT BOOLEAN := l_exceptionLog AND (FND_LOG.LEVEL_EVENT >= G_LOG_LEVEL);
    l_pLog  CONSTANT BOOLEAN := l_eventLog AND (FND_LOG.LEVEL_PROCEDURE >= G_LOG_LEVEL);
    l_sLog  CONSTANT BOOLEAN := l_pLog AND (FND_LOG.LEVEL_STATEMENT >= G_LOG_LEVEL);
    */
  
    /*l_uLog         CONSTANT BOOLEAN := FND_LOG.TEST(FND_LOG.LEVEL_UNEXPECTED,
                                                    l_module) AND
                                       (FND_LOG.LEVEL_UNEXPECTED >=
                                        G_LOG_LEVEL);
    l_exceptionLog CONSTANT BOOLEAN := l_uLog AND (FND_LOG.LEVEL_EXCEPTION >=
                                       G_LOG_LEVEL);
    l_pLog         CONSTANT BOOLEAN := l_exceptionLog AND (FND_LOG.LEVEL_PROCEDURE >=
                                       G_LOG_LEVEL);
    l_sLog         CONSTANT BOOLEAN := l_pLog AND (FND_LOG.LEVEL_STATEMENT >=
                                       G_LOG_LEVEL);*/
    l_msg_count NUMBER;
    l_msg_data  VARCHAR2(240);
    /*l_header_ref_cur SYS_REFCURSOR;
    l_body_ref_cur   SYS_REFCURSOR;
    l_row_tag        VARCHAR2(100);
    l_row_set_tag    VARCHAR2(100);
    l_xml_header     CLOB;
    l_xml_body       CLOB;
    l_xml_report     CLOB;
    
    l_conc_status    BOOLEAN;*/
    l_return         BOOLEAN;
    l_status         VARCHAR2(1);
    l_industry       VARCHAR2(1);
    l_schema         VARCHAR2(30);
    l_application_id NUMBER;
    l_legal_entity   NUMBER;
    l_end_date       DATE;
    l_sob_id         NUMBER;
    l_current_org_id NUMBER;
    l_order_by       VARCHAR2(15);
    --l_multi_org_flag VARCHAR2(1);
  
    --l_stmt_num  NUMBER;
    l_row_count NUMBER;
    --Added for CR5655-Removal of matched lines to have correct Ageing data
    l_ret_xml                  XMLTYPE;
    l_data_clob                CLOB;
    l_parm_tbl                 xx_pk_xml_util.parm_type;
    l_min_accrual_cond         VARCHAR2(4000);
    l_receipt_cond1            VARCHAR2(4000);
    l_receipt_cond2            VARCHAR2(4000);
    l_charge_account_cond      VARCHAR2(4000);
    l_code_combination_id_cond VARCHAR2(4000);
    l_grni_cur                 sys_refcursor;
    l_receipt                  CLOB; --VARCHAR2(32767);		-- Modified for CR8035
    l_po                       CLOB; --VARCHAR2(32767);		-- Modified for CR8035
    l_misc1                    CLOB; --VARCHAR2(32767);		-- Modified for CR8035
    l_misc2                    CLOB; --VARCHAR2(32767);		-- Modified for CR8035
    l_misc3                    CLOB; --VARCHAR2(32767);		-- Modified for CR8035
    l_po_cond1                 VARCHAR2(4000);
    l_po_cond2                 VARCHAR2(4000);
    l_misc_cond1               VARCHAR2(4000);
    l_charge_account           VARCHAR2(4000);
    l_accrual_currency_code    fnd_currencies.currency_code%TYPE;
    l_extended_precision       fnd_currencies.extended_precision%TYPE;
    l_org_id                   Number; ---added by Raju For CR#8035
	
-- Below variables declared for implementing CR8035 by Harshil
	l_misc1_length			   CLOB; --VARCHAR2(32767);
	l_misc2_length			   CLOB; --VARCHAR2(32767);
	l_misc3_length			   CLOB; --VARCHAR2(32767);
    ln_data_row_count		   NUMBER;	
  BEGIN
    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
  
    /*l_stmt_num := 0;
    
    -- Procedure level log message for Entry point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.begin',
                     'Start_Process <<' || 'p_title = ' || p_title || ',' ||
                     'p_accrued_receipts = ' || p_accrued_receipts || ',' ||
                     'p_inc_online_accruals = ' || p_inc_online_accruals || ',' ||
                     'p_inc_closed_pos = ' || p_inc_closed_pos || ',' ||
                     'p_struct_num = ' || p_struct_num || ',' ||
                     'p_category_from = ' || p_category_from || ',' ||
                     'p_category_to = ' || p_category_to || ',' ||
                     'p_min_accrual_amount = ' || p_min_accrual_amount || ',' ||
                     'p_period_name = ' || p_period_name || ',' ||
                     'p_vendor_from = ' || p_vendor_from || ',' ||
                     'p_vendor_to = ' || p_vendor_to || ',' ||
                     'p_orderby = ' || p_orderby || ',' ||
                     'p_qty_precision = ' || p_qty_precision);
    END IF;*/
  
    -- Initialize message list if p_init_msg_list is set to TRUE.
    fnd_msg_pub.initialize;
    --  Initialize API return status to success
    l_return_status := fnd_api.g_ret_sts_success;
    -- Check whether GL is installed
    --l_stmt_num := 10;
    l_return := fnd_installation.get_app_info('SQLGL',
                                              l_status,
                                              l_industry,
                                              l_schema);
  
    IF (l_status = 'I') THEN
      l_application_id := g_gl_application_id;
    ELSE
      l_application_id := g_po_application_id;
    END IF;
  
    -------added below block to get org_id by Raju For CR#8035
    BEGIN
      l_org_id := NULL;
      select O.ORGANIZATION_ID
        into l_org_id
        from HR_OPERATING_UNITS O, AP_SYSTEM_PARAMETERS_ALL SP
       where SP.ORG_ID = O.ORGANIZATION_ID
         and O.NAME = p_org_name;
    EXCEPTION
      WHEN OTHERS THEN
        l_org_id := NULL;
    END;
  
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'l_org_id : ' || l_org_id);
  
    -- Convert Accrual Cutoff date from Legal entity timezone to
    -- Server timezone
    --l_stmt_num := 20;
    ---Commented for CR#8035 l_current_org_id := mo_global.get_current_org_id;
  
    l_current_org_id := nvl(l_org_id, mo_global.get_current_org_id); ---added by Raju For CR#8035
	
	mo_global.set_policy_context('S',l_current_org_id);			-- Added for RT#8392110 by Harshil Shah
  
    /*commenetd for CR#8035 SELECT set_of_books_id
    INTO l_sob_id
    FROM financials_system_parameters; */
  
    ---added below  by Raju For CR#8035
    SELECT set_of_books_id
      INTO l_sob_id
      FROM financials_system_params_all
     where org_id = l_current_org_id;
  
    SELECT fnc2.currency_code, NVL(fnc2.extended_precision, 2)
      INTO l_accrual_currency_code, l_extended_precision
      FROM fnd_currencies fnc2, gl_sets_of_books sob
     WHERE fnc2.currency_code = sob.currency_code
       AND sob.set_of_books_id = l_sob_id;
  
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_accrual_currency_code : ' ||
                            l_accrual_currency_code);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_extended_precision : ' ||
                            l_extended_precision);
  
    SELECT TO_NUMBER(org_information2)
      INTO l_legal_entity
      FROM hr_organization_information
     WHERE organization_id = l_current_org_id ---added by Raju For CR#8035
          --organization_id = mo_global.get_current_org_id
       AND org_information_context = 'Operating Unit Information';
  
    --l_stmt_num := 30;
    SELECT inv_le_timezone_pub.get_server_day_time_for_le(gps.end_date,
                                                          l_legal_entity)
      INTO l_end_date
      FROM gl_period_statuses gps
     WHERE gps.application_id = l_application_id
       AND gps.set_of_books_id = l_sob_id
       AND gps.period_name =
           NVL(p_period_name,
               (SELECT gp.period_name
                  FROM gl_periods gp, gl_sets_of_books sob
                 WHERE sob.set_of_books_id = l_sob_id
                   AND sob.period_set_name = gp.period_set_name
                   AND sob.accounted_period_type = gp.period_type
                   AND gp.start_date <= TRUNC(SYSDATE)
                   AND gp.end_date >= TRUNC(SYSDATE)
				   AND gp.period_name NOT LIKE 'Adj%'				-- For CR8035, Added the logic to avoid Adjustment period error for 31st Dec
				)
               );				   
  
    ---------------------------------------------------------------------
    -- Call the common API CST_PerEndAccruals_PVT.Create_PerEndAccruals
    -- This API creates period end accrual entries in the temporary
    -- table CST_PER_END_ACCRUALS_TEMP.
    ---------------------------------------------------------------------
    --l_stmt_num := 60;
  
    /* Commented by Raju for CR#8035
    cst_perendaccruals_pvt.create_perendaccruals
           (p_api_version             => 1.0,
            p_init_msg_list           => fnd_api.g_false,
            p_commit                  => fnd_api.g_false,
            p_validation_level        => fnd_api.g_valid_level_full,
            x_return_status           => l_return_status,
            x_msg_count               => l_msg_count,
            x_msg_data                => l_msg_data,
            p_min_accrual_amount      => p_min_accrual_amount,
            p_vendor_from             => p_vendor_from,
            p_vendor_to               => p_vendor_to,
            p_category_from           => p_category_from,
            p_category_to             => p_category_to,
            p_end_date                => l_end_date,
            p_accrued_receipt         => NVL (p_accrued_receipts, 'N'),
            p_online_accruals         => NVL (p_inc_online_accruals, 'N'),
            p_closed_pos              => NVL (p_inc_closed_pos, 'N'),
            p_calling_api             => cst_perendaccruals_pvt.g_uninvoiced_receipt_report
           );
    
       -- If return status is not success, add message to the log
       IF (l_return_status <> fnd_api.g_ret_sts_success)
       THEN
          --l_msg_data := 'Failed generating Period End Accrual information';
          RAISE fnd_api.g_exc_unexpected_error;
       END IF; */
  
    /*l_stmt_num := 90;
    DBMS_LOB.createtemporary(l_xml_header, TRUE);
    DBMS_LOB.createtemporary(l_xml_body, TRUE);
    DBMS_LOB.createtemporary(l_xml_report, TRUE);*/
  
    -- Count the no. of rows in the accrual temp table
    -- l_row_count will be part of report header information
    --l_stmt_num := 100;
  
    /* Commented by Raju for CR#8035   
    SELECT COUNT ('X')
        INTO l_row_count
        FROM cst_per_end_accruals_temp
       WHERE ROWNUM = 1;*/
  
    IF (p_orderby = 1) THEN
      l_order_by := 'Category';
    ELSIF (p_orderby = 2) THEN
      l_order_by := 'Vendor';
    ELSE
      l_order_by := ' ';
    END IF;
  
    -------------------------------------------------------------------------
    -- Open reference cursor for fetching data related to report header
    -------------------------------------------------------------------------
    /*l_stmt_num := 110;
    
     OPEN l_header_ref_cur FOR 'SELECT gsb.name                        company_name,
       :p_title         report_title,
       SYSDATE       report_date,
       DECODE(:p_accrued_receipts,
         ''Y'', ''Yes'',
         ''N'', ''No'')          accrued_receipt,
       DECODE(:p_inc_online_accruals,
         ''Y'', ''Yes'',
         ''N'', ''No'')          include_online_accruals,
       DECODE(:p_inc_closed_pos,
         ''Y'', ''Yes'',
         ''N'', ''No'')          include_closed_pos,
       :p_exclude_receipt_matched exclude_receipt_matched,
       :p_exclude_matched_consignment  exclude_matched_consignment,
       :p_category_from      category_from,
       :p_category_to       category_to,
       :p_min_accrual_amount     minimum_accrual_amount,
       :p_period_name       period_name,
       :p_vendor_from       vendor_from,
       :p_vendor_to      vendor_to,
       :l_order_by       order_by,
       :l_row_count      row_count
    FROM gl_sets_of_books gsb
    WHERE  gsb.set_of_books_id = :l_sob_id'
       USING p_title, p_accrued_receipts, p_inc_online_accruals, p_inc_closed_pos, p_exclude_receipt_matched, p_exclude_matched_consignment,  p_category_from, p_category_to, p_min_accrual_amount, p_period_name, p_vendor_from, p_vendor_to, l_order_by, l_row_count, l_sob_id;
    
     -- Set row_tag as HEADER for report header data
     l_row_tag     := 'HEADER';
     l_row_set_tag := NULL;
    
     -- Generate XML data for header part
     l_stmt_num := 120;
     Generate_XML(p_api_version      => 1.0,
                  p_init_msg_list    => FND_API.G_FALSE,
                  p_validation_level => FND_API.G_VALID_LEVEL_FULL,
                  x_return_status    => l_return_status,
                  x_msg_count        => l_msg_count,
                  x_msg_data         => l_msg_data,
                  p_ref_cur          => l_header_ref_cur,
                  p_row_tag          => l_row_tag,
                  p_row_set_tag      => l_row_set_tag,
                  x_xml_data         => l_xml_header);
     -- If return status is not success, add message to the log
     IF (l_return_status <> FND_API.G_RET_STS_SUCCESS) THEN
       l_msg_data := 'Failed generating XML data to the report output';
       RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
     END IF;*/
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_row_count : ' || l_row_count);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'l_sob_id : ' || l_sob_id);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_current_org_id: ' || l_current_org_id);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            'l_order_by : ' || l_order_by);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            ' p_min_accrual_amount : ' ||
                            p_min_accrual_amount);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            ' p_exclude_receipt_matched : ' ||
                            p_exclude_receipt_matched);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            ' p_exclude_matched_consignment : ' ||
                            p_exclude_matched_consignment);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            ' p_exclude_po_matched : ' ||
                            p_exclude_po_matched);
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                            '-----------------------------------------------------------------------------');
  
    -- If row_count is 0, no need to open body_ref_cursor
    IF (1 = 1)
    ---COMMENTED For CR#8035 IF (l_row_count > 0)
     THEN
      ---------------------------------------------------------------------
      -- Open reference cursor for fetching data related to report body
      ---------------------------------------------------------------------
      /*(l_stmt_num := 140;
      
            IF p_exclude_receipt_matched = 'N' AND
               p_exclude_matched_consignment = 'N' AND
               (p_min_accrual_amount = 0 OR p_min_accrual_amount IS NULL) THEN
              IF l_current_org_id IN (456, 88) THEN
      
                OPEN l_body_ref_cur FOR 'select * from (SELECT NVL(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1) po_number,
                    POH.FOB_LOOKUP_CODE             fob,--Added by Vishal
                    (select px.full_name   from per_people_x px
         where px.person_id = pod.DELIVER_TO_PERSON_ID )req_requestor,
         decode(poll.match_option,''P'',''PO'',''R'',''Receipt'',null) inv_match_option,
         ----ppx.full_name Buyer_Name, Commented by Priya for RT# 5249090
         (select ppx.full_name
      from per_people_x ppx
      where poh.agent_id = ppx.person_id
      AND trunc(SYSDATE) BETWEEN ppx.effective_start_date AND
      ppx.effective_end_date) Buyer_Name,
         CASE
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''N'' THEN
              ''2-Way''
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''3-Way''
              WHEN poll.inspection_required_flag = ''Y'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''4-Way''
            END Invoice_Match_App,
            decode(POD.req_distribution_id,
                  null,
                  POD.req_header_reference_num,
                  PORH.segment1) req_num,
                  trunc(PORH.creation_date) req_date,
                  --Added by Priya for RT# 5249090
                  \*decode (PODT.TYPE_NAME,''Standard Purchase Order'',''Standard Purchase Order'',
                  ''Blanket Purchase Agreement'',''Blanket Release'',PODT.TYPE_NAME) po_doc_type,*\
                  decode(poh.type_lookup_code,''STANDARD'',''Standard Purchase Order'',
                  ''BLANKET'',''Blanket Release'',''CONTRACT'',''Contract Purchase Agreement'',poh.type_lookup_code) po_doc_type,
                    porl.release_num                po_release_number,
                    poh.po_header_id                po_header_id,
                    pol.po_line_id                  po_line_id,
                  null                po_shipment_id,--Commented by Vishal
                  null             po_distribution_id,--Commented by Vishal
                    plt.line_type                 line_type,
                    nvl(POL.LINE_NUM_DISPLAY, to_char(POL.LINE_NUM)) line_num,
                    msi.concatenated_segments         item_name,
                   mca.concatenated_segments          category,
                    ----pol.item_description             item_description,
                    (substr(replace(replace(pol.item_description,chr(10),''''),chr(13),''''),1,25))   item_description,
                    rt.transaction_id,
                    pov.vendor_name                 vendor_name,
                    pov.segment1                  vendor_num,
                    pov.vendor_type_lookup_code         vendor_type,
                    pvs.vendor_site_code              vendor_site_name,
                    (  SELECT transaction_type_name
                    FROM  mtl_material_transactions mmt,
                        mtl_transaction_types   mtt
                    WHERE mtt.transaction_type_id = mmt.transaction_type_id
                    AND   mtt.transaction_source_type_id = mmt.transaction_source_type_id
                    AND   mmt.transaction_action_id = mtt.transaction_action_id
                    AND   mmt.rcv_transaction_id = rt.transaction_id) transaction_type,
                    capr.transaction_date              transaction_date,
                    poll.quantity                  ordered_quantity,
                    poll.Quantity_Cancelled            Quantity_Cancelled,
                    poll.unit_meas_lookup_code           UOM,
                    pod.Quantity_Delivered             Quantity_Delivered,
                    (select RSH.RECEIPT_NUM
                   from RCV_SHIPMENT_HEADERS RSH
                  where RSH.SHIPMENT_HEADER_ID = RT.SHIPMENT_HEADER_ID) receipt_num,
                    pod.EXPENDITURE_TYPE,
                   (select apia.invoice_num invoice_number
          from ap_invoices_all          apia,
             ap_invoice_distributions_all aida
         where aida.invoice_distribution_id= capr.invoice_distribution_id
          AND apia.invoice_id(+) = aida.invoice_id
          and aida.line_type_lookup_code in (''ACCRUAL'',''MISCELLANEOUS'')
          and rownum<2) INVOICE_NUM,--Added Miscellaneous by Priya for RT# 5249090
            (select aida.invoice_line_number
          from ap_invoices_all          apia,
             ap_invoice_distributions_all aida
         where aida.invoice_distribution_id= capr.invoice_distribution_id
          AND apia.invoice_id(+) = aida.invoice_id) INVOICE_LINE_NUM,
      (select decode(a.line_type_lookup_code ,''IPV'',sum(a.amount),''0'')
        from ap_invoice_distributions_all a
      Where a.invoice_id =
           (select invoice_id
             from ap_invoice_distributions_all aida
            where aida.line_type_lookup_code in (''ACCRUAL'')
              and aida.invoice_distribution_id = capr.invoice_distribution_id)
                and  a.invoice_line_number=   ( select invoice_line_number
            from ap_invoice_distributions_all aida
           where aida.line_type_lookup_code in (''ACCRUAL'')
            and aida.invoice_distribution_id =capr.invoice_distribution_id)
        AND a.line_type_lookup_code in (''IPV'')
        group by a.line_type_lookup_code)IPV,
          capr.entered_amount entered_amount,
          capr.currency_code currency_code,
          nvl(capr.currency_conversion_rate,1) currency_conversion_rate,
          capr.transaction_type_code,
          capr.invoice_distribution_id,
           decode(capr.invoice_distribution_id,
                NULL,
                decode(capr.write_off_id, NULL, '' PO '', '' WO ''),
                '' AP '') transaction_source,
                (select ood.name
          from hr_organization_units ood
         where ood.organization_id = capr.inventory_organization_id) org,
            (TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date ))) Oracle_Aging_Date,
         ((trunc(sysdate)- TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) Aging_Days,---Added by Vishal
         CASE
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) <= 0 THEN
          ''Current Period''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 0 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 31 THEN
          ''1 - 30 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 30 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 91 THEN
          ''31 - 90 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 90 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 121 THEN
          ''91 - 120 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 120 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 181 THEN
          ''121 - 180 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 180 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 361 THEN
          ''181 - 360 Days''
         ELSE
          ''Over 361 Days''
        END  Age_Bucket_Non_Zero,
                    fnc2.currency_code              accrual_currency_code,
                    poll.shipment_num               shipment_number,
                    poll.unit_meas_lookup_code          uom_code,
                    pod.distribution_num              distribution_num,
                    poll.quantity_received            quantity_received,
                    poll.quantity_billed              quantity_billed,
                    null                        quantity_accrued,
                    capr.quantity                 trx_qty,
                    capr.amount                   funct_amt,
                    rt.transaction_id               rcv_transaction_id,
                    null transfer_transaction_id,
                    (select NVL(RSL.PACKING_SLIP, RSH.PACKING_SLIP)
                   from RCV_SHIPMENT_LINES RSL, RCV_SHIPMENT_HEADERS RSH
                  WHERE RSH.SHIPMENT_HEADER_ID = RT.SHIPMENT_HEADER_ID
                    AND RSL.SHIPMENT_LINE_ID = RT.SHIPMENT_LINE_ID) PACKING_SLIP,
                    (   select gcc.segment1 || ''.'' || gcc.segment2 || ''.'' || gcc.segment3 || ''.'' ||
              gcc.segment4 || ''.'' || gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
              gcc.segment7 || ''.'' || gcc.segment8
           from gl_code_combinations gcc
          where code_combination_Id = capr.accrual_account_id
          )accrual_account,
               (nvl(poh.rate, 0) * pol.unit_price * capr.quantity) PPV1,
                    (nvl(capr.currency_conversion_rate, 0) * pol.unit_price *
                  capr.quantity) PPV2,
                    ROUND(pol.unit_price,
                         NVL(fnc2.extended_precision, 2))     po_unit_price,
                    capr.currency_code              po_currency_code,
                    ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                               0, pol.unit_price * capr.currency_conversion_rate,
                               (pol.unit_price / fnc1.minimum_accountable_unit)
                                 * capr.currency_conversion_rate
                                 * fnc1.minimum_accountable_unit),
                                  NVL(fnc1.extended_precision, 2))
                                              func_unit_price,
                    ----gcc2.concatenated_segments         charge_account,
                   (select concatenated_segments from  gl_code_combinations_kfv gcc,PO_DISTRIBUTIONS_INQ_V  pdi
                    where pdi.code_combination_id = gcc.code_combination_id
                    and pdi.PO_DISTRIBUTION_ID = pod.PO_DISTRIBUTION_ID) charge_account,
                     null             accrual_amount,
                      null    func_accrual_amount,
                  poh.creation_date po_date,
                  (SELECT trunc(max(last_update_date))
                    FROM rcv_transactions rt
                   where rt.po_line_location_id = pod.line_location_id
                    AND ((rt.transaction_type = ''RECEIVE'' AND
                       parent_transaction_id = -1) OR
                       (rt.transaction_type = ''MATCH''))
                   group by po_line_location_id) receipt_date
      
      
              FROM    po_headers_all          poh,
                    po_lines_all          pol,
                    po_line_locations_all     poll,
                    po_distributions_all      pod,
                    PO_REQUISITION_HEADERS_ALL   PORH,
                    PO_REQUISITION_LINES_ALL   PORL,
                    PO_REQ_DISTRIBUTIONS_ALL   PORD,
                    po_vendors            pov,
                    po_vendor_sites_all     pvs,----Added table in place of view by Vishal (defect #10074)
                    po_line_types         plt,
                    po_releases_all         porl,
                    mtl_system_items_kfv      msi,
                    fnd_currencies          fnc1,
                    fnd_currencies          fnc2,
                    mtl_categories_kfv      mca,
                    gl_code_combinations_kfv  gcc,
                    gl_code_combinations_kfv  gcc2,
                    gl_sets_of_books sob,
                    rcv_transactions rt, ---Added by Divya on 07-May for performance fix
                   CST_AP_PO_RECONCILIATION capr,
                   PO_LOOKUP_CODES plc,----Added by Vishal on 16-Aug for Phase 2 requirement ,
                   \*per_people_x ppx ,
                   PO_DOCUMENT_TYPES_ALL PODT,
                   PO_DOCUMENT_TYPES_ALL  PODB,*\--Commented by Priya for RT# 5249090
                   cst_reconciliation_summary  crs --Added by Priya for RT# 5131175
              WHERE poh.po_header_id = pol.po_header_id
              AND plc.LOOKUP_CODE(+) = POH.FOB_LOOKUP_CODE----Added by Vishal on 16-Aug for Phase 2 requirement
              AND plc.LOOKUP_TYPE(+) = ''FOB''----Added by Vishal on 16-Aug for Phase 2 requirement
              ----and poh.agent_id = ppx.person_id----Added by Vishal on 16-Aug for Phase 2 requirement
           AND    POD.REQ_DISTRIBUTION_ID = PORD.DISTRIBUTION_ID(+)
        AND PORD.REQUISITION_LINE_ID = PORL.REQUISITION_LINE_ID(+)
        AND PORL.REQUISITION_HEADER_ID = PORH.REQUISITION_HEADER_ID(+)
        \*AND ((PODB.DOCUMENT_TYPE_CODE in (''PO'', ''PA'') AND
             PODB.DOCUMENT_SUBTYPE = POH.TYPE_LOOKUP_CODE))
          AND PODB.DOCUMENT_TYPE_CODE = PODT.DOCUMENT_TYPE_CODE
          AND PODB.DOCUMENT_SUBTYPE = PODT.DOCUMENT_SUBTYPE
          AND PODT.ORG_ID = PODB.ORG_ID
          AND PODB.ORG_ID = POH.ORG_ID*\ --Commented by Priya for RT# 5249090
              AND   pol.po_line_id = poll.po_line_id
              AND   poll.line_location_id = pod.line_location_id
              AND   pol.line_type_id = plt.line_type_id
              AND   porl.po_release_id (+)  = poll.po_release_id
              AND   poh.vendor_id = pov.vendor_id
              AND   pov.vendor_id= pvs.vendor_id
              AND   poh.vendor_site_id= pvs.vendor_site_id
              AND   msi.inventory_item_id (+)  = pol.item_id
              AND   (msi.organization_id IS NULL
                    OR
                    (msi.organization_id = poll.ship_to_organization_id AND msi.organization_id IS NOT NULL))
              AND   fnc1.currency_code =  capr.currency_code
              AND   fnc2.currency_code = sob.currency_code
              \*AND    cpea.category_id = mca.category_id*\
              AND   pol.category_id=mca.category_id (+)
              ----AND   gcc1.code_combination_id = pod.code_combination_id --Commented by Priya for RT# 5249090
              AND capr.accrual_account_id = gcc.code_combination_id --Added by Priya for RT# 5249090
              AND   gcc2.code_combination_id = pod.accrual_account_id
              AND   sob.set_of_books_id = :l_sob_id
              ----AND   capr.entered_amount !=0 --Commented by Priya for RT# 5249090
              and capr.amount !=0
              AND   crs.operating_unit_id  = :l_current_org_id
              AND   capr.operating_unit_id  = :l_current_org_id --Added by Priya for RT# 5249090
              --Added CRS JOIN by Priya for RT# 5131175
              AND capr.po_distribution_id = crs.po_distribution_id
              and crs.accrual_account_id = capr.accrual_account_id
              AND pod.po_distribution_id = crs.po_distribution_id
              AND capr.po_distribution_id = pod.po_distribution_id ----- Added by Divya 12-Feb
              and  capr.rcv_transaction_id=rt.transaction_id(+) ---Added on 14-Dec ------- Reversed Outer join to include missing Accrual screen lines by Divya 12-Feb
      
      union all
      
      SELECT
      ----NVL(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1) po_number,--Changed as a part of CLM, commented by Priya for missing IRI PO_NUM RT# 5131175
      coalesce(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1,(select poh.segment1 from ap_suppliers aps,po_headers_all poh
      where poh.po_header_id = mmt.transaction_source_id and aps.vendor_id = poh.vendor_id)) po_number,
      POH.FOB_LOOKUP_CODE              fob,--Added by Vishal
      (select px.full_name
      from per_people_x px
      where px.person_id = pod.DELIVER_TO_PERSON_ID )req_requestor,
      decode(poll.match_option,''P'',''PO'',''R'',''Receipt'',null) inv_match_option,
      \*ppx.full_name Buyer_Name,*\--Added by Priya for RT#5063616
      (select ppx.full_name
      from per_people_x ppx
      where poh.agent_id = ppx.person_id
      AND trunc(SYSDATE) BETWEEN ppx.effective_start_date AND
      ppx.effective_end_date) Buyer_Name,
      CASE
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''N'' THEN
              ''2-Way''
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''3-Way''
              WHEN poll.inspection_required_flag = ''Y'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''4-Way''
            END Invoice_Match_App,
            decode(POD.req_distribution_id,
                  null,
                  POD.req_header_reference_num,
                  PORH.segment1) req_num,
                  trunc(PORH.creation_date) req_date,
                  ----Added by Priya for RT# 5249090
                  decode(poh.type_lookup_code,''STANDARD'',''Standard Purchase Order'',
                  ''BLANKET'',''Blanket Release'',''CONTRACT'',''Contract Purchase Agreement'',poh.type_lookup_code) po_doc_type,--Added by Priya for RT#5063616
      por.release_num                         po_release,
      poh.po_header_id                 po_header_id,
      pol.po_line_id                 po_line_id,
      null                      po_shipment_id,
                    cmr.po_distribution_id              po_distribution_id,
                    plt.line_type line_type,
                    nvl(POL.LINE_NUM_DISPLAY, to_char(POL.LINE_NUM)) line_num,
                    decode(cmr.inventory_item_id, null, null,
                                   (select msi.concatenated_segments from
                                    mtl_system_items_vl msi
                                    where inventory_item_id = cmr.inventory_item_id
                                   and rownum <2)
                                   )                             item_name,
      
                    mca.concatenated_segments                         category,
                    -----pol.item_description             item_description,
                   (substr(replace(replace(pol.item_description,chr(10),''''),chr(13),''''),1,25))   item_description,
                   mmt.transaction_id,
                   coalesce(aps.vendor_name,aps1.vendor_name,pov.vendor_name,(select vendor_name
                                    from ap_suppliers aps,po_headers_all poh
                                    where poh.po_header_id = mmt.transaction_source_id
                                    and aps.vendor_id = poh.vendor_id)) vendor_name ,
             coalesce( aps.segment1, aps1.segment1,pov.segment1,(select aps.segment1
                                    from ap_suppliers aps,po_headers_all poh
                                    where poh.po_header_id = mmt.transaction_source_id
                                    and aps.vendor_id = poh.vendor_id)) vendor_num,
                    coalesce(aps.vendor_type_lookup_code,aps1.vendor_type_lookup_code,pov.vendor_type_lookup_code,
                    (select aps.vendor_type_lookup_code from ap_suppliers aps,po_headers_all poh where poh.po_header_id = mmt.transaction_source_id
                    and aps.vendor_id = poh.vendor_id)) vendor_type,
                    pvs.vendor_site_code              vendor_site_name,
                    decode(cmr.invoice_distribution_id,
                             NULL,
                    decode ( cmr.transaction_type_code,
                                  ''CONSIGNMENT'',
                                  (SELECT crc.displayed_field
                                  FROM cst_reconciliation_codes crc
                                  WHERE crc.lookup_code =
                                        cmr.transaction_type_code
                                  AND crc.lookup_type IN
                                       ( ''ACCRUAL WRITE-OFF ACTION'',''ACCRUAL TYPE'')),
                                  (SELECT mtt.transaction_type_name
                                  FROM mtl_transaction_types      mtt
                                  WHERE cmr.transaction_type_code =
                                            to_char(mtt.transaction_type_id) )),
                             (SELECT crc.displayed_field
                             FROM cst_reconciliation_codes crc
                             WHERE crc.lookup_code =
                                  cmr.transaction_type_code
                             AND crc.lookup_type IN
                              ( ''ACCRUAL WRITE-OFF ACTION'',''ACCRUAL TYPE'')))   transaction_type,
                    cmr.transaction_date                        transaction_date,
                    poll.quantity                  ordered_quantity,
                    poll.Quantity_Cancelled            Quantity_Cancelled,
                    poll.unit_meas_lookup_code           UOM,
                    pod.Quantity_Delivered             Quantity_Delivered,
                    null receipt_num,
                    pod.EXPENDITURE_TYPE,
                    apia.invoice_num                          INVOICE_NUM,
                             aida.invoice_line_number                    INVOICE_LINE_NUM,
                             (select decode(a.line_type_lookup_code ,''IPV'',sum(a.amount),''0'')
        from ap_invoice_distributions_all a
      Where a.invoice_id =
           (select invoice_id
             from ap_invoice_distributions_all aida
            where aida.line_type_lookup_code in (''ACCRUAL'')
              and aida.invoice_distribution_id = cmr.invoice_distribution_id)
                and  a.invoice_line_number=   ( select invoice_line_number
            from ap_invoice_distributions_all aida
           where aida.line_type_lookup_code in (''ACCRUAL'')
            and aida.invoice_distribution_id =cmr.invoice_distribution_id)
        AND a.line_type_lookup_code in (''IPV'')
        group by a.line_type_lookup_code)IPV,
      
          cmr.entered_amount                        entered_amount,
           cmr.currency_code                         currency_code,
          nvl(cmr.currency_conversion_rate,1) currency_conversion_rate,
           decode(mmt.transaction_id, null , transaction_type_code, (SELECT mtt.transaction_type_name
                  FROM mtl_transaction_types      mtt where mtt.transaction_type_id = mmt.transaction_type_id)) transaction_type_code ,
          cmr.invoice_distribution_id,
          decode(cmr.invoice_distribution_id,
                             NULL,
                             ''INV'',
                             ''AP'')                                               transaction_source,
      
          mp.organization_code                      org,
          (TO_DATE(nvl(apia.invoice_date,cmr.transaction_date ))) Oracle_Aging_Date,
            ((trunc(sysdate)- TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) Aging_Days,---Added by Vishal
         CASE
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) <= 0 THEN
          ''Current Period''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 0 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 31 THEN
          ''1 - 30 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 30 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 91 THEN
          ''31 - 90 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 90 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 121 THEN
          ''91 - 120 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 120 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 181 THEN
          ''121 - 180 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 180 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 361 THEN
          ''181 - 360 Days''
         ELSE
          ''Over 361 Days''
        END  Age_Bucket_Non_Zero,
          fnc2.currency_code               accrual_currency_code,
                    poll.shipment_num               shipment_number,
                    poll.unit_meas_lookup_code          uom_code,
                    pod.distribution_num              distribution_num,
                    poll.quantity_received,
                    poll.quantity_billed,
                    null        quantity_accrued,
                    \*Added by Vishal 10-Jan-2013*\
                    cmr.quantity                  trx_qty,
                    cmr.amount                    funct_amt,
                   null               rcv_transaction_id,
                   mmt.transfer_transaction_id transfer_transaction_id ,
                   null                 packing_slip,
                   (   select gcc.segment1 || ''.'' || gcc.segment2 || ''.'' || gcc.segment3 || ''.'' ||
              gcc.segment4 || ''.'' || gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
              gcc.segment7 || ''.'' || gcc.segment8
           from gl_code_combinations gcc
          where code_combination_Id = cmr.accrual_account_id
          ) accrual_account,
          (nvl(poh.rate, 0) * pol.unit_price * cmr.quantity) PPV1,
                    (nvl(cmr.currency_conversion_rate, 0) * pol.unit_price *
                  cmr.quantity) PPV2,
                  ROUND(pol.unit_price,
                         NVL(fnc2.extended_precision, 2))     po_unit_price,
                  null  po_currency_code,
                  ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                               0, pol.unit_price * cmr.currency_conversion_rate,
                               (pol.unit_price / fnc1.minimum_accountable_unit)
                                 * cmr.currency_conversion_rate
                                 * fnc1.minimum_accountable_unit),
                                  NVL(fnc1.extended_precision, 2)) func_unit_price,
                   ----gcc2.concatenated_segments         charge_account,
                   (select concatenated_segments from  gl_code_combinations_kfv gcc,PO_DISTRIBUTIONS_INQ_V  pdi
                    where pdi.code_combination_id = gcc.code_combination_id
                    and pdi.PO_DISTRIBUTION_ID = pod.PO_DISTRIBUTION_ID) charge_account,
          null             accrual_amount,
                            null func_accrual_amount,
                  poh.creation_date po_date,
                  (SELECT trunc(max(last_update_date))
                  FROM rcv_transactions rt
                   where rt.po_line_location_id = pod.line_location_id
                    AND ((rt.transaction_type = ''RECEIVE'' AND
                       parent_transaction_id = -1) OR
                       (rt.transaction_type = ''MATCH''))
                   group by po_line_location_id) receipt_date
                       FROM   cst_misc_reconciliation                     cmr,
                             ap_invoices_all                           apia,
                             ap_invoice_distributions_all                  aida,
                              ap_suppliers                              pov,
                             ap_suppliers                            aps,
                             ap_suppliers                            aps1,
                             mtl_parameters                          mp,
                             gl_code_combinations_kfv                    gcc,
                             po_distributions_all                      pod,
                             PO_REQUISITION_HEADERS_ALL                  PORH,
                             PO_REQUISITION_LINES_ALL                    PORL,
                             PO_REQ_DISTRIBUTIONS_ALL                    PORD,
                             po_line_locations_all                       poll,
                             ap_supplier_sites_all                        pvs,
                             po_releases_all                           por,
                             po_lines_all                            pol,
                             po_line_types                           plt,
                             po_headers_all                          poh,
                             mtl_categories_kfv                        mca,
                             mtl_material_transactions                   mmt,
                             fnd_currencies                          fnc1,
                             fnd_currencies                          fnc2,
                             gl_sets_of_books                          sob,
                            ---- gl_code_combinations_kfv   gcc1,                 --Commented by Priya for RT# 5249090
                             gl_code_combinations_kfv   gcc2,
                             PO_LOOKUP_CODES plc
                        WHERE  cmr.invoice_distribution_id = aida.invoice_distribution_id(+)
                        AND plc.LOOKUP_CODE(+) = POH.FOB_LOOKUP_CODE----Added by Vishal on 16-Aug for Phase 2 requirement
                       AND plc.LOOKUP_TYPE(+) = ''FOB''----Added by Vishal on 16-Aug for Phase 2 requirement
                        AND POD.REQ_DISTRIBUTION_ID = PORD.DISTRIBUTION_ID(+)
                        AND PORD.REQUISITION_LINE_ID = PORL.REQUISITION_LINE_ID(+)
                        AND PORL.REQUISITION_HEADER_ID = PORH.REQUISITION_HEADER_ID(+)
                        AND    cmr.vendor_id = pov.vendor_id(+)
                        AND    aps.vendor_id(+)=poh.vendor_id
                        And    aps1.vendor_id(+)=apia.vendor_id
                        --AND    cmr.vendor_id = pov.vendor_id(+)               --Commented by Priya for RT# 5249090
                        ----AND   gcc1.code_combination_id (+)= pod.code_combination_id --Commented by Priya for RT# 5249090
                        AND    gcc2.code_combination_id (+)= pod.accrual_account_id
                        AND    aida.invoice_id = apia.invoice_id(+)
                        AND    poh.vendor_id= pvs.vendor_id (+)
                       AND    poh.vendor_site_id= pvs.vendor_site_id (+)
                        AND    cmr.inventory_organization_id = mp.organization_id(+)
                        AND    cmr.accrual_account_id  = gcc.code_combination_id
                        AND    pod.po_distribution_id(+) = cmr.po_distribution_id
                        and    cmr.inventory_transaction_id = mmt.transaction_id (+)
                        AND    poll.line_location_id(+) = pod.line_location_id
                        AND    pol.category_id=mca.category_id (+)
                        AND    fnc2.currency_code = sob.currency_code
                        AND    fnc1.currency_code =  cmr.currency_code
                        AND    pol.line_type_id = plt.line_type_id (+)
                        AND    poh.org_id (+) =pod.org_id
                        AND    pod.po_release_id = por.po_release_id(+)
                        AND    pol.po_line_id(+) = pod.po_line_id
                        AND    poh.po_header_id(+) = pod.po_header_id
                        AND    cmr.operating_unit_id = :l_current_org_id --MO_GLOBAL.GET_CURRENT_ORG_ID --Commented MO_GLOBAL.GET_CURRENT_ORG_ID by Priya for RT# 5063616
                        ----AND   cmr.entered_amount !=0  --Commented by Priya for RT# 5249090
                        and cmr.amount !=0
                        AND    sob.set_of_books_id = :l_sob_id
                        )
              ORDER BY DECODE(:l_order_by,
              ''Category'', category,
              ''Vendor'', vendor_name),
         item_name,--Added by Priya for RT#5063616
         invoice_num, --Added by Priya for RT#5249090
              po_number,----NVL(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1),
              line_num,---nvl(POL.LINE_NUM_DISPLAY, to_char(POL.LINE_NUM)),
              shipment_number,
              distribution_num'
                \*Added l_sob_id to avoid the bind variable issue in union all*\
                  USING l_sob_id, l_current_org_id, l_current_org_id, l_current_org_id, l_sob_id, l_order_by;
              ELSE
                OPEN l_body_ref_cur FOR 'select * from (SELECT NVL(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1) po_number,
                    POH.FOB_LOOKUP_CODE             fob,--Added by Vishal
                    (select px.full_name   from per_people_x px
         where px.person_id = pod.DELIVER_TO_PERSON_ID )req_requestor,
         decode(poll.match_option,''P'',''PO'',''R'',''Receipt'',null) inv_match_option,
         ----ppx.full_name Buyer_Name, Commented by Priya for RT# 5249090
         (select ppx.full_name
      from per_people_x ppx
      where poh.agent_id = ppx.person_id
      AND trunc(SYSDATE) BETWEEN ppx.effective_start_date AND
      ppx.effective_end_date) Buyer_Name,
         CASE
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''N'' THEN
              ''2-Way''
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''3-Way''
              WHEN poll.inspection_required_flag = ''Y'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''4-Way''
            END Invoice_Match_App,
            decode(POD.req_distribution_id,
                  null,
                  POD.req_header_reference_num,
                  PORH.segment1) req_num,
                  trunc(PORH.creation_date) req_date,
                  --Added by Priya for RT# 5249090
                  \*decode (PODT.TYPE_NAME,''Standard Purchase Order'',''Standard Purchase Order'',
                  ''Blanket Purchase Agreement'',''Blanket Release'',PODT.TYPE_NAME) po_doc_type,*\
                  decode(poh.type_lookup_code,''STANDARD'',''Standard Purchase Order'',
                  ''BLANKET'',''Blanket Release'',''CONTRACT'',''Contract Purchase Agreement'',poh.type_lookup_code) po_doc_type,
                    porl.release_num                po_release_number,
                    poh.po_header_id                po_header_id,
                    pol.po_line_id                  po_line_id,
                  null                po_shipment_id,--Commented by Vishal
                  null             po_distribution_id,--Commented by Vishal
                    plt.line_type                 line_type,
                    nvl(POL.LINE_NUM_DISPLAY, to_char(POL.LINE_NUM)) line_num,
                    msi.concatenated_segments         item_name,
                   mca.concatenated_segments          category,
                   ----substr(pol.item_description,1,20)             item_description,
                   (substr(replace(replace(pol.item_description,chr(10),''''),chr(13),''''),1,25))   item_description,
                    rt.transaction_id,
                    pov.vendor_name                 vendor_name,
                    pov.segment1                  vendor_num,
                    pov.vendor_type_lookup_code         vendor_type,
                    pvs.vendor_site_code              vendor_site_name,
                    (  SELECT transaction_type_name
                    FROM  mtl_material_transactions mmt,
                        mtl_transaction_types   mtt
                    WHERE mtt.transaction_type_id = mmt.transaction_type_id
                    AND   mtt.transaction_source_type_id = mmt.transaction_source_type_id
                    AND   mmt.transaction_action_id = mtt.transaction_action_id
                    AND   mmt.rcv_transaction_id = rt.transaction_id) transaction_type,
                    capr.transaction_date              transaction_date,
                    poll.quantity                  ordered_quantity,
                    poll.Quantity_Cancelled            Quantity_Cancelled,
                    poll.unit_meas_lookup_code           UOM,
                    pod.Quantity_Delivered             Quantity_Delivered,
                    (select RSH.RECEIPT_NUM
                   from RCV_SHIPMENT_HEADERS RSH
                  where RSH.SHIPMENT_HEADER_ID = RT.SHIPMENT_HEADER_ID) receipt_num,
                    pod.EXPENDITURE_TYPE,
                   (select apia.invoice_num invoice_number
          from ap_invoices_all          apia,
             ap_invoice_distributions_all aida
         where aida.invoice_distribution_id= capr.invoice_distribution_id
          AND apia.invoice_id(+) = aida.invoice_id
          and aida.line_type_lookup_code in (''ACCRUAL'',''MISCELLANEOUS'')
          and rownum<2) INVOICE_NUM,--Added Miscellaneous by Priya for RT# 5249090
            (select aida.invoice_line_number
          from ap_invoices_all          apia,
             ap_invoice_distributions_all aida
         where aida.invoice_distribution_id= capr.invoice_distribution_id
          AND apia.invoice_id(+) = aida.invoice_id) INVOICE_LINE_NUM,
      (select decode(a.line_type_lookup_code ,''IPV'',sum(a.amount),''0'')
        from ap_invoice_distributions_all a
      Where a.invoice_id =
           (select invoice_id
             from ap_invoice_distributions_all aida
            where aida.line_type_lookup_code in (''ACCRUAL'')
              and aida.invoice_distribution_id = capr.invoice_distribution_id)
                and  a.invoice_line_number=   ( select invoice_line_number
            from ap_invoice_distributions_all aida
           where aida.line_type_lookup_code in (''ACCRUAL'')
            and aida.invoice_distribution_id =capr.invoice_distribution_id)
        AND a.line_type_lookup_code in (''IPV'')
        group by a.line_type_lookup_code)IPV,
          capr.entered_amount entered_amount,
          capr.currency_code currency_code,
          nvl(capr.currency_conversion_rate,1) currency_conversion_rate,
          capr.transaction_type_code,
          capr.invoice_distribution_id,
           decode(capr.invoice_distribution_id,
                NULL,
                decode(capr.write_off_id, NULL, '' PO '', '' WO ''),
                '' AP '') transaction_source,
                (select ood.name
          from hr_organization_units ood
         where ood.organization_id = capr.inventory_organization_id) org,
            (TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date ))) Oracle_Aging_Date,
         ((trunc(sysdate)- TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) Aging_Days,---Added by Vishal
         CASE
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) <= 0 THEN
          ''Current Period''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 0 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 31 THEN
          ''1 - 30 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 30 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 91 THEN
          ''31 - 90 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 90 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 121 THEN
          ''91 - 120 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 120 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 181 THEN
          ''121 - 180 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) > 180 AND
            ((trunc(sysdate)-TO_DATE(nvl(rt.CREATION_DATE,capr.transaction_date )))) < 361 THEN
          ''181 - 360 Days''
         ELSE
          ''Over 361 Days''
        END  Age_Bucket_Non_Zero,
                    fnc2.currency_code              accrual_currency_code,
                    poll.shipment_num               shipment_number,
                    poll.unit_meas_lookup_code          uom_code,
                    pod.distribution_num              distribution_num,
                    poll.quantity_received            quantity_received,
                    poll.quantity_billed              quantity_billed,
                    null                        quantity_accrued,
                    capr.quantity                 trx_qty,
                    capr.amount                   funct_amt,
                    rt.transaction_id               rcv_transaction_id,
                    null transfer_transaction_id,
                    (select NVL(RSL.PACKING_SLIP, RSH.PACKING_SLIP)
                   from RCV_SHIPMENT_LINES RSL, RCV_SHIPMENT_HEADERS RSH
                  WHERE RSH.SHIPMENT_HEADER_ID = RT.SHIPMENT_HEADER_ID
                    AND RSL.SHIPMENT_LINE_ID = RT.SHIPMENT_LINE_ID) PACKING_SLIP,
                    (   select gcc.segment1 || ''.'' || gcc.segment2 || ''.'' || gcc.segment3 || ''.'' ||
              gcc.segment4 || ''.'' || gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
              gcc.segment7 || ''.'' || gcc.segment8
           from gl_code_combinations gcc
          where code_combination_Id = capr.accrual_account_id
          )accrual_account,
               (nvl(poh.rate, 0) * pol.unit_price * capr.quantity) PPV1,
                    (nvl(capr.currency_conversion_rate, 0) * pol.unit_price *
                  capr.quantity) PPV2,
                    ROUND(pol.unit_price,
                         NVL(fnc2.extended_precision, 2))     po_unit_price,
                    capr.currency_code              po_currency_code,
                    ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                               0, pol.unit_price * capr.currency_conversion_rate,
                               (pol.unit_price / fnc1.minimum_accountable_unit)
                                 * capr.currency_conversion_rate
                                 * fnc1.minimum_accountable_unit),
                                  NVL(fnc1.extended_precision, 2))
                                              func_unit_price,
                    gcc2.concatenated_segments          charge_account,
                     null             accrual_amount,
                      null    func_accrual_amount,
                  poh.creation_date po_date,
                  (SELECT trunc(max(last_update_date))
                    FROM rcv_transactions rt
                   where rt.po_line_location_id = pod.line_location_id
                    AND ((rt.transaction_type = ''RECEIVE'' AND
                       parent_transaction_id = -1) OR
                       (rt.transaction_type = ''MATCH''))
                   group by po_line_location_id) receipt_date
      
      
              FROM    po_headers_all          poh,
                    po_lines_all          pol,
                    po_line_locations_all     poll,
                    po_distributions_all      pod,
                    PO_REQUISITION_HEADERS_ALL   PORH,
                    PO_REQUISITION_LINES_ALL   PORL,
                    PO_REQ_DISTRIBUTIONS_ALL   PORD,
                    po_vendors            pov,
                    po_vendor_sites_all     pvs,----Added table in place of view by Vishal (defect #10074)
                    po_line_types         plt,
                    po_releases_all         porl,
                    mtl_system_items_kfv      msi,
                    fnd_currencies          fnc1,
                    fnd_currencies          fnc2,
                    mtl_categories_kfv      mca,
                    gl_code_combinations_kfv  gcc,
                    gl_code_combinations_kfv  gcc2,
                    gl_sets_of_books sob,
                    rcv_transactions rt, ---Added by Divya on 07-May for performance fix
                   CST_AP_PO_RECONCILIATION capr,
                   PO_LOOKUP_CODES plc,----Added by Vishal on 16-Aug for Phase 2 requirement ,
                   \*per_people_x ppx ,
                   PO_DOCUMENT_TYPES_ALL PODT,
                   PO_DOCUMENT_TYPES_ALL  PODB,*\--Commented by Priya for RT# 5249090
                   cst_reconciliation_summary  crs --Added by Priya for RT# 5131175
              WHERE poh.po_header_id = pol.po_header_id
              AND plc.LOOKUP_CODE(+) = POH.FOB_LOOKUP_CODE----Added by Vishal on 16-Aug for Phase 2 requirement
              AND plc.LOOKUP_TYPE(+) = ''FOB''----Added by Vishal on 16-Aug for Phase 2 requirement
              ----and poh.agent_id = ppx.person_id----Added by Vishal on 16-Aug for Phase 2 requirement
           AND    POD.REQ_DISTRIBUTION_ID = PORD.DISTRIBUTION_ID(+)
        AND PORD.REQUISITION_LINE_ID = PORL.REQUISITION_LINE_ID(+)
        AND PORL.REQUISITION_HEADER_ID = PORH.REQUISITION_HEADER_ID(+)
        \*AND ((PODB.DOCUMENT_TYPE_CODE in (''PO'', ''PA'') AND
             PODB.DOCUMENT_SUBTYPE = POH.TYPE_LOOKUP_CODE))
          AND PODB.DOCUMENT_TYPE_CODE = PODT.DOCUMENT_TYPE_CODE
          AND PODB.DOCUMENT_SUBTYPE = PODT.DOCUMENT_SUBTYPE
          AND PODT.ORG_ID = PODB.ORG_ID
          AND PODB.ORG_ID = POH.ORG_ID*\ --Commented by Priya for RT# 5249090
              AND   pol.po_line_id = poll.po_line_id
              AND   poll.line_location_id = pod.line_location_id
              AND   pol.line_type_id = plt.line_type_id
              AND   porl.po_release_id (+)  = poll.po_release_id
              AND   poh.vendor_id = pov.vendor_id
              AND   pov.vendor_id= pvs.vendor_id
              AND   poh.vendor_site_id= pvs.vendor_site_id
              AND   msi.inventory_item_id (+)  = pol.item_id
              AND   (msi.organization_id IS NULL
                    OR
                    (msi.organization_id = poll.ship_to_organization_id AND msi.organization_id IS NOT NULL))
              AND   fnc1.currency_code =  capr.currency_code
              AND   fnc2.currency_code = sob.currency_code
              \*AND    cpea.category_id = mca.category_id*\
              AND   pol.category_id=mca.category_id (+)
              AND   gcc2.code_combination_id = pod.code_combination_id --Commented by Priya for RT# 5249090
              AND capr.accrual_account_id = gcc.code_combination_id --Added by Priya for RT# 5249090
              ----AND   gcc2.code_combination_id = pod.accrual_account_id
              AND   sob.set_of_books_id = :l_sob_id
              ----AND   capr.entered_amount !=0 --Commented by Priya for RT# 5249090
              and capr.amount !=0
              AND   crs.operating_unit_id  = :l_current_org_id
              AND   capr.operating_unit_id  = :l_current_org_id --Added by Priya for RT# 5249090
              --Added CRS JOIN by Priya for RT# 5131175
              AND capr.po_distribution_id = crs.po_distribution_id
              and crs.accrual_account_id = capr.accrual_account_id
              AND pod.po_distribution_id = crs.po_distribution_id
              AND capr.po_distribution_id = pod.po_distribution_id ----- Added by Divya 12-Feb
              and  capr.rcv_transaction_id=rt.transaction_id(+) ---Added on 14-Dec ------- Reversed Outer join to include missing Accrual screen lines by Divya 12-Feb
      
      union all
      
      SELECT
      ----NVL(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1) po_number,--Changed as a part of CLM, commented by Priya for missing IRI PO_NUM RT# 5131175
      coalesce(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1,(select poh.segment1 from ap_suppliers aps,po_headers_all poh
      where poh.po_header_id = mmt.transaction_source_id and aps.vendor_id = poh.vendor_id)) po_number,
      POH.FOB_LOOKUP_CODE              fob,--Added by Vishal
      (select px.full_name
      from per_people_x px
      where px.person_id = pod.DELIVER_TO_PERSON_ID )req_requestor,
      decode(poll.match_option,''P'',''PO'',''R'',''Receipt'',null) inv_match_option,
      \*ppx.full_name Buyer_Name,*\--Added by Priya for RT#5063616
      (select ppx.full_name
      from per_people_x ppx
      where poh.agent_id = ppx.person_id
      AND trunc(SYSDATE) BETWEEN ppx.effective_start_date AND
      ppx.effective_end_date) Buyer_Name,
      CASE
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''N'' THEN
              ''2-Way''
              WHEN poll.inspection_required_flag = ''N'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''3-Way''
              WHEN poll.inspection_required_flag = ''Y'' and
                 poll.receipt_required_flag = ''Y'' THEN
              ''4-Way''
            END Invoice_Match_App,
            decode(POD.req_distribution_id,
                  null,
                  POD.req_header_reference_num,
                  PORH.segment1) req_num,
                  trunc(PORH.creation_date) req_date,
                  ----Added by Priya for RT# 5249090
                  decode(poh.type_lookup_code,''STANDARD'',''Standard Purchase Order'',
                  ''BLANKET'',''Blanket Release'',''CONTRACT'',''Contract Purchase Agreement'',poh.type_lookup_code) po_doc_type,--Added by Priya for RT#5063616
      por.release_num                         po_release,
      poh.po_header_id                 po_header_id,
      pol.po_line_id                 po_line_id,
      null                      po_shipment_id,
                    cmr.po_distribution_id              po_distribution_id,
                    plt.line_type line_type,
                    nvl(POL.LINE_NUM_DISPLAY, to_char(POL.LINE_NUM)) line_num,
                    decode(cmr.inventory_item_id, null, null,
                                   (select msi.concatenated_segments from
                                    mtl_system_items_vl msi
                                    where inventory_item_id = cmr.inventory_item_id
                                   and rownum <2)
                                   )                             item_name,
      
                    mca.concatenated_segments                         category,
            (substr(replace(replace(pol.item_description,chr(10),''''),chr(13),''''),1,25))        item_description,
                   mmt.transaction_id,
                   coalesce(aps.vendor_name,aps1.vendor_name,pov.vendor_name,(select vendor_name
                                    from ap_suppliers aps,po_headers_all poh
                                    where poh.po_header_id = mmt.transaction_source_id
                                    and aps.vendor_id = poh.vendor_id)) vendor_name ,
             coalesce( aps.segment1, aps1.segment1,pov.segment1,(select aps.segment1
                                    from ap_suppliers aps,po_headers_all poh
                                    where poh.po_header_id = mmt.transaction_source_id
                                    and aps.vendor_id = poh.vendor_id)) vendor_num,
                    coalesce(aps.vendor_type_lookup_code,aps1.vendor_type_lookup_code,pov.vendor_type_lookup_code,
                    (select aps.vendor_type_lookup_code from ap_suppliers aps,po_headers_all poh where poh.po_header_id = mmt.transaction_source_id
                    and aps.vendor_id = poh.vendor_id)) vendor_type,
                    pvs.vendor_site_code              vendor_site_name,
                    decode(cmr.invoice_distribution_id,
                             NULL,
                    decode ( cmr.transaction_type_code,
                                  ''CONSIGNMENT'',
                                  (SELECT crc.displayed_field
                                  FROM cst_reconciliation_codes crc
                                  WHERE crc.lookup_code =
                                        cmr.transaction_type_code
                                  AND crc.lookup_type IN
                                       ( ''ACCRUAL WRITE-OFF ACTION'',''ACCRUAL TYPE'')),
                                  (SELECT mtt.transaction_type_name
                                  FROM mtl_transaction_types      mtt
                                  WHERE cmr.transaction_type_code =
                                            to_char(mtt.transaction_type_id) )),
                             (SELECT crc.displayed_field
                             FROM cst_reconciliation_codes crc
                             WHERE crc.lookup_code =
                                  cmr.transaction_type_code
                             AND crc.lookup_type IN
                              ( ''ACCRUAL WRITE-OFF ACTION'',''ACCRUAL TYPE'')))   transaction_type,
                    cmr.transaction_date                        transaction_date,
                    poll.quantity                  ordered_quantity,
                    poll.Quantity_Cancelled            Quantity_Cancelled,
                    poll.unit_meas_lookup_code           UOM,
                    pod.Quantity_Delivered             Quantity_Delivered,
                    null receipt_num,
                    pod.EXPENDITURE_TYPE,
                    apia.invoice_num                          INVOICE_NUM,
                             aida.invoice_line_number                    INVOICE_LINE_NUM,
                             (select decode(a.line_type_lookup_code ,''IPV'',sum(a.amount),''0'')
        from ap_invoice_distributions_all a
      Where a.invoice_id =
           (select invoice_id
             from ap_invoice_distributions_all aida
            where aida.line_type_lookup_code in (''ACCRUAL'')
              and aida.invoice_distribution_id = cmr.invoice_distribution_id)
                and  a.invoice_line_number=   ( select invoice_line_number
            from ap_invoice_distributions_all aida
           where aida.line_type_lookup_code in (''ACCRUAL'')
            and aida.invoice_distribution_id =cmr.invoice_distribution_id)
        AND a.line_type_lookup_code in (''IPV'')
        group by a.line_type_lookup_code)IPV,
      
          cmr.entered_amount                        entered_amount,
           cmr.currency_code                         currency_code,
          nvl(cmr.currency_conversion_rate,1) currency_conversion_rate,
           decode(mmt.transaction_id, null , transaction_type_code, (SELECT mtt.transaction_type_name
                  FROM mtl_transaction_types      mtt where mtt.transaction_type_id = mmt.transaction_type_id)) transaction_type_code ,
          cmr.invoice_distribution_id,
          decode(cmr.invoice_distribution_id,
                             NULL,
                             ''INV'',
                             ''AP'')                                               transaction_source,
      
          mp.organization_code                      org,
          (TO_DATE(nvl(apia.invoice_date,cmr.transaction_date ))) Oracle_Aging_Date,
            ((trunc(sysdate)- TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) Aging_Days,---Added by Vishal
         CASE
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) <= 0 THEN
          ''Current Period''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 0 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 31 THEN
          ''1 - 30 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 30 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 91 THEN
          ''31 - 90 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 90 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 121 THEN
          ''91 - 120 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 120 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 181 THEN
          ''121 - 180 Days''
         WHEN ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) > 180 AND
            ((trunc(sysdate)-TO_DATE(nvl(apia.invoice_date,cmr.transaction_date )))) < 361 THEN
          ''181 - 360 Days''
         ELSE
          ''Over 361 Days''
        END  Age_Bucket_Non_Zero,
          fnc2.currency_code               accrual_currency_code,
                    poll.shipment_num               shipment_number,
                    poll.unit_meas_lookup_code          uom_code,
                    pod.distribution_num              distribution_num,
                    poll.quantity_received,
                    poll.quantity_billed,
                    null        quantity_accrued,
                    \*Added by Vishal 10-Jan-2013*\
                    cmr.quantity                  trx_qty,
                    cmr.amount                    funct_amt,
                   null               rcv_transaction_id,
                   mmt.transfer_transaction_id transfer_transaction_id ,
                   null                 packing_slip,
                   (   select gcc.segment1 || ''.'' || gcc.segment2 || ''.'' || gcc.segment3 || ''.'' ||
              gcc.segment4 || ''.'' || gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
              gcc.segment7 || ''.'' || gcc.segment8
           from gl_code_combinations gcc
          where code_combination_Id = cmr.accrual_account_id
          ) accrual_account,
          (nvl(poh.rate, 0) * pol.unit_price * cmr.quantity) PPV1,
                    (nvl(cmr.currency_conversion_rate, 0) * pol.unit_price *
                  cmr.quantity) PPV2,
                  ROUND(pol.unit_price,
                         NVL(fnc2.extended_precision, 2))     po_unit_price,
                  null  po_currency_code,
                  ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                               0, pol.unit_price * cmr.currency_conversion_rate,
                               (pol.unit_price / fnc1.minimum_accountable_unit)
                                 * cmr.currency_conversion_rate
                                 * fnc1.minimum_accountable_unit),
                                  NVL(fnc1.extended_precision, 2)) func_unit_price,
                   gcc2.concatenated_segments         charge_account,
          null             accrual_amount,
                            null func_accrual_amount,
                  poh.creation_date po_date,
                  (SELECT trunc(max(last_update_date))
                  FROM rcv_transactions rt
                   where rt.po_line_location_id = pod.line_location_id
                    AND ((rt.transaction_type = ''RECEIVE'' AND
                       parent_transaction_id = -1) OR
                       (rt.transaction_type = ''MATCH''))
                   group by po_line_location_id) receipt_date
                       FROM   cst_misc_reconciliation                     cmr,
                             ap_invoices_all                           apia,
                             ap_invoice_distributions_all                  aida,
                              ap_suppliers                              pov,
                             ap_suppliers                            aps,
                             ap_suppliers                            aps1,
                             mtl_parameters                          mp,
                             gl_code_combinations_kfv                    gcc,
                             po_distributions_all                      pod,
                             PO_REQUISITION_HEADERS_ALL                  PORH,
                             PO_REQUISITION_LINES_ALL                    PORL,
                             PO_REQ_DISTRIBUTIONS_ALL                    PORD,
                             po_line_locations_all                       poll,
                             ap_supplier_sites_all                        pvs,
                             po_releases_all                           por,
                             po_lines_all                            pol,
                             po_line_types                           plt,
                             po_headers_all                          poh,
                             mtl_categories_kfv                        mca,
                             mtl_material_transactions                   mmt,
                             fnd_currencies                          fnc1,
                             fnd_currencies                          fnc2,
                             gl_sets_of_books                          sob,
                            ---- gl_code_combinations_kfv   gcc1,                 --Commented by Priya for RT# 5249090
                             gl_code_combinations_kfv   gcc2,
                             PO_LOOKUP_CODES plc
                        WHERE  cmr.invoice_distribution_id = aida.invoice_distribution_id(+)
                        AND plc.LOOKUP_CODE(+) = POH.FOB_LOOKUP_CODE----Added by Vishal on 16-Aug for Phase 2 requirement
                       AND plc.LOOKUP_TYPE(+) = ''FOB''----Added by Vishal on 16-Aug for Phase 2 requirement
                        AND POD.REQ_DISTRIBUTION_ID = PORD.DISTRIBUTION_ID(+)
                        AND PORD.REQUISITION_LINE_ID = PORL.REQUISITION_LINE_ID(+)
                        AND PORL.REQUISITION_HEADER_ID = PORH.REQUISITION_HEADER_ID(+)
                        AND    cmr.vendor_id = pov.vendor_id(+)
                        AND    aps.vendor_id(+)=poh.vendor_id
                        And    aps1.vendor_id(+)=apia.vendor_id
                        --AND    cmr.vendor_id = pov.vendor_id(+)               --Commented by Priya for RT# 5249090
                        AND    gcc2.code_combination_id (+)= pod.code_combination_id --Commented by Priya for RT# 5249090
                        -----AND    gcc2.code_combination_id (+)= pod.accrual_account_id
                        AND    aida.invoice_id = apia.invoice_id(+)
                        AND    poh.vendor_id= pvs.vendor_id (+)
                       AND    poh.vendor_site_id= pvs.vendor_site_id (+)
                        AND    cmr.inventory_organization_id = mp.organization_id(+)
                        AND    cmr.accrual_account_id  = gcc.code_combination_id
                        AND    pod.po_distribution_id(+) = cmr.po_distribution_id
                        and    cmr.inventory_transaction_id = mmt.transaction_id (+)
                        AND    poll.line_location_id(+) = pod.line_location_id
                        AND    pol.category_id=mca.category_id (+)
                        AND    fnc2.currency_code = sob.currency_code
                        AND    fnc1.currency_code =  cmr.currency_code
                        AND    pol.line_type_id = plt.line_type_id (+)
                        AND    poh.org_id (+) =pod.org_id
                        AND    pod.po_release_id = por.po_release_id(+)
                        AND    pol.po_line_id(+) = pod.po_line_id
                        AND    poh.po_header_id(+) = pod.po_header_id
                        AND    cmr.operating_unit_id = :l_current_org_id --MO_GLOBAL.GET_CURRENT_ORG_ID --Commented MO_GLOBAL.GET_CURRENT_ORG_ID by Priya for RT# 5063616
                        ----AND   cmr.entered_amount !=0  --Commented by Priya for RT# 5249090
                        and cmr.amount !=0
                        AND    sob.set_of_books_id = :l_sob_id
                        )
              ORDER BY DECODE(:l_order_by,
              ''Category'', category,
              ''Vendor'', vendor_name),
         item_name,--Added by Priya for RT#5063616
         invoice_num, --Added by Priya for RT#5249090
              po_number,----NVL(poh.CLM_DOCUMENT_NUMBER,poh.SEGMENT1),
              line_num,---nvl(POL.LINE_NUM_DISPLAY, to_char(POL.LINE_NUM)),
              shipment_number,
              distribution_num'
                \*Added l_sob_id to avoid the bind variable issue in union all*\
                  USING l_sob_id, l_current_org_id, l_current_org_id, l_current_org_id, l_sob_id, l_order_by;
              END IF;
      
              l_row_tag     := 'BODY';
              l_row_set_tag := 'ACCRUAL_INFO';
      
              -- Generate XML data for report body
              l_stmt_num := 150;
              Generate_XML(p_api_version      => 1.0,
                           p_init_msg_list    => FND_API.G_FALSE,
                           p_validation_level => FND_API.G_VALID_LEVEL_FULL,
                           x_return_status    => l_return_status,
                           x_msg_count        => l_msg_count,
                           x_msg_data         => l_msg_data,
                           p_ref_cur          => l_body_ref_cur,
                           p_row_tag          => l_row_tag,
                           p_row_set_tag      => l_row_set_tag,
                           x_xml_data         => l_xml_body);
      
              -- If return status is not success, add message to the log
              IF (l_return_status <> FND_API.G_RET_STS_SUCCESS) THEN
                l_msg_data := 'Failed generating XML data to the report output';
                RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
              END IF;
      
              -- Merge the header part with the body part.
              -- 'ACR_REPORT' will be used as root tag for resultant XML data
              l_stmt_num := 160;
              Merge_XML(p_api_version      => 1.0,
                        p_init_msg_list    => FND_API.G_FALSE,
                        p_validation_level => FND_API.G_VALID_LEVEL_FULL,
                        x_return_status    => l_return_status,
                        x_msg_count        => l_msg_count,
                        x_msg_data         => l_msg_data,
                        p_xml_src1         => l_xml_header,
                        p_xml_src2         => l_xml_body,
                        p_root_tag         => 'ACR_REPORT',
                        x_xml_doc          => l_xml_report);
      
              -- If return status is not success, add message to the log
              IF (l_return_status <> FND_API.G_RET_STS_SUCCESS) THEN
                l_msg_data := 'Failed generating XML data to the report output';
                RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
              END IF;
      
              -- Print the XML data to the report output
              l_stmt_num := 170;
              Print_ClobOutput(p_api_version      => 1.0,
                               p_init_msg_list    => FND_API.G_FALSE,
                               p_validation_level => FND_API.G_VALID_LEVEL_FULL,
                               x_return_status    => l_return_status,
                               x_msg_count        => l_msg_count,
                               x_msg_data         => l_msg_data,
                               p_xml_data         => l_xml_report);
      
              -- If return status is not success, add message to the log
              IF (l_return_status <> FND_API.G_RET_STS_SUCCESS) THEN
                l_msg_data := 'Failed writing XML data to the report output';
                RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
              END IF;
      
              -- Write log messages to request log
              l_stmt_num := 180;
              CST_UTILITY_PUB.writelogmessages(p_api_version   => 1.0,
                                               p_msg_count     => l_msg_count,
                                               p_msg_data      => l_msg_data,
                                               x_return_status => l_return_status);
      
              -- If return status is not success, add message to the log
              IF (l_return_status <> FND_API.G_RET_STS_SUCCESS) THEN
                l_msg_data := 'Failed writing log messages';
                RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
              END IF;
      
              -- Procedure level log message for exit point
              IF (l_pLog) THEN
                FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                               l_module || '.end',
                               'Start_Process >>');
              END IF;
           -- ELSE*/
      IF l_current_org_id IN (456, 88) THEN	
		
        l_charge_account_cond      := ' (SELECT concatenated_segments
                   FROM gl_code_combinations_kfv gcc,
                      po_distributions_inq_v   pdi
                  WHERE pdi.code_combination_id = gcc.code_combination_id
            AND pdi.po_distribution_id = pod.po_distribution_id) ';
        l_code_combination_id_cond := ' pod.accrual_account_id ';
        l_charge_account           := ' ( SELECT    gcc.concatenated_segments
                      FROM    AP_INVOICE_DISTRIBUTIONS_V aid,
                                po_distributions_all pod,
                                 po_distributions_inq_v   pdi,
                                gl_code_combinations_kfv gcc
                     WHERE         aid.po_header_id = poh.po_header_id
                                AND aid.po_line_id = mct.po_line_id
                                AND aid.po_release_id = mct.consumption_release_id
                                AND aid.po_distribution_id(+) = pod.po_distribution_id
                                AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                                AND aid.cancelled_date IS NULL
                                AND pdi.po_distribution_id = pod.po_distribution_id
                                AND gcc.code_combination_id(+) =
                                        pdi.code_combination_id
                    HAVING    COUNT (aid.po_distribution_id) = 1
                 GROUP BY    gcc.concatenated_segments) ';
      ELSE  
	  
        l_charge_account_cond      := ' gcc2.concatenated_segments ';
        l_code_combination_id_cond := ' pod.code_combination_id ';
        l_charge_account           := ' (  SELECT  gcc2.concatenated_segments
            FROM  AP_INVOICE_DISTRIBUTIONS_V aid,
                po_distributions_all pod,
                gl_code_combinations_kfv gcc2
           WHERE     aid.po_header_id = poh.po_header_id
                AND aid.po_line_id = mct.po_line_id
                AND aid.po_release_id = mct.consumption_release_id
                AND aid.po_distribution_id(+) = pod.po_distribution_id
                AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                AND aid.cancelled_date IS NULL
                AND gcc2.code_combination_id(+) =
                    pod.code_combination_id
          HAVING  COUNT (aid.po_distribution_id) = 1
         GROUP BY  gcc2.concatenated_segments) ';
      END IF;
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_charge_account_cond : ' ||
                              l_charge_account_cond);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_code_combination_id_cond : ' ||
                              l_code_combination_id_cond);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_charge_account : ' || l_charge_account);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
    
      IF p_min_accrual_amount = 0 OR p_min_accrual_amount IS NULL THEN
        l_min_accrual_cond := ' AND 1 = 1';
      ELSE
        l_min_accrual_cond := ' AND capr.po_distribution_id IN
         (SELECT bcapr.po_distribution_id
           FROM bom.cst_reconciliation_summary bcapr
          WHERE bcapr.operating_unit_id = capr.operating_unit_id
            AND ABS(bcapr.ap_balance + bcapr.po_balance +
                 bcapr.write_off_balance) > ' ||
                              p_min_accrual_amount ||
                              ' AND  bcapr.po_distribution_id = capr.po_distribution_id  
                      AND  bcapr.accrual_account_id  = capr.accrual_account_id
          GROUP BY bcapr.po_distribution_id
          HAVING COUNT(DISTINCT bcapr.accrual_account_id) = 1)';
      END IF;
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_min_accrual_cond : ' || l_min_accrual_cond);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
    
      IF p_exclude_receipt_matched = 'N' THEN
        l_receipt_cond1 := ' ';
        l_receipt_cond2 := ')';
      ELSE
        l_receipt_cond1 := ',(SELECT NVL(SUM(caprr.amount), 99)
                FROM cst_ap_po_reconciliation caprr,
                    rcv_transactions      rtt
                WHERE caprr.po_distribution_id =
                    capr.po_distribution_id
                 AND caprr.rcv_transaction_id = rtt.transaction_id(+)
                 AND rtt.parent_transaction_id =
                    NVL(DECODE(rt.parent_transaction_id,
                           -1,
                           rt.transaction_id,
                           rt.parent_transaction_id),
                      capr.rcv_transaction_id)
                 AND caprr.accrual_account_id =
                    capr.accrual_account_id) transact_sum,
              (SELECT NVL(SUM(yyyy.amount), 99)
                FROM cst_ap_po_reconciliation yyyy,
                    rcv_transactions      zz
                WHERE yyyy.po_distribution_id =
                    capr.po_distribution_id
                 AND yyyy.accrual_account_id =
                    capr.accrual_account_id
                 AND yyyy.amount != 0
                 AND zz.transaction_id = yyyy.rcv_transaction_id
                 AND yyyy.po_distribution_id =
                    NVL(ZZ.po_distribution_id,
                      yyyy.po_distribution_id)
                 AND zz.shipment_header_id = rt.shipment_header_id) receipt_sum';
        l_receipt_cond2 := ' ) ER
     WHERE ER.transact_sum != 0
      AND ER.receipt_sum != 0';
      END IF;
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_receipt_cond1 : ' || l_receipt_cond1);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_receipt_cond2 : ' || l_receipt_cond2);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
    
      IF p_exclude_po_matched = 'N' THEN
        l_po_cond1 := ' ';
        l_po_cond2 := ')';
      ELSE
        l_po_cond1 := ',MONTHS_BETWEEN(TO_DATE(TO_CHAR(TRUNC(capr.transaction_date),
                                                    ''MMYY''),
                                            ''MMYY''),
                                    TO_DATE((xxap_grni_rep_pkg.remove_monthwise_zero(capr.po_distribution_id,
                                                                                           capr.accrual_account_id)),
                                            ''MMYY'')) month_sum,
                     (SELECT NVL(SUM(caprr.amount), 99)
                        FROM cst_ap_po_reconciliation caprr
                       WHERE caprr.po_distribution_id = capr.po_distribution_id
                         AND caprr.accrual_account_id = capr.accrual_account_id
                         AND caprr.amount != 0
                         AND TO_CHAR(TRUNC(caprr.transaction_date), ''MMYY'') =
                             TO_CHAR(TRUNC(capr.transaction_date), ''MMYY'')) month_total';
        l_po_cond2 := ' ) ep
     WHERE ep.month_total != 0 
      AND ep.month_sum > 0';
      END IF;
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_po_cond1 : ' || l_po_cond1);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_po_cond2 : ' || l_po_cond2);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
    
      IF p_exclude_matched_consignment = 'N' THEN
        l_misc_cond1 := ' ';
      ELSE
        l_misc_cond1 := ' AND NOT EXISTS
          (SELECT 1
                FROM cst_misc_reconciliation cmr2
                WHERE cmr2.po_distribution_id = cmr.po_distribution_id
                 AND cmr2.accrual_account_id = cmr.accrual_account_id
                 AND cmr2.operating_unit_id = cmr.operating_unit_id
                HAVING SUM(cmr2.amount) = 0
                GROUP BY cmr2.po_distribution_id,
                      cmr2.accrual_account_id) ';
      END IF;
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'l_misc_cond1 : ' || l_misc_cond1);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');							  
    
      ---Added :p_location ,p_vendor_from,age_bucket 31-60 and 60-90 clause in below Query by Raju For CR#8035 
	  /* Added 
			operating_unit, 
			bill_qty_greater_than_recv_qty, 
			ordered_delivered_match, 
			delivered_billed_match,
			entity,
			location,
			location_name,	
			cost_center,
			account,
			product,
			intercompany,
			future_1,
			future_2,
			po_closure_status,
			po_last_trx_date,
			last_trx_date_age_bucket,
			po_closed_status,
			rcv_shipment_num,
			bill_of_lading,
			shipped_date,
			freight_carrier_code,
			waybill_airbill_num,
			trane_ref_number
		 by Harshil for CR8035 */

		/* 
		Special characters are handled for the following columns for CR8035
		1)rcv_shipment_num
		2)bill_of_lading
		3)packing_slip
		4)freight_carrier_code
		5)waybill_airbill_num
		6)trane_ref_number
		*/	
		
		-- For CR8035, Updated the logic of Unit Price
		
		/* 
		For CR8035, Called a newly created function get_buyer_name for buyer_name.
		For CR8035, Changed the logic of ordered_quantity,quantity_delivered,quantity_billed and quantity_cancelled
		For CR8035, Changed the column name of po_header_closed_status to po_closed_status and also its logic
		For CR8035, Added a new column trane_ref_number in the GTT and added its logic.		
		*/
    
      l_receipt := 'INSERT INTO xxap_grni_gtt
           (po_number,
            fob,
            req_requestor,
            inv_match_option,
            buyer_name,
            invoice_match_app,
            req_num,
            req_date,
            po_doc_type,
            po_release_number,
            po_header_id,
            po_line_id,
            po_distribution_id,
            line_type,
            line_num,
            item_name,
            category,
            item_description,
            transaction_id,
            vendor_name,
            vendor_num,
            vendor_type,
            vendor_site_name,
            transaction_type,
            transaction_date,
            ordered_quantity,
            quantity_cancelled,
            uom,
            quantity_delivered,
            receipt_num,
            expenditure_type,
            invoice_num,
            invoice_line_num,
            ipv,
            entered_amount,
            currency_code,
            currency_conversion_rate,
            transaction_type_code,
            invoice_distribution_id,
            transaction_source,
            org,
            oracle_aging_date,
            aging_days,
            age_bucket_non_zero,
            accrual_currency_code,
            shipment_number,
            uom_code,
            distribution_num,
            quantity_received,
            quantity_billed,
            trx_qty,
            funct_amt,
            rcv_transaction_id,
            transfer_transaction_id,
            packing_slip,
            accrual_account,
            ppv1,
            ppv2,
            po_unit_price,
            po_currency_code,
            func_unit_price,
            charge_account,
            po_date,
            receipt_date,
			operating_unit,
			bill_qty_greater_than_recv_qty,
			ordered_delivered_match,
			delivered_billed_match,
			entity,
			location,
			location_name,	
			cost_center,
			account,
			product,
			intercompany,
			future_1,
			future_2,
					  po_closure_status,
					  po_last_trx_date,
					  last_trx_date_age_bucket,
					  po_closed_status,
					  rcv_shipment_num,
					  bill_of_lading,
					  shipped_date,
					  freight_carrier_code,
					  waybill_airbill_num,
					  trane_ref_number)
            SELECT po_number,
         fob,
         req_requestor,
         inv_match_option,
         buyer_name,
         invoice_match_app,
         req_num,
         req_date,
         po_doc_type,
         po_release_number,
         po_header_id,
         po_line_id,
         po_distribution_id,
         line_type,
         line_num,
         item_name,
         category,
         item_description,
         transaction_id,
         vendor_name,
         vendor_num,
         vendor_type,
         vendor_site_name,
         transaction_type,
         transaction_date,
         ordered_quantity,
         quantity_cancelled,
         uom,
         quantity_delivered,
         receipt_num,
         expenditure_type,
         invoice_num,
         invoice_line_num,
         ipv,
         entered_amount,
         currency_code,
         currency_conversion_rate,
         transaction_type_code,
         invoice_distribution_id,
         transaction_source,
         org,
         oracle_aging_date,
         aging_days,
         age_bucket_non_zero,
         accrual_currency_code,
         shipment_number,
         uom_code,
         distribution_num,
         quantity_received,
         quantity_billed,
         trx_qty,
         funct_amt,
         rcv_transaction_id,
         transfer_transaction_id,
         packing_slip,
         accrual_account,
         ppv1,
         ppv2,
         po_unit_price,
         po_currency_code,
         func_unit_price,
         charge_account,
         po_date,
         receipt_date,
		 operating_unit,
		 bill_qty_greater_than_recv_qty,
		 ordered_delivered_match,
		 delivered_billed_match,
				  entity,
				  location,	
				  location_name,				  
				  cost_center,
				  account,
				  product,
				  intercompany,
				  future_1,
				  future_2,
					  po_closure_status,
					  po_last_trx_date,
					  last_trx_date_age_bucket,
					  po_closed_status,
					  rcv_shipment_num,
					  bill_of_lading,
					  shipped_date,
					  freight_carrier_code,
					  waybill_airbill_num,
					  trane_ref_number	
      FROM (SELECT NVL(poh.clm_document_number, poh.segment1) po_number,
              poh.fob_lookup_code fob,
              (SELECT px.full_name
                FROM per_people_x px
                WHERE px.person_id = pod.deliver_to_person_id) req_requestor,
              DECODE(poll.match_option,
                   ''P'',
                   ''PO'',
                   ''R'',
                   ''Receipt'',
                   NULL) inv_match_option,
			  XXAP_GRNI_REP_PKG.get_buyer_name(poh.agent_id,poll.po_release_id) buyer_name,
              CASE
                WHEN poll.inspection_required_flag = ''N'' AND
                   poll.receipt_required_flag = ''N'' THEN
                ''2-Way''
                WHEN poll.inspection_required_flag = ''N'' AND
                   poll.receipt_required_flag = ''Y'' THEN
                ''3-Way''
                WHEN poll.inspection_required_flag = ''Y'' AND
                   poll.receipt_required_flag = ''Y'' THEN
                ''4-Way''
              END invoice_match_app,
              DECODE (pod.req_distribution_id,
              NULL, pod.req_header_reference_num,
              (SELECT porh.segment1
                  FROM po_requisition_headers_all porh,
                       po_requisition_lines_all porl,
                       po_req_distributions_all pord
                 WHERE pod.req_distribution_id = pord.distribution_id(+)
                   AND pord.requisition_line_id = porl.requisition_line_id(+)
                   AND porl.requisition_header_id = porh.requisition_header_id(+))) req_num,
              (SELECT TRUNC (porh.creation_date)
          FROM po_requisition_headers_all porh,
               po_requisition_lines_all porl,
               po_req_distributions_all pord
         WHERE pod.req_distribution_id = pord.distribution_id(+)
           AND pord.requisition_line_id = porl.requisition_line_id(+)
           AND porl.requisition_header_id = porh.requisition_header_id(+)) req_date,
              DECODE(poh.type_lookup_code,
                   ''STANDARD'',
                   ''Standard Purchase Order'',
                   ''BLANKET'',
                   ''Blanket Release'',
                   ''CONTRACT'',
                   ''Contract Purchase Agreement'',
                   poh.type_lookup_code) po_doc_type,
              (SELECT por.release_num
                 FROM po_releases_all por
                WHERE por.po_release_id = poll.po_release_id) po_release_number,              
              poh.po_header_id,
              pol.po_line_id,
              capr.po_distribution_id,
              (SELECT plt.line_type from po_line_types plt where pol.line_type_id = plt.line_type_id) line_type,
              NVL(pol.line_num_display, TO_CHAR(pol.line_num)) line_num,
              (SELECT msi.concatenated_segments FROM mtl_system_items_kfv msi
               WHERE msi.inventory_item_id = pol.item_id
              AND msi.organization_id = poll.ship_to_organization_id) item_name  ,
              (SELECT mca.concatenated_segments FROM mtl_categories_kfv mca WHERE  pol.category_id = mca.category_id) category,
             /* (SUBSTR(REPLACE(REPLACE(pol.item_description,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    25)) item_description, */ -- Commented w.r.to PM#344
			  SUBSTR(xxap_utility_pkg.replace_spl_char(pol.item_description),1,25)	item_description, -- Added w.r.to PM#344
              rt.transaction_id,
              pov.vendor_name,
              pov.segment1 vendor_num,
              pov.vendor_type_lookup_code vendor_type,
               (SELECT pvs.vendor_site_code
                FROM ap_supplier_sites_all pvs
               WHERE poh.vendor_id = pvs.vendor_id
                AND poh.vendor_site_id = pvs.vendor_site_id) vendor_site_name,
              (SELECT transaction_type_name
                 FROM mtl_material_transactions mmt, mtl_transaction_types mtt
                WHERE mtt.transaction_type_id = mmt.transaction_type_id
                  AND mtt.transaction_source_type_id = mmt.transaction_source_type_id
                  AND mmt.transaction_action_id = mtt.transaction_action_id
                  AND mmt.rcv_transaction_id = rt.transaction_id) transaction_type,
              capr.transaction_date,
              pod.quantity_ordered ordered_quantity,
              pod.quantity_cancelled,
              poll.unit_meas_lookup_code uom,
              pod.quantity_delivered,
              (SELECT rsh.receipt_num
                FROM rcv_shipment_headers rsh
                WHERE rsh.shipment_header_id = rt.shipment_header_id) receipt_num,
              pod.expenditure_type,
              (SELECT apia.invoice_num invoice_number
                 FROM ap_invoices_all apia, ap_invoice_distributions_all aida
                WHERE aida.invoice_distribution_id = capr.invoice_distribution_id
                  AND apia.invoice_id(+) = aida.invoice_id
                  AND aida.line_type_lookup_code IN (''ACCRUAL'', ''MISCELLANEOUS'')
                  AND ROWNUM < 2) invoice_num,
              (SELECT aida.invoice_line_number
                 FROM ap_invoices_all apia, ap_invoice_distributions_all aida
                WHERE aida.invoice_distribution_id = capr.invoice_distribution_id
                  AND apia.invoice_id(+) = aida.invoice_id) invoice_line_num,
              (SELECT DECODE (a.line_type_lookup_code, ''IPV'', SUM (a.amount), 0)
                 FROM ap_invoice_distributions_all a
                WHERE a.invoice_id =
                    (SELECT invoice_id
                       FROM ap_invoice_distributions_all aida
                      WHERE aida.line_type_lookup_code IN (''ACCRUAL'')
                        AND aida.invoice_distribution_id =
                                                  capr.invoice_distribution_id)
                  AND a.invoice_line_number =
                    (SELECT invoice_line_number
                       FROM ap_invoice_distributions_all aida
                      WHERE aida.line_type_lookup_code IN (''ACCRUAL'')
                        AND aida.invoice_distribution_id =
                                                  capr.invoice_distribution_id)
                  AND a.line_type_lookup_code IN (''IPV'')
             GROUP BY a.line_type_lookup_code) ipv,
              capr.entered_amount,
              capr.currency_code,
              NVL(capr.currency_conversion_rate, 1) currency_conversion_rate,
              capr.transaction_type_code,
              capr.invoice_distribution_id,
              DECODE(capr.invoice_distribution_id,
                   NULL, DECODE(capr.write_off_id, NULL, ''PO'', ''WO''),
                   ''AP''
                   ) transaction_source,
              (SELECT ood.name
                FROM hr_organization_units ood
                WHERE ood.organization_id = capr.inventory_organization_id) org,
              (TO_DATE(NVL(rt.creation_date, capr.transaction_date))) oracle_aging_date,
              ((TRUNC(SYSDATE) -
              TO_DATE(NVL(rt.creation_date, capr.transaction_date)))) aging_days,
               CASE
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) <= 0 THEN
                ''Current Period'' 
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) > 0 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) < 31 THEN
                ''1 - 30 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) > 30 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) < 61 THEN
                ''31 - 60 Days''
             WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) > 60 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) < 91 THEN
                ''61 - 90 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) > 90 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) < 121 THEN
                ''91 - 120 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) > 120 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) < 181 THEN
                ''121 - 180 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) > 180 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(rt.creation_date,
                      capr.transaction_date)))) < 361 THEN
                ''181 - 360 Days''
                ELSE
                ''Over 361 Days''
                END age_bucket_non_zero,
              :l_accrual_currency_code accrual_currency_code,
              poll.shipment_num shipment_number,
              poll.unit_meas_lookup_code uom_code,
              pod.distribution_num,
              poll.quantity_received,
              pod.quantity_billed,
              capr.quantity trx_qty,
              capr.amount funct_amt,
              rt.transaction_id rcv_transaction_id,
              NULL transfer_transaction_id,
			(REPLACE(REPLACE((SELECT NVL(rsl.packing_slip, rsh.packing_slip)
							FROM rcv_shipment_lines rsl, rcv_shipment_headers rsh
							WHERE rsh.shipment_header_id = rt.shipment_header_id
							 AND rsl.shipment_line_id = rt.shipment_line_id),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) packing_slip,
              (SELECT gcc.segment1 || ''.'' || gcc.segment2 || ''.'' ||
                    gcc.segment3 || ''.'' || gcc.segment4 || ''.'' ||
                    gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
                    gcc.segment7 || ''.'' || gcc.segment8
                FROM gl_code_combinations gcc
                WHERE code_combination_id = capr.accrual_account_id) accrual_account,
              (NVL(poh.rate, 0) * pol.unit_price * capr.quantity) ppv1,
              (NVL(capr.currency_conversion_rate, 0) * pol.unit_price *
              capr.quantity) ppv2,
              ROUND(DECODE(poll.po_release_id,NULL,pol.unit_price,poll.price_override), :l_extended_precision) po_unit_price,
              capr.currency_code po_currency_code,
              ( SELECT ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                       0,
                       pol.unit_price *
                       capr.currency_conversion_rate,
                       (pol.unit_price /
                       fnc1.minimum_accountable_unit) *
                       capr.currency_conversion_rate *
                       fnc1.minimum_accountable_unit),
                  NVL(fnc1.extended_precision, 2)) FROM fnd_currencies    fnc1 
                 WHERE  fnc1.currency_code = capr.currency_code ) func_unit_price,
              ' || l_charge_account_cond ||
                   ' charge_account,
              poh.creation_date po_date,
              (SELECT TRUNC(MAX(last_update_date))
                FROM rcv_transactions rt
                WHERE rt.po_line_location_id = pod.line_location_id
                 AND ((rt.transaction_type = ''RECEIVE'' AND
                    parent_transaction_id = -1) OR
                    (rt.transaction_type = ''MATCH''))
                GROUP BY po_line_location_id) receipt_date ' ||
                   l_receipt_cond1
			|| ', 
			(SELECT hou.name
			 FROM hr_operating_units hou
			 WHERE hou.organization_id = '||l_current_org_id||') operating_unit,
			CASE
				WHEN (pod.quantity_billed > pod.quantity_delivered) THEN
				''Y''
				ELSE
				''N''
			END bill_qty_greater_than_recv_qty,
			DECODE(pod.quantity_ordered,pod.quantity_delivered,''Y'',''N'') ordered_delivered_match,
			DECODE(pod.quantity_billed,pod.quantity_delivered,''Y'',''N'') delivered_billed_match,	
			(SELECT gcc.segment1 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) entity,
			(SELECT gcc.segment2 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) location,
			(SELECT ffvl.description 
			 FROM fnd_flex_values_vl ffvl, fnd_flex_value_sets ffvs, gl_code_combinations gcc
			 WHERE 
				 ffvs.flex_value_set_name = ''XXIR_GL_LOCATION''
			 AND ffvs.flex_value_set_id = ffvl.flex_value_set_id
			 AND ffvl.flex_value_meaning = gcc.segment2
			 AND gcc.code_combination_id = capr.accrual_account_id) location_name,  
			(SELECT gcc.segment3 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) cost_center,	
			(SELECT gcc.segment4 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) account,	
			(SELECT gcc.segment5 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) product,	
			(SELECT gcc.segment6 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) intercompany,	
			(SELECT gcc.segment7 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) future_1,	
			(SELECT gcc.segment8 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) future_2,
			poll.closed_code po_closure_status,
			abc.po_last_trx_date po_last_trx_date,
			CASE
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) <= 0
				THEN ''CURRENT Period''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 0
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 31
				THEN ''1 - 30 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 30
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 61
				THEN ''31 - 60 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 60
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 91
				THEN ''61 - 90 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 90
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 121
				THEN ''91 - 120 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 120
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 181
				THEN ''121 - 180 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 180
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 361
				THEN ''181 - 360 Days''
				ELSE ''Over 361 Days''
			END last_trx_date_age_bucket,		 
			NVL(poll.closed_code,''OPEN'') po_closed_status,
			(REPLACE(REPLACE((SELECT rsh.shipment_num FROM rcv_shipment_headers rsh
							 WHERE rsh.shipment_header_id = rt.shipment_header_id),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) rcv_shipment_num,			
			(REPLACE(REPLACE((SELECT rsh.bill_of_lading FROM rcv_shipment_headers rsh
								WHERE rsh.shipment_header_id = rt.shipment_header_id),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) bill_of_lading,
			(SELECT rsh.shipped_date FROM rcv_shipment_headers rsh
			WHERE rsh.shipment_header_id = rt.shipment_header_id) shipped_date,	
			(REPLACE(REPLACE((SELECT rsh.freight_carrier_code FROM rcv_shipment_headers rsh
							  WHERE rsh.shipment_header_id = rt.shipment_header_id),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) freight_carrier_code,
			(REPLACE(REPLACE((SELECT rsh.waybill_airbill_num FROM rcv_shipment_headers rsh
								WHERE rsh.shipment_header_id = rt.shipment_header_id),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) waybill_airbill_num,
              (SUBSTR(REPLACE(REPLACE(poh.comments,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    6)) trane_ref_number									 
      FROM po_headers_all              poh,
         po_lines_all                  pol,
         po_line_locations_all        poll,
         po_distributions_all          pod,
         ap_suppliers                  pov,
         gl_code_combinations_kfv      gcc2,
         rcv_transactions             rt,
         cst_ap_po_reconciliation      capr,
         po_lookup_codes              plc,
         cst_reconciliation_summary   crs,
		(
		  SELECT max(transaction_date) po_last_trx_date, capr2.operating_unit_id, capr2.po_distribution_id
		  FROM cst_ap_po_reconciliation	capr2
		  WHERE
				capr2.operating_unit_id = '||l_current_org_id||' 
			AND	capr2.amount + capr2.entered_amount <> 0
		 GROUP BY capr2.operating_unit_id, capr2.po_distribution_id
		  ) abc		 
     WHERE poh.po_header_id = pol.po_header_id
      AND plc.lookup_code(+) = poh.fob_lookup_code
      AND plc.lookup_type(+) = ''FOB''
      AND pol.po_line_id = poll.po_line_id
      AND poll.line_location_id = pod.line_location_id
      AND poh.vendor_id = pov.vendor_id
      AND gcc2.code_combination_id = ' ||
                   l_code_combination_id_cond || '
      AND (nvl(capr.amount,0)+nvl(capr.entered_amount,0)) != 0
      AND capr.operating_unit_id = :l_current_org_id
             AND capr.operating_unit_id = crs.operating_unit_id
      AND capr.po_distribution_id = crs.po_distribution_id
      AND crs.accrual_account_id = capr.accrual_account_id
      AND pod.po_distribution_id = crs.po_distribution_id
      AND capr.po_distribution_id = pod.po_distribution_id
	  AND capr.operating_unit_id = abc.operating_unit_id
	  AND capr.po_distribution_id = abc.po_distribution_id
      AND ( capr.accrual_account_id in(select code_combination_id from gl_code_combinations where 
                                     segment2=:p_location ) or :p_location is NULL )
            AND ( pov.vendor_id=:p_vendor_from or :p_vendor_from is null )  
      AND poll.match_option = ''R''
      AND capr.rcv_transaction_id = rt.transaction_id(+) ' ||
                   l_min_accrual_cond || l_receipt_cond2;
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'l_receipt : ' || l_receipt);
    
      ---Added p_location by Raju For CR#8035 
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'p_location : ' || p_location);

	  BEGIN							
		  EXECUTE IMMEDIATE l_receipt
			USING l_accrual_currency_code, l_extended_precision, l_current_org_id, p_location, p_location, p_vendor_from, p_vendor_from;
	  EXCEPTION
		WHEN OTHERS THEN
		xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Exception occurred in executing l_receipt : ' ||SQLERRM);
	  END;			
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
							  
	  BEGIN
		SELECT count(1) into ln_data_row_count
		FROM xxap_grni_gtt;
	  EXCEPTION
		WHEN OTHERS THEN
		ln_data_row_count := 0;
	  END;

      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'No. of rows present in GTT at the end of execution of l_receipt is '||ln_data_row_count);								  
    
      ---Added :p_location .:p_vendor clause in below Query by Raju For CR#8035
	  /* Added 
			operating_unit, 
			bill_qty_greater_than_recv_qty, 
			ordered and delivered match, 
			delivered_billed_match,
			entity,
			location,
			location_name,	
			cost_center,
			account,
			product,
			intercompany,
			future_1,
			future_2,
			po_closure_status,
			po_last_trx_date,
			last_trx_date_age_bucket,
			po_closed_status,
			rcv_shipment_num,
			bill_of_lading,
			shipped_date,
			freight_carrier_code,
			waybill_airbill_num,
			trane_ref_number	
		 by Harshil for CR8035 */
		 
		/* 
		Special characters are handled for the following columns for CR8035
		1)rcv_shipment_num
		2)bill_of_lading
		3)packing_slip
		4)freight_carrier_code
		5)waybill_airbill_num
		6)trane_ref_number
		*/	

		-- For CR8035, Update the logic of Unit Price

		/* 
		For CR8035, Called a newly created function get_buyer_name for buyer_name.
		For CR8035, Changed the logic of ordered_quantity,quantity_delivered,quantity_billed and quantity_cancelled
		For CR8035, Changed the column name of po_header_closed_status to po_closed_status and also its logic
		For CR8035, Added a new column trane_ref_number in the GTT and added its logic.		
		*/	
		 
      l_po := 'INSERT INTO xxap_grni_gtt
           (po_number,
            fob,
            req_requestor,
            inv_match_option,
            buyer_name,
            invoice_match_app,
            req_num,
            req_date,
            po_doc_type,
            po_release_number,
            po_header_id,
            po_line_id,
            po_distribution_id,
            line_type,
            line_num,
            item_name,
            category,
            item_description,
            transaction_id,
            vendor_name,
            vendor_num,
            vendor_type,
            vendor_site_name,
            transaction_type,
            transaction_date,
            ordered_quantity,
            quantity_cancelled,
            uom,
            quantity_delivered,
            receipt_num,
            expenditure_type,
            invoice_num,
            invoice_line_num,
            ipv,
            entered_amount,
            currency_code,
            currency_conversion_rate,
            transaction_type_code,
            invoice_distribution_id,
            transaction_source,
            org,
            oracle_aging_date,
            aging_days,
            age_bucket_non_zero,
            accrual_currency_code,
            shipment_number,
            uom_code,
            distribution_num,
            quantity_received,
            quantity_billed,
            trx_qty,
            funct_amt,
            rcv_transaction_id,
            transfer_transaction_id,
            packing_slip,
            accrual_account,
            ppv1,
            ppv2,
            po_unit_price,
            po_currency_code,
            func_unit_price,
            charge_account,
            po_date,
            receipt_date,
			operating_unit,
			bill_qty_greater_than_recv_qty,
			ordered_delivered_match,
			delivered_billed_match,
					  entity,
					  location,
					  location_name,
					  cost_center,
					  account,
					  product,
					  intercompany,
					  future_1,
					  future_2,
					  po_closure_status,
					  po_last_trx_date,
					  last_trx_date_age_bucket,
					  po_closed_status,
					  rcv_shipment_num,
					  bill_of_lading,
					  shipped_date,
					  freight_carrier_code,
					  waybill_airbill_num,
					  trane_ref_number)
          SELECT po_number,
         fob,
         req_requestor,
         inv_match_option,
         buyer_name,
         invoice_match_app,
         req_num,
         req_date,
         po_doc_type,
         po_release_number,
         po_header_id,
         po_line_id,
         po_distribution_id,
         line_type,
         line_num,
         item_name,
         category,
         item_description,
         transaction_id,
         vendor_name,
         vendor_num,
         vendor_type,
         vendor_site_name,
         transaction_type,
         transaction_date,
         ordered_quantity,
         quantity_cancelled,
         uom,
         quantity_delivered,
         receipt_num,
         expenditure_type,
         invoice_num,
         invoice_line_num,
         ipv,
         entered_amount,
         currency_code,
         currency_conversion_rate,
         transaction_type_code,
         invoice_distribution_id,
         transaction_source,
         org,
         oracle_aging_date,
         aging_days,
         age_bucket_non_zero,
         accrual_currency_code,
         shipment_number,
         uom_code,
         distribution_num,
         quantity_received,
         quantity_billed,
         trx_qty,
         funct_amt,
         rcv_transaction_id,
         transfer_transaction_id,
         packing_slip,
         accrual_account,
         ppv1,
         ppv2,
         po_unit_price,
         po_currency_code,
         func_unit_price,
         charge_account,
         po_date,
         receipt_date,
		 operating_unit,
		 bill_qty_greater_than_recv_qty,
		 ordered_delivered_match,
		 delivered_billed_match,
					  entity,
					  location,
					  location_name,
					  cost_center,
					  account,
					  product,
					  intercompany,
					  future_1,
					  future_2,
					  po_closure_status,
					  po_last_trx_date,
					  last_trx_date_age_bucket,
					  po_closed_status,
					  rcv_shipment_num,
					  bill_of_lading,
					  shipped_date,
					  freight_carrier_code,
					  waybill_airbill_num,
					  trane_ref_number	
      FROM (SELECT NVL(poh.clm_document_number, poh.segment1) po_number,
              poh.fob_lookup_code fob,
              (SELECT px.full_name
                FROM per_people_x px
                WHERE px.person_id = pod.deliver_to_person_id) req_requestor,
              DECODE(poll.match_option,
                   ''P'',
                   ''PO'',
                   ''R'',
                   ''Receipt'',
                   NULL) inv_match_option,
			  XXAP_GRNI_REP_PKG.get_buyer_name(poh.agent_id,poll.po_release_id) buyer_name,
              CASE
                WHEN poll.inspection_required_flag = ''N'' AND
                   poll.receipt_required_flag = ''N'' THEN
                ''2-Way''
                WHEN poll.inspection_required_flag = ''N'' AND
                   poll.receipt_required_flag = ''Y'' THEN
                ''3-Way''
                WHEN poll.inspection_required_flag = ''Y'' AND
                   poll.receipt_required_flag = ''Y'' THEN
                ''4-Way''
              END invoice_match_app,
              DECODE (pod.req_distribution_id,
               NULL, pod.req_header_reference_num,
               (SELECT porh.segment1
                  FROM po_requisition_headers_all porh,
                       po_requisition_lines_all porl,
                       po_req_distributions_all pord
                 WHERE pod.req_distribution_id = pord.distribution_id(+)
                   AND pord.requisition_line_id = porl.requisition_line_id(+)
                   AND porl.requisition_header_id = porh.requisition_header_id(+))
              ) req_num,
              (SELECT TRUNC (porh.creation_date)
          FROM po_requisition_headers_all porh,
               po_requisition_lines_all porl,
               po_req_distributions_all pord
         WHERE pod.req_distribution_id = pord.distribution_id(+)
           AND pord.requisition_line_id = porl.requisition_line_id(+)
           AND porl.requisition_header_id = porh.requisition_header_id(+)) req_date,
              DECODE(poh.type_lookup_code,
                   ''STANDARD'',
                   ''Standard Purchase Order'',
                   ''BLANKET'',
                   ''Blanket Release'',
                   ''CONTRACT'',
                   ''Contract Purchase Agreement'',
                   poh.type_lookup_code) po_doc_type,
              (SELECT por.release_num
                 FROM po_releases_all por
                WHERE por.po_release_id = poll.po_release_id) po_release_number,
              poh.po_header_id,
              pol.po_line_id,
              capr.po_distribution_id,
              (SELECT plt.line_type
                FROM po_line_types plt
              WHERE pol.line_type_id = plt.line_type_id) line_type,
              NVL(pol.line_num_display, TO_CHAR(pol.line_num)) line_num,
              (SELECT msi.concatenated_segments
               FROM mtl_system_items_kfv msi
               WHERE msi.inventory_item_id = pol.item_id
               AND msi.organization_id = poll.ship_to_organization_id) item_name  ,
              (SELECT mca.concatenated_segments
               FROM mtl_categories_kfv mca
                WHERE pol.category_id = mca.category_id) category,
              /* (SUBSTR(REPLACE(REPLACE(pol.item_description,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    25)) item_description, */ -- commented w.r.to PM#344
			  SUBSTR(xxap_utility_pkg.replace_spl_char(pol.item_description),1,25)	item_description, -- Added w.r.to PM#344		
              rt.transaction_id,
              pov.vendor_name,
              pov.segment1 vendor_num,
              pov.vendor_type_lookup_code vendor_type,
               (SELECT pvs.vendor_site_code
                FROM ap_supplier_sites_all pvs
               WHERE poh.vendor_id = pvs.vendor_id
                AND poh.vendor_site_id = pvs.vendor_site_id) vendor_site_name,
              (SELECT transaction_type_name
                FROM mtl_material_transactions mmt,
                    mtl_transaction_types    mtt
                WHERE mtt.transaction_type_id =
                    mmt.transaction_type_id
                 AND mtt.transaction_source_type_id =
                    mmt.transaction_source_type_id
                 AND mmt.transaction_action_id =
                    mtt.transaction_action_id
                 AND mmt.rcv_transaction_id = rt.transaction_id) transaction_type,
              capr.transaction_date,
              pod.quantity_ordered ordered_quantity,
              pod.quantity_cancelled,
              poll.unit_meas_lookup_code uom,
              pod.quantity_delivered,
              (SELECT rsh.receipt_num
                FROM rcv_shipment_headers rsh
                WHERE rsh.shipment_header_id = rt.shipment_header_id) receipt_num,
              pod.expenditure_type,
              (SELECT apia.invoice_num invoice_number
                FROM ap_invoices_all          apia,
                    ap_invoice_distributions_all aida
                WHERE aida.invoice_distribution_id =
                    capr.invoice_distribution_id
                 AND apia.invoice_id(+) = aida.invoice_id
                 AND aida.line_type_lookup_code IN
                    (''ACCRUAL'', ''MISCELLANEOUS'')
                 AND ROWNUM < 2) invoice_num,
              (SELECT aida.invoice_line_number
                FROM ap_invoices_all          apia,
                    ap_invoice_distributions_all aida
                WHERE aida.invoice_distribution_id =
                    capr.invoice_distribution_id
                 AND apia.invoice_id(+) = aida.invoice_id) invoice_line_num,
              (SELECT DECODE(a.line_type_lookup_code,
                        ''IPV'',
                        SUM(a.amount),
                        0)
                FROM ap_invoice_distributions_all a
                WHERE a.invoice_id =
                    (SELECT invoice_id
                      FROM ap_invoice_distributions_all aida
                     WHERE aida.line_type_lookup_code IN (''ACCRUAL'')
                      AND aida.invoice_distribution_id =
                         capr.invoice_distribution_id)
                 AND a.invoice_line_number =
                    (SELECT invoice_line_number
                      FROM ap_invoice_distributions_all aida
                     WHERE aida.line_type_lookup_code IN (''ACCRUAL'')
                      AND aida.invoice_distribution_id =
                         capr.invoice_distribution_id)
                 AND a.line_type_lookup_code IN (''IPV'')
                GROUP BY a.line_type_lookup_code) ipv,
              capr.entered_amount,
              capr.currency_code,
              NVL(capr.currency_conversion_rate, 1) currency_conversion_rate,
              capr.transaction_type_code,
              capr.invoice_distribution_id,
              DECODE(capr.invoice_distribution_id,
                   NULL,
                   DECODE(capr.write_off_id, NULL, ''PO'', ''WO''),
                   ''AP'') transaction_source,
              (SELECT ood.name
                FROM hr_organization_units ood
                WHERE ood.organization_id =
                    capr.inventory_organization_id) org,
              (TO_DATE(NVL(rt.creation_date, capr.transaction_date))) oracle_aging_date,
              ((TRUNC(SYSDATE) -
              TO_DATE(NVL(rt.creation_date, capr.transaction_date)))) aging_days,
                 CASE
                  WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) <= 0 THEN
                  ''Current Period''
                  WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) > 0 AND
                     ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) < 31 THEN
                  ''1 - 30 Days''
                  WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) > 30 AND
                     ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) < 61 THEN
                  ''31 - 60 Days''
               WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) > 60 AND
                     ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) < 91 THEN
                  ''61 - 90 Days''
                  WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) > 90 AND
                     ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) < 121 THEN
                  ''91 - 120 Days''
                  WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) > 120 AND
                     ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) < 181 THEN
                  ''121 - 180 Days''
                  WHEN ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) > 180 AND
                     ((TRUNC(SYSDATE) -
                     TO_DATE(NVL(rt.creation_date,
                        capr.transaction_date)))) < 361 THEN
                  ''181 - 360 Days''
                  ELSE
                  ''Over 361 Days''
                  END age_bucket_non_zero,
              :l_accrual_currency_code accrual_currency_code,
              poll.shipment_num shipment_number,
              poll.unit_meas_lookup_code uom_code,
              pod.distribution_num,
              poll.quantity_received,
              pod.quantity_billed,
              capr.quantity trx_qty,
              capr.amount funct_amt,
              rt.transaction_id rcv_transaction_id,
              NULL transfer_transaction_id,
			(REPLACE(REPLACE((SELECT NVL(rsl.packing_slip, rsh.packing_slip)
							FROM rcv_shipment_lines rsl, rcv_shipment_headers rsh
							WHERE rsh.shipment_header_id = rt.shipment_header_id
							 AND rsl.shipment_line_id = rt.shipment_line_id),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) packing_slip,
              (SELECT gcc.segment1 || ''.'' || gcc.segment2 || ''.'' ||
                    gcc.segment3 || ''.'' || gcc.segment4 || ''.'' ||
                    gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
                    gcc.segment7 || ''.'' || gcc.segment8
                FROM gl_code_combinations gcc
                WHERE gcc.code_combination_id = capr.accrual_account_id) accrual_account,
              (NVL(poh.rate, 0) * pol.unit_price * capr.quantity) ppv1,
              (NVL(capr.currency_conversion_rate, 0) * pol.unit_price *
              capr.quantity) ppv2,
              ROUND(DECODE(poll.po_release_id,NULL,pol.unit_price,poll.price_override), :l_extended_precision) po_unit_price,
              capr.currency_code po_currency_code,
               ( SELECT ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                       0,
                       pol.unit_price *
                       capr.currency_conversion_rate,
                       (pol.unit_price /
                       fnc1.minimum_accountable_unit) *
                       capr.currency_conversion_rate *
                       fnc1.minimum_accountable_unit),
                  NVL(fnc1.extended_precision, 2))FROM fnd_currencies    fnc1 
                 WHERE  fnc1.currency_code = capr.currency_code ) func_unit_price,
               ' || l_charge_account_cond ||
              ' charge_account,
              poh.creation_date po_date,
              (SELECT TRUNC(MAX(last_update_date))
                FROM rcv_transactions rt
                WHERE rt.po_line_location_id = pod.line_location_id
                 AND ((rt.transaction_type = ''RECEIVE'' AND
                    parent_transaction_id = -1) OR
                    (rt.transaction_type = ''MATCH''))
                GROUP BY po_line_location_id) receipt_date' ||
              l_po_cond1
			|| ', 
			(SELECT hou.name
			 FROM hr_operating_units hou
			 WHERE hou.organization_id = '||l_current_org_id||') operating_unit,
			CASE
				WHEN (pod.quantity_billed > pod.quantity_delivered) THEN
				''Y''
				ELSE
				''N''
			END bill_qty_greater_than_recv_qty,	
			DECODE(pod.quantity_ordered,pod.quantity_delivered,''Y'',''N'') ordered_delivered_match,
			DECODE(pod.quantity_billed,pod.quantity_delivered,''Y'',''N'') delivered_billed_match,			
			(SELECT gcc.segment1 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) entity,
			(SELECT gcc.segment2 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) location,
			(SELECT ffvl.description 
			 FROM fnd_flex_values_vl ffvl, fnd_flex_value_sets ffvs, gl_code_combinations gcc
			 WHERE 
				 ffvs.flex_value_set_name = ''XXIR_GL_LOCATION''
			 AND ffvs.flex_value_set_id = ffvl.flex_value_set_id
			 AND ffvl.flex_value_meaning = gcc.segment2
			 AND gcc.code_combination_id = capr.accrual_account_id) location_name, 	
			(SELECT gcc.segment3 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) cost_center,	
			(SELECT gcc.segment4 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) account,	
			(SELECT gcc.segment5 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) product,	
			(SELECT gcc.segment6 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) intercompany,	
			(SELECT gcc.segment7 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) future_1,	
			(SELECT gcc.segment8 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = capr.accrual_account_id) future_2,
			poll.closed_code po_closure_status,
			abc.po_last_trx_date po_last_trx_date,
			CASE
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) <= 0
				THEN ''CURRENT Period''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 0
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 31
				THEN ''1 - 30 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 30
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 61
				THEN ''31 - 60 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 60
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 91
				THEN ''61 - 90 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 90
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 121
				THEN ''91 - 120 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 120
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 181
				THEN ''121 - 180 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(abc.po_last_trx_date))) > 180
				AND ((TRUNC(SYSDATE)  - TO_DATE(abc.po_last_trx_date))) < 361
				THEN ''181 - 360 Days''
				ELSE ''Over 361 Days''
			END last_trx_date_age_bucket,
			NVL(poll.closed_code,''OPEN'') po_closed_status,
			(REPLACE(REPLACE((SELECT rsh.shipment_num FROM rcv_shipment_headers rsh
							 WHERE rsh.shipment_header_id = rt.shipment_header_id),
												  CHR(10),
												  ''''),
											 CHR(13),
											 ''''))	 rcv_shipment_num,		
			(REPLACE(REPLACE((SELECT rsh.bill_of_lading FROM rcv_shipment_headers rsh
								WHERE rsh.shipment_header_id = rt.shipment_header_id),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) bill_of_lading,
			(SELECT rsh.shipped_date FROM rcv_shipment_headers rsh
			WHERE rsh.shipment_header_id = rt.shipment_header_id) shipped_date,	
			(REPLACE(REPLACE((SELECT rsh.freight_carrier_code FROM rcv_shipment_headers rsh
							  WHERE rsh.shipment_header_id = rt.shipment_header_id),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) freight_carrier_code,
			(REPLACE(REPLACE((SELECT rsh.waybill_airbill_num FROM rcv_shipment_headers rsh
								WHERE rsh.shipment_header_id = rt.shipment_header_id),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) waybill_airbill_num,
              (SUBSTR(REPLACE(REPLACE(poh.comments,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    6)) trane_ref_number											 
      FROM po_headers_all         poh,
         po_lines_all           pol,
         po_line_locations_all     poll,
         po_distributions_all     pod,
         ap_suppliers           pov,
         gl_code_combinations_kfv   gcc2,
         rcv_transactions        rt,
         cst_ap_po_reconciliation   capr,
         po_lookup_codes         plc,
         cst_reconciliation_summary crs,
		(
		  SELECT max(transaction_date) po_last_trx_date, capr2.operating_unit_id, capr2.po_distribution_id
		  FROM cst_ap_po_reconciliation	capr2
		  WHERE
				capr2.operating_unit_id = '||l_current_org_id||' 
			AND	capr2.amount + capr2.entered_amount <> 0
		 GROUP BY capr2.operating_unit_id, capr2.po_distribution_id
		  ) abc		 
     WHERE poh.po_header_id = pol.po_header_id
      AND plc.lookup_code(+) = poh.fob_lookup_code
      AND plc.lookup_type(+) = ''FOB''
      AND pol.po_line_id = poll.po_line_id
      AND poll.line_location_id = pod.line_location_id
      AND poh.vendor_id = pov.vendor_id
      AND gcc2.code_combination_id = ' ||
              l_code_combination_id_cond || '
      AND (nvl(capr.amount,0)+nvl(capr.entered_amount,0)) != 0
      AND capr.operating_unit_id = :l_current_org_id
      AND capr.po_distribution_id = pod.po_distribution_id
      AND capr.rcv_transaction_id = rt.transaction_id(+) 
      AND capr.operating_unit_id = crs.operating_unit_id
      AND capr.po_distribution_id = crs.po_distribution_id
	  AND capr.operating_unit_id = abc.operating_unit_id
	  AND capr.po_distribution_id = abc.po_distribution_id	  
      AND crs.accrual_account_id = capr.accrual_account_id
      AND pod.po_distribution_id = crs.po_distribution_id  
            AND ( capr.accrual_account_id in(select code_combination_id from gl_code_combinations where 
                     segment2=:p_location ) or :p_location is NULL ) 
            AND ( pov.vendor_id=:p_vendor_from or :p_vendor_from is null )      
      AND poll.match_option = ''P''' || l_min_accrual_cond ||
              l_po_cond2;
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'l_po : ' || l_po);
    
      ---Added :p_location  in below Query by Raju For CR#8035  
		BEGIN
		  EXECUTE IMMEDIATE l_po
			USING l_accrual_currency_code, l_extended_precision, l_current_org_id, p_location, p_location, p_vendor_from, p_vendor_from;
		EXCEPTION
		WHEN OTHERS THEN
			xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Exception occurred in executing l_po : ' ||SQLERRM);
		END;				
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
							  
	  BEGIN
		SELECT count(1) into ln_data_row_count
		FROM xxap_grni_gtt;
	  EXCEPTION
		WHEN OTHERS THEN
		ln_data_row_count := 0;
	  END;

      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'No. of rows present in GTT at the end of execution of l_po is '||ln_data_row_count);								  
    
      ---Added :p_location ,:p_vendor_id clause in below Query by Raju For CR#8035
	  /* Added 
			operating_unit, 
			bill_qty_greater_than_recv_qty, 
			ordered and delivered match, 
			delivered_billed_match,
			entity,
			location,
			location_name,	
			cost_center,
			account,
			product,
			intercompany,
			future_1,
			future_2,
			po_closure_status,
			po_last_trx_date,
			last_trx_date_age_bucket,
			po_closed_status,
			rcv_shipment_num,
			bill_of_lading,
			shipped_date,
			freight_carrier_code,
			waybill_airbill_num,
			trane_ref_number	
		 by Harshil for CR8035 */
		 
		/* 
		Special characters are handled for the following columns for CR8035
		1)rcv_shipment_num
		2)bill_of_lading
		3)packing_slip
		4)freight_carrier_code
		5)waybill_airbill_num
		6)trane_ref_number
		*/

		-- For CR8035, Update the logic of Unit Price

		/* 
		For CR8035, Called a newly created function get_buyer_name for buyer_name.
		For CR8035, Changed the logic of ordered_quantity,quantity_delivered,quantity_billed and quantity_cancelled
		For CR8035, Changed the column name of po_header_closed_status to po_closed_status and also its logic
		For CR8035, Added a new column trane_ref_number in the GTT and added its logic.		
		*/	
	  
      l_misc1 := 'INSERT INTO xxap_grni_gtt
           (po_number,
            fob,
            req_requestor,
            inv_match_option,
            buyer_name,
            invoice_match_app,
            req_num,
            req_date,
            po_doc_type,
            po_release_number,
            po_header_id,
            po_line_id,
            po_distribution_id,
            line_type,
            line_num,
            item_name,
            category,
            item_description,
            transaction_id,
            vendor_name,
            vendor_num,
            vendor_type,
            vendor_site_name,
            transaction_type,
            transaction_date,
            ordered_quantity,
            quantity_cancelled,
            uom,
            quantity_delivered,
            receipt_num,
            expenditure_type,
            invoice_num,
            invoice_line_num,
            ipv,
            entered_amount,
            currency_code,
            currency_conversion_rate,
            transaction_type_code,
            invoice_distribution_id,
            transaction_source,
            org,
            oracle_aging_date,
            aging_days,
            age_bucket_non_zero,
            accrual_currency_code,
            shipment_number,
            uom_code,
            distribution_num,
            quantity_received,
            quantity_billed,
            trx_qty,
            funct_amt,
            rcv_transaction_id,
            transfer_transaction_id,
            packing_slip,
            accrual_account,
            ppv1,
            ppv2,
            po_unit_price,
            po_currency_code,
            func_unit_price,
            charge_account,
            po_date,
            receipt_date,
			operating_unit,
			bill_qty_greater_than_recv_qty,
			ordered_delivered_match,
			delivered_billed_match,
					  entity,
					  location,
					  location_name,
					  cost_center,
					  account,
					  product,
					  intercompany,
					  future_1,
					  future_2,
					  po_closure_status,
					  po_last_trx_date,
					  last_trx_date_age_bucket,
					  po_closed_status,
					  rcv_shipment_num,
					  bill_of_lading,
					  shipped_date,
					  freight_carrier_code,
					  waybill_airbill_num,
					  trane_ref_number	)
           SELECT po_number,
         fob,
         req_requestor,
         inv_match_option,
         buyer_name,
         invoice_match_app,
         req_num,
         req_date,
         po_doc_type,
         po_release_number,
         po_header_id,
         po_line_id,
         po_distribution_id,
         line_type,
         line_num,
         item_name,
         category,
         item_description,
         transaction_id,
         vendor_name,
         vendor_num,
         vendor_type,
         vendor_site_name,
         transaction_type,
         transaction_date,
         ordered_quantity,
         quantity_cancelled,
         uom,
         quantity_delivered,
         receipt_num,
         expenditure_type,
         invoice_num,
         invoice_line_num,
         ipv,
         entered_amount,
         currency_code,
         currency_conversion_rate,
         transaction_type_code,
         invoice_distribution_id,
         transaction_source,
         org,
         oracle_aging_date,
         aging_days,
         age_bucket_non_zero,
         accrual_currency_code,
         shipment_number,
         uom_code,
         distribution_num,
         quantity_received,
         quantity_billed,
         trx_qty,
         funct_amt,
         rcv_transaction_id,
         transfer_transaction_id,
         packing_slip,
         accrual_account,
         ppv1,
         ppv2,
         po_unit_price,
         po_currency_code,
         func_unit_price,
         charge_account,
         po_date,
         receipt_date,
		 operating_unit,
		 bill_qty_greater_than_recv_qty,
		 ordered_delivered_match,
		 delivered_billed_match,
					  entity,
					  location,
					  location_name,
					  cost_center,
					  account,
					  product,
					  intercompany,
					  future_1,
					  future_2,
					  po_closure_status,
					  po_last_trx_date,
					  last_trx_date_age_bucket,
					  po_closed_status,
					  rcv_shipment_num,
					  bill_of_lading,
					  shipped_date,
					  freight_carrier_code,
					  waybill_airbill_num,
					  trane_ref_number	
      FROM (SELECT COALESCE(poh.clm_document_number,poh.segment1) po_number,
              poh.fob_lookup_code fob,
              NULL req_requestor,
              DECODE(poll.match_option,
                   ''P'',
                   ''PO'',
                   ''R'',
                   ''Receipt'',
                   NULL) inv_match_option,
			  XXAP_GRNI_REP_PKG.get_buyer_name(poh.agent_id,pod.po_release_id) buyer_name,
              CASE
                WHEN poll.inspection_required_flag = ''N'' AND
                   poll.receipt_required_flag = ''N'' THEN
                ''2-Way''
                WHEN poll.inspection_required_flag = ''N'' AND
                   poll.receipt_required_flag = ''Y'' THEN
                ''3-Way''
                WHEN poll.inspection_required_flag = ''Y'' AND
                   poll.receipt_required_flag = ''Y'' THEN
                ''4-Way''
              END invoice_match_app,
              NULL req_num,
              NULL req_date,
              DECODE(poh.type_lookup_code,
                   ''STANDARD'',
                   ''Standard Purchase Order'',
                   ''BLANKET'',
                   ''Blanket Release'',
                   ''CONTRACT'',
                   ''Contract Purchase Agreement'',
                   poh.type_lookup_code) po_doc_type,
        (SELECT por.release_num
                 FROM po_releases_all por
                WHERE pod.po_release_id = por.po_release_id) po_release_number,
              poh.po_header_id,
              pol.po_line_id,
              cmr.po_distribution_id,
              (SELECT plt.line_type
               FROM po_line_types plt
              WHERE pol.line_type_id = plt.line_type_id) line_type,
              NVL(pol.line_num_display, TO_CHAR(pol.line_num)) line_num,
              DECODE(cmr.inventory_item_id,
                   NULL,
                   NULL,
                   (SELECT msi.concatenated_segments
                     FROM mtl_system_items_vl msi
                    WHERE inventory_item_id = cmr.inventory_item_id
                      AND ROWNUM = 1 )) item_name,
             (SELECT mca.concatenated_segments FROM mtl_categories_kfv mca WHERE pol.category_id = mca.category_id) CATEGORY,
              /* (SUBSTR(REPLACE(REPLACE(pol.item_description,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    25)) item_description,*/ -- Commented w.r.to PM#344
              SUBSTR(xxap_utility_pkg.replace_spl_char(pol.item_description),1,25)	item_description, -- Added w.r.to PM#344
			  mmt.transaction_id,
        aps.vendor_name,
              aps.segment1 vendor_num,
              aps.vendor_type_lookup_code vendor_type,
                (SELECT pvs.vendor_site_code
                  FROM ap_supplier_sites_all pvs
                 WHERE poh.vendor_id = pvs.vendor_id
                  AND poh.vendor_site_id = pvs.vendor_site_id) vendor_site_name,
              DECODE(cmr.invoice_distribution_id,
                   NULL,
                   DECODE(cmr.transaction_type_code,
                        ''CONSIGNMENT'',
                        (SELECT crc.displayed_field
                          FROM cst_reconciliation_codes crc
                         WHERE crc.lookup_code =
                             cmr.transaction_type_code
                          AND crc.lookup_type IN
                             (''ACCRUAL WRITE-OFF ACTION'',
                              ''ACCRUAL TYPE'')),
                        (SELECT mtt.transaction_type_name
                          FROM mtl_transaction_types mtt
                         WHERE cmr.transaction_type_code =
                             TO_CHAR(mtt.transaction_type_id))),
                   (SELECT crc.displayed_field
                     FROM cst_reconciliation_codes crc
                    WHERE crc.lookup_code =
                        cmr.transaction_type_code
                      AND crc.lookup_type IN
                        (''ACCRUAL WRITE-OFF ACTION'',
                         ''ACCRUAL TYPE''))) transaction_type,
              cmr.transaction_date,
              pod.quantity_ordered ordered_quantity,
              pod.quantity_cancelled,
              poll.unit_meas_lookup_code uom,
              pod.quantity_delivered,
              NULL receipt_num,
              pod.expenditure_type,
              apia.invoice_num,
              aida.invoice_line_number invoice_line_num,
              (SELECT DECODE(a.line_type_lookup_code,
                        ''IPV'',
                        SUM(a.amount),
                        0)
                FROM ap_invoice_distributions_all a
                WHERE a.invoice_id =
                    (SELECT invoice_id
                      FROM ap_invoice_distributions_all aida
                     WHERE aida.line_type_lookup_code IN (''ACCRUAL'')
                      AND aida.invoice_distribution_id =
                         cmr.invoice_distribution_id)
                 AND a.invoice_line_number =
                    (SELECT invoice_line_number
                      FROM ap_invoice_distributions_all aida
                     WHERE aida.line_type_lookup_code IN (''ACCRUAL'')
                      AND aida.invoice_distribution_id =
                         cmr.invoice_distribution_id)
                 AND a.line_type_lookup_code IN (''IPV'')
                GROUP BY a.line_type_lookup_code) ipv,
              cmr.entered_amount,
              cmr.currency_code,
              NVL(cmr.currency_conversion_rate, 1) currency_conversion_rate,
              DECODE(mmt.transaction_id,
                   NULL,
                   transaction_type_code,
                   (SELECT mtt.transaction_type_name
                     FROM mtl_transaction_types mtt
                    WHERE mtt.transaction_type_id =
                        mmt.transaction_type_id)) transaction_type_code,
              cmr.invoice_distribution_id,
              DECODE(cmr.invoice_distribution_id, NULL, ''INV'', ''AP'') transaction_source,
             (SELECT mp.organization_code
                FROM mtl_parameters mp
               WHERE cmr.inventory_organization_id = mp.organization_id) org,
              (TO_DATE(NVL(apia.invoice_date, cmr.transaction_date))) oracle_aging_date,
              ((TRUNC(SYSDATE) -
              TO_DATE(NVL(apia.invoice_date, cmr.transaction_date)))) aging_days,
                CASE
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) <= 0 THEN
                ''Current Period''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) > 0 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) < 31 THEN
                ''1 - 30 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) > 30 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) < 61 THEN
                ''31 - 60 Days''
             WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) > 60 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) < 91 THEN
                ''61 - 90 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) > 90 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) < 121 THEN
                ''91 - 120 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) > 120 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) < 181 THEN
                ''121 - 180 Days''
                WHEN ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) > 180 AND
                   ((TRUNC(SYSDATE) -
                   TO_DATE(NVL(apia.invoice_date,
                      cmr.transaction_date)))) < 361 THEN
                ''181 - 360 Days''
                ELSE
                ''Over 361 Days''
                END age_bucket_non_zero,
              :l_accrual_currency_code accrual_currency_code,
              poll.shipment_num shipment_number,
              poll.unit_meas_lookup_code uom_code,
              pod.distribution_num,
              poll.quantity_received,
              pod.quantity_billed,
              cmr.quantity trx_qty,
              cmr.amount funct_amt,
              NULL rcv_transaction_id,
              mmt.transfer_transaction_id,
              NULL packing_slip,
              (SELECT gcc.segment1 || ''.'' || gcc.segment2 || ''.'' ||
                    gcc.segment3 || ''.'' || gcc.segment4 || ''.'' ||
                    gcc.segment5 || ''.'' || gcc.segment6 || ''.'' ||
                    gcc.segment7 || ''.'' || gcc.segment8
                FROM gl_code_combinations gcc
                WHERE code_combination_id = cmr.accrual_account_id) accrual_account,
              (NVL(poh.rate, 0) * pol.unit_price * cmr.quantity) ppv1,
              (NVL(cmr.currency_conversion_rate, 0) * pol.unit_price *
              cmr.quantity) ppv2,
              ROUND(DECODE(poll.po_release_id,NULL,pol.unit_price,poll.price_override), :l_extended_precision) po_unit_price,
              NULL po_currency_code,
              ( SELECT ROUND(DECODE(NVL(fnc1.minimum_accountable_unit, 0),
                       0,
                       pol.unit_price *
                       cmr.currency_conversion_rate,
                       (pol.unit_price /
                       fnc1.minimum_accountable_unit) *
                       cmr.currency_conversion_rate *
                       fnc1.minimum_accountable_unit),
                  NVL(fnc1.extended_precision, 2))
                  FROM fnd_currencies    fnc1 
                 WHERE  fnc1.currency_code = cmr.currency_code )  func_unit_price,
              ' || l_charge_account_cond ||
                 ' charge_account,
              poh.creation_date po_date,
              NULL receipt_date,
			(SELECT hou.name
			 FROM hr_operating_units hou
			 WHERE hou.organization_id = '||l_current_org_id||') operating_unit,
			CASE
				WHEN (pod.quantity_billed > pod.quantity_delivered) THEN
				''Y''
				ELSE
				''N''
			END bill_qty_greater_than_recv_qty,
			DECODE(pod.quantity_ordered,pod.quantity_delivered,''Y'',''N'') ordered_delivered_match,
			DECODE(pod.quantity_billed,pod.quantity_delivered,''Y'',''N'') delivered_billed_match,	
			(SELECT gcc.segment1 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) entity,
			(SELECT gcc.segment2 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) location,
			(SELECT ffvl.description 
			 FROM fnd_flex_values_vl ffvl, fnd_flex_value_sets ffvs, gl_code_combinations gcc
			 WHERE 
				 ffvs.flex_value_set_name = ''XXIR_GL_LOCATION''
			 AND ffvs.flex_value_set_id = ffvl.flex_value_set_id
			 AND ffvl.flex_value_meaning = gcc.segment2
			 AND gcc.code_combination_id = cmr.accrual_account_id) location_name,	
			(SELECT gcc.segment3 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) cost_center,	
			(SELECT gcc.segment4 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) account,	
			(SELECT gcc.segment5 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) product,	
			(SELECT gcc.segment6 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) intercompany,	
			(SELECT gcc.segment7 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) future_1,	
			(SELECT gcc.segment8 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) future_2,
			poll.closed_code po_closure_status,
			cmr.transaction_date	po_last_trx_date,
			CASE
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) <= 0
				THEN ''CURRENT Period''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 0
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 31
				THEN ''1 - 30 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 30
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 61
				THEN ''31 - 60 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 60
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 91
				THEN ''61 - 90 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 90
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 121
				THEN ''91 - 120 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 120
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 181
				THEN ''121 - 180 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 180
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 361
				THEN ''181 - 360 Days''
				ELSE ''Over 361 Days''
			END		last_trx_date_age_bucket,
			NVL(poll.closed_code,''OPEN'') po_closed_status,
			(REPLACE(REPLACE((SELECT  rsh.shipment_num FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) rcv_shipment_num,			
			(REPLACE(REPLACE((SELECT  rsh.bill_of_lading FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) bill_of_lading,
			(SELECT  rsh.shipped_date FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
			WHERE rsh.shipment_header_id = rsl.shipment_header_id
			AND   rsl.po_header_id = poh.po_header_id
			AND   aida.rcv_transaction_id = rt.transaction_id
			AND   rt.shipment_header_id = rsh.shipment_header_id
			) shipped_date,	
			(REPLACE(REPLACE((SELECT  rsh.freight_carrier_code FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) freight_carrier_code,
			(REPLACE(REPLACE((SELECT  rsh.waybill_airbill_num FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) waybill_airbill_num,
              (SUBSTR(REPLACE(REPLACE(poh.comments,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    6)) trane_ref_number											 
           FROM cst_misc_reconciliation     cmr,
              ap_invoices_all          apia,
              ap_invoice_distributions_all aida,
              ap_suppliers            aps,
              po_distributions_all       pod,
              po_line_locations_all      poll,
              po_lines_all            pol,
              po_headers_all           poh,
              mtl_material_transactions    mmt,
              gl_code_combinations_kfv    gcc2,
              po_lookup_codes          plc
          WHERE cmr.invoice_distribution_id =
              aida.invoice_distribution_id(+)
            AND plc.lookup_code(+) = poh.fob_lookup_code
            AND plc.lookup_type(+) = ''FOB''
            AND aps.vendor_id(+) = poh.vendor_id
            AND gcc2.code_combination_id(+) = ' ||
                 l_code_combination_id_cond || '
            AND aida.invoice_id = apia.invoice_id(+)
            AND pod.po_distribution_id(+) = cmr.po_distribution_id
            AND cmr.inventory_transaction_id = mmt.transaction_id(+)
            AND poll.line_location_id(+) = pod.line_location_id
            AND poh.org_id(+) = pod.org_id
            AND pol.po_line_id(+) = pod.po_line_id
            AND poh.po_header_id(+) = pod.po_header_id
            AND cmr.operating_unit_id = pod.org_id
            AND cmr.operating_unit_id = poh.org_id
            AND cmr.operating_unit_id = :l_current_org_id
            AND ( cmr.accrual_account_id in(select code_combination_id from gl_code_combinations where 
                         segment2=:p_location ) or :p_location is NULL )  
                      AND ( aps.vendor_id=:p_vendor_from or :p_vendor_from is null )
            AND (nvl(cmr.amount,0)+nvl(cmr.entered_amount,0)) != 0
            AND cmr.po_distribution_id IS NOT NULL' ||
                 l_misc_cond1;
    
      l_misc2 := ' UNION
             SELECT  COALESCE ( poh.clm_document_number,  poh.segment1 )  po_number,
           poh.fob_lookup_code fob,
           ( SELECT  px.full_name
               FROM  ap_invoice_distributions_v aid,
                   per_people_x px,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
                   AND px.person_id = pod.deliver_to_person_id
                   AND pod.po_distribution_id = aid.po_distribution_id
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY px.full_name)
             req_requestor,
           (SELECT  DISTINCT
                  DECODE (poll.match_option,
                       ''P'', ''PO'',
                       ''R'', ''Receipt'',
                       NULL
                       )
             FROM   po_line_locations_all poll
             WHERE  po_release_id = mct.consumption_release_id
                  AND po_line_id = pol.po_line_id)
             inv_match_option,
		   XXAP_GRNI_REP_PKG.get_buyer_name(poh.agent_id,por.po_release_id) buyer_name,
           CASE
             WHEN (SELECT  DISTINCT poll.inspection_required_flag
                   FROM  po_line_locations_all poll
                  WHERE  po_release_id = mct.consumption_release_id
                       AND po_line_id = pol.po_line_id) = ''N''
                 AND (SELECT  DISTINCT poll.receipt_required_flag
                     FROM   po_line_locations_all poll
                     WHERE  po_release_id = mct.consumption_release_id
                          AND po_line_id = pol.po_line_id) = ''N''
             THEN
               ''2-Way''
             WHEN (SELECT  DISTINCT poll.inspection_required_flag
                   FROM  po_line_locations_all poll
                  WHERE  po_release_id = mct.consumption_release_id
                       AND po_line_id = pol.po_line_id) = ''N''
                 AND (SELECT  DISTINCT poll.receipt_required_flag
                     FROM   po_line_locations_all poll
                     WHERE  po_release_id = mct.consumption_release_id
                          AND po_line_id = pol.po_line_id) = ''Y''
             THEN
               ''3-Way''
             WHEN (SELECT  DISTINCT poll.inspection_required_flag
                   FROM  po_line_locations_all poll
                  WHERE  po_release_id = mct.consumption_release_id
                       AND po_line_id = pol.po_line_id) = ''Y''
                 AND (SELECT  DISTINCT poll.receipt_required_flag
                     FROM   po_line_locations_all poll
                     WHERE  po_release_id = mct.consumption_release_id
                          AND po_line_id = pol.po_line_id) = ''Y''
             THEN
               ''4-Way''
           END
             invoice_match_app,
           NULL req_num,
           NULL req_date,
           DECODE (poh.type_lookup_code,
                 ''STANDARD'', ''Standard Purchase Order'',
                 ''BLANKET'', ''Blanket Release'',
                 ''CONTRACT'', ''Contract Purchase Agreement'',
                 poh.type_lookup_code
                )
             po_doc_type,
           por.release_num po_release_number,
           poh.po_header_id,
           pol.po_line_id,
           cmr.po_distribution_id,
           (SELECT plt.line_type FROM po_line_types plt WHERE pol.line_type_id = plt.line_type_id) line_type,
           NVL (pol.line_num_display, TO_CHAR (pol.line_num)) line_num,
           DECODE (
             cmr.inventory_item_id,
             NULL,
             NULL,
             (SELECT  msi.concatenated_segments
               FROM   mtl_system_items_vl msi
               WHERE  inventory_item_id = cmr.inventory_item_id
                    AND ROWNUM = 1)
           )
             item_name,
            (SELECT mca.concatenated_segments
             FROM mtl_categories_kfv mca
              WHERE pol.category_id = mca.category_id) category,
           /*(SUBSTR (
              REPLACE (REPLACE (pol.item_description, CHR (10), ''''),
                    CHR (13),
                    ''''
                   ),
              1,
              25
            )) 
             item_description,*/ -- Commented w.r.to PM#344
			SUBSTR(xxap_utility_pkg.replace_spl_char(pol.item_description),1,25)	item_description, -- Added w.r.to PM#344 
            mmt.transaction_id,
            aps.vendor_name,
            aps.segment1 vendor_num,
            aps.vendor_type_lookup_code vendor_type,
           (SELECT  vendor_site_code
             FROM   ap_supplier_sites_all pvs
             WHERE  pvs.vendor_site_id = poh.vendor_site_id)
             vendor_site_name,
           DECODE (
             cmr.invoice_distribution_id,
             NULL,
             DECODE (
               cmr.transaction_type_code,
               ''CONSIGNMENT'',
               (SELECT  crc.displayed_field
                 FROM   cst_reconciliation_codes crc
                 WHERE  crc.lookup_code = cmr.transaction_type_code
                      AND crc.lookup_type IN
                            (''ACCRUAL WRITE-OFF ACTION'',
                             ''ACCRUAL TYPE'')),
               (SELECT  mtt.transaction_type_name
                 FROM   mtl_transaction_types mtt
                 WHERE  cmr.transaction_type_code =
                        TO_CHAR (mtt.transaction_type_id))
             ),
             (SELECT  crc.displayed_field
               FROM   cst_reconciliation_codes crc
               WHERE  crc.lookup_code = cmr.transaction_type_code
                    AND crc.lookup_type IN
                          (''ACCRUAL WRITE-OFF ACTION'', ''ACCRUAL TYPE''))
           )
             transaction_type,
           cmr.transaction_date,
           ( SELECT  pod.quantity_ordered
               FROM  ap_invoice_distributions_v aid,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.po_distribution_id(+) = pod.po_distribution_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY pod.quantity_ordered)
             ordered_quantity,
           ( SELECT  pod.quantity_cancelled
               FROM  ap_invoice_distributions_v aid,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.po_distribution_id(+) = pod.po_distribution_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY pod.quantity_cancelled)
             quantity_cancelled,
           (SELECT  DISTINCT poll.unit_meas_lookup_code
             FROM   po_line_locations_all poll
             WHERE  po_release_id = mct.consumption_release_id
                  AND po_line_id = pol.po_line_id)
             uom,
           ( SELECT  pod.quantity_delivered
               FROM  ap_invoice_distributions_v aid,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.po_distribution_id(+) = pod.po_distribution_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY pod.quantity_delivered)
             quantity_delivered,
           NULL receipt_num,
           ( SELECT  pod.expenditure_type
               FROM  ap_invoice_distributions_v aid,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.po_distribution_id(+) = pod.po_distribution_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY pod.expenditure_type)
             expenditure_type,
           apia.invoice_num,
           aida.invoice_line_number invoice_line_num,
           ( SELECT  DECODE (a.line_type_lookup_code,
                         ''IPV'', SUM (a.amount),
                         0
                        )
               FROM  ap_invoice_distributions_all a
              WHERE  a.invoice_id =
                     (SELECT  invoice_id
                       FROM   ap_invoice_distributions_all aida
                       WHERE  aida.line_type_lookup_code IN (''ACCRUAL'')
                            AND aida.invoice_distribution_id =
                                cmr.invoice_distribution_id)
                   AND a.invoice_line_number =
                       (SELECT  invoice_line_number
                         FROM   ap_invoice_distributions_all aida
                         WHERE  aida.line_type_lookup_code IN
                                  (''ACCRUAL'')
                              AND aida.invoice_distribution_id =
                                  cmr.invoice_distribution_id)
                   AND a.line_type_lookup_code IN (''IPV'')
            GROUP BY a.line_type_lookup_code)
             ipv,
           cmr.entered_amount,
           cmr.currency_code,
           NVL (cmr.currency_conversion_rate, 1) currency_conversion_rate,
           DECODE (
             mmt.transaction_id,
             NULL,
             transaction_type_code,
             (SELECT  mtt.transaction_type_name
               FROM   mtl_transaction_types mtt
               WHERE  mtt.transaction_type_id = mmt.transaction_type_id)
           )
             transaction_type_code,
           cmr.invoice_distribution_id,
           DECODE (cmr.invoice_distribution_id, NULL, ''INV'', ''AP'')
             transaction_source,
             (SELECT mp.organization_code
          FROM mtl_parameters mp
         WHERE cmr.inventory_organization_id = mp.organization_id) org,
           (TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))
             oracle_aging_date,
           ( (TRUNC (SYSDATE)
             - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date))))
             aging_days,
              CASE
           WHEN ( (TRUNC (SYSDATE)
               - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
              ))) <= 0
           THEN
             ''Current Period''
           WHEN ( (TRUNC (SYSDATE)
               - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
              ))) > 0
             AND ( (TRUNC (SYSDATE)
               - TO_DATE (
                 NVL (apia.invoice_date, cmr.transaction_date)
                 ))) < 31
           THEN
             ''1 - 30 Days''
           WHEN ( (TRUNC (SYSDATE)
               - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
              ))) > 30
             AND ( (TRUNC (SYSDATE)
               - TO_DATE (
                 NVL (apia.invoice_date, cmr.transaction_date)
                 ))) < 61
           THEN
             ''31 - 60 Days''
          WHEN ((TRUNC(SYSDATE) -
               TO_DATE(NVL(apia.invoice_date, cmr.transaction_date)))) > 60 AND
               ((TRUNC(SYSDATE) -
               TO_DATE(NVL(apia.invoice_date, cmr.transaction_date)))) < 91 THEN
            ''61 - 90 Days''
           WHEN ( (TRUNC (SYSDATE)
               - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
              ))) > 90
             AND ( (TRUNC (SYSDATE)
               - TO_DATE (
                 NVL (apia.invoice_date, cmr.transaction_date)
                 ))) < 121
           THEN
             ''91 - 120 Days''
           WHEN ( (TRUNC (SYSDATE)
               - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
              ))) > 120
             AND ( (TRUNC (SYSDATE)
               - TO_DATE (
                 NVL (apia.invoice_date, cmr.transaction_date)
                 ))) < 181
           THEN
             ''121 - 180 Days''
           WHEN ( (TRUNC (SYSDATE)
               - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
              ))) > 180
             AND ( (TRUNC (SYSDATE)
               - TO_DATE (
                 NVL (apia.invoice_date, cmr.transaction_date)
                 ))) < 361
           THEN
             ''181 - 360 Days''
           ELSE
             ''Over 361 Days''
           END
           age_bucket_non_zero,
           :l_accrual_currency_code accrual_currency_code,
           (SELECT  DISTINCT poll.shipment_num
             FROM   po_line_locations_all poll
             WHERE  po_release_id = mct.consumption_release_id
                  AND po_line_id = pol.po_line_id
            HAVING  (SELECT   COUNT ( * )
                    FROM   po_line_locations_all poll
                   WHERE   po_release_id = mct.consumption_release_id
                         AND po_line_id = pol.po_line_id) = 1)
             shipment_number,
           (SELECT  DISTINCT poll.unit_meas_lookup_code
             FROM   po_line_locations_all poll
             WHERE  po_release_id = mct.consumption_release_id
                  AND po_line_id = pol.po_line_id)
             uom_code,
           ( SELECT  pod.distribution_num
               FROM  ap_invoice_distributions_v aid,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.po_distribution_id(+) = pod.po_distribution_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY pod.distribution_num)
             distribution_num,
           (SELECT  DISTINCT poll.quantity_received
             FROM   po_line_locations_all poll
             WHERE  po_release_id = mct.consumption_release_id
                  AND po_line_id = pol.po_line_id)
             quantity_received,
           ( SELECT  pod.quantity_billed
               FROM  ap_invoice_distributions_v aid,
                   po_distributions_all pod
              WHERE     aid.po_header_id = poh.po_header_id
                   AND aid.po_line_id = mct.po_line_id
                   AND aid.po_release_id = mct.consumption_release_id
                   AND aid.po_distribution_id(+) = pod.po_distribution_id
                   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
                   AND aid.cancelled_date IS NULL
             HAVING  COUNT (aid.po_distribution_id) = 1
            GROUP BY pod.quantity_billed)
             quantity_billed,
           cmr.quantity trx_qty,
           cmr.amount funct_amt,
           NULL rcv_transaction_id,
           mmt.transfer_transaction_id,
           NULL packing_slip,
           (SELECT    gcc.segment1
                  || ''.''
                  || gcc.segment2
                  || ''.''
                  || gcc.segment3
                  || ''.''
                  || gcc.segment4
                  || ''.''
                  || gcc.segment5
                  || ''.''
                  || gcc.segment6
                  || ''.''
                  || gcc.segment7
                  || ''.''
                  || gcc.segment8
             FROM   gl_code_combinations gcc
             WHERE  code_combination_id = cmr.accrual_account_id)
             accrual_account,
           (NVL (poh.rate, 0) * pol.unit_price * cmr.quantity) ppv1,
           ( NVL (cmr.currency_conversion_rate, 0)
            * pol.unit_price
            * cmr.quantity)
             ppv2,
           ROUND ((SELECT poll.price_override FROM po_line_locations_all poll
					WHERE 
						poll.po_header_id = poh.po_header_id
					AND	poll.po_line_id = pol.po_line_id
					AND poll.po_release_id = por.po_release_id), :l_extended_precision) po_unit_price,
           NULL po_currency_code,
           (SELECT ROUND (DECODE (NVL (fnc1.minimum_accountable_unit, 0),
                              0, pol.unit_price * cmr.currency_conversion_rate,
                                (pol.unit_price
                                 / fnc1.minimum_accountable_unit
                                )
                              * cmr.currency_conversion_rate
                              * fnc1.minimum_accountable_unit
                             ),
                      NVL (fnc1.extended_precision, 2)
                     )
          FROM fnd_currencies fnc1
         WHERE fnc1.currency_code = cmr.currency_code) func_unit_price,
' || l_charge_account || '
             charge_account,
           poh.creation_date po_date,
           NULL receipt_date,
			(SELECT hou.name
			 FROM hr_operating_units hou
			 WHERE hou.organization_id = '||l_current_org_id||') operating_unit,
			CASE
				WHEN (( SELECT  pod.quantity_billed
						   FROM  ap_invoice_distributions_v aid,
							   po_distributions_all pod
						  WHERE     aid.po_header_id = poh.po_header_id
							   AND aid.po_line_id = mct.po_line_id
							   AND aid.po_release_id = mct.consumption_release_id
							   AND aid.po_distribution_id(+) = pod.po_distribution_id
							   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
							   AND aid.cancelled_date IS NULL
						 HAVING  COUNT (aid.po_distribution_id) = 1
						GROUP BY pod.quantity_billed) 
				>     (SELECT  pod.quantity_delivered
					   FROM  ap_invoice_distributions_v aid,
							 po_distributions_all pod
					   WHERE     aid.po_header_id = poh.po_header_id
					   AND aid.po_line_id = mct.po_line_id
					   AND aid.po_release_id = mct.consumption_release_id
					   AND aid.po_distribution_id(+) = pod.po_distribution_id
					   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
					   AND aid.cancelled_date IS NULL
					   HAVING  COUNT (aid.po_distribution_id) = 1
					   GROUP BY pod.quantity_delivered)
					 ) THEN
				''Y''
				ELSE
				''N''
			END bill_qty_greater_than_recv_qty,
			DECODE (( SELECT  pod.quantity_ordered
					   FROM  ap_invoice_distributions_v aid,
						   po_distributions_all pod
					  WHERE     aid.po_header_id = poh.po_header_id
						   AND aid.po_line_id = mct.po_line_id
						   AND aid.po_release_id = mct.consumption_release_id
						   AND aid.po_distribution_id(+) = pod.po_distribution_id
						   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
						   AND aid.cancelled_date IS NULL
					 HAVING  COUNT (aid.po_distribution_id) = 1
					GROUP BY pod.quantity_ordered),
				    (SELECT  pod.quantity_delivered
					   FROM  ap_invoice_distributions_v aid,
						   po_distributions_all pod
					  WHERE     aid.po_header_id = poh.po_header_id
						   AND aid.po_line_id = mct.po_line_id
						   AND aid.po_release_id = mct.consumption_release_id
						   AND aid.po_distribution_id(+) = pod.po_distribution_id
						   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
						   AND aid.cancelled_date IS NULL
					 HAVING  COUNT (aid.po_distribution_id) = 1
					 GROUP BY pod.quantity_delivered),
					''Y'',
					''N''	
				   ) ordered_delivered_match,
			DECODE (
					   (SELECT  pod.quantity_billed
						   FROM  ap_invoice_distributions_v aid,
							   po_distributions_all pod
						  WHERE     aid.po_header_id = poh.po_header_id
							   AND aid.po_line_id = mct.po_line_id
							   AND aid.po_release_id = mct.consumption_release_id
							   AND aid.po_distribution_id(+) = pod.po_distribution_id
							   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
							   AND aid.cancelled_date IS NULL
						 HAVING  COUNT (aid.po_distribution_id) = 1
						GROUP BY pod.quantity_billed),
					   (SELECT  pod.quantity_delivered
						   FROM  ap_invoice_distributions_v aid,
							   po_distributions_all pod
						  WHERE     aid.po_header_id = poh.po_header_id
							   AND aid.po_line_id = mct.po_line_id
							   AND aid.po_release_id = mct.consumption_release_id
							   AND aid.po_distribution_id(+) = pod.po_distribution_id
							   AND aid.line_type_lookup_code(+) = ''ACCRUAL''
							   AND aid.cancelled_date IS NULL
						 HAVING  COUNT (aid.po_distribution_id) = 1
						GROUP BY pod.quantity_delivered),
						''Y'',
						''N''							
				   )	delivered_billed_match,	   
			(SELECT gcc.segment1 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) entity,
			(SELECT gcc.segment2 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) location,
			(SELECT ffvl.description 
			 FROM fnd_flex_values_vl ffvl, fnd_flex_value_sets ffvs, gl_code_combinations gcc
			 WHERE 
				 ffvs.flex_value_set_name = ''XXIR_GL_LOCATION''
			 AND ffvs.flex_value_set_id = ffvl.flex_value_set_id
			 AND ffvl.flex_value_meaning = gcc.segment2
			 AND gcc.code_combination_id = cmr.accrual_account_id) location_name, 	
			(SELECT gcc.segment3 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) cost_center,	
			(SELECT gcc.segment4 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) account,	
			(SELECT gcc.segment5 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) product,	
			(SELECT gcc.segment6 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) intercompany,	
			(SELECT gcc.segment7 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) future_1,	
			(SELECT gcc.segment8 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) future_2,
			pol.closed_code po_closure_status,
			cmr.transaction_date	po_last_trx_date,
			CASE
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) <= 0
				THEN ''CURRENT Period''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 0
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 31
				THEN ''1 - 30 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 30
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 61
				THEN ''31 - 60 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 60
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 91
				THEN ''61 - 90 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 90
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 121
				THEN ''91 - 120 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 120
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 181
				THEN ''121 - 180 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 180
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 361
				THEN ''181 - 360 Days''
				ELSE ''Over 361 Days''
			END		last_trx_date_age_bucket,
           (SELECT  NVL(poll.closed_code,''OPEN'')
             FROM   po_line_locations_all poll
             WHERE  po_release_id = mct.consumption_release_id
                AND po_line_id = pol.po_line_id
			 GROUP BY poll.closed_code)	po_closed_status,
			(REPLACE(REPLACE((SELECT  rsh.shipment_num FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 ''''))	 rcv_shipment_num,			
			(REPLACE(REPLACE((SELECT  rsh.bill_of_lading FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) bill_of_lading,
			(SELECT  rsh.shipped_date FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
			WHERE rsh.shipment_header_id = rsl.shipment_header_id
			AND   rsl.po_header_id = poh.po_header_id
			AND   aida.rcv_transaction_id = rt.transaction_id
			AND   rt.shipment_header_id = rsh.shipment_header_id
			) shipped_date,	
			(REPLACE(REPLACE((SELECT  rsh.freight_carrier_code FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) freight_carrier_code,
			(REPLACE(REPLACE((SELECT  rsh.waybill_airbill_num FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, rcv_transactions rt
								WHERE rsh.shipment_header_id = rsl.shipment_header_id
								AND   rsl.po_header_id = poh.po_header_id
								AND   aida.rcv_transaction_id = rt.transaction_id
								AND   rt.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) waybill_airbill_num,
              (SUBSTR(REPLACE(REPLACE(poh.comments,
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    6)) trane_ref_number											 
       FROM  cst_misc_reconciliation cmr,
           ap_invoices_all apia,
           ap_invoice_distributions_all aida,
           po_releases_all por,
           po_lines_all pol,
           po_headers_all poh,
           ap_suppliers aps,
           mtl_material_transactions mmt,
           mtl_consumption_transactions mct,
           po_lookup_codes plc
      WHERE     cmr.invoice_distribution_id = aida.invoice_distribution_id(+)
           AND plc.lookup_code(+) = poh.fob_lookup_code
           AND plc.lookup_type(+) = ''FOB''
           AND aida.invoice_id = apia.invoice_id(+)
           AND cmr.inventory_transaction_id = mmt.transaction_id(+)
           AND aps.vendor_id(+) = poh.vendor_id
           AND cmr.operating_unit_id = :l_current_org_id
           AND (nvl(cmr.amount,0)+nvl(cmr.entered_amount,0)) != 0
           AND cmr.po_distribution_id IS NULL
           AND mmt.transfer_transaction_id = mct.transaction_id(+)
           AND NVL (mct.transaction_source_id, mmt.transaction_source_id) =
               poh.po_header_id
           AND mct.consumption_release_id = por.po_release_id(+)
           AND mct.po_line_id = pol.po_line_id
       AND ( cmr.accrual_account_id in(select code_combination_id from gl_code_combinations where 
              segment2=:p_location ) or :p_location is NULL )  
           AND ( aps.vendor_id=:p_vendor_from or :p_vendor_from is null )   
           AND cmr.transaction_type_code = ''CONSIGNMENT''';
		   
      l_misc3 := ' UNION
SELECT  NULL po_number,
      NULL fob,
      NULL req_requestor,
      NULL inv_match_option,
      NULL buyer_name,
      NULL invoice_match_app,
      NULL req_num,
      NULL req_date,
      NULL po_doc_type,
      NULL po_release_number,
      NULL po_header_id,
      NULL po_line_id,
      cmr.po_distribution_id,
      NULL line_type,
      NULL line_num,
      DECODE (
        cmr.inventory_item_id,
        NULL,
        NULL,
        (SELECT   msi.concatenated_segments
          FROM   mtl_system_items_vl msi
          WHERE   inventory_item_id = cmr.inventory_item_id
               AND ROWNUM < 2)
      )
        item_name,
      NULL category,
      NULL item_description,
      mmt.transaction_id,
      (SELECT   vendor_name
        FROM   ap_suppliers pov
        WHERE   pov.vendor_id = COALESCE (cmr.vendor_id, apia.vendor_id))
        vendor_name,
      (SELECT   segment1
        FROM   ap_suppliers pov
        WHERE   pov.vendor_id = COALESCE (cmr.vendor_id, apia.vendor_id))
        vendor_num,
      (SELECT   vendor_type_lookup_code
        FROM   ap_suppliers pov
        WHERE   pov.vendor_id = COALESCE (cmr.vendor_id, apia.vendor_id))
        vendor_type,
      (SELECT   vendor_site_code
        FROM   ap_supplier_sites_all pvs
        WHERE   pvs.vendor_site_id =   COALESCE (mct.owning_organization_id,apia.vendor_site_id ))
        vendor_site_name,
      DECODE (
        cmr.invoice_distribution_id,
        NULL,
        DECODE (
          cmr.transaction_type_code,
          ''CONSIGNMENT'',
          (SELECT   crc.displayed_field
            FROM   cst_reconciliation_codes crc
            WHERE   crc.lookup_code = cmr.transaction_type_code
                 AND crc.lookup_type IN
                       (''ACCRUAL WRITE-OFF ACTION'', ''ACCRUAL TYPE'')),
          (SELECT   mtt.transaction_type_name
            FROM   mtl_transaction_types mtt
            WHERE   cmr.transaction_type_code =
                   TO_CHAR (mtt.transaction_type_id))
        ),
        (SELECT   crc.displayed_field
          FROM   cst_reconciliation_codes crc
          WHERE   crc.lookup_code = cmr.transaction_type_code
               AND crc.lookup_type IN
                     (''ACCRUAL WRITE-OFF ACTION'', ''ACCRUAL TYPE''))
      )
        transaction_type,
      cmr.transaction_date,
      NULL ordered_quantity,
      NULL quantity_cancelled,
      NULL uom,
      NULL quantity_delivered,
      NULL receipt_num,
      NULL expenditure_type,
      apia.invoice_num,
      aida.invoice_line_number invoice_line_num,
      (  SELECT  DECODE (a.line_type_lookup_code, ''IPV'', SUM (a.amount), 0)
          FROM  ap_invoice_distributions_all a
         WHERE  a.invoice_id =
                (SELECT   invoice_id
                  FROM   ap_invoice_distributions_all aida
                  WHERE   aida.line_type_lookup_code IN (''ACCRUAL'')
                       AND aida.invoice_distribution_id =
                           cmr.invoice_distribution_id)
              AND a.invoice_line_number =
                  (SELECT   invoice_line_number
                    FROM   ap_invoice_distributions_all aida
                    WHERE   aida.line_type_lookup_code IN (''ACCRUAL'')
                         AND aida.invoice_distribution_id =
                             cmr.invoice_distribution_id)
              AND a.line_type_lookup_code IN (''IPV'')
       GROUP BY  a.line_type_lookup_code)
        ipv,
      cmr.entered_amount,
      cmr.currency_code,
      NVL (cmr.currency_conversion_rate, 1) currency_conversion_rate,
      DECODE (mmt.transaction_id,
            NULL, transaction_type_code,
            (SELECT  mtt.transaction_type_name
              FROM  mtl_transaction_types mtt
             WHERE  mtt.transaction_type_id = mmt.transaction_type_id)
           )
        transaction_type_code,
      cmr.invoice_distribution_id,
      DECODE (cmr.invoice_distribution_id, NULL, ''INV'', ''AP'')
        transaction_source,
     (SELECT mp.organization_code
        FROM mtl_parameters mp
       WHERE cmr.inventory_organization_id = mp.organization_id) org,
      (TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))
        oracle_aging_date,
      ( (TRUNC (SYSDATE)
        - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date))))
        aging_days,
          CASE
          WHEN ( (TRUNC (SYSDATE)
              - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))) <=
              0
          THEN
            ''Current Period''
          WHEN ( (TRUNC (SYSDATE)
              - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))) >
              0
            AND ( (TRUNC (SYSDATE)
              - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
                ))) < 31
          THEN
            ''1 - 30 Days''
          WHEN ( (TRUNC (SYSDATE)
              - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))) >
              30
            AND ( (TRUNC (SYSDATE)
              - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
                ))) < 61
          THEN
            ''31 - 60 Days''
           WHEN ((TRUNC(SYSDATE) -
                 TO_DATE(NVL(apia.invoice_date, cmr.transaction_date)))) > 60 AND
                 ((TRUNC(SYSDATE) -
                 TO_DATE(NVL(apia.invoice_date, cmr.transaction_date)))) < 91 THEN
              ''61 - 90 Days''                
          WHEN ( (TRUNC (SYSDATE)
              - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))) >
              90
            AND ( (TRUNC (SYSDATE)
              - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
                ))) < 121
          THEN
            ''91 - 120 Days''
          WHEN ( (TRUNC (SYSDATE)
              - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))) >
              120
            AND ( (TRUNC (SYSDATE)
              - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
                ))) < 181
          THEN
            ''121 - 180 Days''
          WHEN ( (TRUNC (SYSDATE)
              - TO_DATE (NVL (apia.invoice_date, cmr.transaction_date)))) >
              180
            AND ( (TRUNC (SYSDATE)
              - TO_DATE (
                NVL (apia.invoice_date, cmr.transaction_date)
                ))) < 361
          THEN
            ''181 - 360 Days''
          ELSE
            ''Over 361 Days''
          END
          age_bucket_non_zero,
      :l_accrual_currency_code accrual_currency_code,
      NULL shipment_number,
      NULL uom_code,
      NULL distribution_num,
      NULL quantity_received,
      NULL quantity_billed,
      cmr.quantity trx_qty,
      cmr.amount funct_amt,
      NULL rcv_transaction_id,
      mmt.transfer_transaction_id,
      NULL packing_slip,
      (SELECT     gcc.segment1
             || ''.''
             || gcc.segment2
             || ''.''
             || gcc.segment3
             || ''.''
             || gcc.segment4
             || ''.''
             || gcc.segment5
             || ''.''
             || gcc.segment6
             || ''.''
             || gcc.segment7
             || ''.''
             || gcc.segment8
        FROM   gl_code_combinations gcc
        WHERE   code_combination_id = cmr.accrual_account_id)
        accrual_account,
      NULL ppv1,
      NULL ppv2,
      NULL po_unit_price,
      NULL po_currency_code,
      NULL func_unit_price,
      NULL charge_account,	
      NULL po_date,
      NULL receipt_date,
			(SELECT hou.name
			 FROM hr_operating_units hou
			 WHERE hou.organization_id = '||l_current_org_id||') operating_unit,
			''N'' bill_qty_greater_than_recv_qty,
			''N'' ordered_delivered_match,
			''N'' delivered_billed_match,	
			(SELECT gcc.segment1 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) entity,
			(SELECT gcc.segment2 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) location,
			(SELECT ffvl.description 
			 FROM fnd_flex_values_vl ffvl, fnd_flex_value_sets ffvs, gl_code_combinations gcc
			 WHERE 
				 ffvs.flex_value_set_name = ''XXIR_GL_LOCATION''
			 AND ffvs.flex_value_set_id = ffvl.flex_value_set_id
			 AND ffvl.flex_value_meaning = gcc.segment2
			 AND gcc.code_combination_id = cmr.accrual_account_id) location_name, 	
			(SELECT gcc.segment3 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) cost_center,	
			(SELECT gcc.segment4 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) account,	
			(SELECT gcc.segment5 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) product,	
			(SELECT gcc.segment6 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) intercompany,	
			(SELECT gcc.segment7 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) future_1,	
			(SELECT gcc.segment8 FROM gl_code_combinations gcc
			  WHERE gcc.code_combination_id = cmr.accrual_account_id) future_2,
			(SELECT poll.closed_code FROM po_line_locations_all poll, po_distributions_all pod
			WHERE pod.po_distribution_id = aida.po_distribution_id
			AND pod.line_location_id = poll.line_location_id)	po_closure_status,
			cmr.transaction_date	po_last_trx_date,
			CASE
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) <= 0
				THEN ''CURRENT Period''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 0
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 31
				THEN ''1 - 30 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 30
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 61
				THEN ''31 - 60 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 60
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 91
				THEN ''61 - 90 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 90
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 121
				THEN ''91 - 120 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 120
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 181
				THEN ''121 - 180 Days''
				WHEN ((TRUNC(SYSDATE) - TO_DATE(cmr.transaction_date))) > 180
				AND ((TRUNC(SYSDATE)  - TO_DATE(cmr.transaction_date))) < 361
				THEN ''181 - 360 Days''
				ELSE ''Over 361 Days''
			END		last_trx_date_age_bucket,
			(SELECT NVL(poll.closed_code,''OPEN'') FROM po_line_locations_all poll, po_distributions_all pod
			WHERE pod.po_distribution_id = aida.po_distribution_id
			AND pod.line_location_id = poll.line_location_id)	po_closed_status,
			(REPLACE(REPLACE((SELECT rsh.shipment_num FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, po_headers_all poh, po_distributions_all pod
								WHERE aida.po_distribution_id = pod.po_distribution_id
								AND   pod.po_header_id = poh.po_header_id
								AND   poh.po_header_id = rsl.po_header_id
								AND   rsl.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 ''''))	 rcv_shipment_num,			
			(REPLACE(REPLACE((SELECT rsh.bill_of_lading FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, po_headers_all poh, po_distributions_all pod
								WHERE aida.po_distribution_id = pod.po_distribution_id
								AND   pod.po_header_id = poh.po_header_id
								AND   poh.po_header_id = rsl.po_header_id
								AND   rsl.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) bill_of_lading,
			(SELECT rsh.shipped_date FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, po_headers_all poh, po_distributions_all pod
			WHERE aida.po_distribution_id = pod.po_distribution_id
			AND   pod.po_header_id = poh.po_header_id
			AND   poh.po_header_id = rsl.po_header_id
			AND   rsl.shipment_header_id = rsh.shipment_header_id
			) shipped_date,	
			(REPLACE(REPLACE((SELECT rsh.freight_carrier_code FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, po_headers_all poh, po_distributions_all pod
								WHERE aida.po_distribution_id = pod.po_distribution_id
								AND   pod.po_header_id = poh.po_header_id
								AND   poh.po_header_id = rsl.po_header_id
								AND   rsl.shipment_header_id = rsh.shipment_header_id
								),
										  CHR(10),
										  ''''),
									 CHR(13),
									 '''')) freight_carrier_code,
			(REPLACE(REPLACE((SELECT rsh.waybill_airbill_num FROM rcv_shipment_headers rsh, rcv_shipment_lines rsl, po_headers_all poh, po_distributions_all pod
								WHERE aida.po_distribution_id = pod.po_distribution_id
								AND   pod.po_header_id = poh.po_header_id
								AND   poh.po_header_id = rsl.po_header_id
								AND   rsl.shipment_header_id = rsh.shipment_header_id
								),
												  CHR(10),
												  ''''),
											 CHR(13),
											 '''')) waybill_airbill_num,
              (SUBSTR(REPLACE(REPLACE((SELECT poh.comments FROM po_headers_all poh, po_distributions_all pod
								WHERE aida.po_distribution_id = pod.po_distribution_id
								AND   pod.po_header_id = poh.po_header_id
								),
                              CHR(10),
                              ''''),
                         CHR(13),
                         ''''),
                    1,
                    6)) trane_ref_number											 
  FROM  cst_misc_reconciliation cmr,
      ap_invoices_all apia,
      ap_invoice_distributions_all aida,
      mtl_material_transactions mmt,
      mtl_consumption_transactions mct
 WHERE     cmr.invoice_distribution_id = aida.invoice_distribution_id(+)
      AND aida.invoice_id = apia.invoice_id(+)
      AND cmr.inventory_transaction_id = mmt.transaction_id(+)
      AND cmr.operating_unit_id = :l_current_org_id
      AND (nvl(cmr.amount,0)+nvl(cmr.entered_amount,0)) != 0 
      AND ( cmr.accrual_account_id in(select code_combination_id from gl_code_combinations where 
                      segment2=:p_location ) or :p_location is NULL )  
            AND ( cmr.vendor_id=:p_vendor_from or :p_vendor_from is null )     
      AND cmr.po_distribution_id IS NULL
      AND mmt.transfer_transaction_id = mct.transaction_id(+)
      AND cmr.transaction_type_code != ''CONSIGNMENT'')';
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'l_misc1 : ' || l_misc1);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'-----------------------------------------------------------------------------');
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'l_misc2 : ' || l_misc2);
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'-----------------------------------------------------------------------------');
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'l_misc3 : ' || l_misc3);
    
      /* Calculating the length of l_misc1, l_misc2 and l_misc3 for debugging purpose as 
		 EXECUTE IMMEDIATE (l_misc1 || l_misc2 || l_misc3) was going into error due to length issues for concatenated string
		 and that's why converted l_misc1, l_misc2 and l_misc3 to CLOB variables for CR8035 */
		 
	  BEGIN
		SELECT dbms_lob.getlength(l_misc1)
		INTO l_misc1_length
		FROM DUAL;
	  EXCEPTION
		WHEN OTHERS THEN
		l_misc1_length := NULL;
		xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Exception occurred in getting length of misc1 '||SQLERRM);
	  END;
	  
	  xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Length of misc1 : ' || l_misc1_length);

	  BEGIN
		SELECT dbms_lob.getlength(l_misc2)
		INTO l_misc2_length
		FROM DUAL;
	  EXCEPTION
		WHEN OTHERS THEN
		l_misc2_length := NULL;
		xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Exception occurred in getting length of misc2 '||SQLERRM);
	  END;

	  xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Length of misc2 : ' || l_misc2_length);	  

	  BEGIN
		SELECT dbms_lob.getlength(l_misc3)
		INTO l_misc3_length
		FROM DUAL;
	  EXCEPTION
		WHEN OTHERS THEN
		l_misc3_length := NULL;
		xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Exception occurred in getting length of misc3 '||SQLERRM);
	  END;		  

	  xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Length of misc3 : ' || l_misc3_length);	  

      ---Added :p_location,p_vendor_from   in below  execute by Raju For CR#8035	  
	  BEGIN	  
		  EXECUTE IMMEDIATE (l_misc1 || l_misc2 || l_misc3)
			USING l_accrual_currency_code, l_extended_precision, l_current_org_id, p_location, p_location, p_vendor_from, p_vendor_from, l_accrual_currency_code, l_extended_precision, l_current_org_id, p_location, p_location, p_vendor_from, p_vendor_from, l_accrual_currency_code, l_current_org_id, p_location, p_location, p_vendor_from, p_vendor_from;
	  EXCEPTION
		WHEN OTHERS THEN
		xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Exception occurred in executing misc1,misc2 and misc3 : ' ||SQLERRM);
	  END;

      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              'Debug completes.....');	  
    
      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,
                              '-----------------------------------------------------------------------------');
      l_parm_tbl('P_EXCLUDE_RECEIPT_MATCHED') := p_exclude_receipt_matched;
      l_parm_tbl('P_EXCLUDE_MATCHED_CONSIGNMENT') := p_exclude_matched_consignment;
      l_parm_tbl('P_MIN_ACCRUAL_AMOUNT') := p_min_accrual_amount;
      l_parm_tbl('P_EXCLUDE_PO_MATCHED') := p_exclude_po_matched;
	  
	  BEGIN
		SELECT count(1) into ln_data_row_count
		FROM xxap_grni_gtt;
	  EXCEPTION
		WHEN OTHERS THEN
		ln_data_row_count := 0;
	  END;

      xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG,'No. of rows present in GTT at the end of execution of l_misc1, l_misc2 and l_misc3 is '||ln_data_row_count);	  	
    
      OPEN l_grni_cur FOR
        SELECT *
          FROM xxap_grni_gtt
         ORDER BY DECODE(l_order_by, 'Category', 18, 'Vendor', 21),
                  17,
                  33,
                  1,
                  16,
                  47,
                  49;
    
      l_ret_xml := xx_pk_xml_util.p_query_to_xml(iv_main_tag    => 'ACR_REPORT',
                                                 iv_row_set_tag => 'BODY',
                                                 iv_row_tag     => 'ACCRUAL_INFO',
                                                 i_return_type  => xx_pk_xml_util.cv_xml_document,
                                                 i_parm_tbl     => l_parm_tbl,
                                                 i_data_cur     => l_grni_cur);
    
      IF l_grni_cur%ISOPEN THEN
        CLOSE l_grni_cur;
      END IF;
    
      l_data_clob := l_ret_xml.getclobval();
      -- write the XML to the request output
      xx_pk_xml_util.p_clob_to_out_file(l_data_clob);
    END IF;
	
	--Calling Execute_datafix added by raju for CR#8035
	IF p_run_data_fix='Y' THEN
	
	 Execute_datafix(errbuf, retcode);
	END IF;
	
	
  EXCEPTION
    /*WHEN FND_API.G_EXC_UNEXPECTED_ERROR THEN
    IF (l_exceptionLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_EXCEPTION,
                     l_module || '.' || l_stmt_num,
                     l_msg_data);
    END IF;
    
    -- Write log messages to request log
    CST_UTILITY_PUB.writelogmessages(p_api_version   => 1.0,
                                     p_msg_count     => l_msg_count,
                                     p_msg_data      => l_msg_data,
                                     x_return_status => l_return_status);
    
    -- Set concurrent program status to error
    l_conc_status := FND_CONCURRENT.SET_COMPLETION_STATUS('ERROR',
                                                          l_msg_data);*/
    WHEN OTHERS THEN
      errbuf  := SQLERRM;
      retcode := 2;
      -- Unexpected level log message for FND log
    /*      IF (l_uLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_UNEXPECTED,
                     l_module || '.' || l_stmt_num,
                     SQLERRM);
    END IF;
    
    IF FND_MSG_PUB.Check_Msg_Level(FND_MSG_PUB.G_MSG_LVL_UNEXP_ERROR) THEN
      FND_MSG_PUB.Add_Exc_Msg(G_PKG_NAME,
                              l_api_name,
                              '(' || TO_CHAR(l_stmt_num) || ') : ' ||
                              SUBSTRB(SQLERRM, 1, 230));
    END IF;
    
    -- Write log messages to request log
    CST_UTILITY_PUB.writelogmessages(p_api_version   => 1.0,
                                     p_msg_count     => l_msg_count,
                                     p_msg_data      => l_msg_data,
                                     x_return_status => l_return_status);
    
    -- Set concurrent program status to error
    l_conc_status := FND_CONCURRENT.SET_COMPLETION_STATUS('ERROR',
                                                          'An unexpected error has occurred, please contact System Administrator. ');*/
  END start_process;

  ------------------------------------------------------------------------------
  -- PROCEDURE  :  Generate_XML
  -- DESCRIPTION  :   The procedure generates and returns the XML data for
  --     the reference cursor passed by the calling API.
  ------------------------------------------------------------------------------
  /*PROCEDURE Generate_XML(p_api_version      IN NUMBER,
                         p_init_msg_list    IN VARCHAR2,
                         p_validation_level IN NUMBER,
                         x_return_status    OUT NOCOPY VARCHAR2,
                         x_msg_count        OUT NOCOPY NUMBER,
                         x_msg_data         OUT NOCOPY VARCHAR2,
                         p_ref_cur          IN SYS_REFCURSOR,
                         p_row_tag          IN VARCHAR2,
                         p_row_set_tag      IN VARCHAR2,
                         x_xml_data         OUT NOCOPY CLOB) IS
    l_api_name    CONSTANT VARCHAR2(30) := 'Generate_XML';
    l_api_version CONSTANT NUMBER := 1.0;
    l_return_status VARCHAR2(1);
    l_full_name CONSTANT VARCHAR2(60) := G_PKG_NAME || '.' || l_api_name;
    l_module    CONSTANT VARCHAR2(60) := 'cst.plsql.' || l_full_name;
  
    l_uLog CONSTANT BOOLEAN := FND_LOG.TEST(FND_LOG.LEVEL_UNEXPECTED,
                                            l_module) AND
                               (FND_LOG.LEVEL_UNEXPECTED >= G_LOG_LEVEL);
    l_pLog CONSTANT BOOLEAN := l_uLog AND
                               (FND_LOG.LEVEL_PROCEDURE >= G_LOG_LEVEL);
    l_sLog CONSTANT BOOLEAN := l_pLog AND
                               (FND_LOG.LEVEL_STATEMENT >= G_LOG_LEVEL);
  
    l_stmt_num NUMBER;
    l_ctx      DBMS_XMLGEN.CTXHANDLE;
  BEGIN
    l_stmt_num := 0;
  
    -- Procedure level log message for Entry point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.begin',
                     'Generate_XML <<');
    END IF;
  
    -- Standard call to check for call compatibility.
    IF NOT FND_API.Compatible_API_Call(l_api_version,
                                       p_api_version,
                                       l_api_name,
                                       G_PKG_NAME) THEN
      RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
    END IF;
  
    -- Initialize message list if p_init_msg_list is set to TRUE.
    IF FND_API.to_Boolean(p_init_msg_list) THEN
      FND_MSG_PUB.initialize;
    END IF;
  
    --  Initialize API return status to success
    x_return_status := FND_API.G_RET_STS_SUCCESS;
    l_return_status := FND_API.G_RET_STS_SUCCESS;
  
    -- create a new context with the SQL query
    l_stmt_num := 10;
    l_ctx      := DBMS_XMLGEN.newContext(p_ref_cur);
  
    -- Add tag names for rows and row sets
    l_stmt_num := 20;
    DBMS_XMLGEN.setRowSetTag(l_ctx, p_row_tag);
    DBMS_XMLGEN.setRowTag(l_ctx, p_row_set_tag);
  
    -- generate XML data
    l_stmt_num := 30;
    x_xml_data := DBMS_XMLGEN.getXML(l_ctx);
  
    -- close the context
    l_stmt_num := 40;
    DBMS_XMLGEN.CLOSECONTEXT(l_ctx);
  
    -- Procedure level log message for exit point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.end',
                     'Generate_XML >>');
    END IF;
  
    -- Get message count and if 1, return message data.
    FND_MSG_PUB.Count_And_Get(p_count => x_msg_count, p_data => x_msg_data);
  EXCEPTION
    WHEN FND_API.G_EXC_UNEXPECTED_ERROR THEN
      x_return_status := FND_API.G_RET_STS_UNEXP_ERROR;
  
      FND_MSG_PUB.Count_And_Get(p_count => x_msg_count,
                                p_data  => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := FND_API.G_RET_STS_UNEXP_ERROR;
  
      -- Unexpected level log message
      IF (l_uLog) THEN
        FND_LOG.STRING(FND_LOG.LEVEL_UNEXPECTED,
                       l_module || '.' || l_stmt_num,
                       SQLERRM);
      END IF;
  
      IF FND_MSG_PUB.Check_Msg_Level(FND_MSG_PUB.G_MSG_LVL_UNEXP_ERROR) THEN
        FND_MSG_PUB.Add_Exc_Msg(G_PKG_NAME,
                                l_api_name,
                                '(' || TO_CHAR(l_stmt_num) || ') : ' ||
                                SUBSTRB(SQLERRM, 1, 230));
      END IF;
  
      FND_MSG_PUB.Count_And_Get(p_count => x_msg_count,
                                p_data  => x_msg_data);
  END Generate_XML;*/

  ------------------------------------------------------------------------------
  -- PROCEDURE  :  Merge_XML
  -- DESCRIPTION  :   The procedure merges data from two XML objects into a
  --     single XML object and adds a root tag to the resultant
  --     XML data.
  ------------------------------------------------------------------------------
  /*PROCEDURE Merge_XML(p_api_version      IN NUMBER,
                      p_init_msg_list    IN VARCHAR2,
                      p_validation_level IN NUMBER,
                      x_return_status    OUT NOCOPY VARCHAR2,
                      x_msg_count        OUT NOCOPY NUMBER,
                      x_msg_data         OUT NOCOPY VARCHAR2,
                      p_xml_src1         IN CLOB,
                      p_xml_src2         IN CLOB,
                      p_root_tag         IN VARCHAR2,
                      x_xml_doc          OUT NOCOPY CLOB) IS
    l_api_name    CONSTANT VARCHAR2(30) := 'Merge_XML';
    l_api_version CONSTANT NUMBER := 1.0;
    l_return_status VARCHAR2(1);
    l_full_name CONSTANT VARCHAR2(60) := G_PKG_NAME || '.' || l_api_name;
    l_module    CONSTANT VARCHAR2(60) := 'cst.plsql.' || l_full_name;
  
    l_uLog CONSTANT BOOLEAN := FND_LOG.TEST(FND_LOG.LEVEL_UNEXPECTED,
                                            l_module) AND
                               (FND_LOG.LEVEL_UNEXPECTED >= G_LOG_LEVEL);
    l_pLog CONSTANT BOOLEAN := l_uLog AND
                               (FND_LOG.LEVEL_PROCEDURE >= G_LOG_LEVEL);
    l_sLog CONSTANT BOOLEAN := l_pLog AND
                               (FND_LOG.LEVEL_STATEMENT >= G_LOG_LEVEL);
  
    l_ctx         DBMS_XMLGEN.CTXHANDLE;
    l_offset      NUMBER;
    l_stmt_num    NUMBER;
    l_length_src1 NUMBER;
    l_length_src2 NUMBER;
    \*Bug 7282242*\
    l_encoding   VARCHAR2(20);
    l_xml_header VARCHAR2(100);
  BEGIN
    l_stmt_num := 0;
  
    -- Procedure level log message for Entry point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.begin',
                     'Merge_XML <<');
    END IF;
  
    -- Standard call to check for call compatibility.
    IF NOT FND_API.Compatible_API_Call(l_api_version,
                                       p_api_version,
                                       l_api_name,
                                       G_PKG_NAME) THEN
      RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
    END IF;
  
    -- Initialize message list if p_init_msg_list is set to TRUE.
    IF FND_API.to_Boolean(p_init_msg_list) THEN
      FND_MSG_PUB.initialize;
    END IF;
  
    --  Initialize API return status to success
    x_return_status := FND_API.G_RET_STS_SUCCESS;
    l_return_status := FND_API.G_RET_STS_SUCCESS;
  
    l_stmt_num    := 10;
    l_length_src1 := DBMS_LOB.GETLENGTH(p_xml_src1);
    l_length_src2 := DBMS_LOB.GETLENGTH(p_xml_src2);
  
    l_stmt_num := 20;
    DBMS_LOB.createtemporary(x_xml_doc, TRUE);
  
    IF (l_length_src1 > 0) THEN
      -- Get the first occurence of XML header
      l_stmt_num := 30;
      l_offset   := DBMS_LOB.INSTR(lob_loc => p_xml_src1,
                                   pattern => '>',
                                   offset  => 1,
                                   nth     => 1);
  
      -- Copy XML header part to the destination XML doc
      l_stmt_num := 40;
  
      \*Bug 7282242*\
      \*Remove the header (21 characters)*\
      --DBMS_LOB.copy (x_xml_doc, p_xml_src1, l_offset + 1);
  
      \*The following 3 lines of code ensures that XML data generated here uses the right encoding*\
      l_encoding   := fnd_profile.VALUE('ICX_CLIENT_IANA_ENCODING');
      l_xml_header := '<?xml version="1.0" encoding="' || l_encoding ||
                      '"?>';
      DBMS_LOB.writeappend(x_xml_doc, LENGTH(l_xml_header), l_xml_header);
  
      -- Append the root tag to the XML doc
      l_stmt_num := 50;
      DBMS_LOB.writeappend(x_xml_doc,
                           LENGTH(p_root_tag) + 2,
                           '<' || p_root_tag || '>');
  
      -- Append the 1st XML doc to the destination XML doc
      l_stmt_num := 60;
      DBMS_LOB.COPY(x_xml_doc,
                    p_xml_src1,
                    l_length_src1 - l_offset,
                    DBMS_LOB.GETLENGTH(x_xml_doc) + 1,
                    l_offset + 1);
  
      -- Append the 2nd XML doc to the destination XML doc
      IF (l_length_src2 > 0) THEN
        l_stmt_num := 70;
        DBMS_LOB.COPY(x_xml_doc,
                      p_xml_src2,
                      l_length_src2 - l_offset,
                      DBMS_LOB.GETLENGTH(x_xml_doc) + 1,
                      l_offset + 1);
      END IF;
  
      -- Append the root tag to the end of XML doc
      l_stmt_num := 80;
      DBMS_LOB.writeappend(x_xml_doc,
                           LENGTH(p_root_tag) + 3,
                           '</' || p_root_tag || '>');
    END IF;
  
    -- Procedure level log message for exit point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.end',
                     'Merge_XML >>');
    END IF;
  
    -- Get message count and if 1, return message data.
    FND_MSG_PUB.Count_And_Get(p_count => x_msg_count, p_data => x_msg_data);
  EXCEPTION
    WHEN FND_API.G_EXC_UNEXPECTED_ERROR THEN
      x_return_status := FND_API.G_RET_STS_UNEXP_ERROR;
  
      FND_MSG_PUB.Count_And_Get(p_count => x_msg_count,
                                p_data  => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := FND_API.G_RET_STS_UNEXP_ERROR;
  
      -- Unexpected level log message
      IF (l_uLog) THEN
        FND_LOG.STRING(FND_LOG.LEVEL_UNEXPECTED,
                       l_module || '.' || l_stmt_num,
                       SQLERRM);
      END IF;
  
      IF FND_MSG_PUB.Check_Msg_Level(FND_MSG_PUB.G_MSG_LVL_UNEXP_ERROR) THEN
        FND_MSG_PUB.Add_Exc_Msg(G_PKG_NAME,
                                l_api_name,
                                '(' || TO_CHAR(l_stmt_num) || ') : ' ||
                                SUBSTRB(SQLERRM, 1, 230));
      END IF;
  
      FND_MSG_PUB.Count_And_Get(p_count => x_msg_count,
                                p_data  => x_msg_data);
  END Merge_XML;*/

  ------------------------------------------------------------------------------
  -- PROCEDURE  :  Merge_XML
  -- DESCRIPTION  :   The procedure writes the XML data to the report output
  --     file. The XML publisher picks the data from this output
  --     file to display the data in user specified format.
  ------------------------------------------------------------------------------
  /*PROCEDURE Print_ClobOutput(p_api_version      IN NUMBER,
                             p_init_msg_list    IN VARCHAR2,
                             p_validation_level IN NUMBER,
                             x_return_status    OUT NOCOPY VARCHAR2,
                             x_msg_count        OUT NOCOPY NUMBER,
                             x_msg_data         OUT NOCOPY VARCHAR2,
                             p_xml_data         IN CLOB) IS
    l_api_name    CONSTANT VARCHAR2(30) := 'Print_ClobOutput';
    l_api_version CONSTANT NUMBER := 1.0;
    l_return_status VARCHAR2(1);
    l_full_name CONSTANT VARCHAR2(60) := G_PKG_NAME || '.' || l_api_name;
    l_module    CONSTANT VARCHAR2(60) := 'cst.plsql.' || l_full_name;
  
    l_uLog CONSTANT BOOLEAN := FND_LOG.TEST(FND_LOG.LEVEL_UNEXPECTED,
                                            l_module) AND
                               (FND_LOG.LEVEL_UNEXPECTED >= G_LOG_LEVEL);
    l_pLog CONSTANT BOOLEAN := l_uLog AND
                               (FND_LOG.LEVEL_PROCEDURE >= G_LOG_LEVEL);
    l_sLog CONSTANT BOOLEAN := l_pLog AND
                               (FND_LOG.LEVEL_STATEMENT >= G_LOG_LEVEL);
  
    l_stmt_num NUMBER;
    l_amount   NUMBER;
    l_offset   NUMBER;
    l_length   NUMBER;
    l_data     VARCHAR2(32767);
  BEGIN
    l_stmt_num := 0;
  
    -- Procedure level log message for Entry point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.begin',
                     'Print_ClobOutput <<');
    END IF;
  
    -- Standard call to check for call compatibility.
    IF NOT FND_API.Compatible_API_Call(l_api_version,
                                       p_api_version,
                                       l_api_name,
                                       G_PKG_NAME) THEN
      RAISE FND_API.G_EXC_UNEXPECTED_ERROR;
    END IF;
  
    -- Initialize message list if p_init_msg_list is set to TRUE.
    IF FND_API.to_Boolean(p_init_msg_list) THEN
      FND_MSG_PUB.initialize;
    END IF;
  
    --  Initialize API return status to success
    x_return_status := FND_API.G_RET_STS_SUCCESS;
    l_return_status := FND_API.G_RET_STS_SUCCESS;
  
    -- Get length of the CLOB p_xml_data
    l_stmt_num := 10;
    l_length   := NVL(DBMS_LOB.getlength(p_xml_data), 0);
  
    -- Set the offset point to be the start of the CLOB data
    l_offset := 1;
  
    -- l_amount will be used to read 32KB of data once at a time
    l_amount := 16383; --Changed for bug 6954937
  
    -- Loop until the length of CLOB data is zero
    l_stmt_num := 20;
  
    LOOP
      EXIT WHEN l_length <= 0;
  
      -- Read 32 KB of data and print it to the report output
      DBMS_LOB.read(p_xml_data, l_amount, l_offset, l_data);
  
      FND_FILE.PUT(FND_FILE.OUTPUT, l_data);
  
      l_length := l_length - l_amount;
      l_offset := l_offset + l_amount;
    END LOOP;
  
    -- Procedure level log message for exit point
    IF (l_pLog) THEN
      FND_LOG.STRING(FND_LOG.LEVEL_PROCEDURE,
                     l_module || '.end',
                     'Print_ClobOutput >>');
    END IF;
  
    -- Get message count and if 1, return message data.
    FND_MSG_PUB.Count_And_Get(p_count => x_msg_count, p_data => x_msg_data);
  EXCEPTION
    WHEN FND_API.G_EXC_UNEXPECTED_ERROR THEN
      x_return_status := FND_API.G_RET_STS_UNEXP_ERROR;
  
      FND_MSG_PUB.Count_And_Get(p_count => x_msg_count,
                                p_data  => x_msg_data);
    WHEN OTHERS THEN
      x_return_status := FND_API.G_RET_STS_UNEXP_ERROR;
  
      -- Unexpected level log message
      IF (l_uLog) THEN
        FND_LOG.STRING(FND_LOG.LEVEL_UNEXPECTED,
                       l_module || '.' || l_stmt_num,
                       SQLERRM);
      END IF;
  
      IF FND_MSG_PUB.Check_Msg_Level(FND_MSG_PUB.G_MSG_LVL_UNEXP_ERROR) THEN
        FND_MSG_PUB.Add_Exc_Msg(G_PKG_NAME,
                                l_api_name,
                                '(' || TO_CHAR(l_stmt_num) || ') : ' ||
                                SUBSTRB(SQLERRM, 1, 230));
      END IF;
  
      FND_MSG_PUB.Count_And_Get(p_count => x_msg_count,
                                p_data  => x_msg_data);
  END Print_ClobOutput;*/
  --Added for CR5655-Removal of matched lines to have correct Ageing data
  FUNCTION remove_monthwise_zero(p_po_distribution_id IN NUMBER,
                                 p_accrual_account_id IN NUMBER)
    RETURN VARCHAR2 IS
    l_sum       NUMBER := 0;
    l_month     VARCHAR2(5);
    l_min_month VARCHAR2(5);
    r_month     VARCHAR2(5);
  
    CURSOR cur_month IS
      SELECT mm.*
        FROM (SELECT SUM(amount) month_amount,
                     TO_CHAR(TRUNC(transaction_date), 'MMYY') v_month,
                     MONTHS_BETWEEN(TO_DATE(TO_CHAR(TRUNC(SYSDATE), 'MMYY'),
                                            'MMYY'),
                                    TO_DATE((TO_CHAR(TRUNC(transaction_date),
                                                     'MMYY')),
                                            'MMYY')) m
                FROM cst_ap_po_reconciliation
               WHERE po_distribution_id = p_po_distribution_id
                 AND accrual_account_id = p_accrual_account_id
                 AND amount != 0
               GROUP BY TO_CHAR(TRUNC(transaction_date), 'MMYY')
               ORDER BY 3 DESC) mm
       WHERE mm.month_amount != 0;
  BEGIN
    FOR rec_month IN cur_month LOOP
      l_sum   := rec_month.month_amount + l_sum;
      l_month := rec_month.v_month;
    
      IF l_sum = 0 THEN
        r_month := l_month;
      END IF;
    END LOOP;
  
    IF r_month IS NULL THEN
      SELECT TO_CHAR(ADD_MONTHS(MIN(TRUNC(transaction_date)), -1), 'MMYY')
        INTO l_min_month
        FROM cst_ap_po_reconciliation
       WHERE po_distribution_id = p_po_distribution_id
         AND accrual_account_id = p_accrual_account_id
         AND amount != 0;
    
      r_month := l_min_month;
    END IF;
  
    RETURN r_month;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '0413';
  END remove_monthwise_zero;

  --added below for CR#8035
  PROCEDURE Execute_datafix(errbuf  OUT NOCOPY VARCHAR2,
                            retcode OUT NOCOPY NUMBER) IS
  BEGIN
    
	 xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'Inside Datafix');
	 
	delete from cst_ap_po_reconciliation
     where po_distribution_id in (select po_distribution_id from xnta);
  
    delete from cst_reconciliation_summary
     where po_distribution_id in (select po_distribution_id from xnta);
  
    delete from cst_ap_po_reconciliation
     where po_distribution_id in (select po_distribution_id from xntaap);
  
    delete from cst_reconciliation_summary
     where po_distribution_id in (select po_distribution_id from xntaap);
  
    -- issue a commit
    --COMMIT;
	COMMIT; -- Added w.r.to RT8730945
    xx_pk_fnd_file.put_line(xx_pk_fnd_file.LOG, 'DATAFIX call finish');
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

-- Added a new function for buyer_name for CR8035
  FUNCTION get_buyer_name(p_poh_agent_id IN NUMBER,
						  p_po_release_id IN NUMBER)
  RETURN VARCHAR2 IS
	  ln_agent_id	NUMBER;
	  lv_buyer_name VARCHAR2(100);
  BEGIN
		BEGIN
			SELECT por.agent_id INTO ln_agent_id
			FROM po_releases_all por
			WHERE po_release_id = p_po_release_id;
		EXCEPTION
			WHEN OTHERS THEN
			ln_agent_id := NULL;
		END;

		BEGIN
			SELECT ppx.full_name INTO lv_buyer_name
			FROM per_people_x ppx
			WHERE NVL(ln_agent_id,p_poh_agent_id) = ppx.person_id
			AND TRUNC(SYSDATE) BETWEEN ppx.effective_start_date AND ppx.effective_end_date;
		EXCEPTION
			WHEN OTHERS THEN
			lv_buyer_name := NULL;
		END;

		RETURN lv_buyer_name;
  EXCEPTION
    WHEN OTHERS THEN
	  lv_buyer_name := NULL;
      RETURN lv_buyer_name;
  END get_buyer_name;		

END xxap_grni_rep_pkg;
/
SHOW errors package body XXAP_GRNI_REP_PKG