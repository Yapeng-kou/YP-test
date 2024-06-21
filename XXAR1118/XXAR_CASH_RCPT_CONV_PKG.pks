SET DEFINE OFF;

create or replace PACKAGE        "XXAR_CASH_RCPT_CONV_PKG" AUTHID DEFINER
AS
	/*********************************************************
	** Title:        AR Cash Receipts Conversion Package
	** File:         XXAR_CASH_RCPT_CONV_PKG.pks
	** Description: This script creates a package specification for  AR Cash Receipts
	** Parameters:  {None.}
	** Run as:      APPS
	**
	**   $Header: xxar/patch/115/sql/XXAR_CASH_RCPT_CONV_PKG.pks 1.0 28-JUL-2014 06:28:31 CCBIZB $
	**   $Change History$ (*ALL VERSIONS*)
	**   ** Keyword Tracking:
    **
    **   $Header: xxar/patch/115/sql/XXAR_CASH_RCPT_CONV_PKG.pks 1.2 08-SEP-2014 16:09:48 CCBIZB $
    **   $Change History$ (*ALL VERSIONS*)
    **   Revision 1.2 (COMPLETE)
    **     Created:  08-SEP-2014 16:09:48      CCBIZB
    **       removed unused sub-programs
    **
    **   Revision 1.1 (COMPLETE)
    **     Created:  08-SEP-2014 10:37:21      CCBIZB
    **       added desc
    **
    **   Revision 1.0 (COMPLETE)
    **     Created:  22-AUG-2014 17:44:11      CCBIZB
    **       Initial revision.
    **
	**
	**   Revision 1.0 (COMPLETE)
	**     Created:  28-JUL-2014 07:26:19      CCBIZB
	**       Initial revision.
	**
	**
	** History:
	** Date          Who                Description
	** -----------   ------------------ ------------------------------------
	** 28-Jul-2014   ccbizb   			AR Cash Receipts
	** 27-Jul-2023   Kondu Nandini     EBR - Section26 - Schema Removal Remediation
	********************************************************/

	PROCEDURE MAIN (o_err                   OUT VARCHAR2,
					o_ret_code              OUT NUMBER,
                   in_batch_id          IN     NUMBER,
                   iv_validate_import   IN     VARCHAR2,
                   iv_email_address     IN     VARCHAR2);



	PROCEDURE cash_rcpt_translate (in_batch_id IN NUMBER);

	PROCEDURE r12_import (in_batch_id NUMBER, o_success OUT NOCOPY VARCHAR2);

	PROCEDURE update_rcpt_translated_values (
		ir_cash_rcpt_rec   IN XXCTQ_RECEPT_C_AR_RECEIPT%ROWTYPE);             ----EBR Section 26 Schema Reference Removal

	PROCEDURE update_success_error_records (in_batch_id       IN NUMBER,
											in_record_id   IN   NUMBER,
											iv_orig_reference   IN   VARCHAR2,
											iv_status         IN VARCHAR2,
											in_cr_id       IN   NUMBER
											);

END XXAR_CASH_RCPT_CONV_PKG;
/