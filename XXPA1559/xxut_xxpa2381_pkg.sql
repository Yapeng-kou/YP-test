create or replace package xxut_xxpa2381_pkg as
/******************************************************************************
** Program Name    : xxut_xxpa2381_pkg.sql
** Program Type    : PL/SQL Script
** Created By      : Jyotsana Kandpal
** Creation Date   : 12-AUG-2019
** Description     : Package listing test cases for SPECTRUM BOLT-ON 
**   $Header: xxut/12.0.0/sql/xxut_xxpa2381_pkg.sql  $
**   $Change History$ (*ALL VERSIONS*)
** ****************************************************************************
** Modification History
** Date      		Who          		Description
** ****************************************************************************
** 12-AUG-2019 		Jyotsana Kandpal     Initial Version--created for CR#24105
******************************************************************************/
  -- %suite(XX Project Creation Interface Test)
  -- %suitepath(XXPA.xxpa2381)
  -- %rollback(manual)
  
  -- %test(Test attachment creation at Project Level)
  procedure test_attach_project;
  -- %test(Test attachment creation at Task Level)
  procedure test_attach_task;
  -- %test(Test attachment creation at Project Funding Level)
  procedure test_attach_projfunding;
  -- %test(Test attachment creation at Agreement level)
  procedure test_attach_agr;


  TYPE rec_type_xxpa2381 IS RECORD( p_request_type			VARCHAR2(200),
									p_partner_code			VARCHAR2(200),
									p_ext_message_id        VARCHAR2(200),
									p_agreement_number		VARCHAR2(200),
									p_agreement_desc		VARCHAR2(200),
									p_cust_po_number		VARCHAR2(200),
									p_project_number		VARCHAR2(200),
									p_project_name			VARCHAR2(200),
									p_project_desc			VARCHAR2(200),
									p_project_type			VARCHAR2(200),
									p_so_number				VARCHAR2(200),
								    p_agr_dff_attributes 	VARCHAR2(200),
								    p_agr_attachment        VARCHAR2(1000),
								    p_project_attachment    VARCHAR2(1000),
								    p_task_attachment    	VARCHAR2(1000),
								    p_funding_attachment    VARCHAR2(1000));
end;
/
create or replace package body xxut_xxpa2381_pkg as
/****************************************************************************
   Prog Unit:  create_event
   Desc:       procedure used to create test event xxpa2381_EQUIP_ORDER_IN
  ****************************************************************************/
  procedure create_event(p_rec      			IN  xxut_xxpa2381_pkg.rec_type_xxpa2381,
						 x_api_return_TYPE   	OUT XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE
						) IS

  lv_payload clob;
  lv_event_type CONSTANT VARCHAR2(60) := 'XXPA2381_PROJECT_IN';
  begin

    lv_payload :=  '<G_XXPA2381_INT>
					<SENDER><ID>'||p_rec.p_partner_code||'</ID>
					<REFERENCE>'||p_Rec.p_ext_message_id||'</REFERENCE>
					</SENDER>
					<G_PA_AGREEMENTS_ALL>
					<PA_AGREEMENTS_ALL>
					<PM_AGREEMENT_REFERENCE>'||p_Rec.p_agreement_number||'</PM_AGREEMENT_REFERENCE>
					<CUSTOMER_NUM>676238</CUSTOMER_NUM>
					<AGREEMENT_NUM>'||p_Rec.p_agreement_number||'</AGREEMENT_NUM>
					<AGREEMENT_TYPE>TRANE Firm Quote</AGREEMENT_TYPE>
					<AMOUNT>12715</AMOUNT>
					<DESCRIPTION>'||p_rec.p_agreement_desc||'</DESCRIPTION>
					<ATTRIBUTE10>0</ATTRIBUTE10>
					<OWNING_ORGANIZATION_ID>6217</OWNING_ORGANIZATION_ID>
					<AGREEMENT_CURRENCY_CODE>USD</AGREEMENT_CURRENCY_CODE>
					<CUSTOMER_ORDER_NUMBER>'||p_rec.p_cust_po_number||'</CUSTOMER_ORDER_NUMBER>
					<START_DATE>14-AUG-2018</START_DATE>
					<PM_PRODUCT_CODE>SPECTRUM_AP</PM_PRODUCT_CODE>
					<TERM_NAME>NET 60</TERM_NAME>
					<OWNED_BY_PERSON_NUMBER>11050238</OWNED_BY_PERSON_NUMBER>
					<OWNING_ORGANIZATION_CODE>VTM</OWNING_ORGANIZATION_CODE>
					<OWNING_ORGANIZATION_NAME>AP HUB Vietnam Service and Project Org</OWNING_ORGANIZATION_NAME>
					<UPDATE_AGREEMENT_ALLOWED>N</UPDATE_AGREEMENT_ALLOWED>
					'||nvl(p_Rec.p_agr_attachment,'') ||
					'<G_PA_PROJECTS_ALL>
					<PA_PROJECTS_ALL>
					<PM_PROJECT_REFERENCE>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PM_PROJECT_REFERENCE>
					<PA_PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PA_PROJECT_NUMBER>
					<PROJECT_NAME>'||p_Rec.p_project_name||'</PROJECT_NAME>
					<PROJECT_STATUS_CODE>SUBMITTED</PROJECT_STATUS_CODE>
					<DESCRIPTION>'||p_rec.p_project_desc||'</DESCRIPTION>
					<START_DATE>14-AUG-2018</START_DATE>
					<COMPLETION_DATE>14-AUG-2019</COMPLETION_DATE>
					<PROJECT_CURRENCY_CODE>USD</PROJECT_CURRENCY_CODE>
					<CARRYING_OUT_ORGANIZATION_CODE>VTM</CARRYING_OUT_ORGANIZATION_CODE>
					<CARRYING_OUT_ORGANIZATION_NAME>AP HUB Vietnam Service and Project Org</CARRYING_OUT_ORGANIZATION_NAME>
					<PROJECT_TYPE>'||p_rec.p_project_type||'</PROJECT_TYPE>'
					|| nvl(p_rec.p_project_attachment,'') ||
					'<G_SRC_ATTRIBUTES>
					<SRC_ATTRIBUTE>
					<NAME>VERSION_NUMBER</NAME>
					</SRC_ATTRIBUTE>
					</G_SRC_ATTRIBUTES>
					<G_PA_PROJECT_CUSTOMERS>
					<PA_PROJECT_CUSTOMERS>
					<CUSTOMER_ID>28454134</CUSTOMER_ID>
					<INV_CURRENCY_CODE>USD</INV_CURRENCY_CODE>
					<CUSTOMER_NUMBER>676238</CUSTOMER_NUMBER>
					<SHIP_TO_ADDRESS_1>106 TAN SON NHI, TAN SON NHI WARD</SHIP_TO_ADDRESS_1>
					<SHIP_TO_ADDRESS_2>TAN PHU DISTRICT</SHIP_TO_ADDRESS_2>
					<SHIP_TO_ADDRESS_4>MINH LONG EQUIPMENT ACCESSORIES TRADING COMPANY LIMITED</SHIP_TO_ADDRESS_4>
					<CITY>HOCHIMINH</CITY>
					<COUNTY>(84) 8 3718 0174</COUNTY>
					<POSTAL_CODE>70000</POSTAL_CODE>
					<COUNTRY>VN</COUNTRY>
					<BILL_TO_PARTY_SITE_ID>27888761</BILL_TO_PARTY_SITE_ID>
					</PA_PROJECT_CUSTOMERS>
					</G_PA_PROJECT_CUSTOMERS>
					<G_TASKS>
					<TASKS>
					<PM_TASK_REFERENCE>140</PM_TASK_REFERENCE>
					<TASK_NAME>Technical Assistance</TASK_NAME>
					<PA_TASK_NUMBER>140</PA_TASK_NUMBER>
					<TASK_DESCRIPTION>Technical Assistance</TASK_DESCRIPTION>
					<TASK_START_DATE>14-AUG-2018</TASK_START_DATE>
					<TASK_COMPLETION_DATE>14-AUG-2019</TASK_COMPLETION_DATE>
					<ATTRIBUTE1>41901</ATTRIBUTE1>
					<ATTRIBUTE8>Submitted</ATTRIBUTE8>
					<WORK_TYPE>On Demand</WORK_TYPE>
					<BILLABLE_FLAG>Y</BILLABLE_FLAG>
					<CHARGEABLE_FLAG>Y</CHARGEABLE_FLAG>
					'||nvl(p_rec.p_task_attachment,'')||
					'</TASKS>
					<TASKS>
					<PM_TASK_REFERENCE>080</PM_TASK_REFERENCE>
					<TASK_NAME>Sales Office Logistics</TASK_NAME>
					<PA_TASK_NUMBER>080</PA_TASK_NUMBER>
					<TASK_DESCRIPTION>Sales Office Logistics</TASK_DESCRIPTION>
					<TASK_START_DATE>14-AUG-2018</TASK_START_DATE>
					<TASK_COMPLETION_DATE>14-AUG-2019</TASK_COMPLETION_DATE>
					<ATTRIBUTE1>41198</ATTRIBUTE1>
					<ATTRIBUTE8>Submitted</ATTRIBUTE8>
					<WORK_TYPE>On Demand</WORK_TYPE>
					<BILLABLE_FLAG>Y</BILLABLE_FLAG>
					<CHARGEABLE_FLAG>Y</CHARGEABLE_FLAG>
					</TASKS>
					<TASKS>
					<PM_TASK_REFERENCE>010</PM_TASK_REFERENCE>
					<TASK_NAME>Equipment</TASK_NAME>
					<PA_TASK_NUMBER>010</PA_TASK_NUMBER>
					<TASK_DESCRIPTION>Equipment</TASK_DESCRIPTION>
					<TASK_START_DATE>14-AUG-2018</TASK_START_DATE>
					<TASK_COMPLETION_DATE>14-AUG-2019</TASK_COMPLETION_DATE>
					<ATTRIBUTE1>41901</ATTRIBUTE1>
					<ATTRIBUTE8>Submitted</ATTRIBUTE8>
					<WORK_TYPE>Equipment</WORK_TYPE>
					<BILLABLE_FLAG>Y</BILLABLE_FLAG>
					<CHARGEABLE_FLAG>Y</CHARGEABLE_FLAG>
					</TASKS>
					</G_TASKS>
					<G_PA_PROJECT_PLAYERS>
					<PA_PROJECT_PLAYERS>
					<PROJECT_ROLE_TYPE>PROJECT MANAGER</PROJECT_ROLE_TYPE>
					<START_DATE>14-AUG-2018</START_DATE>
					<END_DATE>14-AUG-2019</END_DATE>
					<PRJ_PLAYER_EMP_NO>11050238</PRJ_PLAYER_EMP_NO>
					</PA_PROJECT_PLAYERS>
					</G_PA_PROJECT_PLAYERS>
					<G_PA_PROJECT_CLASSES>
					<PA_PROJECT_CLASSES>
					<CLASS_CATEGORY>Virtual Sales Location</CLASS_CATEGORY>
					<CLASS_CODE>413101</CLASS_CODE>
					</PA_PROJECT_CLASSES>
					<PA_PROJECT_CLASSES>
					<CLASS_CATEGORY>Business Offering</CLASS_CATEGORY>
					<CLASS_CODE>Trane Equipment</CLASS_CODE>
					</PA_PROJECT_CLASSES>
					<PA_PROJECT_CLASSES>
					<CLASS_CATEGORY>Sales Channel</CLASS_CATEGORY>
					<CLASS_CODE>Direct Sales Channel</CLASS_CODE>
					<CODE_PERCENTAGE>170000000000000000000</CODE_PERCENTAGE>
					</PA_PROJECT_CLASSES>
					</G_PA_PROJECT_CLASSES>
					<G_PA_CREDIT_RECEIVERS>
					<PA_CREDIT_RECEIVERS>
					<CREDIT_TYPE_CODE>QUOTA CREDIT</CREDIT_TYPE_CODE>
					<START_DATE_ACTIVE>14-AUG-2018</START_DATE_ACTIVE>
					<CREDIT_PERCENTAGE>100</CREDIT_PERCENTAGE>
					<EMPLOYEE_NUMBER>10402804</EMPLOYEE_NUMBER>
					</PA_CREDIT_RECEIVERS>
					</G_PA_CREDIT_RECEIVERS>
					</PA_PROJECTS_ALL>
					</G_PA_PROJECTS_ALL>
					<G_PA_PROJECT_FUNDINGS>
					<PA_PROJECT_FUNDING>
					<ALLOCATED_AMOUNT>12715</ALLOCATED_AMOUNT>
					<DATE_ALLOCATED>09-AUG-2019</DATE_ALLOCATED>
					<PA_PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PA_PROJECT_NUMBER>
					'|| nvl(p_rec.p_funding_attachment,'') ||
					'</PA_PROJECT_FUNDING>
					</G_PA_PROJECT_FUNDINGS>
					</PA_AGREEMENTS_ALL>
					</G_PA_AGREEMENTS_ALL>
					</G_XXPA2381_INT>';
	

	XXINT_EVENT_API_PUB.CREATE_EVENT(x_api_return_type    => x_api_return_TYPE,
									 p_event_type         => lv_event_type,
									 p_attribute_category => lv_event_type,
									 p_content_clob       => lv_payload,
									 p_content_clob_code  => 'HTTP_RECEIVE_XML_PAYLOAD_IN');

  END create_event;

 /****************************************************************************
   Prog Unit:  process_event
   Desc:       procedure used to process the event XXONT1239_ORDER_IN
  ****************************************************************************/
  PROCEDURE process_event(p_guid    IN  varchar2,
                          x_retcode OUT number,
                          x_retmesg OUT varchar2) IS
  BEGIN
        xxint_event_api_pub.process_event(x_retcode => x_retcode,
                                          x_retmesg => x_retmesg,
                                          p_guid    => p_guid);

  END process_event;

  procedure test_attach_project IS
	l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
	--
	l_retcode     number;
	l_msg_data    varchar2(200);
	--
	l_rec 		xxut_xxpa2381_pkg.rec_type_xxpa2381;
	l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
	--
	l_clob    CLOB;
	l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
	l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
	l_test_guid l_api_return_TYPE.guid%TYPE;
	l_current_event_phase varchar2(15);
	l_current_event_status varchar2(15);
	l_project_id pa_projects_all.project_id%TYPE;
	l_proj_attachment_created varchar2(1);
	l_task_level_funding_cnt number;
	l_agreement_id pa_Agreements_all.agreement_id%TYPE;
	l_project_number pa_projects_all.segment1%TYPE;
	l_last_process_msg xxint_events.lasT_process_msg%TYPE;
	l_resp			 NUMBER;
	l_user			 NUMBER;
	l_app		   	     NUMBER;
	l_request_id number;
	lb_complete      BOOLEAN;
	lc_phase         VARCHAR2 (100);
	lc_status        VARCHAR2 (100);
	lc_dev_phase     VARCHAR2 (100);
	lc_dev_status    VARCHAR2 (100);
	lc_message       VARCHAR2 (100);
	l_request_cnt number:=0;
	begin
		--Data selection to use in Payload build
		l_rec.p_request_type		:=	'P';
		l_rec.p_partner_code		:=  'SPECTRUM_AP';
		l_rec.p_ext_message_id      :=  l_date;
		l_rec.p_agreement_number	:=  l_date;
		l_rec.p_agreement_desc		:=  'Test Project Attachment creation for SPECTRUM_MEA CR 24105';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Project Attachment Creation';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;
        l_rec.p_agr_dff_attributes  :=  NULL;
        l_rec.p_project_attachment  := '<G_ATTACHMENT>
									  <ATTACHMENTS>
										 <noteType>Miscellaneous</noteType>
										 <notes>Testing Milestone billing 
					Test Project Header attachment</notes>
									  </ATTACHMENTS>
								   </G_ATTACHMENT>';
								   
		l_Rec.p_task_attachment     := '<G_ATTACHMENT>
											<ATTACHMENTS>
											   <noteType>Miscellaneous</noteType>
											   <notes>Testing Milestone billing 
					Test Project Task attachment</notes>
											</ATTACHMENTS>
										 </G_ATTACHMENT>';
										 
		l_rec.p_funding_attachment  := '<G_ATTACHMENT>
									  <ATTACHMENTS>
										 <noteType>IR POA Notes</noteType>
										 <notes>Testing Milestone billing 
					Test Project Task attachment</notes>
									  </ATTACHMENTS></G_ATTACHMENT>';								 
        -------------------------------------------------------------------------------------
		create_event(p_rec      			=> l_rec,
					 x_api_return_TYPE   	=> l_api_return_TYPE
					);
		-------------------------------------------------------------------------------------
		--#1. Expects Event validation success,  hence retcode as 0.
		ut.expect(l_api_return_TYPE.retcode,l_api_return_TYPE.guid|| ' Event created validation error, in an expected error case. Need further analysis. Return Msg: '||l_api_return_TYPE.retmesg).to_equal(0);

		IF l_api_return_TYPE.retcode = 0 THEN

			l_test_guid := l_api_return_TYPE.guid;

			--Process Event Phase 02
			----------------------------------------------------------
			--process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--Keeps waiting for the event to halt at Closed status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute4,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'CLOSED' AND l_current_event_status = 'CLOSED' and l_last_process_msg like '%Event phase successfully processed%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

             --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;

			  select decode(count(1),0,'N','Y')
				 into l_proj_attachment_created
				 FROM fnd_attached_docs_form_vl fadv,
					  fnd_documents_short_text  fds
		        WHERE fds.media_id = fadv.media_id
				  AND fadv.function_name = 'PAXPREPR'
				  AND fadv.entity_name = 'PA_PROJECTS'
				  AND pk1_value = l_project_id;

				--#4. Expects Attachment to have been created as per the SPECTRUM Payload. If not, throw error
				ut.expect(l_proj_attachment_created,'Project Attachment not created as expected.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));
				
			
		END IF;

	end test_attach_project;
	
	procedure test_attach_task IS
	l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
	--
	l_retcode     number;
	l_msg_data    varchar2(200);
	--
	l_rec 		xxut_xxpa2381_pkg.rec_type_xxpa2381;
	l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
	--
	l_clob    CLOB;
	l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
	l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
	l_test_guid l_api_return_TYPE.guid%TYPE;
	l_current_event_phase varchar2(15);
	l_current_event_status varchar2(15);
	l_project_id pa_projects_all.project_id%TYPE;
	l_task_attachment_created varchar2(1);
	l_task_level_funding_cnt number;
	l_agreement_id pa_Agreements_all.agreement_id%TYPE;
	l_project_number pa_projects_all.segment1%TYPE;
	l_last_process_msg xxint_events.lasT_process_msg%TYPE;
	l_resp			 NUMBER;
	l_user			 NUMBER;
	l_app		   	     NUMBER;
	l_request_id number;
	lb_complete      BOOLEAN;
	lc_phase         VARCHAR2 (100);
	lc_status        VARCHAR2 (100);
	lc_dev_phase     VARCHAR2 (100);
	lc_dev_status    VARCHAR2 (100);
	lc_message       VARCHAR2 (100);
	l_request_cnt number:=0;
	begin
		--Data selection to use in Payload build
		l_rec.p_request_type		:=	'P';
		l_rec.p_partner_code		:=  'SPECTRUM_AP';
		l_rec.p_ext_message_id      :=  l_date;
		l_rec.p_agreement_number	:=  l_date;
		l_rec.p_agreement_desc		:=  'Test Task Attachment creation for SPECTRUM_MEA CR 24105';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Task Attachment Creation';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;
        l_rec.p_agr_dff_attributes  :=  NULL;
        l_Rec.p_task_attachment     := '<G_ATTACHMENT>
											<ATTACHMENTS>
											   <noteType>Miscellaneous</noteType>
											   <notes>Testing Milestone billing 
					Test Project Task attachment</notes>
											</ATTACHMENTS>
										 </G_ATTACHMENT>';
										 
		-------------------------------------------------------------------------------------
		create_event(p_rec      			=> l_rec,
					 x_api_return_TYPE   	=> l_api_return_TYPE
					);
		-------------------------------------------------------------------------------------
		--#1. Expects Event validation success,  hence retcode as 0.
		ut.expect(l_api_return_TYPE.retcode,l_api_return_TYPE.guid|| ' Event created validation error, in an expected error case. Need further analysis. Return Msg: '||l_api_return_TYPE.retmesg).to_equal(0);

		IF l_api_return_TYPE.retcode = 0 THEN

			l_test_guid := l_api_return_TYPE.guid;

			--Process Event Phase 02
			----------------------------------------------------------
			--process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--Keeps waiting for the event to halt at Closed status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute4,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'CLOSED' AND l_current_event_status = 'CLOSED' and l_last_process_msg like '%Event phase successfully processed%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

             --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;

			  select decode(count(1),0,'N','Y')
				 into l_task_attachment_created
				 FROM fnd_attached_docs_form_vl fadv,
					  fnd_documents_short_text  fds,
					  pa_tasks pt
		        WHERE fds.media_id = fadv.media_id
				  AND fadv.function_name = 'PAXPREPR'
				  AND fadv.entity_name = 'PA_TASKS'
				  AND pk1_value = pt.task_id
				  AND pt.project_id = l_project_id;

				--#4. Expects Attachment to have been created as per the SPECTRUM Payload. If not, throw error
				ut.expect(l_task_attachment_created,'Task Attachment not created as expected.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));
				
			
		END IF;

	end test_attach_task;
	
	procedure test_attach_projfunding IS
	l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
	--
	l_retcode     number;
	l_msg_data    varchar2(200);
	--
	l_rec 		xxut_xxpa2381_pkg.rec_type_xxpa2381;
	l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
	--
	l_clob    CLOB;
	l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
	l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
	l_test_guid l_api_return_TYPE.guid%TYPE;
	l_current_event_phase varchar2(15);
	l_current_event_status varchar2(15);
	l_project_id pa_projects_all.project_id%TYPE;
	l_funding_attachment_created varchar2(1);
	l_project_funding_id pa_project_fundings.project_funding_id%TYPE;
	l_task_level_funding_cnt number;
	l_agreement_id pa_Agreements_all.agreement_id%TYPE;
	l_project_number pa_projects_all.segment1%TYPE;
	l_last_process_msg xxint_events.lasT_process_msg%TYPE;
	l_resp			 NUMBER;
	l_user			 NUMBER;
	l_app		   	     NUMBER;
	l_request_id number;
	lb_complete      BOOLEAN;
	lc_phase         VARCHAR2 (100);
	lc_status        VARCHAR2 (100);
	lc_dev_phase     VARCHAR2 (100);
	lc_dev_status    VARCHAR2 (100);
	lc_message       VARCHAR2 (100);
	l_request_cnt number:=0;
	begin
		--Data selection to use in Payload build
		l_rec.p_request_type		:=	'P';
		l_rec.p_partner_code		:=  'SPECTRUM_AP';
		l_rec.p_ext_message_id      :=  l_date;
		l_rec.p_agreement_number	:=  l_date;
		l_rec.p_agreement_desc		:=  'Test Project Funding Attach creation for SPECTRUM_MEA CR 24105';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Project Funding Attachment Creation';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;
        l_rec.p_agr_dff_attributes  :=  NULL;
        l_rec.p_funding_attachment  := '<G_ATTACHMENT>
									  <ATTACHMENTS>
										 <noteType>IR POA Notes</noteType>
										 <notes>Testing Milestone billing 
					Test Project Task attachment</notes>
									  </ATTACHMENTS></G_ATTACHMENT>';								 
        -------------------------------------------------------------------------------------
		create_event(p_rec      			=> l_rec,
					 x_api_return_TYPE   	=> l_api_return_TYPE
					);
		-------------------------------------------------------------------------------------
		--#1. Expects Event validation success,  hence retcode as 0.
		ut.expect(l_api_return_TYPE.retcode,l_api_return_TYPE.guid|| ' Event created validation error, in an expected error case. Need further analysis. Return Msg: '||l_api_return_TYPE.retmesg).to_equal(0);

		IF l_api_return_TYPE.retcode = 0 THEN

			l_test_guid := l_api_return_TYPE.guid;

			--Process Event Phase 02
			----------------------------------------------------------
			--process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--Keeps waiting for the event to halt at Closed status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute4,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'CLOSED' AND l_current_event_status = 'CLOSED' and l_last_process_msg like '%Event phase successfully processed%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

             --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;
			  
			 select pa.agreement_id,project_funding_id
			   into l_agreement_id, l_project_funding_id
			   from pa_agreements_all pa,
			   pa_project_fundings ppf
			   where ppf.project_id = l_project_id 
			   and ppf.agreement_id = pa.agreement_id;
			 
			  select decode(count(1),0,'N','Y')
				 into l_funding_attachment_created
				 FROM fnd_attached_docs_form_vl fadv,
					  fnd_documents_short_text  fds
		        WHERE fds.media_id = fadv.media_id
				  AND fadv.function_name = 'PAXINEAG'
				  AND fadv.entity_name = 'PA_PROJECT_FUNDINGS'
				  AND pk1_value = l_project_funding_id;

				--#4. Expects Attachment to have been created as per the SPECTRUM Payload. If not, throw error
				ut.expect(l_funding_attachment_created,'Project Funding Attachment not created as expected.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));
				
			
		END IF;

	end test_attach_projfunding;

  procedure test_attach_agr IS
	l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
	--
	l_retcode     number;
	l_msg_data    varchar2(200);
	--
	l_rec 		xxut_xxpa2381_pkg.rec_type_xxpa2381;
	l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
	--
	l_clob    CLOB;
	l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
	l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
	l_test_guid l_api_return_TYPE.guid%TYPE;
	l_current_event_phase varchar2(15);
	l_current_event_status varchar2(15);
	l_project_id pa_projects_all.project_id%TYPE;
	l_agr_attachment_created varchar2(1);
	l_task_level_funding_cnt number;
	l_agreement_id pa_Agreements_all.agreement_id%TYPE;
	l_project_number pa_projects_all.segment1%TYPE;
	l_last_process_msg xxint_events.lasT_process_msg%TYPE;
	l_resp			 NUMBER;
	l_user			 NUMBER;
	l_app		   	     NUMBER;
	l_request_id number;
	lb_complete      BOOLEAN;
	lc_phase         VARCHAR2 (100);
	lc_status        VARCHAR2 (100);
	lc_dev_phase     VARCHAR2 (100);
	lc_dev_status    VARCHAR2 (100);
	lc_message       VARCHAR2 (100);
	l_request_cnt number:=0;
	begin
		--Data selection to use in Payload build
		l_rec.p_request_type		:=	'P';
		l_rec.p_partner_code		:=  'SPECTRUM_AP';
		l_rec.p_ext_message_id      :=  l_date;
		l_rec.p_agreement_number	:=  l_date;
		l_rec.p_agreement_desc		:=  'Test Agr Attachment creation for SPECTRUM_MEA CR 24105';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Agr DFF Creation';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;
        l_rec.p_agr_dff_attributes  :=  NULL;
        l_rec.p_agr_attachment      := '<G_ATTACHMENT>
										<ATTACHMENTS>
										   <noteType>IR Milestone Billing Notes</noteType>
										   <notes>Testing Milestone billing attachment</notes>
										</ATTACHMENTS>
										<ATTACHMENTS>
										   <noteType>IR Project Special Instructions</noteType>
										   <notes>Lieferadresse:
													Hauptbahnhof Wien
													Canettistraße 7
													1100 Wien</notes>
										</ATTACHMENTS>
										</G_ATTACHMENT>';	

        l_rec.p_project_attachment  := '<G_ATTACHMENT>
									  <ATTACHMENTS>
										 <noteType>Miscellaneous</noteType>
										 <notes>Testing Milestone billing 
					Test Project Header attachment</notes>
									  </ATTACHMENTS>
								   </G_ATTACHMENT>';
								   
		l_Rec.p_task_attachment     := '<G_ATTACHMENT>
											<ATTACHMENTS>
											   <noteType>Miscellaneous</noteType>
											   <notes>Testing Milestone billing 
					Test Project Task attachment</notes>
											</ATTACHMENTS>
										 </G_ATTACHMENT>';
										 
		l_rec.p_funding_attachment  := '<G_ATTACHMENT>
									  <ATTACHMENTS>
										 <noteType>IR POA Notes</noteType>
										 <notes>Testing Milestone billing 
					Test Project Task attachment</notes>
									  </ATTACHMENTS></G_ATTACHMENT>';								 
        -------------------------------------------------------------------------------------
		create_event(p_rec      			=> l_rec,
					 x_api_return_TYPE   	=> l_api_return_TYPE
					);
		-------------------------------------------------------------------------------------
		--#1. Expects Event validation success,  hence retcode as 0.
		ut.expect(l_api_return_TYPE.retcode,l_api_return_TYPE.guid|| ' Event created validation error, in an expected error case. Need further analysis. Return Msg: '||l_api_return_TYPE.retmesg).to_equal(0);

		IF l_api_return_TYPE.retcode = 0 THEN

			l_test_guid := l_api_return_TYPE.guid;

			--Process Event Phase 02
			----------------------------------------------------------
			--process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--Keeps waiting for the event to halt at Closed status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute4,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'CLOSED' AND l_current_event_status = 'CLOSED' and l_last_process_msg like '%Event phase successfully processed%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

             --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;

			  select pa.agreement_id
			   into l_agreement_id
			   from pa_agreements_all pa,
			   pa_project_fundings ppf
			   where ppf.project_id = l_project_id 
			   and ppf.agreement_id = pa.agreement_id;
			 -- ut.expect(l_api_return_TYPE.retcode,'Project ID: '||l_project_id).to_equal(3);

			 --Forcefully update the Project Status to Approved , to let the event proceed to further phases

			 update pa_projects_all set project_status_code = 'APPROVED', wf_status_code = NULL
			 where project_id = l_project_id;
			 commit;

			 -- Setting environment before calling add to Project Mfg Org
			 SELECT RESPONSIBILITY_ID
			  INTO l_resp
			  FROM FND_RESPONSIBILITY_VL
			WHERE RESPONSIBILITY_NAME = 'AT 5854 Service Project Administration Supervisor';

			SELECT APPLICATION_ID
			  INTO l_app
			  FROM FND_APPLICATION
			 WHERE APPLICATION_SHORT_NAME='PA';

			SELECT USER_ID
			  INTO l_user
			  FROM FND_USER
			 WHERE USER_NAME='CCBPNA';

			FND_GLOBAL.APPS_INITIALIZE(l_user ,l_resp ,l_app );

			--Submit the request to add project to Manufacturing, to let the event proceed without errors
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			--xxont_order_email_err_rpt_pkg.xxont_email_err_rpt_pkg(l_errbuf,l_retcode,l_order_source_id);
			l_request_id :=
				   fnd_request.submit_request (application      => 'XXPA',
											   program          => 'XXPA1559_2',
											   description      => NULL,
											   start_time       =>   SYSDATE
																   + (  1
																	  / (24 * 60
																		)
																	 ), --SYSDATE,
											   sub_request      => FALSE,
											   argument1        => l_project_id,
											   argument2		=> 'N',
											   argument3        => 5
											  );

			commit;
			IF l_request_id > 0
			 THEN
			 LOOP
				lb_complete :=
				   fnd_concurrent.wait_for_request (l_request_id,
													60,
													0,
													lc_phase,
													lc_status,
													lc_dev_phase,
													lc_dev_status,
													lc_message
												   );


				SELECT COUNT (*)
				  INTO l_request_cnt
				  FROM fnd_lookup_values f, fnd_lookup_values u
				 WHERE u.lookup_type = 'CP_PHASE_CODE'
				   AND u.lookup_type = f.lookup_type
				   AND u.lookup_code = f.lookup_code
				   AND UPPER (u.meaning) = 'COMPLETED'
				   AND UPPER (f.meaning) = UPPER (lc_phase);

				EXIT WHEN l_request_cnt > 0;

			 END LOOP;
			END IF;
			----------------------------------------------------------------------------------------------------------------------------------------------------------------------

			--Process Event Phase 03
			----------------------------------------------------------
--			process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--#2. Expects event to be processed and with above expected messages. If not throw error.
	--		ut.expect(l_retcode,'Caught error in Phase 03 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

				select decode(count(1),0,'N','Y')
				 into l_agr_attachment_created
				 FROM fnd_attached_docs_form_vl fadv,
					  fnd_documents_short_text  fds
		        WHERE fds.media_id = fadv.media_id
				  AND fadv.function_name = 'PAXINEAG'
				  AND fadv.entity_name = 'PA_AGREEMENTS'
				  AND fadv.category_description = 'IR Milestone Billing Notes'
				  AND pk1_value = l_agreement_id;

				--#4. Expects Attachment to have been created as per the SPECTRUM Payload. If not, throw error
				ut.expect(l_agr_attachment_created,'Agreement Attachment not created as expected.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));
				
			
		END IF;

	end test_attach_agr;
	
end xxut_xxpa2381_pkg;
/
show errors package body xxut_xxpa2381_pkg