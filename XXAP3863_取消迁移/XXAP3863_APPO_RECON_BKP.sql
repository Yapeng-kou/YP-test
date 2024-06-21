set serveroutput on size 10000000 lines 132 trimout on tab off pages 100

whenever sqlerror exit failure rollback
    
/*****************************************************************************
    Title : Create backup XXAP.XXAP3863_APPO_RECON_BKP table for CST_AP_PO_RECONCILIATION FOR APPO Accrual Write off
    Schema:       XXAP
    File Name:    XXAP3863_APPO_RECON_BKP.sql
    Description : This script creates the XXAP3863_APPO_RECON_BKP backup table in XXAP schema
				  and Add process_flag,request_id and error_message columns to the same.  
    Run As : APPS
**  Keyword Tracking:
**   
**  
**   $Header: xxap/12.0.0/patch/115/sql/XXAP3863_APPO_RECON_BKP.sql 1.1 13-MAY-2021 07:24:53 IRIMID $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.1 (COMPLETE)
**     Created:  13-MAY-2021 07:24:54      IRIMID (Gaurav Gupta)
**       SCTASK0153288 - Moved RICE table from XXBK to XXAP schema
**   
**   Revision 1.0 (COMPLETE)
**     Created:  07-OCT-2019 06:15:51      CCDZPQ (Raja Nandi)
**       CR10912 Initial Creation
**   
**   
**   Module: XXAP
**   Location:$XXAP_TOP/patch/115/sql
**
** History:
**  Date       Version         By         		 Description
**  -----       ------        ------      		------------
** 04-OCT-19    1.0        Raja Nandi      Initial Creation
** 13-MAY-21    1.1        Gaurav Gupta    SCTASK0153288 - Moved RICE table from XXBK to XXAP schema
**
********************************************************************************/
create table XXAP.XXAP3863_APPO_RECON_BKP as
SELECT crs.*
 FROM CST_AP_PO_RECONCILIATION crs where 1=2;
 
-- Alter Table to add additional columns
alter table XXAP.XXAP3863_APPO_RECON_BKP add (PROCESS_FLAG varchar2(5),DF_REQUEST_ID number,ERROR_MESSAGE varchar2(240));

-- Comment on Table
COMMENT ON TABLE XXAP.XXAP3863_APPO_RECON_BKP IS 'XXAP.XXAP3863_APPO_RECON_BKP table for CST_AP_PO_RECONCILIATION for APPO accrual write off';

-- Create INDEX
create index XXAP.XXAP3863_CST_APPO_RECON_BKP_N1 on XXAP.XXAP3863_APPO_RECON_BKP (df_request_Id);
