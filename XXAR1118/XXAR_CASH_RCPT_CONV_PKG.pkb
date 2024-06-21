SET DEFINE OFF;

create or replace PACKAGE BODY        "XXAR_CASH_RCPT_CONV_PKG" 
IS
    /*********************************************************
       ** Title:        AR Cash Receipts Conversion Package
       ** File:         XXAR_CASH_RCPT_CONV_PKG.pkb
       ** Description: This script creates a package Body for  AR Cash Receipts
       ** Parameters:  {None.}
       ** Run as:      APPS
       **
       ** Keyword Tracking:
        **
        **   $Header: xxar/patch/115/sql/XXAR_CASH_RCPT_CONV_PKG.pkb 1.9 10-NOV-2014 10:28:11 CCACND $
        **   $Change History$ (*ALL VERSIONS*)
        **   Revision 1.9 (COMPLETE)
        **     Created:  10-NOV-2014 10:28:11      CCACND
        **       Defect#15254 - abnormal termination fix and AMOUNT comma
        **       elimination using REGEXP
        **
        **   Revision 1.8 (COMPLETE)
        **     Created:  28-OCT-2014 11:38:07      CCBIZB
        **       removed sqlerrm from api error
        **
        **   Revision 1.7 (COMPLETE)
        **     Created:  14-OCT-2014 10:19:00      CCBIZB
        **       modified date format
        **
        **   Revision 1.6 (COMPLETE)
        **     Created:  18-SEP-2014 16:21:50      CCBIZB
        **       modified exception handling at few places
        **
        **   Revision 1.5 (COMPLETE)
        **     Created:  15-SEP-2014 17:44:12      CCBIZB
        **       removed one unused variable and assignment
        **
        **   Revision 1.4 (COMPLETE)
        **     Created:  08-SEP-2014 17:43:54      CCBIZB
        **       rectified variable naming
        **
        **   Revision 1.3 (COMPLETE)
        **     Created:  08-SEP-2014 16:11:11      CCBIZB
        **       removed unused code and variables, added nvl to few places and
        **       removed duplicate and redundant parts.
        **
        **   Revision 1.2 (COMPLETE)
        **     Created:  08-SEP-2014 10:23:07      CCBIZB
        **       added check for invalid org
        **
        **   Revision 1.1 (COMPLETE)
        **     Created:  26-AUG-2014 14:36:03      CCBIZB
        **       modified with comments
        **
        **   Revision 1.0 (COMPLETE)
        **     Created:  22-AUG-2014 17:44:32      CCBIZB
        **       Initial revision.
        **
        **
       ** History:
       ** Date          Who                Description
       ** -----------   ------------------ ------------------------------------
       ** 28-Jul-2014   ccbizb               AR Cash Receipts
       ** 10-Nov-2014   ccacnd               Defect#15254 - abnormal termination fix and AMOUNT comma elimination using REGEXP
	   ** 27-Jul-2023   Kondu Nandini        EBR - Section26 - Schema Removal Remediation
       ********************************************************/

   gv_ctq_data_set          VARCHAR2 (100)     := 'Unapplied Receipts';
   gn_created_by            NUMBER             := fnd_global.user_id;
   gn_request_id            NUMBER             := fnd_global.conc_request_id;
   gn_user_id               NUMBER             := fnd_profile.VALUE ('USER_ID');
   gn_resp_id               NUMBER             := fnd_profile.VALUE ('RESP_ID');
   gn_resp_appl_id          NUMBER             := fnd_profile.VALUE ('RESP_APPL_ID');
   gn_org_id                NUMBER             := fnd_profile.VALUE ('ORG_ID');

   gn_success_count         NUMBER;
   gn_error_count           NUMBER;
   gn_total_count           NUMBER;
   gn_invalid_count         NUMBER;
   gn_valid_count           NUMBER             := 0;
   gv_success               VARCHAR2 (1)    := fnd_api.g_ret_sts_success;
   gv_stmt                  VARCHAR2 (30);
   gv_rep_errorbuf          VARCHAR (2000);
   gv_rep_retcode           NUMBER;
   ge_abnormal_termination  EXCEPTION;


PROCEDURE create_cash (
      -- Standard API parameters.
      p_api_version                    IN              NUMBER,
      p_init_msg_list                  IN              VARCHAR2
            := fnd_api.g_false,
      p_commit                         IN              VARCHAR2
            := fnd_api.g_false,
      p_validation_level               IN              NUMBER
            := fnd_api.g_valid_level_full,
      x_return_status                  OUT NOCOPY      VARCHAR2,
      x_msg_count                      OUT NOCOPY      NUMBER,
      x_msg_data                       OUT NOCOPY      VARCHAR2,
      -- Receipt info. parameters
      p_usr_currency_code              IN              VARCHAR2 DEFAULT NULL,
      --the translated currency code
      p_currency_code                  IN              VARCHAR2 DEFAULT NULL,
      p_usr_exchange_rate_type         IN              VARCHAR2 DEFAULT NULL,
      p_exchange_rate_type             IN              VARCHAR2 DEFAULT NULL,
      p_exchange_rate                  IN              NUMBER DEFAULT NULL,
      p_exchange_rate_date             IN              DATE DEFAULT NULL,
      p_amount                         IN              NUMBER DEFAULT NULL,
      p_factor_discount_amount         IN              NUMBER DEFAULT NULL,
      p_receipt_number                 IN              VARCHAR2 DEFAULT NULL,
      p_receipt_date                   IN              DATE DEFAULT NULL,
      p_gl_date                        IN              DATE DEFAULT NULL,
      p_maturity_date                  IN              DATE DEFAULT NULL,
      p_postmark_date                  IN              DATE DEFAULT NULL,
      p_customer_id                    IN              NUMBER DEFAULT NULL,
      p_customer_name                  IN              VARCHAR2 DEFAULT NULL,
      p_customer_number                IN              VARCHAR2 DEFAULT NULL,
      p_customer_bank_account_id       IN              NUMBER DEFAULT NULL,
      p_customer_bank_account_num      IN              VARCHAR2 DEFAULT NULL,
      p_customer_bank_account_name     IN              VARCHAR2 DEFAULT NULL,
      p_payment_trxn_extension_id      IN              NUMBER DEFAULT NULL,
      --payment uptake changes bichatte
      p_location                       IN              VARCHAR2 DEFAULT NULL,
      p_customer_site_use_id           IN              NUMBER DEFAULT NULL,
      p_default_site_use               IN              VARCHAR2 DEFAULT 'Y',
      --bug4448307-4509459
      p_customer_receipt_reference     IN              VARCHAR2 DEFAULT NULL,
      p_override_remit_account_flag    IN              VARCHAR2 DEFAULT NULL,
      p_remittance_bank_account_id     IN              NUMBER DEFAULT NULL,
      p_remittance_bank_account_num    IN              VARCHAR2 DEFAULT NULL,
      p_remittance_bank_account_name   IN              VARCHAR2 DEFAULT NULL,
      p_deposit_date                   IN              DATE DEFAULT NULL,
      p_receipt_method_id              IN              NUMBER DEFAULT NULL,
      p_receipt_method_name            IN              VARCHAR2 DEFAULT NULL,
      p_doc_sequence_value             IN              NUMBER DEFAULT NULL,
      p_ussgl_transaction_code         IN              VARCHAR2 DEFAULT NULL,
      p_anticipated_clearing_date      IN              DATE DEFAULT NULL,
      p_called_from                    IN              VARCHAR2 DEFAULT NULL,
      p_attribute_rec                  IN              ar_receipt_api_pub.attribute_rec_type
            DEFAULT ar_receipt_api_pub.attribute_rec_const,
      -- ******* Global Flexfield parameters *******
      p_global_attribute_rec           IN              ar_receipt_api_pub.global_attribute_rec_type
            DEFAULT ar_receipt_api_pub.global_attribute_rec_const,
      p_comments                       IN              VARCHAR2 DEFAULT NULL,
      --   ***  Notes Receivable Additional Information  ***
      p_issuer_name                    IN              VARCHAR2 DEFAULT NULL,
      p_issue_date                     IN              DATE DEFAULT NULL,
      p_issuer_bank_branch_id          IN              NUMBER DEFAULT NULL,
      p_org_id                         IN              NUMBER DEFAULT NULL,
      p_installment                    IN              NUMBER DEFAULT NULL,
      --   ** OUT NOCOPY variables
      p_cr_id                          OUT NOCOPY      NUMBER
      --ov_err_sts                           OUT VARCHAR2,
      --ov_err_msg                           OUT VARCHAR2
   )
   IS
       lv_err_msg                     VARCHAR2 (4000);
    ln_msg_count                 NUMBER:= 0;
    lv_msg_data                 VARCHAR2 (4000):= '';
    lv_return_status              VARCHAR2(10) := '';
    --e_api_error                    EXCEPTION;
   BEGIN
        apps.ar_receipt_api_pub.create_cash (p_api_version,
                                           p_init_msg_list,
                                           p_commit,
                                           p_validation_level,
                                           lv_return_status, --x_return_status,
                                           ln_msg_count, --x_msg_count,
                                           lv_msg_data, --x_msg_data,
                                           p_usr_currency_code,
                                           p_currency_code,
                                           p_usr_exchange_rate_type,
                                           p_exchange_rate_type,
                                           p_exchange_rate,
                                           p_exchange_rate_date,
                                           p_amount,
                                           p_factor_discount_amount,
                                           p_receipt_number,
                                           p_receipt_date,
                                           p_gl_date,
                                           p_maturity_date,
                                           p_postmark_date,
                                           p_customer_id,
                                           p_customer_name,
                                           p_customer_number,
                                           p_customer_bank_account_id,
                                           p_customer_bank_account_num,
                                           p_customer_bank_account_name,
                                           p_payment_trxn_extension_id,
                                           p_location,
                                           p_customer_site_use_id,
                                           p_default_site_use,
                                           p_customer_receipt_reference,
                                           p_override_remit_account_flag,
                                           p_remittance_bank_account_id,
                                           p_remittance_bank_account_num,
                                           p_remittance_bank_account_name,
                                           p_deposit_date,
                                           p_receipt_method_id,
                                           p_receipt_method_name,
                                           p_doc_sequence_value,
                                           p_ussgl_transaction_code,
                                           p_anticipated_clearing_date,
                                           p_called_from,
                                           p_attribute_rec,
                                           p_global_attribute_rec,
                                           p_comments,
                                           p_issuer_name,
                                           p_issue_date,
                                           p_issuer_bank_branch_id,
                                           p_org_id,
                                           p_installment,
                                           p_cr_id
                                          );

        x_return_status := lv_return_status;
        x_msg_count := ln_msg_count;
        x_msg_data := lv_msg_data;

        IF (lv_return_status <> gv_success)
        THEN
            IF NVL(ln_msg_count,0) <= 1
            Then
                lv_err_msg := lv_msg_data;
            ELSIF ln_msg_count > 1
            Then
                xxctq_util_pkg.log_message ('Error in creation Api');
                x_msg_data := 'Error in creation Api';
                x_msg_count := ln_msg_count; --ov_err_sts := 'ERROR';
                FOR i IN 1 .. ln_msg_count
                LOOP
                    fnd_msg_pub.get (p_msg_index => i,
                                     p_encoded => 'F',
                                     p_data => lv_msg_data,
                                     p_msg_index_out => ln_msg_count
                                     );
                    x_msg_data := x_msg_data || '~' || lv_msg_data;
                    xxctq_util_pkg.log_message(
                                                'lv_msg_data : ' || lv_msg_data
                                               );
                END LOOP;
            END IF;
            ROLLBACK;
            --RAISE e_api_error;
        END IF;

    EXCEPTION
        WHEN OTHERS
        THEN
            xxctq_util_pkg.log_message(
                                'Unhandled exception in cash receipt creation API - ' || SQLERRM
                               );

            x_return_status := 'E';
            x_msg_count := ln_msg_count;
            x_msg_data :=
                    'UnExpected Error Occured while creating Cutomer Account '
                    || SQLERRM;
            ROLLBACK;
   END create_cash;



PROCEDURE apply_on_account (
-- Standard API parameters.
      p_api_version                    IN              NUMBER,
      p_init_msg_list                  IN              VARCHAR2
            := fnd_api.g_false,
      p_commit                         IN              VARCHAR2
            := fnd_api.g_false,
      p_validation_level               IN              NUMBER
            := fnd_api.g_valid_level_full,
      x_return_status                  OUT NOCOPY      VARCHAR2,
      x_msg_count                      OUT NOCOPY      NUMBER,
      x_msg_data                       OUT NOCOPY      VARCHAR2,
      --  Receipt application parameters.
      p_cash_receipt_id                IN              ar_cash_receipts.cash_receipt_id%TYPE
            DEFAULT NULL,
      p_receipt_number                 IN              ar_cash_receipts.receipt_number%TYPE
            DEFAULT NULL,
      p_amount_applied                 IN              ar_receivable_applications.amount_applied%TYPE
            DEFAULT NULL,
      p_apply_date                     IN              ar_receivable_applications.apply_date%TYPE
            DEFAULT NULL,
      p_apply_gl_date                  IN              ar_receivable_applications.gl_date%TYPE
            DEFAULT NULL,
      p_ussgl_transaction_code         IN              ar_receivable_applications.ussgl_transaction_code%TYPE
            DEFAULT NULL,
      p_attribute_rec                  IN              ar_receipt_api_pub.attribute_rec_type
            DEFAULT ar_receipt_api_pub.attribute_rec_const,
      -- ******* Global Flexfield parameters *******
      p_global_attribute_rec           IN              ar_receipt_api_pub.global_attribute_rec_type
            DEFAULT ar_receipt_api_pub.global_attribute_rec_const,
      p_comments                       IN              ar_receivable_applications.comments%TYPE
            DEFAULT NULL,
      p_application_ref_num            IN              ar_receivable_applications.application_ref_num%TYPE,
      p_secondary_application_ref_id   IN              ar_receivable_applications.secondary_application_ref_id%TYPE,
      p_customer_reference             IN              ar_receivable_applications.customer_reference%TYPE,
      p_called_from                    IN              VARCHAR2,
      p_customer_reason                IN              ar_receivable_applications.customer_reason%TYPE,
      p_secondary_app_ref_type         IN              ar_receivable_applications.secondary_application_ref_type%TYPE
            := NULL,
      p_secondary_app_ref_num          IN              ar_receivable_applications.secondary_application_ref_num%TYPE
            := NULL,
      p_org_id                         IN              NUMBER DEFAULT NULL
   )
    IS
        ln_on_acct_cust_id           NUMBER;
        ln_on_acct_cust_site_use_id  NUMBER;
        ln_msg_count                 NUMBER := 0;
        lv_msg_data                 VARCHAR2 (4000):= '';
        lv_err_msg                     VARCHAR2 (4000);
        lv_return_status              VARCHAR2(10) := '';

    BEGIN
        IF p_amount_applied IS NOT NULL OR p_amount_applied != 0
        THEN
            apps.ar_receipt_api_pub.apply_on_account
                                             (p_api_version,
                                              p_init_msg_list,
                                              p_commit,
                                              p_validation_level,
                                              lv_return_status, --x_return_status,
                                              ln_msg_count, --x_msg_count,
                                              lv_msg_data, --x_msg_data,
                                              --  Receipt application parameters.
                                              p_cash_receipt_id,
                                              p_receipt_number,
                                              p_amount_applied,
                                              p_apply_date,
                                              p_apply_gl_date,
                                              p_ussgl_transaction_code,
                                              p_attribute_rec,
                                              -- ******* Global Flexfield parameters *******
                                              p_global_attribute_rec,
                                              p_comments,
                                              p_application_ref_num,
                                              p_secondary_application_ref_id,
                                              p_customer_reference,
                                              p_called_from,
                                              p_customer_reason,
                                              p_secondary_app_ref_type,
                                              p_secondary_app_ref_num,
                                              p_org_id
                                             );
        END IF;

        x_return_status := lv_return_status;
        x_msg_count := ln_msg_count;
        x_msg_data := lv_msg_data;

        IF (lv_return_status <> gv_success)
        THEN
            IF NVL(ln_msg_count,0) <= 1
            Then
                lv_err_msg := lv_msg_data;
            ELSIF ln_msg_count > 1
            Then
                xxctq_util_pkg.log_message ('Error in creation Api');
                x_msg_data := 'Error in creation Api';
                x_msg_count := ln_msg_count; --ov_err_sts := 'ERROR';
                FOR i IN 1 .. ln_msg_count
                LOOP
                    fnd_msg_pub.get (p_msg_index => i,
                                     p_encoded => 'F',
                                     p_data => lv_msg_data,
                                     p_msg_index_out => ln_msg_count
                                     );
                    x_msg_data := x_msg_data || '~' || lv_msg_data;
                    xxctq_util_pkg.log_message(
                                                'lv_msg_data : ' || lv_msg_data
                                               );
                END LOOP;
            END IF;
            ROLLBACK;
            --RAISE e_api_error;
        ELSE

            BEGIN
                SELECT     pay_from_customer, customer_site_use_id
                INTO     ln_on_acct_cust_id, ln_on_acct_cust_site_use_id
                FROM     ar_cash_receipts
                WHERE     cash_receipt_id = p_cash_receipt_id;
            EXCEPTION
                WHEN OTHERS
                THEN
                    xxctq_util_pkg.log_message(
                                'Exception while fetching ln_on_acct_cust_id and ln_on_acct_cust_site_use_id - ' || SQLERRM
                               );
            END;

            IF ln_on_acct_cust_id IS NOT NULL
            THEN
                 UPDATE ar_receivable_applications
                    SET on_acct_cust_id = ln_on_acct_cust_id,
                        on_acct_cust_site_use_id = ln_on_acct_cust_site_use_id
                  WHERE cash_receipt_id = p_cash_receipt_id
                    AND NVL(status, 'NEW') = 'ACC';
            END IF; --ln_on_acct_cust_id IS NOT NULL

        END IF; --(x_return_status <> gv_success)
    EXCEPTION
        WHEN OTHERS
        THEN
            xxctq_util_pkg.log_message(
                                'Unhandled exception in apply_on_account API - ' || SQLERRM
                               );

            x_return_status := 'E';
            x_msg_count := ln_msg_count;
            x_msg_data :=
                    'UnExpected Error Occured while creating Cutomer Account '
                    || SQLERRM;
            ROLLBACK;
    END apply_on_account;


/*
   **  Object Name:        delete_error_rec
   **  Description: This procedure is used to delete old records with the same batch from the exception table
   **  Parameters:  in_batch_id =Batch ID to run the program
   **  Run as:      APPS
   **  Keyword Tracking:
*/
    PROCEDURE delete_error_rec (in_batch_id IN NUMBER)IS
      PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        DELETE FROM xxctq_exception_detail             ----EBR Section 26 Schema Reference Removal
        WHERE batch_id = in_batch_id;

        xxctq_util_pkg.log_message('Deleted Error description details from Error table are: '||SQL%ROWCOUNT);
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            xxctq_util_pkg.log_message('EXCEPTION in delete_error_rec - UnExpected Error Occured while deleting AR Cash Receipt exception Values. ');
            ROLLBACK;
    END ;


/*
   ** Object Name: check_ou_status
   ** Description: This script is used to check whether the Organization passed in the File is accessible to user or not
   ** Parameters: p_batch_id =Batch ID to run the program
   ** Run as: APPS
   ** Keyword Tracking:
*/

   FUNCTION check_ou_status (p_batch_id NUMBER)
      RETURN NUMBER
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
      /*********************Function to check whether the Organization passed in the File is accessible to user or not********************************/
        ln_valid_org_id   NUMBER := 0;
        lv_error_message     VARCHAR2 (2000) := NULL;
        ln_check_access      NUMBER := NULL;
        /* 0 - Success - To Move forward for improt
           1 - Warning - Switch Responsibility
           2 - Error - NULL Operating Unit */

      CURSOR cur_rcpt_org_c                              -- Data file Cursor
      IS
           SELECT H_ORGANIZATION_NAME AS ORGANIZATION_NAME
             FROM XXCTQ_RECEPT_C_AR_RECEIPT
            WHERE batch_id = p_batch_id AND H_ORGANIZATION_NAME IS NOT NULL
         GROUP BY H_ORGANIZATION_NAME;

      CURSOR cur_rcpt_null_org -- Data file Cursor to deal with NULL Operation Unit records
      IS
         SELECT batch_id, record_id, H_ORGANIZATION_NAME
           FROM XXCTQ_RECEPT_C_AR_RECEIPT xx_rec
          WHERE batch_id = p_batch_id
            AND (TRIM (H_ORGANIZATION_NAME) IS NULL OR
                     (NOT EXISTS (SELECT organization_id
                                    FROM hr_operating_units
                                   WHERE name = xx_rec.H_ORGANIZATION_NAME)));
   BEGIN
      ln_check_access := 0; -- ** Value "0" is for Success - To Move forward for improt **

      FOR rec_data_org_list IN cur_rcpt_org_c
      LOOP
         ln_valid_org_id := 0;

         BEGIN
            SELECT ORGANIZATION_ID --COUNT (1)
              INTO ln_valid_org_id
              FROM mo_glob_org_access_tmp mo_tmp
             WHERE mo_tmp.organization_name = rec_data_org_list.ORGANIZATION_NAME;
         EXCEPTION
            WHEN OTHERS
            THEN
               ln_valid_org_id := 0;
         END;

         IF ln_valid_org_id = 0                           -- NO OU selected
         THEN
            xxctq_util_pkg.
             log_message (
                  'Operating Unit "'
               || rec_data_org_list.ORGANIZATION_NAME
               || '" Is not Supported by the Current Responsibility.');
            ln_check_access := 1; -- ** Value "1" is for program Warning - Suggestions for Switch Responsibility **
         ELSE
            xxctq_util_pkg.
             log_message (
                  'Operating Unit "'
               || rec_data_org_list.ORGANIZATION_NAME
               || '" Is Valid');

            /************************************Update Operating unit id for Valid OU's */
            UPDATE XXCTQ_RECEPT_C_AR_RECEIPT x
               SET x.DEST_ORG_ID_TV = ln_valid_org_id
             WHERE x.batch_id = p_batch_id
               AND x.H_ORGANIZATION_NAME = rec_data_org_list.ORGANIZATION_NAME;

            -- ln_check_access := 0; -- ** Value "0" is for Success - To Move forward for improt **
            --COMMIT;
         END IF;

      END LOOP;

      ------------------- ** If operating UNIT is null **
      -- Note : We don't require to use this check as non-null constraint has been added in the staging table level.

      UPDATE XXCTQ_RECEPT_C_AR_RECEIPT x
         SET status = 'INVALID'
       WHERE batch_id = p_batch_id
         AND NVL(status, 'NEW')  <> 'SUCCESS'
         AND (TRIM (H_ORGANIZATION_NAME) IS NULL OR
                     (NOT EXISTS (SELECT organization_id
                                    FROM hr_operating_units
                                   WHERE name = H_ORGANIZATION_NAME)));

      IF SQL%ROWCOUNT > 0
      THEN
         xxctq_util_pkg.
          log_message (
            '****There are some AR Receipts records with #NULL# operating Unit - Please correct the Batch****');

         FOR rec_rcpt_null_org IN cur_rcpt_null_org -- ** Only to deal error for null OU Records **
         LOOP
            lv_error_message := nvl(rec_rcpt_null_org.H_ORGANIZATION_NAME,'#NULL#') ||
               '"OPERATING_UNIT_NAME" value is not found or Invalid';
            xxctq_util_pkg.error_insert_proc (gv_ctq_data_set,
                                              rec_rcpt_null_org.batch_id,
                                              rec_rcpt_null_org.record_id,
                                              lv_error_message);
         END LOOP;

         ln_check_access := 2; -- ** Value "2" is for NULL Operating Unit it will Error out **
         --COMMIT;
      END IF;

      COMMIT;
      RETURN ln_check_access;
   EXCEPTION
      WHEN OTHERS
      THEN
         lv_error_message :=
               'Function "CHECK_OU_STATUS" raised the exception at =>'
            || ' SQLERRMSG => '
            || SUBSTR (SQLERRM, 1, 1950);
         xxctq_util_pkg.log_message (lv_error_message);
         ln_check_access := 3; -- Value "3" to Raise Unexpected error in the Main procedure **
         xxctq_util_pkg.log_message('EXCEPTION in delete_error_rec ');
         ROLLBACK;
         RETURN ln_check_access;
   END check_ou_status;


/*
   **  Object Name:        MAIN
   **  Description: This script is used as the main procedure of the Concurrent Program to load AR Cash Receipts through Classic Conversions
   **  Parameters:  in_batch_id = Batch ID to run the program
   **               iv_validate_import
   **               iv_email_address
   **  Run as:      APPS
   **  Keyword Tracking:
*/
    PROCEDURE main (
      o_err                OUT      VARCHAR2,
      o_ret_code           OUT      NUMBER,
      in_batch_id          IN       NUMBER,
      iv_validate_import   IN       VARCHAR2,
      iv_email_address     IN       VARCHAR2
   )
   IS
      lv_success               VARCHAR2 (1);
      ln_check_ou_status       NUMBER := NULL;

    BEGIN

        --delete exception details for the batch if we run again
        delete_error_rec(in_batch_id);

        -- Get total Counts
        BEGIN
         SELECT COUNT (*)
           INTO gn_total_count
           FROM XXCTQ_RECEPT_C_AR_RECEIPT                        ----EBR Section 26 Schema Reference Removal
          WHERE batch_id = in_batch_id;
        EXCEPTION
            WHEN OTHERS
            THEN
               xxctq_util_pkg.log_message(
                  'Issue to determine TOTAL count for Receipt Staging Table '
               || SQLERRM
              );
               gn_total_count := 0;
        END;


        IF gn_total_count > 0
          THEN
            -- Call Status Monitors
                xxctq_util_pkg.start_status_monitor (in_batch_id,
                                                    gn_request_id,
                                                    gv_ctq_data_set
                                                    );

            -- Print Glabal Variables
            BEGIN

                xxctq_util_pkg.log_message('gn_request_id : ' || gn_request_id);
                xxctq_util_pkg.log_message('gn_org_id : ' || gn_org_id);
                xxctq_util_pkg.log_message('gn_created_by : ' || gn_created_by);
            END;

            ln_check_ou_status := check_ou_status (in_batch_id);

            IF ln_check_ou_status = 0 -- ** Value "0" is for Success - To Move forward for Validate and Improt **
            THEN
                    xxctq_util_pkg.
                     log_message ('check_organization_access is passed ... ');

                    --Status Monitor Translation Running
                    BEGIN
                        xxctq_util_pkg.update_status_monitor(in_batch_id,
                                                            gn_request_id,
                                                            gv_ctq_data_set,
                                                            'Translation Running'
                                                            );
                    END;

                    -- Get Translations
                    xxctq_util_pkg.log_message(
                                '*****************************Translation Started Batch # : '
                                || in_batch_id
                                );

                    --END;

                    BEGIN
                        cash_rcpt_translate (in_batch_id);
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            xxctq_util_pkg.log_message(
                                        ' Issue in calling cash_rcpt_translate '
                                        || SQLERRM
                                      );
                        RAISE ge_abnormal_termination;
                    END;

                    xxctq_util_pkg.log_message(
                       '*****************************Translation Completed Batch # : '
                    || in_batch_id
                   );

                    -- Get total Valid Count for Total Receipt Records
                    BEGIN
                        SELECT COUNT (*)
                        INTO gn_valid_count
                        FROM XXCTQ_RECEPT_C_AR_RECEIPT                ----EBR Section 26 Schema Reference Removal
                        WHERE batch_id = in_batch_id
                        AND NVL(status, 'NEW') = 'VALID';
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            gn_valid_count := 0;
                    END;

                    -- Validate or Import
                    IF iv_validate_import = 'Validate and Import'
                    THEN
                        --Status Monitor Import Running
                        BEGIN
                            xxctq_util_pkg.update_status_monitor(    in_batch_id,
                                                                    gn_request_id,
                                                                    gv_ctq_data_set,
                                                                    'Import Running'
                                                                );
                        END;


                        BEGIN
                            r12_import (in_batch_id, lv_success);
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                xxctq_util_pkg.log_message(
                                            ' Issue in calling r12 import procedure '
                                            || SQLERRM
                                        );
                                RAISE ge_abnormal_termination;
                        END;

                    END IF; --iv_validate_import = 'Validate and Import'

                --Status Monitor
                BEGIN
                    xxctq_util_pkg.end_status_monitor (    in_batch_id,
                                                        gn_request_id,
                                                        gv_ctq_data_set
                                                    );

                END;

                -- Get All Counts for Header Table

                BEGIN
                    SELECT COUNT (*)
                      INTO gn_invalid_count
                      FROM XXCTQ_RECEPT_C_AR_RECEIPT                  ----EBR Section 26 Schema Reference Removal
                     WHERE batch_id = in_batch_id
                       AND NVL(status, 'NEW') = 'INVALID';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        xxctq_util_pkg.log_message(
                                    'Issue to determine INVALID count for Header Staging Table '
                                    || SQLERRM
                                );
                        gn_invalid_count := 0;
                END;

                BEGIN
                    SELECT COUNT (*)
                      INTO gn_error_count
                      FROM XXCTQ_RECEPT_C_AR_RECEIPT                  ----EBR Section 26 Schema Reference Removal
                     WHERE batch_id = in_batch_id
                       AND NVL(status, 'NEW') = 'ERROR';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        xxctq_util_pkg.log_message(
                                    'Issue to determine ERROR count for Receipt Staging Table '
                                    || SQLERRM
                                );
                        gn_error_count := 0;
                END;

                BEGIN
                    SELECT COUNT (*)
                      INTO gn_success_count
                      FROM XXCTQ_RECEPT_C_AR_RECEIPT                   ----EBR Section 26 Schema Reference Removal
                     WHERE batch_id = in_batch_id
                       AND NVL(status, 'NEW') = 'SUCCESS';
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        xxctq_util_pkg.log_message(
                                    'Issue to determine SUCCESS count for Receipt Staging Table '
                                    || SQLERRM
                                );
                        gn_success_count := 0;
                END;

                xxctq_util_pkg.log_message(
                 ' **************AR Cash Receipts Record Summary***********************'
                );
            xxctq_util_pkg.log_message( 'TOTAL   : ' || gn_total_count);
            xxctq_util_pkg.log_message( 'VALID : '   || gn_valid_count);
            xxctq_util_pkg.log_message( 'INVALID : ' || gn_invalid_count);
            xxctq_util_pkg.log_message( 'SUCCESS : ' || gn_success_count);
            xxctq_util_pkg.log_message( 'ERROR   : ' || gn_error_count);

                --Error Reporting
                BEGIN
                    xxctq_util_pkg.log_message(
                        '*****************************Error Extracting for AR Receipts....'
                        );
                    xxctq_util_pkg.log_message( '');
                    xxctq_util_pkg.log_message( '');
                    xxctq_util_pkg.log_message( '');
                    xxctq_util_pkg.log_message( '');
                    xxctq_util_pkg.log_message( '');
                    xxctq_util_pkg.xxctq_error_extract (gv_rep_errorbuf,
                                                        gv_rep_retcode,
                                                        in_batch_id,
                                                        gv_ctq_data_set,
                                                        gn_request_id,
                                                        iv_email_address
                                                        );
                    xxctq_util_pkg.log_message(
                                '*****************************Error Extraction Completed....'
                            );
                END;
            ELSIF ln_check_ou_status = 1 -- ** Value "1" is for program Warning - Suggestions for Switch Responsibility **
             THEN
                o_ret_code := 1;
             ELSIF ln_check_ou_status = 2 -- ** Value "2" is for NULL Operating Unit it will Error out **
             THEN
                o_ret_code := 2;                                          -- Error
                xxctq_util_pkg.xxctq_error_extract (gv_rep_errorbuf,
                                gv_rep_retcode,
                                in_batch_id,
                                gv_ctq_data_set,
                                gn_request_id,
                                iv_email_address);
             ELSIF ln_check_ou_status = 3 -- Value "3" to Raise Unexpected error in the Main procedure **
             THEN
                o_ret_code := 2;
             END IF; --ln_check_ou_status = 0
          ELSE
         xxctq_util_pkg.log_message ('No records to process');
          END IF;


    EXCEPTION
        WHEN ge_abnormal_termination
        THEN
            xxctq_util_pkg.log_message(
                                'Program terminated ABNORMALLY at: '
                                || SQLERRM
                            );
            xxctq_util_pkg.error_status_monitor (in_batch_id,
                                                gn_request_id,
                                                gv_ctq_data_set
                                                );
            o_ret_code := 2;
        WHEN OTHERS
        THEN
            xxctq_util_pkg.log_message(
                        'UnExpected Error Occured while creating AR Receipt '
                        || SQLERRM
                    );
            -- Call Status Monitors
            xxctq_util_pkg.error_status_monitor (in_batch_id,
                                                gn_request_id,
                                                gv_ctq_data_set
                                                );
            o_ret_code := 2;

    END main;


/*
**  Object Name:        R12_IMPORT
**  Description: This procedure is used to call the populate the record types for AR Receipts API and finally to submit it
**  Parameters:  in_batch_id -- Batch ID to load AR Receipts
**  Run as:      APPS
**  Keyword Tracking:
*/

    PROCEDURE r12_import (in_batch_id NUMBER, o_success OUT NOCOPY VARCHAR2)
    IS
        lv_return_status            VARCHAR2 (10);
        ln_msg_count                NUMBER;
        lv_msg_data                    VARCHAR2 (4000);
        ln_cr_id                    NUMBER; --Cash Receipt Id
        ln_amount                    NUMBER;
        lv_receipt_number             VARCHAR2(100);
        lv_currency                   VARCHAR2(10);
        --lv_receipt_method             VARCHAR2(40);
        ln_receipt_method_id        NUMBER;
        l_receipt_date               DATE;
        l_gl_date                    DATE;
        ln_destination_org_id         NUMBER;
        ln_cust_account               NUMBER;
        ln_cust_site_id               NUMBER;
        lv_comments                   VARCHAR2(2000);
        lv_err_msg                     VARCHAR2 (4000);
        e_error_assignment             EXCEPTION;
        lv_exchange_rate_type        VARCHAR2 (240);
        lv_exchange_rate             VARCHAR2 (240);
        l_exchange_date             DATE;
        lv_stmt                        VARCHAR2 (240);
        ln_on_account_amount        NUMBER;
        l_on_acc_applied_date        DATE;

        CURSOR cur_imp_rcpt_c
        IS
            SELECT     *
              FROM    XXCTQ_RECEPT_C_AR_RECEIPT                ----EBR Section 26 Schema Reference Removal
             WHERE    batch_id = in_batch_id
               AND    NVL(status, 'NEW') = 'VALID';

    BEGIN


        for rec_cur_imp_rcpt_c IN cur_imp_rcpt_c
        LOOP

            xxctq_util_pkg.log_message(
                                 ' API Call for  AR Receipt Orig Seq: '
                              || rec_cur_imp_rcpt_c.h_orig_system
                             );

            BEGIN

                xxctq_util_pkg.log_message('staging status -' || rec_cur_imp_rcpt_c.status);

                lv_stmt := '1.0 - lv_return_status ';
                lv_return_status           := NULL;
                lv_stmt := '1.0 - ln_msg_count ';
                ln_msg_count              := 0;
                lv_stmt := '1.0 - lv_msg_data ';
                lv_msg_data               := NULL;
                lv_stmt := '1.0 - ln_cr_id ';
                ln_cr_id                   := NULL;
                lv_stmt := '1.0 - lv_exchange_rate_type ';
                lv_exchange_rate_type      := rec_cur_imp_rcpt_c.H_EXCHANGE_RATE_TYPE;
                lv_stmt := '1.0 - lv_exchange_rate ';
                lv_exchange_rate           := rec_cur_imp_rcpt_c.H_EXCHANGE_RATE;
                lv_stmt := '1.0 - l_exchange_date ';
                l_exchange_date           := NULL;
                lv_stmt := '1.0 - ln_amount ';
                ----REG EXP Replace Added by Naresh on 10-Nov-14 to avoid COMMA in amount fields
                ln_amount                  := REGEXP_REPLACE(rec_cur_imp_rcpt_c.H_RECEIPT_AMOUNT,'([,])','');
                lv_stmt := '1.0 - lv_receipt_number ';
                lv_receipt_number          := rec_cur_imp_rcpt_c.H_RECEIPT_NUMBER;
                lv_stmt := '1.0 - lv_currency ';
                lv_currency                := rec_cur_imp_rcpt_c.H_CURRENCY_CODE;
                --lv_stmt := '1.0 - lv_receipt_method ';
                --lv_receipt_method          := rec_cur_imp_rcpt_c.H_RECEIPT_METHOD; --RECEIPT_METHOD_ID_tv;
                lv_stmt := '1.0 - ln_receipt_method_id ';
                ln_receipt_method_id        := rec_cur_imp_rcpt_c.RECEIPT_METHOD_ID_tv;
                lv_stmt := '1.0 - l_receipt_date ';
                l_receipt_date            := TO_DATE (rec_cur_imp_rcpt_c.H_RECEIPT_DATE, 'DD-MON-RRRR'); --rec_cur_imp_rcpt_c.H_RECEIPT_DATE; --
                                            --TO_CHAR(TRUNC(TO_DATE(rec_cur_imp_rcpt_c.H_RECEIPT_DATE,  'MM/DD/RRRR HH24:MI:SS') ), 'DD-MON-RRRR');
                lv_stmt := '1.0 - l_gl_date ';
                l_gl_date        := TO_DATE (rec_cur_imp_rcpt_c.H_GL_DATE,'DD-MON-RRRR'); --rec_cur_imp_rcpt_c.H_GL_DATE;
                                    --TO_CHAR(TRUNC(TO_DATE(rec_cur_imp_rcpt_c.H_GL_DATE,  'MM/DD/RRRR HH24:MI:SS') ), 'DD-MON-RRRR');
                lv_stmt := '1.0 - ln_destination_org_id ';
                ln_destination_org_id      := rec_cur_imp_rcpt_c.dest_org_id_tv;
                lv_stmt := '1.0 - ln_cust_account ';
                ln_cust_account            := rec_cur_imp_rcpt_c.CUST_ACCOUNT_ID_tv;
                lv_stmt := '1.0 - ln_cust_site_id ';
                ln_cust_site_id            := rec_cur_imp_rcpt_c.SITE_USE_ID_tv;
                lv_stmt := '1.0 - lv_comments ';
                lv_comments                := rec_cur_imp_rcpt_c.H_COMMENTS;
                lv_stmt := '1.0 - ln_on_account_amount ';
                ln_on_account_amount        := rec_cur_imp_rcpt_c.H_ON_ACCOUNT_AMOUNT;
                lv_stmt := '1.0 - l_on_acc_applied_date ';
                l_on_acc_applied_date    := TO_DATE (rec_cur_imp_rcpt_c.H_ON_ACCOUNT_APPLIED_DATE, 'DD-MON-RRRR');
                                            --TO_CHAR(TRUNC(TO_DATE(rec_cur_imp_rcpt_c.H_ON_ACCOUNT_APPLIED_DATE,  'MM/DD/RRRR HH24:MI:SS') ), 'DD-MON-RRRR');

                BEGIN


                    --apps.ar_receipt_api_pub.
                    create_cash (
                                    -- Standard API parameters.
                                    p_api_version                    => 1.0,
                                    p_init_msg_list                  => FND_API.G_TRUE,
                                    p_commit                         => FND_API.G_FALSE,
                                    p_validation_level               => FND_API.G_VALID_LEVEL_FULL,
                                    x_return_status                  => lv_return_status,
                                    x_msg_count                      => ln_msg_count,
                                    x_msg_data                       => lv_msg_data,
                                    -- Receipt info. parameters
                                    p_usr_currency_code              => NULL,
                                    --the translated currency code
                                    p_currency_code                  => lv_currency,
                                    p_usr_exchange_rate_type         => NULL,
                                    p_exchange_rate_type             => lv_exchange_rate_type,
                                    p_exchange_rate                  => lv_exchange_rate,
                                    p_exchange_rate_date             => l_exchange_date,
                                    p_amount                         => ln_amount,
                                    p_factor_discount_amount         => NULL,
                                    p_receipt_number                 => lv_receipt_number,
                                    p_receipt_date                   => l_receipt_date,
                                    p_gl_date                        => l_gl_date,
                                    p_maturity_date                  => NULL,
                                    p_postmark_date                  => NULL,
                                    p_customer_id                    => ln_cust_account,
                                    p_customer_name                  => NULL,
                                    p_customer_number                => NULL,
                                    p_customer_bank_account_id       => NULL,
                                    p_customer_bank_account_num      => NULL,
                                    p_customer_bank_account_name     => NULL,
                                    p_payment_trxn_extension_id      => NULL,
                                    --payment uptake changes bichatte
                                    p_location                       => NULL,
                                    p_customer_site_use_id           => ln_cust_site_id,
                                    p_default_site_use               => NULL,
                                    --bug4448307-4509459
                                    p_customer_receipt_reference     => NULL,
                                    p_override_remit_account_flag    => NULL,
                                    p_remittance_bank_account_id     => NULL,
                                    p_remittance_bank_account_num    => NULL,
                                    p_remittance_bank_account_name   => NULL,
                                    p_deposit_date                   => NULL,
                                    p_receipt_method_id              => ln_receipt_method_id,
                                    p_receipt_method_name            => NULL,
                                    p_doc_sequence_value             => NULL,
                                    p_ussgl_transaction_code         => NULL,
                                    p_anticipated_clearing_date      => NULL,
                                    p_called_from                    => NULL,
                                    p_attribute_rec                  => NULL,
                                    -- ******* Global Flexfield parameters *******
                                    p_global_attribute_rec           => NULL,
                                    p_comments                       => lv_comments,
                                    --   ***  Notes Receivable Additional Information  ***
                                    p_issuer_name                    => NULL,
                                    p_issue_date                     => NULL,
                                    p_issuer_bank_branch_id          => NULL,
                                    p_org_id                         => ln_destination_org_id,
                                    p_installment                    => NULL,
                                    --   ** OUT NOCOPY variables
                                    p_cr_id                          => ln_cr_id
                                );



                    xxctq_util_pkg.log_message(
                                             '**********New AR Cash Receipt ID : '
                                          || ln_cr_id
                                         );
                    xxctq_util_pkg.log_message(
                                         '*********Return Status create_cash: '
                                      || lv_return_status
                                     );
                    xxctq_util_pkg.log_message(
                                      'ln_msg_count :  ' || ln_msg_count
                                     );
                    xxctq_util_pkg.log_message(
                                      'lv_msg_data : ' || lv_msg_data
                                    );


                    IF (lv_return_status = gv_success)
                    THEN

                        IF     rec_cur_imp_rcpt_c.H_ON_ACCOUNT_AMOUNT IS NOT NULL
                            OR rec_cur_imp_rcpt_c.H_ON_ACCOUNT_AMOUNT != 0
                        THEN

                            BEGIN

                                apply_on_account( p_api_version                => 1.0,
                                                  p_init_msg_list            => FND_API.G_TRUE,
                                                  p_commit                    => FND_API.G_TRUE,
                                                  p_validation_level        => FND_API.G_VALID_LEVEL_FULL,
                                                  x_return_status            => lv_return_status,
                                                  x_msg_count                => ln_msg_count,
                                                  x_msg_data                => lv_msg_data,
                                                  --  Receipt application parameters.
                                                  p_cash_receipt_id            => ln_cr_id,
                                                  p_receipt_number            => NULL, --lv_receipt_number,
                                                  p_amount_applied            => ln_on_account_amount,
                                                  p_apply_date                => l_on_acc_applied_date,
                                                  p_apply_gl_date            => l_gl_date,
                                                  p_ussgl_transaction_code    => NULL,
                                                  p_attribute_rec            => NULL,
                                                  -- ******* Global Flexfield parameters *******
                                                  p_global_attribute_rec    => NULL,
                                                  p_comments                => lv_comments,
                                                  p_application_ref_num        => NULL,
                                                  p_secondary_application_ref_id    => NULL,
                                                  p_customer_reference        => NULL,
                                                  p_called_from                => NULL,
                                                  p_customer_reason            => NULL,
                                                  p_secondary_app_ref_type    => NULL,
                                                  p_secondary_app_ref_num    => NULL,
                                                  p_org_id                    => ln_destination_org_id
                                             );



                                xxctq_util_pkg.log_message(
                                                     '********* apply_on_account Return Status : '
                                                  || lv_return_status
                                                 );
                                xxctq_util_pkg.log_message(
                                                  'ln_msg_count :  ' || ln_msg_count
                                                 );
                                xxctq_util_pkg.log_message(
                                                  'lv_msg_data : ' || lv_msg_data
                                                 );

                                IF (lv_return_status = gv_success)
                                THEN

                                    update_success_error_records
                                                             (rec_cur_imp_rcpt_c.batch_id,
                                                              rec_cur_imp_rcpt_c.record_id,
                                                              rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                                              'SUCCESS',
                                                             ln_cr_id
                                                             --0
                                                             );

                                    o_success := 'S';
                                ELSE
                                    ROLLBACK;
                                    o_success := 'E';
                                    xxctq_util_pkg.log_message (lv_msg_data);
                                    lv_err_msg :=
                                               'UnExpected Error Occured after calling apply_on_account. API Error - ' || lv_msg_data;
                                               --|| SQLERRM;
                                    xxctq_util_pkg.error_insert_proc (    gv_ctq_data_set,
                                                                    rec_cur_imp_rcpt_c.batch_id,
                                                                    rec_cur_imp_rcpt_c.record_id,
                                                                    lv_err_msg
                                                                );

                                    update_success_error_records (    rec_cur_imp_rcpt_c.batch_id,
                                                                    rec_cur_imp_rcpt_c.record_id,
                                                                    rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                                                    'ERROR',
                                                                    NULL
                                                                );

                                END IF;    --(lv_return_status = gv_success)

                            EXCEPTION
                                WHEN OTHERS
                                THEN
                                    ROLLBACK;
                                    o_success := 'E';
                                    xxctq_util_pkg.log_message (
                                               'UnExpected Error Occured while calling to create apply_on_account '
                                               || SQLERRM);
                                    lv_err_msg :=
                                               'UnExpected Error Occured while calling to create apply_on_account '
                                               || SQLERRM;
                                    xxctq_util_pkg.error_insert_proc (    gv_ctq_data_set,
                                                                    rec_cur_imp_rcpt_c.batch_id,
                                                                    rec_cur_imp_rcpt_c.record_id,
                                                                    lv_err_msg
                                                                );

                                    update_success_error_records (    rec_cur_imp_rcpt_c.batch_id,
                                                                    rec_cur_imp_rcpt_c.record_id,
                                                                    rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                                                    'ERROR',
                                                                    NULL
                                                                );

                            END;

                        ELSE
                            xxctq_util_pkg.log_message (
                                       'Created unapplied AR Cash Receipt with Cash Receipt ID '||ln_cr_id);
                            update_success_error_records
                                                                 (rec_cur_imp_rcpt_c.batch_id,
                                                                  rec_cur_imp_rcpt_c.record_id,
                                                                  rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                                                  'SUCCESS',
                                                                 ln_cr_id
                                                                 --0
                                                                 );

                            o_success := 'S';
                            COMMIT;

                        END IF;    --rec_cur_imp_rcpt_c.H_ON_ACCOUNT_AMOUNT IS NOT NULL OR rec_cur_imp_rcpt_c.H_ON_ACCOUNT_AMOUNT != 0

                    ELSE
                        ROLLBACK;
                        o_success := 'E';
                        xxctq_util_pkg.log_message (
                                   lv_msg_data
                                   );
                        lv_err_msg :=
                                   'UnExpected Error Occured after calling create_cash. API Error - ' || lv_msg_data;
                                   --|| SQLERRM;
                        xxctq_util_pkg.error_insert_proc (    gv_ctq_data_set,
                                                        rec_cur_imp_rcpt_c.batch_id,
                                                        rec_cur_imp_rcpt_c.record_id,
                                                        lv_err_msg
                                                    );

                        update_success_error_records (    rec_cur_imp_rcpt_c.batch_id,
                                                        rec_cur_imp_rcpt_c.record_id,
                                                        rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                                        'ERROR',
                                                        NULL
                                                    );
                    END IF;    --(lv_return_status <> gv_success)

                EXCEPTION
                    WHEN OTHERS
                    THEN
                        xxctq_util_pkg.log_message(
                                'UnExpected Error Occured while creating AR Receipt. ' || lv_msg_data
                                || SQLERRM
                                );
                        lv_err_msg :=
                            (   'UnExpected Error Occured while creating AR Receipt ' || lv_msg_data
                            || SQLERRM
                            );
                        ROLLBACK;
                        o_success := 'E';

                        xxctq_util_pkg.error_insert_proc (gv_ctq_data_set,
                                                rec_cur_imp_rcpt_c.batch_id,
                                                rec_cur_imp_rcpt_c.record_id,
                                                lv_err_msg
                                               );

                        update_success_error_records (rec_cur_imp_rcpt_c.batch_id,
                                            rec_cur_imp_rcpt_c.record_id,
                                            rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                            'ERROR',
                                            NULL
                                            );
                END;

                xxctq_util_pkg.log_message(
                                       ' Processing Completed for Receipt '
                                    || rec_cur_imp_rcpt_c.record_id
                                   );
            EXCEPTION
                WHEN e_error_assignment
                THEN
                    lv_err_msg:= 'During API call - Error in Assignment of '
                                                || ' Level '
                                                || lv_stmt || ' ' || SQLERRM;
                    xxctq_util_pkg.error_insert_proc (gv_ctq_data_set,
                                                rec_cur_imp_rcpt_c.batch_id,
                                                rec_cur_imp_rcpt_c.record_id,
                                                lv_err_msg
                                               );
                    update_success_error_records (rec_cur_imp_rcpt_c.batch_id,
                                            rec_cur_imp_rcpt_c.record_id,
                                            rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                            'ERROR',
                                            NULL
                                           );
                    xxctq_util_pkg.log_message (
                                 ' Record Not found to process for Record ID : '
                              || rec_cur_imp_rcpt_c.record_id
                              || ' Batch ID : '
                              || rec_cur_imp_rcpt_c.batch_id);
                       xxctq_util_pkg.log_message(
                                                   ' During API call - Error in Assignment of '
                                                || ' Level '
                                                || lv_stmt
                                                || ' for header record id '
                                                || rec_cur_imp_rcpt_c.record_id
                                                || ' - Moving to Next Record '
                                               );

                --Added by Naresh on 10-Nov-14 to avoid abnormal termination and continue for next record
                WHEN others THEN
                    lv_err_msg:= 'During API call - Error in Assignment of '
                                                || ' Level '
                                                || lv_stmt || ' ' || SQLERRM;
                    xxctq_util_pkg.error_insert_proc (gv_ctq_data_set,
                                                rec_cur_imp_rcpt_c.batch_id,
                                                rec_cur_imp_rcpt_c.record_id,
                                                lv_err_msg
                                               );
                    update_success_error_records (rec_cur_imp_rcpt_c.batch_id,
                                            rec_cur_imp_rcpt_c.record_id,
                                            rec_cur_imp_rcpt_c.H_ORIG_SYSTEM,
                                            'ERROR',
                                            NULL
                                           );
                    xxctq_util_pkg.log_message (
                                 ' Record Not found to process for Record ID : '
                              || rec_cur_imp_rcpt_c.record_id
                              || ' Batch ID : '
                              || rec_cur_imp_rcpt_c.batch_id);
                       xxctq_util_pkg.log_message(
                                                   ' During API call - Error in Assignment of '
                                                || ' Level '
                                                || lv_stmt
                                                || ' for header record id '
                                                || rec_cur_imp_rcpt_c.record_id
                                                || ' - Moving to Next Record '
                                               );
            END;

        END LOOP;    --rec_cur_imp_rcpt_c IN cur_imp_rcpt_c

    EXCEPTION
        WHEN OTHERS
        THEN
            xxctq_util_pkg.log_message(
                                  ' Issue in r12_import  Level '
                                                || lv_stmt || ' ' ||SQLERRM
                                 );
            RAISE ge_abnormal_termination;
    END r12_import;


/*
**  Object Name:        update_success_error_records
**  Description: This procedure is used to update records in staging table for AR Receipts
**  Parameters:  in_batch_id :- Batch ID
                  in_record_id :- record ID
                  iv_orig_reference :-  orig_reference
                  iv_status :- to mark the staging as Success or Error
**  Run as:      APPS
**  Keyword Tracking:
*/
   PROCEDURE update_success_error_records (
      in_batch_id         IN   NUMBER,
      in_record_id        IN   NUMBER,
      iv_orig_reference   IN   VARCHAR2,
      iv_status           IN   VARCHAR2,
      in_cr_id       IN   NUMBER
   --in_rel_party_id   IN   NUMBER
   )
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      UPDATE     XXCTQ_RECEPT_C_AR_RECEIPT                     ----EBR Section 26 Schema Reference Removal
         SET     status = iv_status,
                 last_updated_by = gn_created_by,
                 last_update_date = SYSDATE,
                x_cash_receipt_id = in_cr_id
       WHERE     h_orig_system = iv_orig_reference
         AND     batch_id = in_batch_id
         and    record_id = in_record_id;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         xxctq_util_pkg.log_message('EXCEPTION in update_success_error_records ');
         xxctq_util_pkg.error_insert_proc
                  (gv_ctq_data_set,
                   in_batch_id,
                   in_record_id,
                   'UnExpected Error Occured while updating Success Status. '
                  );
         ROLLBACK;
   END update_success_error_records;

/*
**  Object Name:        update_rcpt_translated_values
**  Description: This procedure is used to update AR Cash Receipts Staging Table with the translated values
**  Parameters:  ir_cash_rcpt_rec :- record type of  AR Receipts staging
**  Run as:      APPS
**  Keyword Tracking:
*/

    PROCEDURE update_rcpt_translated_values (
            ir_cash_rcpt_rec   IN   XXCTQ_RECEPT_C_AR_RECEIPT%ROWTYPE            ----EBR Section 26 Schema Reference Removal
        )
        IS
          PRAGMA AUTONOMOUS_TRANSACTION;

        BEGIN

            UPDATE    XXCTQ_RECEPT_C_AR_RECEIPT                      ----EBR Section 26 Schema Reference Removal
            SET    status = ir_cash_rcpt_rec.status,
                CUST_ACCOUNT_ID_tv = ir_cash_rcpt_rec.CUST_ACCOUNT_ID_tv,
                SITE_USE_ID_tv = ir_cash_rcpt_rec.SITE_USE_ID_tv,
                last_updated_by = gn_created_by,
                last_update_date = TRUNC (SYSDATE)
            WHERE     record_id = ir_cash_rcpt_rec.record_id
            AND     batch_id = ir_cash_rcpt_rec.batch_id;

            COMMIT;

        EXCEPTION
        WHEN OTHERS THEN
             xxctq_util_pkg.log_message(
                    'UnExpected Error Occured while updating AR Cash Receipt Translated Values'
                 || SQLERRM
                );
             xxctq_util_pkg.error_insert_proc
                (gv_ctq_data_set,
                 ir_cash_rcpt_rec.batch_id,
                 ir_cash_rcpt_rec.record_id,
                    'UnExpected Error Occured while updating AR Cash Receipt Translated Values. '
                 || SQLERRM
                );
             ROLLBACK;
       END update_rcpt_translated_values;

    PROCEDURE  mass_upd_rcpt_method (in_batch_id IN NUMBER)
    IS
        CURSOR cur_mass_upd
        IS
            SELECT H_RECEIPT_METHOD
              FROM XXCTQ_RECEPT_C_AR_RECEIPT
             WHERE batch_id = in_batch_id
          GROUP BY H_RECEIPT_METHOD ;

    ln_rec_value VARCHAR2(100);
    lv_rec_error_msg VARCHAR2(1000);

    BEGIN

        xxctq_util_pkg.update_status_monitor (in_batch_id,
                                  gn_request_id,
                                  gv_ctq_data_set,
                                  'Traslating RECEIPT_METHOD');

        FOR rec_mass_upd in cur_mass_upd
        LOOP
            ln_rec_value:= '';
            lv_rec_error_msg := NULL;

            IF rec_mass_upd.H_RECEIPT_METHOD IS NOT NULL
            THEN

                BEGIN
                    SELECT RECEIPT_METHOD_ID
                    INTO ln_rec_value
                    FROM AR_RECEIPT_METHODS
                    WHERE UPPER(NAME) = UPPER(rec_mass_upd.H_RECEIPT_METHOD)
                    AND NVL(END_DATE, SYSDATE) >= SYSDATE;
                    --xxctq_util_pkg.log_message (ln_rec_value);
                EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                        ln_rec_value := '#INVALID#';
                        lv_rec_error_msg := '"RECEIPT_METHOD" value is not found in Oracle';
                        xxctq_util_pkg.log_message (lv_rec_error_msg);
                    WHEN OTHERS
                    THEN
                        ln_rec_value := '#INVALID#';
                        lv_rec_error_msg := 'Oracle Exception while translating RECEIPT_METHOD => '
                                    || ' SQLERRMSG => '
                                    || SUBSTR (SQLERRM, 1, 1950);
                        xxctq_util_pkg.log_message (lv_rec_error_msg);
                END;
            /* ELSE
                ln_rec_value := 0;
                lv_rec_error_msg := '"RECEIPT_METHOD" value is not provided in data file';
                xxctq_util_pkg.log_message (lv_rec_error_msg); */
            END IF;

            /* IF ln_rec_value IN (0, -999)
            THEN
                lv_rec_error_msg := 'Invalid H_RECEIPT_METHOD ->'|| rec_mass_upd.H_RECEIPT_METHOD;
                xxctq_util_pkg.log_message (lv_rec_error_msg);
            END IF; */

            UPDATE XXCTQ_RECEPT_C_AR_RECEIPT
            SET RECEIPT_METHOD_ID_tv = DECODE(ln_rec_value, '#INVALID#', -999, ln_rec_value),
                last_update_date = sysdate,
                last_updated_by = gn_user_id
            WHERE H_RECEIPT_METHOD = rec_mass_upd.H_RECEIPT_METHOD
            AND batch_id = in_batch_id;

            --END IF;

        END LOOP;

        COMMIT;

    EXCEPTION
        WHEN OTHERS
        THEN
            xxctq_util_pkg.log_message ('Un-expected Error in mass_upd_rcpt_method '||substr(SQLERRM,1,120));
            ROLLBACK;

    END mass_upd_rcpt_method;

/*
**  Object Name:        cash_rcpt_translate
**  Description: This procedure is used translate Cash Receipts records
**  Parameters:  p_batch_id IN => Batch ID to process the conversion
**  Run as:      APPS
**  Keyword Tracking:
*/

   PROCEDURE cash_rcpt_translate (in_batch_id IN NUMBER)
   AS
      /*********************Translation Procedure********************************/

    lv_error_message                VARCHAR2 (4000);
    lr_cash_rcpt_rec                   XXCTQ_RECEPT_C_AR_RECEIPT%ROWTYPE;      ----EBR Section 26 Schema Reference Removal
    ln_RECEIPT_METHOD_ID            NUMBER;
    lv_CURRENCY_CODE                VARCHAR2(10);
    ln_CUST_ACCOUNT_ID                NUMBER;
    ln_SITE_USE_ID                    NUMBER;
    ln_CASH_RECEIPT_ID                NUMBER;
    ln_orig_system_valid            NUMBER;
    lv_exchange_rate_type_valid        VARCHAR2 (1);
    lv_cust_num                       VARCHAR2(200);
    ln_customer_id                    NUMBER;
    ln_cust_site_id                   NUMBER;

      CURSOR cur_cash_rcpt_c
      IS
            SELECT *
            FROM    XXCTQ_RECEPT_C_AR_RECEIPT                   ----EBR Section 26 Schema Reference Removal
            WHERE    batch_id = in_batch_id
            and    NVL(Status, 'NEW') <> 'SUCCESS';

    BEGIN

        gv_stmt := '20';
        ln_RECEIPT_METHOD_ID        := NULL;
        lv_CURRENCY_CODE        := NULL;
        ln_CUST_ACCOUNT_ID        := NULL;
        ln_SITE_USE_ID            := NULL;
        ln_CASH_RECEIPT_ID        := NULL;
        ln_orig_system_valid        := NULL;
        lv_exchange_rate_type_valid    := NULL;


        --- Mass Update procedure for H_RECEIPT_METHOD
        mass_upd_rcpt_method(in_batch_id);


        FOR rec_cash_rcpt_c IN cur_cash_rcpt_c
        LOOP

            gv_stmt := '20.0';
            BEGIN

                xxctq_util_pkg.log_message(
                                 'Translaton Started for AR Cash Receipts Record ID:  '
                              || rec_cash_rcpt_c.record_id
                             );
                lv_error_message := '';
                lr_cash_rcpt_rec.status := 'VALID';
                lr_cash_rcpt_rec.record_id := rec_cash_rcpt_c.record_id;
                lr_cash_rcpt_rec.batch_id := rec_cash_rcpt_c.batch_id;




                /*===============================Begin of Translations===================================*/

                --H_RECEIPT_METHOD
                IF rec_cash_rcpt_c.H_RECEIPT_METHOD IS NULL
                THEN
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_METHOD" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';
                    XXCTQ_UTIL_PKG.log_message (lv_error_message);
                ELSIF rec_cash_rcpt_c.RECEIPT_METHOD_ID_tv = -999
                THEN
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_METHOD" value is not found or exception occurred in Oracle';
                    lr_cash_rcpt_rec.status := 'INVALID';
                    XXCTQ_UTIL_PKG.log_message (lv_error_message);
                END IF;


                /* IF rec_cash_rcpt_c.RECEIPT_METHOD_ID_tv = -999
                THEN
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_METHOD" value is not found or exception occurred in Oracle';
                    lr_cash_rcpt_rec.status := 'INVALID';

                    xxctq_util_pkg.log_message (lv_error_message);
                ELSIF     rec_cash_rcpt_c.RECEIPT_METHOD_ID_tv = 0
                THEN
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_METHOD" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';

                END IF; */

                IF rec_cash_rcpt_c.H_RECEIPT_DATE IS NULL
                THEN

                    gv_stmt := '20.3';
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_DATE" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';

                END IF; --rec_cash_rcpt_c.H_RECEIPT_DATE

                IF rec_cash_rcpt_c.H_GL_DATE IS NULL
                THEN

                    gv_stmt := '20.4';
                    lv_error_message := lv_error_message||'~'||
                            '"GL_DATE" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';

                END IF; --rec_cash_rcpt_c.H_GL_DATE

                IF rec_cash_rcpt_c.H_CURRENCY_CODE IS NOT NULL
                THEN

                    gv_stmt := '20.5';

                    BEGIN
                        SELECT CURRENCY_CODE
                        INTO lv_CURRENCY_CODE --lr_cash_rcpt_rec.CURRENCY_CODE_tv
                        FROM FND_CURRENCIES
                        WHERE ENABLED_FLAG = 'Y'
                        AND NVL(END_DATE_ACTIVE, SYSDATE+1) > SYSDATE
                        AND  CURRENCY_CODE = rec_cash_rcpt_c.H_CURRENCY_CODE;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                    '"CURRENCY_CODE" value is not found in Oracle';
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);

                        WHEN OTHERS
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                    'Oracle Exception while translating CURRENCY_CODE at gv_stmt => '
                                    || gv_stmt
                                    || ' SQLCODE :'
                                    || SQLCODE
                                    || ' SQLERRMSG => '
                                    || SUBSTR (SQLERRM, 1, 1950);
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);

                    END;
                ELSE
                    --lr_cash_rcpt_rec.CURRENCY_CODE_tv := NULL;
                    lv_error_message := lv_error_message||'~'||
                            '"CURRENCY_CODE" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';
                END IF; --rec_cash_rcpt_c.H_CURRENCY_CODE

                IF rec_cash_rcpt_c.H_RECEIPT_AMOUNT IS NULL
                THEN

                    gv_stmt := '20.6';
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_AMOUNT" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';

                END IF; --rec_cash_rcpt_c.H_RECEIPT_AMOUNT

                IF rec_cash_rcpt_c.H_CUSTOMER_NUMBER IS NOT NULL
                THEN

                    gv_stmt := '20.7';

                    --ln_customer_id  := NULL;
                    lv_cust_num     := NULL;

                    BEGIN
                        xxctq_util_pkg.get_r12_supplier_cust(iv_supp_cust_mode       => 'CUSTOMER',
                                                            iv_system_name        => rec_cash_rcpt_c.H_ORIG_SYSTEM,
                                                            iv_leg_supp_cust      => rec_cash_rcpt_c.H_CUSTOMER_NUMBER,
                                                            o_supp_cust_id        => lr_cash_rcpt_rec.CUST_ACCOUNT_ID_tv,
                                                            o_supp_cust_num       => lv_cust_num
                                                          );

                        IF lr_cash_rcpt_rec.CUST_ACCOUNT_ID_tv <= 0
                        THEN
                            lv_error_message := lv_error_message || '~' ||
                                                'Return Value: '||lr_cash_rcpt_rec.CUST_ACCOUNT_ID_tv||' Invalid Customer: System: '
                                                ||rec_cash_rcpt_c.h_orig_system||' Cust_Num: '||rec_cash_rcpt_c.H_CUSTOMER_NUMBER || '"CUSTOMER_NUMBER" value is not found in Oracle';
                            lr_cash_rcpt_rec.status := 'INVALID';
                            xxctq_util_pkg.log_message (lv_error_message);
                        ELSE
                            xxctq_util_pkg.log_message('CustomerID: '||lr_cash_rcpt_rec.CUST_ACCOUNT_ID_tv||' CustomerNum: '||lv_cust_num||
                                                'Valid Customer: System: ' ||rec_cash_rcpt_c.h_orig_system||' Cust_Num: '||rec_cash_rcpt_c.H_CUSTOMER_NUMBER);

                        END IF; --lr_cash_rcpt_rec.CUST_ACCOUNT_ID_tv <= 0
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                        'Oracle Exception while translating CUSTOMER_NUMBER at gv_stmt => '
                                        || gv_stmt
                                        || ' SQLCODE :'
                                        || SQLCODE
                                        || ' SQLERRMSG => '
                                        || SUBSTR (SQLERRM, 1, 1950);
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);
                    END;

                ELSE
                    lr_cash_rcpt_rec.CUST_ACCOUNT_ID_tv := NULL;
                    lv_error_message := lv_error_message||'~'||
                            '"CUSTOMER_NUMBER" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';

                END IF; --rec_cash_rcpt_c.H_CUSTOMER_NUMBER

                IF rec_cash_rcpt_c.H_CUSTOMER_LOCATION IS NOT NULL
                THEN

                    gv_stmt := '20.8';

                    ln_customer_id  := NULL;
                    ln_cust_site_id := NULL;

                    BEGIN
                        xxctq_util_pkg.get_r12_cust_site(   iv_system_name         => rec_cash_rcpt_c.H_ORIG_SYSTEM,
                                                            iv_leg_customer        => rec_cash_rcpt_c.H_CUSTOMER_NUMBER,
                                                            iv_leg_cust_site       => rec_cash_rcpt_c.H_CUSTOMER_LOCATION,
                                                            iv_site_purpose        => 'BILL_TO',--SHIP_TO,
                                                            in_org_id              => rec_cash_rcpt_c.DEST_ORG_ID_TV,--736,--94,
                                                            o_cust_acct_id         => ln_customer_id,
                                                            o_cust_acct_site_id    => ln_cust_site_id,
                                                            o_site_use_id          => lr_cash_rcpt_rec.SITE_USE_ID_tv
                                                            );
                        IF ln_customer_id <= 0  THEN
                            lv_error_message := lv_error_message || '~' ||'Return Value: '||ln_customer_id||' Invalid Customer: System: '
                                                ||rec_cash_rcpt_c.h_orig_system||' Cust_Num: '||rec_cash_rcpt_c.H_CUSTOMER_NUMBER ||' Site: '||rec_cash_rcpt_c.H_CUSTOMER_LOCATION ||'"CUSTOMER_LOCATION" value is not found in Oracle';
                            lr_cash_rcpt_rec.status := 'INVALID';
                            xxctq_util_pkg.log_message (lv_error_message);
                        ELSE
                            xxctq_util_pkg.log_message ('CustomerID: '||ln_customer_id
                                                ||' Cust Site ID: '||ln_cust_site_id|| ' Site Use ID: '||  lr_cash_rcpt_rec.SITE_USE_ID_tv
                                                ||' Valid Customer: System: ' ||rec_cash_rcpt_c.h_orig_system||' Cust_Num: '||rec_cash_rcpt_c.H_CUSTOMER_NUMBER
                                                ||' Site: '||rec_cash_rcpt_c.H_CUSTOMER_LOCATION);

                        END IF;
                    EXCEPTION
                        WHEN OTHERS
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                        'Oracle Exception while translating CUSTOMER_LOCATION at gv_stmt => '
                                        || gv_stmt
                                        || ' SQLCODE :'
                                        || SQLCODE
                                        || ' SQLERRMSG => '
                                        || SUBSTR (SQLERRM, 1, 1950);
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);
                    END;

                ELSE
                    lr_cash_rcpt_rec.SITE_USE_ID_tv := NULL;
                    lv_error_message := lv_error_message||'~'||
                            '"CUSTOMER_LOCATION" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';
                END IF; --rec_cash_rcpt_c.H_CUSTOMER_LOCATION

                IF rec_cash_rcpt_c.H_RECEIPT_NUMBER IS NOT NULL
                THEN

                    gv_stmt := '20.9';

                    BEGIN
                        SELECT     CASH_RECEIPT_ID
                        INTO     ln_CASH_RECEIPT_ID --lr_cash_rcpt_rec.CASH_RECEIPT_ID_tv
                        FROM     AR_CASH_RECEIPTS_ALL ARC
                        WHERE      RECEIPT_NUMBER = rec_cash_rcpt_c.H_RECEIPT_NUMBER
                        AND      CUSTOMER_SITE_USE_ID = (
                                            SELECT     HCSU.SITE_USE_ID
                                            FROM     HZ_CUST_SITE_USES_ALL HCSU,
                                                HZ_CUST_ACCT_SITES_ALL HCAS,
                                                HZ_CUST_ACCOUNTS HCA,
                                                HZ_PARTIES HP
                                            WHERE HCSU.SITE_USE_CODE = 'BILL_TO'
                                            AND HCSU.LOCATION = rec_cash_rcpt_c.H_CUSTOMER_LOCATION
                                            AND HCSU.CUST_ACCT_SITE_ID = HCAS.CUST_ACCT_SITE_ID
                                            AND HCAS.CUST_ACCOUNT_ID = HCA.CUST_ACCOUNT_ID
                                            AND HCA.PARTY_ID = HP.PARTY_ID
                                            AND HCSU.ORG_ID = lr_cash_rcpt_rec.DEST_ORG_ID_TV --gn_org_id --APPLD_GLOBAL_REC.GLOBAL_ORGA_ID
                                            AND HP.STATUS = 'A'
                                            AND HCA.STATUS = 'A'
                                            AND HCA.ACCOUNT_NUMBER = rec_cash_rcpt_c.H_CUSTOMER_NUMBER
                                        )
                        AND     RECEIPT_DATE = --TO_CHAR(TRUNC(TO_DATE(rec_cash_rcpt_c.H_RECEIPT_DATE,  'MM/DD/RRRR HH24:MI:SS') ), 'DD-MON-RRRR')
                                                TO_DATE(rec_cash_rcpt_c.H_RECEIPT_DATE, 'DD-MON-RRRR')
                                                --rec_cash_rcpt_c.H_RECEIPT_DATE
                        AND     AMOUNT = rec_cash_rcpt_c.H_RECEIPT_AMOUNT;

                        IF ln_CASH_RECEIPT_ID IS NOT NULL
                        THEN

                            lv_error_message := lv_error_message||'~'||
                                    '"RECEIPT_NUMBER" value is already in Oracle which is invalid';
                            lr_cash_rcpt_rec.status := 'INVALID';

                        END IF;

                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            /* lv_error_message := lv_error_message||'~'||
                                    '"RECEIPT_NUMBER" value is not found in Oracle which means new record'; */
                            xxctq_util_pkg.log_message ('"RECEIPT_NUMBER" value is not found in Oracle which means new record');

                        WHEN OTHERS
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                    'Oracle Exception while translating RECEIPT_NUMBER at gv_stmt => '
                                    || gv_stmt
                                    || ' SQLCODE :'
                                    || SQLCODE
                                    || ' SQLERRMSG => '
                                    || SUBSTR (SQLERRM, 1, 1950);
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);

                    END;
                ELSE
                    --lr_cash_rcpt_rec.CASH_RECEIPT_ID_tv := NULL;
                    lv_error_message := lv_error_message||'~'||
                            '"RECEIPT_NUMBER" value is not provided in data file';
                    lr_cash_rcpt_rec.status := 'INVALID';
                END IF; --rec_cash_rcpt_c.H_RECEIPT_NUMBER

                IF     rec_cash_rcpt_c.H_EXCHANGE_RATE_TYPE IS NOT NULL
                THEN

                    gv_stmt := '20.10';

                    BEGIN

                        SELECT     'Y' --CONVERSION_TYPE
                        INTO    lv_exchange_rate_type_valid --lr_cash_rcpt_rec.EXCHANGE_RATE_TYPE_tv
                        FROM     GL_DAILY_CONVERSION_TYPES
                        WHERE     CONVERSION_TYPE = rec_cash_rcpt_c.H_EXCHANGE_RATE_TYPE;

                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                    '"EXCHANGE_RATE_TYPE" value is not found in Oracle';
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);

                        WHEN OTHERS
                        THEN
                            lv_error_message := lv_error_message||'~'||
                                    'Oracle Exception while translating EXCHANGE_RATE_TYPE at gv_stmt => '
                                    || gv_stmt
                                    || ' SQLCODE :'
                                    || SQLCODE
                                    || ' SQLERRMSG => '
                                    || SUBSTR (SQLERRM, 1, 1950);
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);

                    END;

                    IF lv_exchange_rate_type_valid = 'Y'
                    THEN

                        IF (UPPER (rec_cash_rcpt_c.H_EXCHANGE_RATE_TYPE) = 'USER' AND rec_cash_rcpt_c.H_EXCHANGE_RATE IS NOT NULL)
                            OR (UPPER(rec_cash_rcpt_c.H_EXCHANGE_RATE_TYPE) != 'USER' AND rec_cash_rcpt_c.H_EXCHANGE_RATE IS NULL)
                        THEN
                            xxctq_util_pkg.log_message ('H_EXCHANGE_RATE_TYPE and H_EXCHANGE_RATE combination is valid.');
                        ELSE
                            lv_error_message := lv_error_message||'~'||
                                    '"EXCHANGE_RATE_TYPE" and EXCHANGE_RATE combination is not valid';
                            lr_cash_rcpt_rec.status := 'INVALID';

                            xxctq_util_pkg.log_message (lv_error_message);

                        END IF;

                    END IF; --lv_exchange_rate_type_valid = 'Y'


                END IF; --rec_cash_rcpt_c.H_EXCHANGE_RATE_TYPE

                IF rec_cash_rcpt_c.H_ORIG_SYSTEM IS NOT NULL
                THEN

                    gv_stmt := '20.12';

                    IF rec_cash_rcpt_c.H_ORIG_SYSTEM != 'R12'
                    THEN
                        BEGIN
                            select     1
                            INTO     ln_orig_system_valid
                            from     HZ_ORIG_SYSTEMS_B
                            where     ORIG_SYSTEM = rec_cash_rcpt_c.H_ORIG_SYSTEM;
                        EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                                lv_error_message := lv_error_message||'~'||
                                        '"ORIG_SYSTEM" value is not found in Oracle';
                                lr_cash_rcpt_rec.status := 'INVALID';

                                xxctq_util_pkg.log_message (lv_error_message);
                            WHEN OTHERS
                            THEN
                                lv_error_message := lv_error_message||'~'||
                                        'Oracle Exception while translating ORIG_SYSTEM at gv_stmt => '
                                        || gv_stmt
                                        || ' SQLCODE :'
                                        || SQLCODE
                                        || ' SQLERRMSG => '
                                        || SUBSTR (SQLERRM, 1, 1950);
                                lr_cash_rcpt_rec.status := 'INVALID';

                                xxctq_util_pkg.log_message (lv_error_message);

                        END;
                    END IF; --rec_cash_rcpt_c.H_ORIG_SYSTEM != 'R12'

                ELSE

                    lv_error_message := lv_error_message||'~'||
                            '"ORIG_SYSTEM" value is not found in Oracle';
                    lr_cash_rcpt_rec.status := 'INVALID';

                END IF; --rec_cash_rcpt_c.H_ORIG_SYSTEM

                xxctq_util_pkg.log_message(
                                  ' rec_cash_rcpt_c.record_id '
                               || rec_cash_rcpt_c.record_id
                               || ', '
                               || 'lr_cash_rcpt_rec.status : '
                               || lr_cash_rcpt_rec.status
                              );

                IF lr_cash_rcpt_rec.status = 'INVALID'
                THEN
                   xxctq_util_pkg.error_insert_proc
                                                 (gv_ctq_data_set,
                                                  rec_cash_rcpt_c.batch_id,
                                                  rec_cash_rcpt_c.record_id,
                                                  lv_error_message
                                                 );
                END IF;

                update_rcpt_translated_values (lr_cash_rcpt_rec);

            EXCEPTION
                WHEN OTHERS
                THEN
                    lr_cash_rcpt_rec.status := 'INVALID';
                    lv_error_message :=
                            lv_error_message
                        || '~'
                        || 'UnExpected Error Occured while getting Receipt Translations . '
                        || SQLCODE
                        || '~'
                        || SQLERRM;
                    xxctq_util_pkg.error_insert_proc
                                                    (gv_ctq_data_set,
                                                    rec_cash_rcpt_c.batch_id,
                                                    rec_cash_rcpt_c.record_id,
                                                    lv_error_message
                                                    );
                    update_rcpt_translated_values (lr_cash_rcpt_rec);

            END;

            xxctq_util_pkg.log_message(
                                'Translaton Completed for Receipt Record ID:  '
                             || rec_cash_rcpt_c.record_id
                            );
            xxctq_util_pkg.log_message(
                                  ' ------------------------------  '
                                 );

        END LOOP; --rec_cash_rcpt_c

    EXCEPTION
      WHEN OTHERS
      THEN
         xxctq_util_pkg.log_message(
                                     ' Error in  cur_cash_rcpt_c AR Cash Receipt Translation'
                                  || SQLERRM
                                 );

    END cash_rcpt_translate;

END XXAR_CASH_RCPT_CONV_PKG;
/