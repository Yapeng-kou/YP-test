SET SERVEROUTPUT ON SIZE 1000000 LINES 132 TRIMOUT ON TAB OFF PAGES 100;

WHENEVER SQLERROR EXIT FAILURE ROLLBACK;

CREATE OR REPLACE PACKAGE xxpa_proj_task_crtn_pkg AS
    /******************************************************************************
    *                           - COPYRIGHT NOTICE -                              *
    *******************************************************************************
    ** Title       :    XXPA1559
    ** File        :    XPA_PROJ_TASK_CRTN_PKG.PKS
    ** Description :
    ** Parameters  :   {None}
    ** Run as      :    APPS
    ** Keyword Tracking:
    **
    **   $Header: xxpa/12.0.0/patch/115/sql/XXPA_PROJ_TASK_CRTN_PKG.pks 1.3 13-JUL-2016 16:15:15 CCBSSJ $
    **   $Change History$ (*ALL VERSIONS*)
    **   Revision 1.3 (COMPLETE)
    **     Created:  13-JUL-2016 16:15:15      CCBSSJ (Vishnusimman Manivannan)
    **       RT6579102 - Added new function check_missed_pjm_orgs merged with
    **       Panama Hub
    **
    **   Revision 1.2 (COMPLETE)
    **     Created:  06-MAR-2013 07:05:07      C-LTOSHN (Lalitha Toshniwal)
    **       Buffer in minutes parameter added to Procedure
    **
    **   Revision 1.1 (COMPLETE)
    **     Created:  21-SEP-2012 17:00:17      CCAZYS (None)
    **       Specification Upload
    **
    **   Revision 1.0 (COMPLETE)
    **     Created:  21-SEP-2012 15:52:37      CCAZYS (None)
    **       Initial revision.
    **
    **update by yapeng.kou 2024-06-13     Missing function for obtaining dates.
    *****************************************************************************/

    FUNCTION check_missed_pjm_orgs(p_project_id IN NUMBER) RETURN VARCHAR2; --Added for RT6579102

    PROCEDURE xxpa_proj_task_creatn_proc(p_errbuf              OUT VARCHAR2
                                        ,p_retcode             OUT VARCHAR2
                                        ,p_project_id          IN NUMBER
                                        ,p_check_for_agreement IN VARCHAR2
                                        ,p_buffer_lst_run_mins IN NUMBER);
    --add by yapeng.kou 2024-06-13
    FUNCTION f_get_last_run_dt(p_interface_num IN VARCHAR2) RETURN DATE;
    FUNCTION f_set_last_run_dt(p_interface_num IN VARCHAR2
                              ,p_date          IN VARCHAR2) RETURN BOOLEAN;
    --end by yapeng.kou 2024-06-13

END xxpa_proj_task_crtn_pkg;
/
SHOW ERRORS PACKAGE xxpa_proj_task_crtn_pkg;
/