SET serveroutput on size 1000000 lines 132 trimout on tab off pages 100

WHENEVER sqlerror exit failure rollback


create or replace PACKAGE  xxpa4432_project_attach_pkg 
IS
 /******************************************************************************
   ** Title:       XXPA Project Attachments Conversion - xxpa4432_project_attach_pkg
   ** File:        xxpa4432_project_attach_pkg.pks
   ** Description: This script creates a package header
   ** Parameters:  Default
   ** Run as:      APPS
   ** Keyword Tracking:
   **
   **
   **   $Header: xxpa/12.0.0/patch/115/sql/xxpa4432_project_attach_pkg.pks 1.3 03-OCT-2023 2:33:27 U112025 $
   **   $Change History$ (*ALL VERSIONS*)
   **
   **   Revision 1.0 (COMPLETE)
   **     Created:  03-OCT-2023 20:53:45   U112025 (Sowmya Shetty)
   **       Initial revision.
   **
   **
   ** History:
   ** Date          Who                Description
   ** -----------   ------------------ ----------------------------
   ** 03-OCT-2023   U112025             CR25375 - XXPA4023 Project Attachment Conversion program
  ************************************************************************************/


    PROCEDURE main (x_errbuf OUT VARCHAR2,
					x_retcode OUT NUMBER,
					p_org_id IN NUMBER,
					p_submit_loader IN VARCHAR2,
					p_is_submit_loader IN VARCHAR2,
					p_file_path IN VARCHAR2,
					p_file  IN VARCHAR2,
					p_batch_id IN NUMBER,
					p_validate_import IN VARCHAR2,
					p_email IN VARCHAR2,
					p_debug_flag IN VARCHAR2
					);

    PROCEDURE xx_process_attachments_data(p_batch_id   IN NUMBER,--Added for Defect 31900
	                                     x_err_code OUT VARCHAR2,
								         x_err_msg  OUT VARCHAR2
						                 );



END xxpa4432_project_attach_pkg;
/
Show err