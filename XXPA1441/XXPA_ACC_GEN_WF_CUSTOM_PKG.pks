create or replace PACKAGE XXPA_ACC_GEN_WF_CUSTOM_PKG AS
  /*********************************************************
  ** Title:       XXPA1441 Project Related PO,Req and Invoice Default Account Generation
  ** File:        XXPA_ACC_GEN_WF_CUSTOM_PKG.pks
  ** Description: This script creates a package header
  ** Parameters:  {None.}
  ** Run as:      APPS
  ** 12_2_Compliant: YES
  ** Keyword Tracking:
  **   
  **   $Header: xxpa/12.0.0/patch/115/sql/XXPA_ACC_GEN_WF_CUSTOM_PKG.pks 1.5.0.1 19-JUL-2023 06:05:20 U105471 $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.5.0.1 (COMPLETE)
  **     Created:  19-JUL-2023 06:05:20      U105471 (Jai ShankarKumar)
  **       CR25183 - Added procedure XXPA_COMP_ORG_PROC for Cross Charging
  **       Functionality
  **   
  **   Revision 1.5 (COMPLETE)
  **     Created:  28-APR-2021 12:34:56      CCDVAJ (Rushikesh Joshi)
  **       CR#24631 - Added new procedure XXPA_GET_ORG_TYPE_PROC - Rushi
  **   
  **   Revision 1.4 (COMPLETE)
  **     Created:  09-NOV-2015 07:00:37      CCBWIL (Soniya Doshi)
  **       changes added for CR4776 - Workflow Account Generator Updates
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  06-JAN-2014 15:19:04      CCAYSB (None)
  **       Updated the document for FIT defect
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  18-DEC-2013 12:08:52      CCAYSB (None)
  **       Updated for Phase-2 CR
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  14-OCT-2013 11:09:57      CCAYSB (None)
  **       includes updates for Phase-2
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  29-OCT-2012 03:57:41      C-AARORA1 (None)
  **       Initial revision.
  **   
  **
  ** History:
  ** Date          Who                Description
  ** -----------   ------------------ ------------------------------------
  ** 10-Oct-2012   Ashu Arora         Initial Creation
  ** 05-Dec-2013   Muralidhar Ng      Added Phase-2 Requirements
  ** 05-Nov-2015   Soniya Doshi       Changes for CR4776 - Workflow Account Generator Updates
  ** 28-Apr-2021   Rushikesh Joshi    Changes for CR#24631 - Added procedure XXPA_GET_ORG_TYPE_PROC
  ** 26-Jun-2023   Jai Shankar Kumar  Changes for CR25183 - Added procedure XXPA_COMP_ORG_PROC for Cross Charging
  ********************************************************/

  /* This Workflow Procedure Will Get The Project Class Of A Specific Project */
  PROCEDURE XXPA_GET_PROJ_CLASS_PROC(P_ITEMTYPE IN VARCHAR2,
                                     P_ITEMKEY  IN VARCHAR2,
                                     P_ACTID    IN NUMBER,
                                     P_FUNCMODE IN VARCHAR2,
                                     X_RESULT   OUT VARCHAR2);
  
   /* This Workflow Procedure Will Get The Organization Type Of a specific Project */
  PROCEDURE XXPA_GET_ORG_TYPE_PROC(P_ITEMTYPE IN VARCHAR2,
                                   P_ITEMKEY  IN VARCHAR2,
                                   P_ACTID    IN NUMBER,
                                   P_FUNCMODE IN VARCHAR2,
                                   X_RESULT   OUT VARCHAR2);

  /* This Workflow Procedure Will Get The Project Indirect Cost Center Based On A Project Lookup */
  PROCEDURE XXPA_GET_INDIR_CCTR_PROC(P_ITEMTYPE IN VARCHAR2,
                                     P_ITEMKEY  IN VARCHAR2,
                                     P_ACTID    IN NUMBER,
                                     P_FUNCMODE IN VARCHAR2,
                                     X_RESULT   OUT VARCHAR2);
  /* This Workflow Procedure Will check the project id exiss for  Assest Accounts for Phase-2*/
  PROCEDURE XXPA_VAL_PROJ_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                    P_ITEMKEY  IN VARCHAR2,
                                    P_ACTID    IN NUMBER,
                                    P_FUNCMODE IN VARCHAR2,
                                    X_RESULT   OUT VARCHAR2);

  /*  PROCEDURE XXPA_VAL_ASS_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
  P_ITEMKEY  IN VARCHAR2,
  P_ACTID    IN NUMBER,
  P_FUNCMODE IN VARCHAR2,
  X_RESULT   OUT VARCHAR2);*/

  /* This Workflow Procedure Will check the MultiCIP Project type. Added for Phase-2*/
  PROCEDURE XXPA_VAL_PROJ_TYPE_PROC(P_ITEMTYPE IN VARCHAR2,
                                    P_ITEMKEY  IN VARCHAR2,
                                    P_ACTID    IN NUMBER,
                                    P_FUNCMODE IN VARCHAR2,
                                    X_RESULT   OUT VARCHAR2);

  /* This Workflow Procedure Will Get The Project Indirect Cost Center Based On A Project Lookup */
  PROCEDURE XXPA_GET_INDIR_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                     P_ITEMKEY  IN VARCHAR2,
                                     P_ACTID    IN NUMBER,
                                     P_FUNCMODE IN VARCHAR2,
                                     X_RESULT   OUT VARCHAR2);

  /* This Workflow Procedure Will Get The Product Code Segment For Generating The Acc. Flex Combination*/
  PROCEDURE XXPA_GET_PROD_CODE_PROC(P_ITEMTYPE IN VARCHAR2,
                                    P_ITEMKEY  IN VARCHAR2,
                                    P_ACTID    IN NUMBER,
                                    P_FUNCMODE IN VARCHAR2,
                                    X_RESULT   OUT VARCHAR2);
  /* This Workflow Procedure Will Get The Product Code Segment from Task Attribute1 Generating The Acc. Flex Combination*/
  PROCEDURE XXPA_GET_CONTR_PROD_CODE_PROC(P_ITEMTYPE IN VARCHAR2,
                                          P_ITEMKEY  IN VARCHAR2,
                                          P_ACTID    IN NUMBER,
                                          P_FUNCMODE IN VARCHAR2,
                                          X_RESULT   OUT VARCHAR2);

  /* This Workflow Procedure Will Get The Labo rWIP account Generating The Acc. Flex Combination*/
  PROCEDURE XXPA_GET_LABOR_WIP_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                         P_ITEMKEY  IN VARCHAR2,
                                         P_ACTID    IN NUMBER,
                                         P_FUNCMODE IN VARCHAR2,
                                         X_RESULT   OUT VARCHAR2);
  /* This Workflow Procedure Will Get cost center from Task Service Type Code Generating The Acc. Flex Combination*/

  PROCEDURE XXPA_GET_NONBILLABLE_CCTR_PROC(P_ITEMTYPE IN VARCHAR2,
                                           P_ITEMKEY  IN VARCHAR2,
                                           P_ACTID    IN NUMBER,
                                           P_FUNCMODE IN VARCHAR2,
                                           X_RESULT   OUT VARCHAR2);
  --Below changes added for CR4776 - Workflow Account Generator Updates
  FUNCTION XXPA_VAL_PROJ_ACWIP_PROC(P_ACCOUNT IN VARCHAR2) RETURN VARCHAR2;
  
  -- CR25183 - Create New Procedure for Cross Charging - START
  PROCEDURE XXPA_COMP_ORG_PROC(P_ITEMTYPE IN VARCHAR2,
                               P_ITEMKEY  IN VARCHAR2,
                               P_ACTID    IN NUMBER,
                               P_FUNCMODE IN VARCHAR2,
                               X_RESULT   OUT VARCHAR2);
  -- CR25183 - Create New Procedure for Cross Charging - END

END XXPA_ACC_GEN_WF_CUSTOM_PKG;
/