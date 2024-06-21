
CREATE OR REPLACE PACKAGE BODY xxpa_contract_creation_pkg AS
/******************************************************************************
*                           - COPYRIGHT NOTICE -                              *
*******************************************************************************
** Title	:        XXPA1559
** File		:        xxpa_contract_creation_pkg.pkb
** Description	: 	 
** Parameters	:  	 {None}
** Run as	:        APPS
** Keyword Tracking:
**   
**   $Header: xxpa/12.0.0/patch/115/sql/xxpa_contract_creation_pkg.pkb 1.0 21-SEP-2012 03:06:20 C-LTOSHN $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  21-SEP-2012 03:06:20      C-LTOSHN (Lalitha Toshniwal)
**       Initial revision.
**   
** History:
** Date          Who                 Description
** -----------   ------------------  ------------------------------------------
** 10-Sep-2012   Lalitha Toshniwal   XXPA1559 Initial Creation               *
*****************************************************************************/
g_error_msg               VARCHAR2(2000);
g_request_id		  NUMBER;

PROCEDURE xxpa_contract_creation_proc(p_project_id  IN NUMBER)
IS 
  l_project_number 	    VARCHAR2(25);
  l_req_status    	    BOOLEAN;
  l_req_id                  NUMBER;
  e_submit_request          EXCEPTION;
BEGIN
     BEGIN
          SELECT segment1
          INTO   l_project_number
          FROM   pa_projects
          WHERE  project_id   = p_project_id;               
     EXCEPTION
     WHEN OTHERS THEN
          g_error_msg := SQLERRM;
          XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
     END;
          
     l_req_status := FND_SUBMIT.SET_REQUEST_SET ('XXPA','XXPA1559');  
     
     IF (l_req_status)
     THEN
         l_req_status := FND_SUBMIT.SUBMIT_PROGRAM ( 'XXPA',
						     'XXPA1559',
						     'STAGE10',
						      p_project_id,
                                                     'N'
					          );
     ELSE                 
         g_error_msg         := 'Failed to Set Request Set Context For Project Number :- '|| l_project_number;
         RAISE e_submit_request;
     END IF;
     
     IF (l_req_status)
     THEN
         l_req_status := FND_SUBMIT.SUBMIT_PROGRAM ('XXPA',
                                                    'XXPA1559_1',
                                                    'STAGE20',
                                                     p_project_id,
                                                    'N',
                                                    'Y'
     						   );
     ELSE           
         g_error_msg          := 'Failed to Submit Stage 10 For Project Number :- '|| l_project_number;
         RAISE e_submit_request;
     END IF;          
     
     -- Check 2nd STAGE of request set submitted successfully
     IF NOT l_req_status
     THEN
         g_error_msg         :='Failed to Submit Stage 20 For Project Number :- '|| l_project_number;
         RAISE e_submit_request;
     END IF;     
     
     l_req_id := FND_SUBMIT.SUBMIT_SET (NULL,FALSE);
           
     COMMIT;
     
     IF l_req_id <= 0
     THEN
         g_error_msg         := 'Failed to Submit Request Set For Project Number :- '|| l_project_number;
         RAISE e_submit_request;
     END IF;      
      
     g_request_id := l_req_id;

EXCEPTION
WHEN e_submit_request THEN
     ROLLBACK;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
WHEN OTHERS THEN  
     g_error_msg := SQLERRM;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_contract_creation_proc;

FUNCTION xxpa_contract_creation_request RETURN VARCHAR2
AS
BEGIN
     IF g_request_id IS NOT NULL 
     THEN   
         RETURN('XX Create Contract for Projects Request Set has been submitted with request id='||g_request_id);
     ELSE
         RETURN('XX Create Contract for Projects Request Set has not been submitted');
     END IF;
     g_request_id:=NULL;
EXCEPTION
WHEN OTHERS THEN  
     RETURN(NULL);
     g_error_msg := SQLERRM;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_contract_creation_request;
     
FUNCTION xxpa_contract_number(p_project_id  IN NUMBER) RETURN VARCHAR2
AS
  l_contract_number VARCHAR2(240);
BEGIN
     SELECT k_number_disp
       INTO l_contract_number
       FROM oke_k_headers    okh                               
      WHERE okh.project_id = p_project_id;
      
     RETURN('Contract '||l_contract_number ||' is already created for this Project.'); 
EXCEPTION
WHEN OTHERS THEN 
     RETURN(NULL);
     g_error_msg := SQLERRM;
     XX_PK_FND_FILE.PUT_LINE(XX_PK_FND_FILE.LOG,g_error_msg);
END xxpa_contract_number;

END xxpa_contract_creation_pkg;
/
