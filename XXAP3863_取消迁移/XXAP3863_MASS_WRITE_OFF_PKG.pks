set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

Whenever sqlerror exit failure rollback
CREATE OR REPLACE PACKAGE XXAP3863_MASS_WRITE_OFF_PKG AUTHID DEFINER AS
 /*********************************************************
   ** Title:       XX GRNI Clearing Mass Write Off
   ** File:        XXAP3863_MASS_WRITE_OFF_PKG.pks
   ** Description: This script creates a package Spec
   ** Parameters:  {None.}
   ** Run as:      APPS
   ** Keyword Tracking:
   **	
  **   $Header: xxap/12.0.0/patch/115/sql/XXAP3863_MASS_WRITE_OFF_PKG.pks 1.0 07-OCT-2019 06:22:22 CCDZPQ $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.0 (COMPLETE)
  **     Created:  07-OCT-2019 06:22:22      CCDZPQ (Raja Nandi)
  **       CR10912 Initial Creation
  **   
   **   
   **   
   ** History:
   ** Date          Who                Description
   ** -----------   ------------------ ------------------------------------
   ** 03-OCT-19   Raja Nandi       Initial Creation
    ********************************************************/
	procedure main(p_errbuff 		OUT VARCHAR2,
                 p_retcode 			OUT NUMBER,
                 p_ou_id    		IN NUMBER,
				 p_sob_id			IN NUMBER,
				 p_directory_path	IN VARCHAR2,
				 p_file_name		IN VARCHAR2,
				 --p_wo_date		IN VARCHAR2,
				 p_reason_id		IN NUMBER,
				 p_comments			IN VARCHAR2);
END XXAP3863_MASS_WRITE_OFF_PKG;
/
Show errors package XXAP3863_MASS_WRITE_OFF_PKG
desc XXAP3863_MASS_WRITE_OFF_PKG
	