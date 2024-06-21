CREATE OR REPLACE PACKAGE BODY XXPA_ACC_GEN_WF_CUSTOM_PKG AS
  /*********************************************************
  ** Title:       XXPA1441 Project Related PO,Req and Invoice Default Account Generation
  ** File:        XXPA_ACC_GEN_WF_CUSTOM_PKG.pks
  ** Description: This script creates a package header
  ** Parameters:  {None.}
  ** Run as:      APPS
  ** 12_2_Compliant: YES
  ** Keyword Tracking:
  **
  **   $Header: xxpa/12.0.0/patch/115/sql/XXPA_ACC_GEN_WF_CUSTOM_PKG.pkb 1.12.0.1 19-JUL-2023 06:07:03 U105471 $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.12.0.1 (COMPLETE)
  **     Created:  19-JUL-2023 06:07:03      U105471 (Jai ShankarKumar)
  **       CR25183 - Added procedure XXPA_COMP_ORG_PROC for Cross Charging
  **       Functionality
  **
  **   Revision 1.12 (COMPLETE)
  **     Created:  30-SEP-2022 23:31:40      U100294 (Sourabh Bhattacharjee)
  **       Enclosed the changes in BEGIN END block
  **
  **   Revision 1.11 (COMPLETE)
  **     Created:  26-AUG-2022 22:28:26      U100294 (Sourabh Bhattacharjee)
  **       CR24934 - PA_BILLABLE_FLAG needs to be set for REQIMPORT
  **
  **   Revision 1.10 (COMPLETE)
  **     Created:  28-APR-2021 12:33:34      CCDVAJ (Rushikesh Joshi)
  **       CR#24631 - Added new procedure XXPA_GET_ORG_TYPE_PROC - Rushi
  **
  **   Revision 1.9 (COMPLETE)
  **     Created:  09-NOV-2015 07:01:04      CCBWIL (Soniya Doshi)
  **       changes added for CR4776 - Workflow Account Generator Updates
  **
  **   Revision 1.8 (COMPLETE)
  **     Created:  10-AUG-2015 02:53:12      CCBWIL (Soniya Doshi)
  **       Changes for CR3668
  **
  **   Revision 1.7 (COMPLETE)
  **     Created:  19-JUN-2014 05:17:11      CCAYSB (None)
  **       Coomented the global variable  G_ERROR_STACK for RT 5444745
  **
  **   Revision 1.6 (COMPLETE)
  **     Created:  05-FEB-2014 15:10:08      CCAYSB (None)
  **       Updated the Script to re-factor the global variable g_error_stack
  **
  **   Revision 1.5 (COMPLETE)
  **     Created:  05-FEB-2014 12:21:09      CCAYSB (None)
  **       Updated the script for Global variable Assignment
  **
  **   Revision 1.4 (COMPLETE)
  **     Created:  06-JAN-2014 15:19:58      CCAYSB (None)
  **       Updated the script for FIT defect
  **
  **   Revision 1.3 (COMPLETE)
  **     Created:  18-DEC-2013 12:36:56      CCAYSB (None)
  **       Updated for Phase-2 CR
  **
  **   Revision 1.2 (COMPLETE)
  **     Created:  18-DEC-2013 12:08:35      CCAYSB (None)
  **       Updated for Phase-2 CR
  **
  **   Revision 1.1 (COMPLETE)
  **     Created:  14-OCT-2013 11:10:34      CCAYSB (None)
  **       Updates include phase-2 requirements
  **
  **   Revision 1.0 (COMPLETE)
  **     Created:  29-OCT-2012 04:07:14      C-AARORA1 (None)
  **       Initial revision.
  **
  **
  ** History:
  ** Date          Who                        Description
  ** -----------   ------------------         ------------------------------------
  ** 10-Oct-2012   Ashu Arora               Initial Creation
  ** 05-Dec-2013   Muralidhar Ng            Added Phase-2 Requirements
  ** 31-Jul-2015   Soniya Doshi                Added for CR3668 : Base version taken as 1.6 as version 1.7(Rt#5444745) is not migrated to PROD.
  ** 05-Nov-2015   Soniya Doshi                Changes for CR4776 - Workflow Account Generator Updates
  ** 28-Apr-2021   Rushikesh Joshi             Changes for CR#24631 - Added procedure XXPA_GET_ORG_TYPE_PROC
  ** 26-Aug-2022   Sourabh Bhattacharjee    Changes for CR24934 - PA_BILLABLE_FLAG needs to be set for REQIMPORT
  ** 26-Jun-2023   Jai Shankar Kumar        Changes for CR25183 - Added procedure XXPA_COMP_ORG_PROC for Cross Charging
  ********************************************************
  ----------------------------
  /*Global Variables declaration*/
  ----------------------------
  GV_ERROR_STAGE   VARCHAR2(4) := '00'; -- Error Stage Detection For Debuging
  GV_ERROR_MESSAGE VARCHAR2(300) := NULL;
  GV_ERROR_STACK   VARCHAR2(500);
  gc_event_type    VARCHAR2(1000) := 'XXPO2413_REQUISITION_EVENT_IN';
  gc_key_type      xxint_event_type_key_vals.key_type%TYPE := 'PARTNER';
  gv_key_name      xxint_event_type_key_vals.key_name%TYPE := 'TASK_BILLABLE';
  /*
   ----------------------------------------------------------------------------------
   PROCEDURE NAME: XXPA_GET_PROJ_CLASS_PROC
   DESCRIPTION: Procedure to be called from the Project Supplier Invoice,PO and
                PO Requisition Account Generator To Generate Accounting Flex Field.
   PARAMETERS:
               p_itemtype           :   Workflow Item Type(Internal Name)
               p_itemkey            :   Workflow Item Key
               p_actid              :   Workflow Activity Id
               p_funcmode           :   Workflow Function Mode
               x_result             :   Workflow return result Type
   -----------------------------------------------------------------------------------
  */
  PROCEDURE XXPA_GET_PROJ_CLASS_PROC(P_ITEMTYPE IN VARCHAR2,
                                     P_ITEMKEY  IN VARCHAR2,
                                     P_ACTID    IN NUMBER,
                                     P_FUNCMODE IN VARCHAR2,
                                     X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID              PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LV_PROJECT_TYPE_CLASS_CODE PA_PROJECT_TYPES_ALL.PROJECT_TYPE_CLASS_CODE%TYPE;
    LV_OLD_ERROR_STACK         VARCHAR2(500);
    NO_CLASS_CODE              EXCEPTION;
    LV_ERROR_MESSAGE           VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------

    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPA_GET_PROJ_CLASS_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN' THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');

    -------------------------------------------
    -- Select the Project Class from the table
    -------------------------------------------
    GV_ERROR_STAGE := '30';

    SELECT PPTA.PROJECT_TYPE_CLASS_CODE
      INTO LV_PROJECT_TYPE_CLASS_CODE
      FROM PA_PROJECTS_ALL PPA,
           PA_PROJECT_TYPES_ALL PPTA
     WHERE PPTA.PROJECT_TYPE = PPA.PROJECT_TYPE
       AND PPTA.ORG_ID = PPA.ORG_ID
       AND PPA.PROJECT_ID = LN_PROJECT_ID;

    -----------------------------------------------------------------------
    -- If the retrieval was successful, then set the appropriate item
    -- attribute to the value retrieved. Otherwise, raise the appropriate
    -- error message
    -----------------------------------------------------------------------
    GV_ERROR_STAGE := '40';

    IF LV_PROJECT_TYPE_CLASS_CODE = 'CAPITAL'
    THEN
      X_RESULT      := 'COMPLETE:XXPA_CAPITAL_PROJECTS';
      GV_ERROR_STACK := LV_OLD_ERROR_STACK;
    ELSIF LV_PROJECT_TYPE_CLASS_CODE = 'INDIRECT'
    THEN
      X_RESULT      := 'COMPLETE:XXPA_INDIRECT_PROJECTS';
      GV_ERROR_STACK := LV_OLD_ERROR_STACK;
    ELSIF LV_PROJECT_TYPE_CLASS_CODE = 'CONTRACT'
    THEN
      X_RESULT      := 'COMPLETE:XXPA_CONTRACT_PROJECTS';
      GV_ERROR_STACK := LV_OLD_ERROR_STACK;
    ELSE
      RAISE NO_CLASS_CODE;
    END IF;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when lookup code is not defined
    ------------------------------------------------------------------
    WHEN NO_CLASS_CODE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROJ_CLASS_PROC',
                      ARG1      => 'Project Class Code : ' || LV_PROJECT_TYPE_CLASS_CODE,
                      ARG2      => 'Project Class Code is Invalid',
                      ARG3      => NULL,
                      ARG4      => NULL,
                      ARG5      => NULL);

      -- Error Message To Be Populated in Form

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Project Type ' || LV_PROJECT_TYPE_CLASS_CODE ||
                            ' is invalid. ' ||
                            'Please Enter CAPITAL or INDIRECT  or CONTRACT Project Types Only.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:XXPA_OTHERS';
      RETURN;

    ------------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ------------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROJ_CLASS_PROC',
                      ARG1      => 'Project Class Code : ' || LV_PROJECT_TYPE_CLASS_CODE,
                      ARG2      => 'Project Class Code is not found',
                      ARG3      => NULL,
                      ARG4      => NULL,
                      ARG5      => NULL);

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Project Type is not found for the Project entered. ' ||
                            'Please Enter CAPITAL or INDIRECT or CONTRACT Project Types Only.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:XXPA_OTHERS';
      RETURN;

    -----------------------------------------------------------
    -- All other exceptions are raised to the calling program
    -----------------------------------------------------------

    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG1          => 'Project Id : ' || LN_PROJECT_ID,
                                                      P_ARG2          => 'Project Class Code : ' || LV_PROJECT_TYPE_CLASS_CODE);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:XXPA_OTHERS';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROJ_CLASS_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Project Id null',
                      ARG3      => NULL,
                      ARG4      => NULL,
                      ARG5      => NULL);

      RETURN;

  END XXPA_GET_PROJ_CLASS_PROC;

/*
   ----------------------------------------------------------------------------------
   PROCEDURE NAME: XXPA_GET_ORG_TYPE_PROC
   DESCRIPTION: Procedure to be called from the Project Supplier Invoice,PO and
                PO Requisition Account Generator To Generate Accounting Flex Field.
   PARAMETERS:
               p_itemtype           :   Workflow Item Type(Internal Name)
               p_itemkey            :   Workflow Item Key
               p_actid              :   Workflow Activity Id
               p_funcmode           :   Workflow Function Mode
               x_result             :   Workflow return result Type
   -----------------------------------------------------------------------------------
  */
  PROCEDURE XXPA_GET_ORG_TYPE_PROC(P_ITEMTYPE IN VARCHAR2,
                                   P_ITEMKEY  IN VARCHAR2,
                                   P_ACTID    IN NUMBER,
                                   P_FUNCMODE IN VARCHAR2,
                                   X_RESULT   OUT VARCHAR2)
  AS
    LN_TASK_ORG_ID     PA_PROJECTS_ALL.CARRYING_OUT_ORGANIZATION_ID%TYPE;
    LV_OLD_ERROR_STACK VARCHAR2(500);
    LV_ERROR_MESSAGE   VARCHAR2(2000);
    LN_TASK_ID           PA_TASKS.TASK_ID%TYPE;  -- CR24934 PA_BILLABLE_FLAG needs to be set for acct string to be generated
    LV_BILLABLE_FLAG   VARCHAR2(10);  -- CR24934 PA_BILLABLE_FLAG needs to be set for acct string to be generated
    LV_PM_PROD_CODE    PA_TASKS.PM_PRODUCT_CODE%TYPE; -- CR24934 PA_BILLABLE_FLAG needs to be set for acct string to be generated

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------

    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPA_GET_ORG_TYPE_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
    THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_TASK_ORG_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                  ITEMKEY  => P_ITEMKEY,
                                                  ANAME    => 'TASK_ORGANIZATION_ID');

    -----------------------------------------------------------------------
    -- If the retrieval was successful, then set the appropriate item
    -- attribute to the value retrieved. Otherwise, raise the appropriate
    -- error message
    -----------------------------------------------------------------------
    GV_ERROR_STAGE := '30';

    IF LN_TASK_ORG_ID IS NOT NULL
    THEN
      /*Added code for CR24934*/
      BEGIN
        LN_TASK_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                  ITEMKEY  => P_ITEMKEY,
                                                  ANAME    => 'TASK_ID');

        SELECT NVL(BILLABLE_FLAG,'N'),
               PM_PRODUCT_CODE
          INTO LV_BILLABLE_FLAG,
               LV_PM_PROD_CODE
          FROM PA_TASKS
         WHERE TASK_ID = LN_TASK_ID ;

        /*IF NVL(xxint_event_type_utils.get_key_parm_value(p_event_type     => gc_event_type,
                                                         p_key_type       => gc_key_type,
                                                         p_key_type_value => LV_PM_PROD_CODE,
                                                         p_name           => gv_key_name),'N') = 'Y'
        THEN

          WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                    ITEMKEY  => P_ITEMKEY,
                                    ANAME    => 'PA_BILLABLE_FLAG',
                                    AVALUE   => LV_BILLABLE_FLAG);
        END IF ;*/ --modify by yapeng.kou XXINT not Need 
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL ;
        WHEN OTHERS THEN
          NULL ;
      END;
      /*Ended code for CR24934*/

      X_RESULT       := 'COMPLETE:XXPA_TASK_ORGANIZATION';
      GV_ERROR_STACK := LV_OLD_ERROR_STACK;
    ELSE
      X_RESULT      := 'COMPLETE:XXPA_EXPENDITURE_ORGANIZATION';
      GV_ERROR_STACK := LV_OLD_ERROR_STACK;
    END IF;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when lookup code is not defined
    ------------------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                       P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                       P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                       P_ARG1          => 'Task Organization Id : ' || LN_TASK_ORG_ID,
                                                       P_ARG2          => NULL);

      -- populate the error message wf attribute and return failure.

      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:XXPA_OTHERS';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_ORG_TYPE_PROC',
                      ARG1      => 'Task Organization Id : ' || LN_TASK_ORG_ID,
                      ARG2      => NULL,
                      ARG3      => NULL,
                      ARG4      => NULL,
                      ARG5      => NULL);

      RETURN;
  END XXPA_GET_ORG_TYPE_PROC;

  /*
   ----------------------------------------------------------------------------------
   PROCEDURE NAME: XXPA_COMP_ORG_PROC
   DESCRIPTION: Procedure to be called from the Project Supplier Invoice Account
                Generator To Generate Accounting Flex Field.
   PARAMETERS:
               p_itemtype           :   Workflow Item Type(Internal Name)
               p_itemkey            :   Workflow Item Key
               p_actid              :   Workflow Activity Id
               p_funcmode           :   Workflow Function Mode
               x_result             :   Workflow return result Type
   -----------------------------------------------------------------------------------
  */
  -- CR25183 - Create New Procedure for Cross Charging - START
  PROCEDURE XXPA_COMP_ORG_PROC(P_ITEMTYPE IN VARCHAR2,
                               P_ITEMKEY  IN VARCHAR2,
                               P_ACTID    IN NUMBER,
                               P_FUNCMODE IN VARCHAR2,
                               X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJ_OWN_ORG    org_organization_definitions.organization_id%TYPE;
    LN_EXP_ORG         org_organization_definitions.organization_id%TYPE;
    LV_PROJ_OWN_OU     org_organization_definitions.operating_unit%TYPE;
    LV_EXP_OU          org_organization_definitions.operating_unit%TYPE;
    LN_PROJECT_ID      pa_projects_all.project_id%TYPE;
    LV_PROJ_TYPE_CLASS pa_project_types_all.project_type_class_code%TYPE;
    LV_OLD_ERROR_STACK VARCHAR2(500);
    LV_ERROR_MESSAGE   VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPA_COMP_ORG_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
    THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ----------------------------------------------------------------
    -- Retrieve the value for the Project Owning and Expenditure Org
    ----------------------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJ_OWN_ORG := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                   ITEMKEY  => P_ITEMKEY,
                                                   ANAME    => 'PROJECT_ORGANIZATION_ID');
    LN_EXP_ORG      := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                   ITEMKEY  => P_ITEMKEY,
                                                   ANAME    => 'EXPENDITURE_ORGANIZATION_ID');
    LN_PROJECT_ID   := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                   ITEMKEY  => P_ITEMKEY,
                                                   ANAME    => 'PROJECT_ID');
    -------------------------------------------
    -- Select the Project Class from the table
    -------------------------------------------
    GV_ERROR_STAGE := '30';

    BEGIN
      SELECT ppta.project_type_class_code
        INTO LV_PROJ_TYPE_CLASS
        FROM pa_projects_all ppa, pa_project_types_all ppta
       WHERE ppta.project_type = ppa.project_type
         AND ppta.org_id = ppa.org_id
         AND ppa.project_id = LN_PROJECT_ID;
    EXCEPTION
      WHEN OTHERS THEN
        LV_PROJ_TYPE_CLASS := NULL;
    END;
    -----------------------------------------------------------------------
    -- If the retrieval was successful, then set the appropriate result type
    -- lookup value. Otherwise, raise the appropriate error message
    -----------------------------------------------------------------------

    GV_ERROR_STAGE := '35';
    BEGIN
      SELECT operating_unit
        INTO LV_PROJ_OWN_OU
        FROM org_organization_definitions
       WHERE organization_id = LN_PROJ_OWN_ORG;
    EXCEPTION
      WHEN OTHERS THEN
        LV_PROJ_OWN_OU := NULL;
    END;

    GV_ERROR_STAGE := '40';
    BEGIN
      SELECT operating_unit
        INTO LV_EXP_OU
        FROM org_organization_definitions
       WHERE organization_id = LN_EXP_ORG;
    EXCEPTION
      WHEN OTHERS THEN
        LV_EXP_OU := NULL;
    END;

    IF LV_PROJ_OWN_OU <> NVL(LV_EXP_OU, LV_PROJ_OWN_OU) AND
	   LV_PROJ_TYPE_CLASS = 'CONTRACT'
    THEN
      X_RESULT := 'COMPLETE:XXPA_EXPENDITURE_ORGANIZATION';
    ELSE
      X_RESULT := 'COMPLETE:XXPA_TASK_ORGANIZATION';
    END IF;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when lookup code is not defined
    ------------------------------------------------------------------

    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                       P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                       P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                       P_ARG1          => 'Project Organization Id : '     || LN_PROJ_OWN_ORG,
                                                       P_ARG2          => 'Expenditure Organization Id : ' || LN_EXP_ORG);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return OTHERS so that the abort generation End function is called
      X_RESULT := 'COMPLETE:XXPA_OTHERS';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_COMP_ORG_PROC',
                      ARG1      => 'Project Organization Id : '     || LN_PROJ_OWN_ORG,
                      ARG2      => 'Expenditure Organization Id : ' || LN_EXP_ORG,
                      ARG3      => NULL,
                      ARG4      => NULL,
                      ARG5      => NULL);

      X_RESULT := 'COMPLETE:XXPA_OTHERS';
      RETURN;
  END XXPA_COMP_ORG_PROC;
  -- CR25183 - Create New Procedure for Cross Charging - END

  /*
   ----------------------------------------------------------------------------------
   PROCEDURE NAME: XXPA_GET_INDIR_CCTR_PROC
   DESCRIPTION: Procedure to be called from the Project Supplier Invoice,PO and
                PO Requisition Account Generator To Generate Accounting Flex Field.
   PARAMETERS:
               p_itemtype           :   Workflow Item Type(Internal Name)
               p_itemkey            :   Workflow Item Key
               p_actid              :   Workflow Activity Id
               p_funcmode           :   Workflow Function Mode
               x_result             :   Workflow return result Type
   -----------------------------------------------------------------------------------
  */
  PROCEDURE XXPA_GET_INDIR_CCTR_PROC(P_ITEMTYPE IN VARCHAR2,
                                     P_ITEMKEY  IN VARCHAR2,
                                     P_ACTID    IN NUMBER,
                                     P_FUNCMODE IN VARCHAR2,
                                     X_RESULT   OUT VARCHAR2)

  AS
    LN_PROJECT_ID              PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LV_PROJECT_TYPE            PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LV_TASK_SERVICE_TYPE       PA_SERVICE_TYPE_LOV_V.CODE%TYPE;
    LV_SEGMENT_LOOKUP_SET_NAME PA_SEGMENT_VALUE_LOOKUP_SETS.SEGMENT_VALUE_LOOKUP_SET_NAME%TYPE := 'Proj Type to Indir CCtr Lookup';
    LV_SEGMENT_VALUE           PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_SEGMENT_CCTR_VALUE      PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_OLD_ERROR_STACK         VARCHAR2(500);
    NO_PROJECT_TYPE            EXCEPTION;
    NO_SEGMENT_VALUE           EXCEPTION;
    NO_SEGMENT_CCTR_VALUE      EXCEPTION;
    LV_ERROR_MESSAGE           VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------

    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPO_GET_INDIR_CCTR_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');

    ---------------------------------------------------
    -- Retrieve the value for the Task Service Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '30';
    LV_TASK_SERVICE_TYPE := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                                      ITEMKEY  => P_ITEMKEY,
                                                      ANAME    => 'TASK_SERVICE_TYPE');

    ---------------------------------------------------
    -- Retrieve the value for the Project Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '40';
    SELECT PPTA.PROJECT_TYPE
      INTO LV_PROJECT_TYPE
      FROM PA_PROJECTS_ALL PPA,
           PA_PROJECT_TYPES_ALL PPTA
     WHERE PPTA.PROJECT_TYPE = PPA.PROJECT_TYPE
       AND PPTA.ORG_ID = PPA.ORG_ID
       AND PPA.PROJECT_ID = LN_PROJECT_ID;

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Project Type is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '50';
    IF LV_PROJECT_TYPE IS NULL
	THEN
      RAISE NO_PROJECT_TYPE;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Lookup Set Name
    ---------------------------------------------------

    GV_ERROR_STAGE := '60';
    SELECT PSVL.SEGMENT_VALUE
      INTO LV_SEGMENT_VALUE
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
       AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = UPPER(LV_SEGMENT_LOOKUP_SET_NAME)
       AND UPPER(PSVL.SEGMENT_VALUE_LOOKUP) = UPPER(LV_PROJECT_TYPE);

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the segment value is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '70';
    IF LV_SEGMENT_VALUE IS NULL
	THEN
      RAISE NO_SEGMENT_VALUE;
    END IF;

    --------------------------------------------------------------
    -- Retrieve the value for the Segment CCtr Value
    --------------------------------------------------------------
    GV_ERROR_STAGE := '80';
    SELECT LTRIM(RTRIM(PSVL.SEGMENT_VALUE))
      INTO LV_SEGMENT_CCTR_VALUE
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
       AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = UPPER(LV_SEGMENT_VALUE)
       AND UPPER(PSVL.SEGMENT_VALUE_LOOKUP) = UPPER(LV_TASK_SERVICE_TYPE);

    ------------------------------------------------------------------------------
    -- Raise the appropriate exception if the Segment CCtr Value is not found
    ------------------------------------------------------------------------------
    GV_ERROR_STAGE := '90';
    IF LV_SEGMENT_CCTR_VALUE IS NULL
	THEN
      RAISE NO_SEGMENT_CCTR_VALUE;
    END IF;

    ------------------------------------------------------------------------------
    -- Set the Segment CCtr Value To Lookup Value
    ------------------------------------------------------------------------------

    GV_ERROR_STAGE := '100';
    WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                              ITEMKEY  => P_ITEMKEY,
                              ANAME    => 'LOOKUP_SET_VALUE',
                              AVALUE   => LV_SEGMENT_CCTR_VALUE);

    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not defined
    ------------------------------------------------------------------

    WHEN NO_PROJECT_TYPE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Service Type : ' || LV_TASK_SERVICE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Project Type is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Project Type is not found for the Project entered. ' ||
                            'Please Enter CAPITAL or INDIRECT Project Types Only.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    --------------------------------------------------------------------
    -- User defined exception raised when CCtr lookup set is not defined
    --------------------------------------------------------------------
    WHEN NO_SEGMENT_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Service Type : ' || LV_TASK_SERVICE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => ' CCtr Lookup Set is Not Defined or Project Type Lookup Set is Invalid');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Task Service Type : ' || LV_TASK_SERVICE_TYPE || '. ' ||
                            'Unable to Determine Cost Center Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set/ Value is not defined
    ------------------------------------------------------------------------------

    WHEN NO_SEGMENT_CCTR_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Service Type : ' || LV_TASK_SERVICE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Project Type Lookup Set or Value is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Task Service Type : ' || LV_TASK_SERVICE_TYPE || '. ' ||
                            'Unable to Determine Cost Center Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ----------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ----------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Service Type : ' || LV_TASK_SERVICE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'CCtr Lookup Set Or Project Type Lookup Set Or Lookup value is Invalid Or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Task Service Type : ' || LV_TASK_SERVICE_TYPE || '. ' ||
                            'Unable to Determine Cost Center Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ---------------------------------------------------------
    -- All other exceptions are raised to the calling program
    ---------------------------------------------------------

    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);

      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                       P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                       P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                       P_ARG1          => LV_SEGMENT_LOOKUP_SET_NAME,
                                                       P_ARG2          => 'Task Service Type : ' || LV_TASK_SERVICE_TYPE);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Service Type : ' || LV_TASK_SERVICE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_GET_INDIR_CCTR_PROC');
      RETURN;
  END XXPA_GET_INDIR_CCTR_PROC;

  /*
     ----------------------------------------------------------------------------------
     PROCEDURE NAME: XXPA_GET_INDIR_ACCT_PROC
     DESCRIPTION: Procedure to be called from the Project Supplier Invoice,PO and
                  PO Requisition Account Generator To Generate Accounting Flex Field.
     PARAMETERS:
                 p_itemtype           :   Workflow Item Type(Internal Name)
                 p_itemkey            :   Workflow Item Key
                 p_actid              :   Workflow Activity Id
                 p_funcmode           :   Workflow Function Mode
                 x_result             :   Workflow return result Type
     -----------------------------------------------------------------------------------
  */
  PROCEDURE XXPA_GET_INDIR_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                     P_ITEMKEY  IN VARCHAR2,
                                     P_ACTID    IN NUMBER,
                                     P_FUNCMODE IN VARCHAR2,
                                     X_RESULT   OUT VARCHAR2)

   AS
    LN_PROJECT_ID              PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LV_PROJECT_TYPE            PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LV_TASK_SERVICE_TYPE       PA_SERVICE_TYPE_LOV_V.CODE%TYPE;
    LV_EXPENDITURE_TYPE        PA_EXPENDITURE_TYPES.EXPENDITURE_TYPE%TYPE;
    LV_SEGMENT_LOOKUP_SET_NAME PA_SEGMENT_VALUE_LOOKUP_SETS.SEGMENT_VALUE_LOOKUP_SET_NAME%TYPE := 'Proj Type to Task Lookup';
    LV_SEGMENT_VALUE           PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_SEGMENT_VALUE1          PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_SEGMENT_ACCT_VALUE      PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_OLD_ERROR_STACK         VARCHAR2(500);
    NO_PROJECT_TYPE            EXCEPTION;
    NO_SEGMENT_VALUE           EXCEPTION;
    NO_SEGMENT_VALUE1          EXCEPTION;
    NO_SEGMENT_ACCT_VALUE      EXCEPTION;
    LV_ERROR_MESSAGE           VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPO_GET_INDIR_ACCT_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');
    ---------------------------------------------------
    -- Retrieve the value for the Expenditure Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '30';
    LV_EXPENDITURE_TYPE := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                                     ITEMKEY  => P_ITEMKEY,
                                                     ANAME    => 'EXPENDITURE_TYPE');
    ---------------------------------------------------
    -- Retrieve the value for the Task Service Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '30.1';
    LV_TASK_SERVICE_TYPE := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                                      ITEMKEY  => P_ITEMKEY,
                                                      ANAME    => 'TASK_SERVICE_TYPE');
    ---------------------------------------------------
    -- Retrieve the value for the Project Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '40';

    SELECT PPTA.PROJECT_TYPE
      INTO LV_PROJECT_TYPE
      FROM PA_PROJECTS_ALL PPA,
	       PA_PROJECT_TYPES_ALL PPTA
     WHERE PPTA.PROJECT_TYPE = PPA.PROJECT_TYPE
       AND PPTA.ORG_ID = PPA.ORG_ID
       AND PPA.PROJECT_ID = LN_PROJECT_ID;

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Project Type is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '50';
    IF LV_PROJECT_TYPE IS NULL
	THEN
      RAISE NO_PROJECT_TYPE;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Lookup Set Name
    ---------------------------------------------------
    GV_ERROR_STAGE := '60';
    SELECT PSVL.SEGMENT_VALUE
      INTO LV_SEGMENT_VALUE
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
       AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = UPPER(LV_SEGMENT_LOOKUP_SET_NAME)
       AND UPPER(PSVL.SEGMENT_VALUE_LOOKUP) = UPPER(LV_PROJECT_TYPE);

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the segment value is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '70';
    IF LV_SEGMENT_VALUE IS NULL
	THEN
      RAISE NO_SEGMENT_VALUE;
    END IF;

    --------------------------------------------------------------
    -- Retrieve the value for the Lookup Set Name
    --------------------------------------------------------------
    GV_ERROR_STAGE := '80';

    SELECT LTRIM(RTRIM(PSVL.SEGMENT_VALUE))
      INTO LV_SEGMENT_VALUE1
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
       AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = UPPER(LV_SEGMENT_VALUE)
       AND UPPER(PSVL.SEGMENT_VALUE_LOOKUP) = UPPER(LV_TASK_SERVICE_TYPE);

    ------------------------------------------------------------------------------
    -- Raise the appropriate exception if the segment value1 is not found
    ------------------------------------------------------------------------------
    GV_ERROR_STAGE := '90';
    IF LV_SEGMENT_VALUE1 IS NULL
	THEN
      RAISE NO_SEGMENT_VALUE1;
    END IF;

    --------------------------------------------------------------
    -- Retrieve the value for the Segment Acct Value
    --------------------------------------------------------------
    GV_ERROR_STAGE := '80.1';

    /*          SELECT LTRIM(RTRIM(psvl.segment_value))   ---Commented by Ashu
                         INTO LV_SEGMENT_ACCT_VALUE
                         FROM PA_SEGMENT_VALUE_LOOKUP_SETS psv,
                              PA_SEGMENT_VALUE_LOOKUPS     psvl
                        WHERE psvl.segment_value_lookup_set_id =
                                                         psv.segment_value_lookup_set_id
                          AND UPPER(psv.segment_value_lookup_set_name)   =
                                                        UPPER(LV_SEGMENT_VALUE1)
                          AND UPPER(psvl.segment_value_lookup) = UPPER(LV_EXPENDITURE_TYPE);
    */

    ------------------------------------------------------------------------------
    -- Raise the appropriate exception if the Segment CCtr Value is not found
    ------------------------------------------------------------------------------
    GV_ERROR_STAGE := '90.1';
    /*IF LV_SEGMENT_ACCT_VALUE IS NULL   ---Commented by Ashu
     THEN
       RAISE no_segment_acct_value;
     END IF;
    */
    ------------------------------------------------------------------------------
    -- Set the Segment CCtr Value To Lookup Value
    ------------------------------------------------------------------------------

    GV_ERROR_STAGE := '100';
    /* wf_engine.SetItemAttrText( itemtype => p_itemtype,
               itemkey  => p_itemkey,
               aname  => 'LOOKUP_SET_VALUE',
               avalue => LV_SEGMENT_ACCT_VALUE);  ---changed by Ashu
    */

    WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                              ITEMKEY  => P_ITEMKEY,
                              ANAME    => 'LOOKUP_SET_VALUE',
                              AVALUE   => LV_SEGMENT_VALUE1); ---changed by Ashu

    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not defined
    ------------------------------------------------------------------
    WHEN NO_PROJECT_TYPE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Project Type is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Project Type is not found for the Project entered. ' ||
                            'Please Enter CAPITAL or INDIRECT Project Types Only.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    --------------------------------------------------------------------
    -- User defined exception raised when Acct lookup set is not defined
    --------------------------------------------------------------------
    WHEN NO_SEGMENT_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => ' Acct Lookup Set is Not Defined or Project Type Lookup Set is Invalid');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Unable to Determine Account Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set/ Value is not defined
    ------------------------------------------------------------------------------
    WHEN NO_SEGMENT_VALUE1 THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Task Service Type Lookup Set : ' || LV_SEGMENT_VALUE1,
                      ARG5      => 'Service Type Lookup Set is Not Defined or Project Type Lookup Set is Invalid');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Task Service Type : ' || LV_TASK_SERVICE_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Unable to Determine Account Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set/ Value is not defined
    ------------------------------------------------------------------------------
    WHEN NO_SEGMENT_ACCT_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Project Type Lookup Set or Value is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Unable to Determine Account Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ----------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ----------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Acct Lookup Set Or Project Type Lookup Set Or Lookup value is Invalid Or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Unable to Determine Account Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ---------------------------------------------------------
    -- All other exceptions are raised to the calling program
    ---------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);

      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                       P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                       P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                       P_ARG1          => LV_SEGMENT_LOOKUP_SET_NAME,
                                                       P_ARG2          => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_INDIR_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Expenditure Type : ' || LV_EXPENDITURE_TYPE,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_GET_INDIR_ACCT_PROC');

      RETURN;
  END XXPA_GET_INDIR_ACCT_PROC;

  /*
     ----------------------------------------------------------------------------------
     PROCEDURE NAME: XXPA_GET_PROD_CODE_PROC
     DESCRIPTION: Procedure to be called from the Project Supplier Invoice,PO and
                  PO Requisition Account Generator To Generate Accounting Flex Field.
     PARAMETERS:
                 p_itemtype           :   Workflow Item Type(Internal Name)
                 p_itemkey            :   Workflow Item Key
                 p_actid              :   Workflow Activity Id
                 p_funcmode           :   Workflow Function Mode
                 x_result             :   Workflow return result Type
     -----------------------------------------------------------------------------------
  */

  PROCEDURE XXPA_GET_PROD_CODE_PROC(P_ITEMTYPE IN VARCHAR2,
                                    P_ITEMKEY  IN VARCHAR2,
                                    P_ACTID    IN NUMBER,
                                    P_FUNCMODE IN VARCHAR2,
                                    X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID              PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LN_TASK_ID                 PA_TASKS.TASK_ID%TYPE;
    LV_PROJECT_TYPE            PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LV_SEGMENT_LOOKUP_SET_NAME PA_SEGMENT_VALUE_LOOKUP_SETS.SEGMENT_VALUE_LOOKUP_SET_NAME%TYPE := 'Proj Type to Indir Prod Lookup';
    LV_SEGMENT_VALUE           PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_SEGMENT_VALUE_EXP_TYPE  PA_SEGMENT_VALUE_LOOKUPS.SEGMENT_VALUE%TYPE;
    LV_EXPENDITURE_TYPE        PA_EXPENDITURE_TYPES.EXPENDITURE_TYPE%TYPE;
    LV_ATTRIBUTE1              PA_TASKS.ATTRIBUTE1%TYPE;
    LV_OLD_ERROR_STACK         VARCHAR2(500);
    NO_PROJECT_TYPE            EXCEPTION;
    NO_SEGMENT_VALUE           EXCEPTION;
    NO_EXP_TYPE_VALUE          EXCEPTION;
    NO_ATTRIBUTE1_VALUE        EXCEPTION;
    LV_ERROR_MESSAGE           VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPO_GET_PROD_CODE_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');
    ---------------------------------------------------
    -- Retrieve the value for the Task Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '30';
    LN_TASK_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'TASK_ID');
    ---------------------------------------------------
    -- Retrieve the value for the Expenditure Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '40';
    LV_EXPENDITURE_TYPE := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                                     ITEMKEY  => P_ITEMKEY,
                                                     ANAME    => 'EXPENDITURE_TYPE');
    ---------------------------------------------------
    -- Retrieve the value for the Project Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '50';

    SELECT PPTA.PROJECT_TYPE
      INTO LV_PROJECT_TYPE
      FROM PA_PROJECTS_ALL PPA,
	       PA_PROJECT_TYPES_ALL PPTA
     WHERE PPTA.PROJECT_TYPE = PPA.PROJECT_TYPE
       AND PPTA.ORG_ID = PPA.ORG_ID
       AND PPA.PROJECT_ID = LN_PROJECT_ID;

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Project Type is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '60';
    IF LV_PROJECT_TYPE IS NULL
	THEN
      RAISE NO_PROJECT_TYPE;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Lookup Set Name
    ---------------------------------------------------
    GV_ERROR_STAGE := '70';
    SELECT PSVL.SEGMENT_VALUE
      INTO LV_SEGMENT_VALUE
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
       AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = UPPER(LV_SEGMENT_LOOKUP_SET_NAME)
       AND UPPER(PSVL.SEGMENT_VALUE_LOOKUP) = UPPER(LV_PROJECT_TYPE);

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the segment value is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '80';
    IF LV_SEGMENT_VALUE IS NULL
	THEN
      RAISE NO_SEGMENT_VALUE;
    END IF;

    --------------------------------------------------------------
    -- Retrieve the value for the Segment Value Exp Type
    --------------------------------------------------------------
    GV_ERROR_STAGE := '90';
    SELECT LTRIM(RTRIM(PSVL.SEGMENT_VALUE))
      INTO LV_SEGMENT_VALUE_EXP_TYPE
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
       AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = UPPER(LV_SEGMENT_VALUE)
       AND UPPER(PSVL.SEGMENT_VALUE_LOOKUP) = UPPER(LV_EXPENDITURE_TYPE);

    ------------------------------------------------------------------------------
    -- Raise the appropriate exception if the Segment Value Exp Type is not found
    ------------------------------------------------------------------------------
    GV_ERROR_STAGE := '100';
    IF LV_SEGMENT_VALUE_EXP_TYPE IS NULL
	THEN
      RAISE NO_EXP_TYPE_VALUE;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Task Attribute1
    ---------------------------------------------------
    GV_ERROR_STAGE := '110';
    SELECT CONCAT(SUBSTR(TO_CHAR(NVL(ATTRIBUTE1, 'X')), 1, 3), LV_SEGMENT_VALUE_EXP_TYPE)
      INTO LV_ATTRIBUTE1
      FROM PA_TASKS
     WHERE TASK_ID = LN_TASK_ID;

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Attribute1 is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '120';
    IF LENGTH(LV_ATTRIBUTE1) <> 5
	THEN
      RAISE NO_ATTRIBUTE1_VALUE;
    END IF;

    GV_ERROR_STAGE := '130';
    WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                              ITEMKEY  => P_ITEMKEY,
                              ANAME    => 'LOOKUP_SET_VALUE',
                              AVALUE   => LV_ATTRIBUTE1);

    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not defined
    ------------------------------------------------------------------
    WHEN NO_PROJECT_TYPE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Project Type is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Project Type is not found for the Project entered. ' ||
                            'Please Enter CAPITAL or INDIRECT Project Types Only.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    -------------------------------------------------------------------------
    -- User defined exception raised when Prod Code lookup set is not defined
    -------------------------------------------------------------------------
    WHEN NO_SEGMENT_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => ' Prod Lookup Set is Not Defined or Project Type Lookup Set is Invalid');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Unable to Determine Product Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set is not defined
    ------------------------------------------------------------------------
    WHEN NO_EXP_TYPE_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Project Type Lookup Set is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Unable to Determine Product Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set is not defined
    ------------------------------------------------------------------------
    WHEN NO_ATTRIBUTE1_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Length of Combination of Task Attribute1 and Prod Code Lookup is Not Equal To 5');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Product Segment Value : ' || LV_ATTRIBUTE1 || '. ' ||
                            'Unable to Determine Product Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ------------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Prod Lookup Set Or Project Type Lookup Set Or Lookup value is Invalid Or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'The lookup set/intermediate value combination has not been defined. ' ||
                            'Define the segment value obtained by the lookup set/intermediate value combination, using the AutoAccounting Lookup Sets window. ' ||
                            'Lookup Set Name : ' ||
                            LV_SEGMENT_LOOKUP_SET_NAME || '. ' ||
                            'Project Type : ' || LV_PROJECT_TYPE || '. ' ||
                            'Expenditure Type : ' || LV_EXPENDITURE_TYPE || '. ' ||
                            'Product Segment Value : ' || LV_ATTRIBUTE1 || '. ' ||
                            'Unable to Determine Product Segment.');

      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);
      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    -----------------------------------------------------------
    -- All other exceptions are raised to the calling program
    -----------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG1          => LV_SEGMENT_LOOKUP_SET_NAME,
                                                      P_ARG2          => 'Project Id : ' || LN_PROJECT_ID);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG3      => 'LV_SEGMENT_LOOKUP_SET_NAME : ' || LV_SEGMENT_LOOKUP_SET_NAME,
                      ARG4      => 'Project Type Lookup Set : ' || LV_SEGMENT_VALUE,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_GET_PROD_CODE_PROC');
      RETURN;
  END XXPA_GET_PROD_CODE_PROC;

  PROCEDURE XXPA_GET_CONTR_PROD_CODE_PROC(P_ITEMTYPE IN VARCHAR2,
                                          P_ITEMKEY  IN VARCHAR2,
                                          P_ACTID    IN NUMBER,
                                          P_FUNCMODE IN VARCHAR2,
                                          X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID       PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LN_TASK_ID          PA_TASKS.TASK_ID%TYPE;
    LV_PROJECT_TYPE     PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LV_ATTRIBUTE1       PA_TASKS.ATTRIBUTE1%TYPE;
    LV_OLD_ERROR_STACK  VARCHAR2(500);
    NO_PROJECT_TYPE     EXCEPTION;
    NO_SEGMENT_VALUE    EXCEPTION;
    NO_EXP_TYPE_VALUE   EXCEPTION;
    NO_ATTRIBUTE1_VALUE EXCEPTION;
    LV_ERROR_MESSAGE    VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPA_GET_CONTRACT_PROD_CODE_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');

    ---------------------------------------------------
    -- Retrieve the value for the Task Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '30';
    LN_TASK_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'TASK_ID');

    ---------------------------------------------------
    -- Retrieve the value for the Task Attribute1
    ---------------------------------------------------
    GV_ERROR_STAGE := '110';

    SELECT NVL(ATTRIBUTE1, 'X')
      INTO LV_ATTRIBUTE1
      FROM PA_TASKS
     WHERE TASK_ID = LN_TASK_ID;

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Attribute1 is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '120';
    IF LV_ATTRIBUTE1 = 'X'
	THEN
      RAISE NO_ATTRIBUTE1_VALUE;
    END IF;

    GV_ERROR_STAGE := '130';
    WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                              ITEMKEY  => P_ITEMKEY,
                              ANAME    => 'LOOKUP_SET_VALUE',
                              AVALUE   => LV_ATTRIBUTE1);

    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set is not defined
    ------------------------------------------------------------------------
    WHEN NO_ATTRIBUTE1_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_CONTRACT_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Task Attribute1 has no value');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Product Segment Value : ' || LV_ATTRIBUTE1 || '. ' ||
                            'Unable to Determine Product Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ------------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_CONTRACT_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Task Attribute1 Value not found');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Product Segment Value : ' || LV_ATTRIBUTE1 || '. ' ||
                            'Unable to Determine Product Segment.');

      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);
      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    -----------------------------------------------------------
    -- All other exceptions are raised to the calling program
    -----------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);

      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG2          => 'Project Id : ' || LN_PROJECT_ID);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_CONTRACT_PROD_CODE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_GET_CONTRACT_PROD_CODE_PROC');

      RETURN;
  END XXPA_GET_CONTR_PROD_CODE_PROC;

  PROCEDURE XXPA_GET_LABOR_WIP_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                         P_ITEMKEY  IN VARCHAR2,
                                         P_ACTID    IN NUMBER,
                                         P_FUNCMODE IN VARCHAR2,
                                         X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID      PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LN_TASK_ID         PA_TASKS.TASK_ID%TYPE;
    LV_PROJECT_TYPE    PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    L_VALUE            PA_RULES.CONSTANT_VALUE%TYPE;
    LV_OLD_ERROR_STACK VARCHAR2(500);
    NO_PROJECT_TYPE    EXCEPTION;
    NO_SEGMENT_VALUE   EXCEPTION;
    NO_EXP_TYPE_VALUE  EXCEPTION;
    NO_VALUE           EXCEPTION;
    LV_ERROR_MESSAGE   VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPA_GET_LABOR_WIP_ACCT_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the '3 Constant Labor WIP Account' AutoAccounting Rule.
    ---------------------------------------------------
    GV_ERROR_STAGE := '110';
    SELECT NVL(CONSTANT_VALUE, 'X')
      INTO L_VALUE
      FROM PA_RULES
     WHERE RULE_NAME = '3 Constant Labor WIP Account'
       AND KEY_SOURCE = 'C';

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Attribute1 is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '120';
    IF L_VALUE = 'X' THEN
      RAISE NO_VALUE;
    END IF;

    GV_ERROR_STAGE := '130';
    WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                              ITEMKEY  => P_ITEMKEY,
                              ANAME    => 'LOOKUP_SET_VALUE',
                              AVALUE   => L_VALUE);

    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set is not defined
    ------------------------------------------------------------------------
    WHEN NO_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_LABOR_WIP_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => '3 Constant Labor WIP Account autoaccounting rule has no value');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'account Segment Value : ' || L_VALUE || '. ' ||
                            'Unable to Determine account Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ------------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_LABOR_WIP_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => '3 Constant Labor WIP Account autoaccounting rule has no value');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Account Segment Value : ' || L_VALUE || '. ' ||
                            'Unable to Determine account Segment.');

      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);
      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    -----------------------------------------------------------
    -- All other exceptions are raised to the calling program
    -----------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG2          => 'Project Id : ' || LN_PROJECT_ID);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_LABOR_WIP_ACCT_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_GET_LABOR_WIP_ACCT_PROC');

      RETURN;
  END XXPA_GET_LABOR_WIP_ACCT_PROC;

  PROCEDURE XXPA_GET_NONBILLABLE_CCTR_PROC(P_ITEMTYPE IN VARCHAR2,
                                           P_ITEMKEY  IN VARCHAR2,
                                           P_ACTID    IN NUMBER,
                                           P_FUNCMODE IN VARCHAR2,
                                           X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID         PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LV_PROJECT_TYPE       PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    L_TASK                PA_TASKS.TASK_NUMBER%TYPE;
    L_SERVICE_CODE        PA_TASKS.SERVICE_TYPE_CODE%TYPE;
    LV_OLD_ERROR_STACK    VARCHAR2(500);
    NO_SERVICE_CODE_TYPE  EXCEPTION;
    NO_SEGMENT_VALUE      EXCEPTION;
    NO_SEGMENT_CCTR_VALUE EXCEPTION;
    LV_ERROR_MESSAGE      VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPO_GET_NONBILLABLE_CCTR_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');

    ---------------------------------------------------
    -- Retrieve the value for the Task
    ---------------------------------------------------
    GV_ERROR_STAGE := '30';
    L_TASK := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                        ITEMKEY  => P_ITEMKEY,
                                        ANAME    => 'TASK_NUMBER');

    ---------------------------------------------------
    -- Retrieve the value for the Service Type Code
    ---------------------------------------------------
    GV_ERROR_STAGE := '40';
    SELECT SUBSTR(LOOKUP_CODE, 1, 5)
      INTO L_SERVICE_CODE
      FROM PA_TASKS PT,
	       FND_LOOKUP_VALUES_VL FL
     WHERE PROJECT_ID = LN_PROJECT_ID
       AND TASK_NUMBER = L_TASK
       AND FL.LOOKUP_CODE = SUBSTR(PT.SERVICE_TYPE_CODE, 1, 5)
       AND FL.LOOKUP_TYPE = 'SERVICE TYPE'
       AND FL.ENABLED_FLAG = 'Y'
       AND TRUNC(SYSDATE) BETWEEN FL.START_DATE_ACTIVE AND NVL(FL.END_DATE_ACTIVE, TRUNC(SYSDATE) + 1);

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the SERVICE TYPE CODE  is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '50';
    IF L_SERVICE_CODE IS NULL
	THEN
      RAISE NO_SERVICE_CODE_TYPE;
    END IF;

    ------------------------------------------------------------------------------
    -- Set the Segment CCtr Value To Lookup Value
    ------------------------------------------------------------------------------
    GV_ERROR_STAGE := '100';
    WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                              ITEMKEY  => P_ITEMKEY,
                              ANAME    => 'LOOKUP_SET_VALUE',
                              AVALUE   => L_SERVICE_CODE);

    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not defined
    ------------------------------------------------------------------
    WHEN NO_SERVICE_CODE_TYPE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_NONBILLABLE_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Service Type code : ' || L_SERVICE_CODE,
                      ARG5      => 'Task service type code is invalid or not defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Task service type code is invalid or not defined. ' ||
                            'Please Enter the task service type code.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ----------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ----------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_NONBILLABLE_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task NUMBER : ' || L_TASK,
                      ARG5      => 'Task service type code is invalid or not defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Requisition Account Generator failed to generate the default account. ' ||
                            'Task service type code is invalid or not defined. ' ||
                            'Define the Task Service Type Code ' ||
                            'Unable to Determine Cost Center Segment.');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ---------------------------------------------------------
    -- All other exceptions are raised to the calling program
    ---------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);

      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG1          => LN_PROJECT_ID,
                                                      P_ARG2          => 'Task Service Type code : ' || L_SERVICE_CODE);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_GET_NONBILLABLE_CCTR_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task NUMBER : ' || L_TASK,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_GET_NONBILLABLE_CCTR_PROC');

      RETURN;
  END XXPA_GET_NONBILLABLE_CCTR_PROC;

  PROCEDURE XXPA_VAL_PROJ_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                    P_ITEMKEY  IN VARCHAR2,
                                    P_ACTID    IN NUMBER,
                                    P_FUNCMODE IN VARCHAR2,
                                    X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID      PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LV_PROJECT_TYPE    PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LN_CCID            GL_CODE_COMBINATIONS.CODE_COMBINATION_ID%TYPE;
    LN_S_CCID          GL_CODE_COMBINATIONS.CODE_COMBINATION_ID%TYPE;
    LV_ACCOUNT         GL_CODE_COMBINATIONS.SEGMENT4%TYPE;
    LV_S_ACCOUNT       GL_CODE_COMBINATIONS.SEGMENT4%TYPE;
    LN_COUNT           NUMBER DEFAULT NULL;
    LV_CONCAT_SEGMENTS VARCHAR2(100);
    LV_OLD_ERROR_STACK VARCHAR2(500) DEFAULT 'XXPA_VAL_PROJ_ACCT_PROC';
    --Exception Types
    NO_PROJECT_EXCEPION EXCEPTION;
    LV_ERROR_MESSAGE    VARCHAR2(2000) DEFAULT NULL;

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
/*    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' ||
                         'XXPA_VAL_PROJ_ACCT_PROC';*/
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for Code combination_id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_CCID       := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'CODE_COMBINATION_ID');
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'PROJECT_ID');
    GV_ERROR_STAGE := '40';
    IF LN_CCID IS NOT NULL
	THEN
      ---------------------------------------------------
      -- Retrieve the value for the Project Id
      ---------------------------------------------------
      GV_ERROR_STAGE := '50';

      SELECT SEGMENT4
        INTO LV_ACCOUNT
        FROM GL_CODE_COMBINATIONS
       WHERE CODE_COMBINATION_ID = LN_CCID;

      ------------------------------------------------------------------------
      -- Raise the appropriate exception if the Project is not found
      ------------------------------------------------------------------------
      GV_ERROR_STAGE := '60';

      SELECT COUNT(1)
        INTO LN_COUNT
        FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
             PA_SEGMENT_VALUE_LOOKUPS     PSVL
       WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
         AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = 'XXPA_ASSET_ACCOUNTS'
         AND LV_ACCOUNT LIKE PSVL.SEGMENT_VALUE || '%';

      IF LN_COUNT <> 0
	  THEN
        IF LN_PROJECT_ID IS NOT NULL
		THEN
          X_RESULT := 'COMPLETE:SUCCESS';
        ELSE
          RAISE NO_PROJECT_EXCEPION;
        END IF;
      ELSE
        X_RESULT := 'COMPLETE:SUCCESS';
      END IF;
    END IF;

    X_RESULT := 'COMPLETE:SUCCESS';
  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not there on PO
    ------------------------------------------------------------------
    WHEN NO_PROJECT_EXCEPION THEN
      -- Record standard workflow debugging message
      --LV_ERROR_MESSAGE := 'All asset accounts (168xxx, 165xxx, 175xxx and 1954xx) require a project number.  Please enter the required project information or update Segment 4 of the Account Code combination';
      --above line commented and below line added by soniya for CR3668
      LV_ERROR_MESSAGE := 'All asset accounts (168xxx, 165xxx, 175xxx, 1954xx and 1322xx) require a project number.  Please enter the required project information or update Segment 4 of the Account Code combination';
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_PROJ_ACCT_PROC',
                      ARG1      => 'Code combination Id : ' || LN_CCID,
                      ARG2      => 'Account : ' || LV_ACCOUNT,
                      ARG5      => 'Asset Accounts Requires a Project');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE', LV_ERROR_MESSAGE);
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;
    WHEN OTHERS THEN
      LV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => LV_OLD_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => LV_ERROR_MESSAGE,
                                                      P_ARG1          => LN_CCID,
                                                      P_ARG2          => 'LV_ACCOUNT : ' || LV_ACCOUNT);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_PROJ_ACCT_PROC',
                      ARG1      => 'Code combination Id : ' || LN_CCID,
                      ARG2      => 'Account : ' || LV_ACCOUNT,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_VAL_PROJ_ACCT_PROC');
      RETURN;
  END XXPA_VAL_PROJ_ACCT_PROC;

  /*PROCEDURE XXPA_VAL_ASS_ACCT_PROC(P_ITEMTYPE IN VARCHAR2,
                                   P_ITEMKEY  IN VARCHAR2,
                                   P_ACTID    IN NUMBER,
                                   P_FUNCMODE IN VARCHAR2,
                                   X_RESULT   OUT VARCHAR2) AS
    LN_PROJECT_ID   PA_PROJECTS_ALL.PROJECT_ID%TYPE DEFAULT NULL;
    LV_PROJECT_TYPE PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LN_CCID         GL_CODE_COMBINATIONS.CODE_COMBINATION_ID%TYPE DEFAULT NULL;
    LV_ACCOUNT      GL_CODE_COMBINATIONS.SEGMENT4%TYPE;
    LN_COUNT        NUMBER := 0;

    LV_OLD_ERROR_STACK VARCHAR2(500);
    --Exception Types
    NO_PROJECT_EXCEPION EXCEPTION;
    LV_ERROR_MESSAGE VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------

    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPA_VAL_ASS_ACCT_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN' THEN
      X_RESULT := NULL;
      RETURN;
    END IF;
    XXPA_ACC_GEN_TEST_PROC(GV_ERROR_STAGE, 'LN_CCID#' || LN_CCID);
    XXPA_ACC_GEN_TEST_PROC(GV_ERROR_STAGE, 'LN_PROJECT_ID#' || LN_PROJECT_ID);
    ---------------------------------------------------
    -- Retrieve the value for Code combination_id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';

    LN_CCID       := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'DIST_CODE_COMBINATION_ID');
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'PROJECT_ID');
    XXPA_ACC_GEN_TEST_PROC(GV_ERROR_STAGE, 'LN_CCID#' || LN_CCID);
    XXPA_ACC_GEN_TEST_PROC(GV_ERROR_STAGE, 'LN_PROJECT_ID#' || LN_PROJECT_ID);
    GV_ERROR_STAGE := '30';
    IF LN_CCID IS NOT NULL THEN
      ---------------------------------------------------
      -- Retrieve the value for the Project Id
      ---------------------------------------------------
      XXPA_ACC_GEN_TEST_PROC(GV_ERROR_STAGE, 'LV_ACCOUNT#' || LV_ACCOUNT);
      GV_ERROR_STAGE := '40';

      SELECT SEGMENT4
        INTO LV_ACCOUNT
        FROM GL_CODE_COMBINATIONS
       WHERE CODE_COMBINATION_ID = LN_CCID;

      XXPA_ACC_GEN_TEST_PROC(GV_ERROR_STAGE, 'LV_ACCOUNT#' || LV_ACCOUNT);
      XXPA_ACC_GEN_TEST_PROC(LN_COUNT, 'LV_ACCOUNT#' || LN_COUNT);
      ------------------------------------------------------------------------
      -- Raise the appropriate exception if the Project is not found
      ------------------------------------------------------------------------
      GV_ERROR_STAGE := '50';

      SELECT COUNT(1)
        INTO LN_COUNT
        FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
             PA_SEGMENT_VALUE_LOOKUPS     PSVL
       WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID =
             PSV.SEGMENT_VALUE_LOOKUP_SET_ID
         AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) =
             'XXPA_ASSET_ACCOUNTS'
         AND LV_ACCOUNT LIKE PSVL.SEGMENT_VALUE || '%';
      IF LN_COUNT <> 0 THEN
        IF LN_PROJECT_ID IS NOT NULL THEN

          X_RESULT := 'COMPLETE:SUCCESS';
        ELSE
          RAISE NO_PROJECT_EXCEPION;
        END IF;
      ELSE
        X_RESULT := 'COMPLETE:SUCCESS';
      END IF;
    END IF;
    X_RESULT := 'COMPLETE:SUCCESS';
  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not there on PO
    ------------------------------------------------------------------
    WHEN NO_PROJECT_EXCEPION THEN
      -- Record standard workflow debugging message
      LV_ERROR_MESSAGE := 'All asset accounts (168xxx, 165xxx, 175xxx and 1954xx) require a project number.  Please enter the required project information or update Segment 4 of the Account Code combination';
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_ASS_ACCT_PROC',
                      ARG1      => 'Code combination Id : ' || LN_CCID,
                      ARG2      => 'Account : ' || LV_ACCOUNT,
                      ARG5      => 'Asset Accounts Requires a Project');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE', LV_ERROR_MESSAGE);
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);

      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG1          => LN_CCID,
                                                      P_ARG2          => 'LV_ACCOUNT : ' ||
                                                                         LV_ACCOUNT);

      -- populate the error message wf attribute and return failure.

      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_ASS_ACCT_PROC',
                      ARG1      => 'Code combination Id : ' || LN_CCID,
                      ARG2      => 'Account : ' || LV_ACCOUNT,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_VAL_ASS_ACCT_PROC');

      RETURN;
  END XXPA_VAL_ASS_ACCT_PROC;*/
  /*
     ----------------------------------------------------------------------------------
     PROCEDURE NAME: XXPA_VAL_PROJ_TYPE_PROC
     DESCRIPTION: Procedure to be called from the Project Supplier Invoice,PO and
                  PO Requisition Account Generator To Generate Accounting Flex Field.
     PARAMETERS:
                 p_itemtype           :   Workflow Item Type(Internal Name)
                 p_itemkey            :   Workflow Item Key
                 p_actid              :   Workflow Activity Id
                 p_funcmode           :   Workflow Function Mode
                 x_result             :   Workflow return result Type
     -----------------------------------------------------------------------------------
  */

  PROCEDURE XXPA_VAL_PROJ_TYPE_PROC(P_ITEMTYPE IN VARCHAR2,
                                    P_ITEMKEY  IN VARCHAR2,
                                    P_ACTID    IN NUMBER,
                                    P_FUNCMODE IN VARCHAR2,
                                    X_RESULT   OUT VARCHAR2)
  AS
    LN_PROJECT_ID       PA_PROJECTS_ALL.PROJECT_ID%TYPE;
    LN_TASK_ID          PA_TASKS.TASK_ID%TYPE;
    LV_PROJECT_TYPE     PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LV_PROJECT_TYPE_OUT PA_PROJECT_TYPES_ALL.PROJECT_TYPE%TYPE;
    LV_OLD_ERROR_STACK  VARCHAR2(500);
    NO_PROJECT_TYPE     EXCEPTION;
    NO_CIP_TYPE_VALUE   EXCEPTION;
    NO_ATTRIBUTE1_VALUE EXCEPTION;
    LV_ERROR_MESSAGE    VARCHAR2(2000);

  BEGIN
    -----------------------------------------------------------------------
    -- Check the Workflow mode in which this function has been called. If
    -- it is not in the RUN mode, then exit out of this function
    -----------------------------------------------------------------------
    LV_OLD_ERROR_STACK := GV_ERROR_STACK;
    GV_ERROR_STACK     := GV_ERROR_STACK || '-->' || 'XXPO_GET_PROD_CODE_PROC';
    GV_ERROR_STAGE     := '10';

    IF P_FUNCMODE <> 'RUN'
	THEN
      X_RESULT := NULL;
      RETURN;
    END IF;

    ---------------------------------------------------
    -- Retrieve the value for the Project Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '20';
    LN_PROJECT_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                                 ITEMKEY  => P_ITEMKEY,
                                                 ANAME    => 'PROJECT_ID');

    ---------------------------------------------------
    -- Retrieve the value for the Task Id
    ---------------------------------------------------
    GV_ERROR_STAGE := '30';
    LN_TASK_ID := WF_ENGINE.GETITEMATTRNUMBER(ITEMTYPE => P_ITEMTYPE,
                                              ITEMKEY  => P_ITEMKEY,
                                              ANAME    => 'TASK_ID');

    ---------------------------------------------------
    -- Retrieve the value for the Project Type
    ---------------------------------------------------
    GV_ERROR_STAGE := '40';

    SELECT PPTA.PROJECT_TYPE
      INTO LV_PROJECT_TYPE
      FROM PA_PROJECTS_ALL PPA,
	       PA_PROJECT_TYPES_ALL PPTA
     WHERE PPTA.PROJECT_TYPE = PPA.PROJECT_TYPE
       AND PPTA.ORG_ID = PPA.ORG_ID
       AND PPA.PROJECT_ID = LN_PROJECT_ID;

    ------------------------------------------------------------------------
    -- Raise the appropriate exception if the Project Type is not found
    ------------------------------------------------------------------------
    GV_ERROR_STAGE := '50';
    IF LV_PROJECT_TYPE IS NULL THEN
      RAISE NO_PROJECT_TYPE;
    END IF;

    --------------------------------------------------------------
    -- check the  Work type value for CIP, if not CIP, raise exception  NO_CIP_TYPE_VALUE
    --------------------------------------------------------------
    GV_ERROR_STAGE := '60';
    IF LV_PROJECT_TYPE = 'Multiple CIP'
	THEN
      --------------------------------------------------------------
      -- Retrieve the Work type value for the task
      --------------------------------------------------------------
      GV_ERROR_STAGE := '70';
      SELECT PWT.NAME
        INTO LV_PROJECT_TYPE_OUT
        FROM PA_PROJECTS_ALL PPA,
		     PA_TASKS PT,
			 PA_WORK_TYPES_V PWT
       WHERE PPA.PROJECT_ID = PT.PROJECT_ID
         AND PPA.PROJECT_TYPE = 'Multiple CIP'
         AND PT.WORK_TYPE_ID = PWT.WORK_TYPE_ID
         AND PPA.PROJECT_ID = LN_PROJECT_ID
         AND PT.TASK_ID = LN_TASK_ID;

      IF LV_PROJECT_TYPE_OUT NOT LIKE '%CIP%'
	  THEN
        RAISE NO_CIP_TYPE_VALUE;
      END IF;

      IF LV_PROJECT_TYPE_OUT = LV_PROJECT_TYPE
	  THEN
        WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                  ITEMKEY  => P_ITEMKEY,
                                  ANAME    => 'WORK_TYPE_NAME',
                                  AVALUE   => LV_PROJECT_TYPE);
      ELSE
        WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                  ITEMKEY  => P_ITEMKEY,
                                  ANAME    => 'WORK_TYPE_NAME',
                                  AVALUE   => LV_PROJECT_TYPE_OUT);
      END IF;

    ELSE
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'WORK_TYPE_NAME',
                                AVALUE   => LV_PROJECT_TYPE);

    END IF;
    X_RESULT := 'COMPLETE:SUCCESS';
    GV_ERROR_STACK := LV_OLD_ERROR_STACK;

  EXCEPTION
    ------------------------------------------------------------------
    -- User defined exception raised when project type is not defined
    ------------------------------------------------------------------
    WHEN NO_PROJECT_TYPE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_PROJ_TYPE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Project Type is Invalid or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Account Generator failed to generate the default account. ' ||
                            'Project Type is not found for the Project entered. ');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    ------------------------------------------------------------------------
    -- User defined exception raised when Project Lookup Set is not defined
    ------------------------------------------------------------------------
    WHEN NO_CIP_TYPE_VALUE THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_PROJ_TYPE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Work Type is Invalid or Not a CIP Type');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'The Account Code cannot be generated. Please contact the Projects group to set the Wrok Type on the task you have selected');
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;
      ------------------------------------------------------------------------
    -- If data is not found after the SELECT, it indicates that the
    -- combination of the lookup type and lookup code has not been defined
    ------------------------------------------------------------------------
    WHEN NO_DATA_FOUND THEN
      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_PROJ_TYPE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Prod Lookup Set Or Project Type Lookup Set Or Lookup value is Invalid Or Not Defined');

      FND_MESSAGE.SET_NAME('FND', 'ERROR_MESSAGE');
      FND_MESSAGE.SET_TOKEN('MESSAGE',
                            'No Work type defined for Project' ||
                            LN_PROJECT_ID || ' AND task ' || LN_TASK_ID);
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => FND_MESSAGE.GET_ENCODED);
      -- Return a failure so that the abort generation End function is called

      X_RESULT := 'COMPLETE:FAILURE';
      RETURN;

    -----------------------------------------------------------
    -- All other exceptions are raised to the calling program
    -----------------------------------------------------------
    WHEN OTHERS THEN
      GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      LV_ERROR_MESSAGE := PA_ACC_GEN_WF_PKG.SHOW_ERROR(P_ERROR_STACK   => GV_ERROR_STACK,
                                                      P_ERROR_STAGE   => GV_ERROR_STAGE,
                                                      P_ERROR_MESSAGE => GV_ERROR_MESSAGE,
                                                      P_ARG1          => LV_PROJECT_TYPE,
                                                      P_ARG2          => 'Project Id : ' || LN_PROJECT_ID);

      -- populate the error message wf attribute and return failure.
      WF_ENGINE.SETITEMATTRTEXT(ITEMTYPE => P_ITEMTYPE,
                                ITEMKEY  => P_ITEMKEY,
                                ANAME    => 'ERROR_MESSAGE',
                                AVALUE   => LV_ERROR_MESSAGE);

      -- Return a failure so that the abort generation End function is called
      X_RESULT := 'COMPLETE:FAILURE';

      -- Record standard workflow debugging message
      WF_CORE.CONTEXT(PKG_NAME  => 'XXPA_ACC_GEN_WF_CUSTOM_PKG',
                      PROC_NAME => 'XXPA_VAL_PROJ_TYPE_PROC',
                      ARG1      => 'Project Id : ' || LN_PROJECT_ID,
                      ARG2      => 'Task Id    : ' || LN_TASK_ID,
                      ARG5      => 'Other Exception In XXPA_ACC_GEN_WF_CUSTOM_PKG.XXPA_VAL_PROJ_TYPE_PROC');

      RETURN;
  END XXPA_VAL_PROJ_TYPE_PROC;

  --Below changes added for CR4776 - Workflow Account Generator Updates
  FUNCTION XXPA_VAL_PROJ_ACWIP_PROC (P_ACCOUNT IN VARCHAR2)
  RETURN VARCHAR2 IS
    LN_COUNT VARCHAR2(1) DEFAULT NULL;

  BEGIN
    SELECT 'Y'
      INTO LN_COUNT
      FROM PA_SEGMENT_VALUE_LOOKUP_SETS PSV,
	       PA_SEGMENT_VALUE_LOOKUPS PSVL
     WHERE PSVL.SEGMENT_VALUE_LOOKUP_SET_ID = PSV.SEGMENT_VALUE_LOOKUP_SET_ID
	   AND UPPER(PSV.SEGMENT_VALUE_LOOKUP_SET_NAME) = 'XXPA_ASSET_ACCOUNTS'
	   AND P_ACCOUNT LIKE PSVL.SEGMENT_VALUE || '%';
    RETURN LN_COUNT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END;

END XXPA_ACC_GEN_WF_CUSTOM_PKG;

/