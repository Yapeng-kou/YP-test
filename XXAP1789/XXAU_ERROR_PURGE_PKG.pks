set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

Whenever sqlerror exit failure rollback

CREATE OR REPLACE PACKAGE XXAU_ERROR_PURGE_PKG AUTHID DEFINER AS
  /******************************************************************************
  ** Title:       Custom package for purging XXAU Common Error Log 
  ** File:        XXAU_ERROR_PURGE_PKG.pks
  ** Description: A custom package to Purge XXAU Common Error Log 
  ** Parameters:  {None.}
  **
  **
  ** Run as:      APPS
  ** Keyword Tracking:
  **   
  **   $Header: xxau/12.0.0/patch/115/sql/XXAU_ERROR_PURGE_PKG.pks 1.2 22-MAR-2018 06:18:48 CCCCPZ $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.2 (COMPLETE)
  **     Created:  22-MAR-2018 06:18:48      CCCCPZ (Satyendra Dangi)
  **       RT7670013 - REMOVE DELETE CONSTRAINT
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  10-OCT-2014 16:36:04      IRFZSQ (None)
  **       RT#5615615
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  01-MAY-2013 12:07:19      RSAWANT (None)
  **       Initial revision.
  **   
  **
  ** History:
  ** Date          Who                        Description
  ** -----------   ------------------------   ------------------------------------
  ** 15-04-2013    AMRITA DAS                 Initial Creation
  ** 10-10-2014    Surabhi C                  RT#5615615 - Purge Header less lines
  ** 21-Mar-2018   CCCCPZ                     RT7670013 - REMOVE DELETE CONSTRAINT
  *******************************************************************************/


  /****************************************************************************
  ** Function Name: XXAU_ERROR_PURGE_PRC
  **
  ** Purpose:  Concurrent program to Purge XXAU Common Error Log
  **
  **
  ** Procedure History:
  ** Date          Who                        Description
  ** -----------   ------------------------   ------------------------------------
  ** 15-04-2013    AMRITA DAS                 Initial Creation
  ** 10-10-2014    Surabhi C                  RT#5615615 - Purge Header-less lines
  *******************************************************************************/


  PROCEDURE XXAU_ERROR_PURGE_PRC(errbuf            		OUT VARCHAR2,
                                 retcode           		OUT NUMBER,
                                 p_error_date_from 		IN VARCHAR2,
                                 p_error_date_to   		IN VARCHAR2,
                                 p_error_source    		IN VARCHAR2,
                                 p_object_type     		IN VARCHAR2,
                                 p_object_name     		IN VARCHAR2,
                                 p_severity        		IN VARCHAR2,
                                 p_purge_no_hdr_line    in VARCHAR2 DEFAULT 'N',
                                 p_restrict_delete      IN VARCHAR2 DEFAULT 'Y'--RT7670013
                                 );

END XXAU_ERROR_PURGE_PKG;
/
Show errors package XXAU_ERROR_PURGE_PKG

desc XXAU_ERROR_PURGE_PKG
