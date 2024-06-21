CREATE OR REPLACE PACKAGE APPS.XXPA_CONTRACT_CREATION_PMO_PKG 
AS 
PROCEDURE xxpa_contract_crtn_pmo_proc(p_errbuf                   OUT   VARCHAR2
                                     ,p_retcode                  OUT   VARCHAR2
                                     ,p_project_id                IN   NUMBER
                                     ,p_check_agreement_exists    IN   VARCHAR2
                                     ,p_chk_for_pjm_exists        IN   VARCHAR2
                                     ,p_invoke_from_tools_menu    IN   VARCHAR2 DEFAULT 'N');

PROCEDURE xxpa_contract_creation_proc(p_project_id  IN NUMBER);

FUNCTION xxpa_contract_creation_request RETURN VARCHAR2;

PROCEDURE xxpa_proj_task_mfgorg_proc(p_project_id  IN NUMBER);

FUNCTION xxpa_proj_task_mfgorg_request RETURN VARCHAR2;

FUNCTION xxpa_contract_number(p_project_id  IN NUMBER) RETURN VARCHAR2;

END XXPA_CONTRACT_CREATION_PMO_PKG;
/