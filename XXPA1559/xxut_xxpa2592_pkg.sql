create or replace package xxut_xxpa2592_pkg as
/******************************************************************************
** Program Name    : xxut_xxpa2592_pkg.sql
** Program Type    : PL/SQL Script
** Created By      : Jyotsana Kandpal
** Creation Date   : 10-MAY-2019
** Description     : Package listing test cases for SPECTRUM BOLT-ON 
**   $Header: xxut/12.0.0/sql/xxut_xxpa2592_pkg.sql  $
**   $Change History$ (*ALL VERSIONS*)
** ****************************************************************************
** Modification History
** Date      		Who          		Description
** ****************************************************************************
** 10-MAY-2019 		Jyotsana Kandpal     Initial Version--created for CR#24082/24100/24091
******************************************************************************/
  -- %suite(XX Order Error Email Report Test)
  -- %suitepath(XXPA.xxpa2592)
  -- %rollback(manual)
  
  -- %test(INVALID_PARTNER - Test passes if the partner on the XML is invalid)
  procedure invalid_partner;
  -- %test(PROJ_LEVEL_FUNDING - Test passes if the funding is created at proj level)
  procedure proj_level_funding;
  -- %test(TASK_LEVEL_FUNDING - Test passes if the funding is created at task level)
  procedure task_level_funding;
  -- %test(create_bill_rev_events - Test passes if billing/revenue events are created for the passed project/agreement)
  procedure create_bill_rev_events;
  -- %test(test_agr_dff_cr_from_spectrum - Test passes if agreement DFF is set for the passed agreement from the SPECTRUM Payload)
  procedure test_agr_dff_cr_from_spectrum;
  -- %test(test_agr_dff_cr_from_r12 - Test passes if agreement DFF is set for the passed agreement from the R12 OU setup)
  procedure test_agr_dff_cr_from_r12;
 

  TYPE rec_type_xxpa2592 IS RECORD( p_request_type			VARCHAR2(200),
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
                  p_agr_dff_attributes VARCHAR2(200));
end;
/
create or replace package body xxut_xxpa2592_pkg as
/****************************************************************************
   Prog Unit:  create_event
   Desc:       procedure used to create test event XXPA2592_EQUIP_ORDER_IN
  ****************************************************************************/
  procedure create_event(p_rec      			IN  xxut_xxpa2592_pkg.rec_type_xxpa2592,
						 x_api_return_TYPE   	OUT XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE
						) IS

  lv_payload clob;
  lv_event_type CONSTANT VARCHAR2(60) := 'XXPA2592_EQUIP_ORDER_IN';
  begin

    lv_payload :=  '<EBS_PROJECT_ORDER>
					   <CONTROL_AREA>
						  <PARTNER_CODE>'|| p_rec.p_partner_code ||'</PARTNER_CODE>
						  <INSTANCE_NAME>PRD</INSTANCE_NAME>
						  <REQUEST_TYPE>'|| p_Rec.p_request_type ||'</REQUEST_TYPE>
						  <EXTERNAL_MESSAGE_ID>'|| p_rec.p_ext_message_id ||'</EXTERNAL_MESSAGE_ID>
					   </CONTROL_AREA>
					   <DATA_AREA>
						  <G_PROJECT_ORDERS>
							 <ORDER_TYPE>'|| p_Rec.p_request_type ||'</ORDER_TYPE>
							 <PM_AGREEMENT_REFERENCE>'||p_rec.p_agreement_number||'-'|| p_rec.p_ext_message_id ||'</PM_AGREEMENT_REFERENCE>
							 <AGREEMENT_NUM>'||p_rec.p_agreement_number||'-'|| p_rec.p_ext_message_id ||'</AGREEMENT_NUM>
							 <AGREEMENT_TYPE>TRANE Firm Quote</AGREEMENT_TYPE>
							 <AGREEMENT_DESCRIPTION>'||p_rec.p_agreement_desc||'</AGREEMENT_DESCRIPTION>
							 <PO_AMOUNT>12715</PO_AMOUNT>
							 <CURRENCY_CODE>USD</CURRENCY_CODE>
							 <CUSTOMER_PO_NUMBER>'||p_rec.p_cust_po_number||'</CUSTOMER_PO_NUMBER>
							 <PM_PRODUCT_CODE>'|| p_rec.p_partner_code ||'</PM_PRODUCT_CODE>
							 <OWNING_ORGANIZATION_CODE>VTM</OWNING_ORGANIZATION_CODE>
							 <OWNING_ORGANIZATION_NAME>AP HUB Vietnam Service and Project Org</OWNING_ORGANIZATION_NAME>
							 <JOB_LOCATION_COUNTRY>VN</JOB_LOCATION_COUNTRY>
							 <VERSION_NUMBER>0</VERSION_NUMBER>'
               || nvl(p_rec.p_agr_dff_attributes,'') ||
							 '<CUSTOMER_INFO>
								<CUSTOMER_NUMBER>676238</CUSTOMER_NUMBER>
								<BILL_TO_PARTY_SITE_ID>27888761</BILL_TO_PARTY_SITE_ID>
								<PAYMENT_TERMS>NET 60</PAYMENT_TERMS>
								<INV_CURRENCY_CODE>USD</INV_CURRENCY_CODE>
								<SHIP_TO_ADDRESS_LINE1>106 TAN SON NHI, TAN SON NHI WARD</SHIP_TO_ADDRESS_LINE1>
								<SHIP_TO_ADDRESS_LINE2>TAN PHU DISTRICT</SHIP_TO_ADDRESS_LINE2>
								<SHIP_TO_ADDRESS_LINE4>MINH LONG EQUIPMENT ACCESSORIES TRADING COMPANY LIMITED</SHIP_TO_ADDRESS_LINE4>
								<SHIP_TO_ADDRESS_CITY>HOCHIMINH</SHIP_TO_ADDRESS_CITY>
								<SHIP_TO_ADDRESS_POSTAL_CODE>70000</SHIP_TO_ADDRESS_POSTAL_CODE>
								<SHIP_TO_ADDRESS_COUNTRY>VN</SHIP_TO_ADDRESS_COUNTRY>
								<SHIP_TO_ADDRESS_COUNTY>(84) 8 3718 0174</SHIP_TO_ADDRESS_COUNTY>
							 </CUSTOMER_INFO>
							 <G_SALES_COMMISSION>
								<SALES_COMMISSION>
								   <CREDIT_PERCENTAGE>100</CREDIT_PERCENTAGE>
								   <EMPLOYEE_NUMBER>10402804</EMPLOYEE_NUMBER>
								   <CREDIT_TYPE_CODE>Quota Credit</CREDIT_TYPE_CODE>
								   <START_DATE_ACTIVE>14-Aug-2018</START_DATE_ACTIVE>
								   <EBS_USER_NAME>Tieu Bao, Tran</EBS_USER_NAME>
								</SALES_COMMISSION>
							 </G_SALES_COMMISSION>
							 <G_PROJECTS>
								<PROJECT>
								   <PA_PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PA_PROJECT_NUMBER>
								   <PROJECT_NAME>'||p_rec.p_project_name||'</PROJECT_NAME>
								   <DESCRIPTION>'||p_rec.p_project_desc||'</DESCRIPTION>
								   <START_DATE>14-Aug-2018</START_DATE>
								   <COMPLETION_DATE>14-Aug-2019</COMPLETION_DATE>
								   <PROJECT_TYPE>'||p_rec.p_project_type||'</PROJECT_TYPE>
								   <G_PROJECTS_PLAYERS>
									  <PROJECT_PLAYERS>
										 <PROJECT_ROLE_TYPE>PROJECT MANAGER</PROJECT_ROLE_TYPE>
										 <PRJ_PLAYER_EMP_NO>11050238</PRJ_PLAYER_EMP_NO>
										 <START_DATE>14-Aug-2018</START_DATE>
										 <END_DATE>14-Aug-2019</END_DATE>
									  </PROJECT_PLAYERS>
								   </G_PROJECTS_PLAYERS>
								   <G_PA_PROJECT_CLASSES>
									  <PA_PROJECT_CLASSES>
										 <CLASS_CATEGORY>Business Offering</CLASS_CATEGORY>
										 <CLASS_CODE>Trane Equipment</CLASS_CODE>
									  </PA_PROJECT_CLASSES>
								   </G_PA_PROJECT_CLASSES>
								   <G_RESERVE_CODES>
									  <RESERVE_CODES>
										 <LINE_NUMBER>1</LINE_NUMBER>
										 <N-CODE>N999</N-CODE>
										 <N-CODE_DESCRIPTION>Equipment</N-CODE_DESCRIPTION>
										 <N-CODE_AMOUNT>11353.00</N-CODE_AMOUNT>
									  </RESERVE_CODES>
									  <RESERVE_CODES>
										 <LINE_NUMBER>2</LINE_NUMBER>
										 <N-CODE>N999</N-CODE>
										 <N-CODE_DESCRIPTION>Equipment</N-CODE_DESCRIPTION>
										 <N-CODE_AMOUNT>0.00</N-CODE_AMOUNT>
									  </RESERVE_CODES>
									  <RESERVE_CODES>
										 <LINE_NUMBER>3</LINE_NUMBER>
										 <N-CODE>N999</N-CODE>
										 <N-CODE_DESCRIPTION>Equipment</N-CODE_DESCRIPTION>
										 <N-CODE_AMOUNT>0.00</N-CODE_AMOUNT>
									  </RESERVE_CODES>
									  <RESERVE_CODES>
										 <LINE_NUMBER>4</LINE_NUMBER>
										 <N-CODE>N999</N-CODE>
										 <N-CODE_DESCRIPTION>Equipment</N-CODE_DESCRIPTION>
										 <N-CODE_AMOUNT>0.00</N-CODE_AMOUNT>
									  </RESERVE_CODES>
									  <RESERVE_CODES>
										 <LINE_NUMBER>5</LINE_NUMBER>
										 <N-CODE>N918</N-CODE>
										 <N-CODE_DESCRIPTION>Sales Office Logistics</N-CODE_DESCRIPTION>
										 <N-CODE_AMOUNT>1160</N-CODE_AMOUNT>
									  </RESERVE_CODES>
									  <RESERVE_CODES>
										 <LINE_NUMBER>6</LINE_NUMBER>
										 <N-CODE>N909</N-CODE>
										 <N-CODE_DESCRIPTION>Technical Assistance</N-CODE_DESCRIPTION>
										 <N-CODE_AMOUNT>202</N-CODE_AMOUNT>
									  </RESERVE_CODES>
								   </G_RESERVE_CODES>
								   <G_TASKS>
									  <TASKS>
										 <G_SRC_ATTRIBUTES>
											<SRC_ATTRIBUTE>
											   <VALUE>No</VALUE>
											</SRC_ATTRIBUTE>
										 </G_SRC_ATTRIBUTES>
									  </TASKS>
								   </G_TASKS>
								</PROJECT>
							 </G_PROJECTS>
							 <G_ORDER>
								<ORDER_HEADER>
								   <ORG_CODE>SGOUHUB</ORG_CODE>
								   <REQUEST_DATE>15-Sep-2018</REQUEST_DATE>
								   <TRANSACTIONAL_CURR_CODE>USD</TRANSACTIONAL_CURR_CODE>
								   <SHIPMENT_PRIORITY>Standard Priority</SHIPMENT_PRIORITY>
								   <FREIGHT_TERMS>Prepaid</FREIGHT_TERMS>
								   <SHIPPING_METHOD>CUSTOMER CARRIER-Ocean-STD</SHIPPING_METHOD>
								   <FOB>CIF</FOB>
								   <SHIPPING_INSTRUCTIONS>- 3/3 original clean on board Bills of lading marked freight prepaid</SHIPPING_INSTRUCTIONS>
								   <PRICE_LIST>APH SPECTRUM PRICELIST USD</PRICE_LIST>
								   <ATTRIBUTE7>N</ATTRIBUTE7>
								   <ATTRIBUTE19>'||p_rec.p_so_number||'</ATTRIBUTE19>
								   <G_ADDITIONAL_ATTRS>
									  <ADDITIONAL_ATTRIBUTE>
										 <ATTRIBUTE_NAME>ATTRIBUTE10</ATTRIBUTE_NAME>
										 <ATTRIBUTE_VALUE>Asia Region</ATTRIBUTE_VALUE>
									  </ADDITIONAL_ATTRIBUTE>
									  <ADDITIONAL_ATTRIBUTE>
										 <ATTRIBUTE_NAME>ATTRIBUTE11</ATTRIBUTE_NAME>
										 <ATTRIBUTE_VALUE>TRUONG HUYEN TRAM</ATTRIBUTE_VALUE>
									  </ADDITIONAL_ATTRIBUTE>
								   </G_ADDITIONAL_ATTRS>
								   <G_ORDER_LINE>
									  <ORDER_LINE>
										 <LINE_NUMBER>1</LINE_NUMBER>
										 <INVENTORY_ITEM>WTKD48AD0GBA</INVENTORY_ITEM>
										 <ORDERED_QUANTITY>1</ORDERED_QUANTITY>
										 <ORDERED_QUANTITY_UOM>EA</ORDERED_QUANTITY_UOM>
										 <FOB>CIF</FOB>
										 <SHIPMENT_PRIORITY>Standard Priority</SHIPMENT_PRIORITY>
										 <REQUEST_DATE>15-Sep-2018</REQUEST_DATE>
										 <PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PROJECT_NUMBER>
										 <TASK_NUMBER>010</TASK_NUMBER>
										 <G_ADDITIONAL_ATTRS>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE15</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>Thailand ILC Team</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>'||p_rec.p_so_number||'</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE1</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE2</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>THBKK</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE3</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>2004</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE9</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>EXPEDITORS INTERNATIONAL</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE16</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5/F, VORAWAT BUILDING||</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE17</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>BANGKOK|||10500|TH</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE10</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE13</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE14</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>37142947|0695</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE6</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>665640</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE20</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>WTKD48AD0GBA</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE8</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>N</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762321</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762321</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-1</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762321</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
										 </G_ADDITIONAL_ATTRS>
										 <G_PRICING_ATTRS>
											<PRICE_ATTR_LINES>
											   <PRICING_CONTEXT>IR MANUAL LIST</PRICING_CONTEXT>
											   <PRICING_ATTRIBUTE1>0</PRICING_ATTRIBUTE1>
											   <PRICING_ATTRIBUTE2>0</PRICING_ATTRIBUTE2>
											   <PRICING_ATTRIBUTE3>1</PRICING_ATTRIBUTE3>
											   <PRICING_ATTRIBUTE4>1</PRICING_ATTRIBUTE4>
											   <PRICING_ATTRIBUTE5>1</PRICING_ATTRIBUTE5>
											   <PRICING_ATTRIBUTE6>1</PRICING_ATTRIBUTE6>
											   <PRICING_ATTRIBUTE8>634.00</PRICING_ATTRIBUTE8>
											   <PRICING_ATTRIBUTE9>USD</PRICING_ATTRIBUTE9>
											   <PRICING_ATTRIBUTE10>WTKD48AD0GBA</PRICING_ATTRIBUTE10>
											   <PRICING_ATTRIBUTE12>634</PRICING_ATTRIBUTE12>
											</PRICE_ATTR_LINES>
										 </G_PRICING_ATTRS>
									  </ORDER_LINE>
									  <ORDER_LINE>
										 <LINE_NUMBER>2</LINE_NUMBER>
										 <INVENTORY_ITEM>BDCB40B01R00</INVENTORY_ITEM>
										 <ORDERED_QUANTITY>5</ORDERED_QUANTITY>
										 <ORDERED_QUANTITY_UOM>EA</ORDERED_QUANTITY_UOM>
										 <FOB>CIF</FOB>
										 <SHIPMENT_PRIORITY>Standard Priority</SHIPMENT_PRIORITY>
										 <REQUEST_DATE>15-Sep-2018</REQUEST_DATE>
										 <PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PROJECT_NUMBER>
										 <TASK_NUMBER>010</TASK_NUMBER>
										 <G_ADDITIONAL_ATTRS>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE15</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>Thailand ILC Team</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>'||p_rec.p_so_number||'</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE1</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE2</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>THBKK</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE3</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>2004</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE9</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>EXPEDITORS INTERNATIONAL</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE16</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5/F, VORAWAT BUILDING||</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE17</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>BANGKOK|||10500|TH</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE10</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE13</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE14</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>37769399|0416</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE6</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>665641</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE20</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>BDCB40B01R00</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE8</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>N</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762322</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762322</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-1</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762322</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762323</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762323</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-2</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762323</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762324</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762324</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-3</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762324</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762325</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762325</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-4</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762325</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762326</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762326</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-5</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762326</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
										 </G_ADDITIONAL_ATTRS>
										 <G_PRICING_ATTRS>
											<PRICE_ATTR_LINES>
											   <PRICING_CONTEXT>IR MANUAL LIST</PRICING_CONTEXT>
											   <PRICING_ATTRIBUTE1>0</PRICING_ATTRIBUTE1>
											   <PRICING_ATTRIBUTE2>0</PRICING_ATTRIBUTE2>
											   <PRICING_ATTRIBUTE3>1</PRICING_ATTRIBUTE3>
											   <PRICING_ATTRIBUTE4>1</PRICING_ATTRIBUTE4>
											   <PRICING_ATTRIBUTE5>1</PRICING_ATTRIBUTE5>
											   <PRICING_ATTRIBUTE6>1</PRICING_ATTRIBUTE6>
											   <PRICING_ATTRIBUTE8>925.00</PRICING_ATTRIBUTE8>
											   <PRICING_ATTRIBUTE9>USD</PRICING_ATTRIBUTE9>
											   <PRICING_ATTRIBUTE10>BDCB40B01R00</PRICING_ATTRIBUTE10>
											   <PRICING_ATTRIBUTE12>925</PRICING_ATTRIBUTE12>
											</PRICE_ATTR_LINES>
										 </G_PRICING_ATTRS>
									  </ORDER_LINE>
									  <ORDER_LINE>
										 <LINE_NUMBER>3</LINE_NUMBER>
										 <INVENTORY_ITEM>TTK060KD00FA</INVENTORY_ITEM>
										 <ORDERED_QUANTITY>1</ORDERED_QUANTITY>
										 <ORDERED_QUANTITY_UOM>EA</ORDERED_QUANTITY_UOM>
										 <FOB>CIF</FOB>
										 <SHIPMENT_PRIORITY>Standard Priority</SHIPMENT_PRIORITY>
										 <REQUEST_DATE>15-Sep-2018</REQUEST_DATE>
										 <PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PROJECT_NUMBER>
										 <TASK_NUMBER>010</TASK_NUMBER>
										 <G_ADDITIONAL_ATTRS>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE15</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>Thailand ILC Team</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>'||p_rec.p_so_number||'</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE1</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE2</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>THBKK</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE3</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>2004</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE9</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>EXPEDITORS INTERNATIONAL</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE16</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5/F, VORAWAT BUILDING||</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE17</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>BANGKOK|||10500|TH</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE10</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE13</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE14</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>37776186|0444</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE6</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>665642</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE20</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>TTK060KD00FA</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE8</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>N</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762327</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762327</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-1</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762327</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
										 </G_ADDITIONAL_ATTRS>
										 <G_PRICING_ATTRS>
											<PRICE_ATTR_LINES>
											   <PRICING_CONTEXT>IR MANUAL LIST</PRICING_CONTEXT>
											   <PRICING_ATTRIBUTE1>0</PRICING_ATTRIBUTE1>
											   <PRICING_ATTRIBUTE2>0</PRICING_ATTRIBUTE2>
											   <PRICING_ATTRIBUTE3>1</PRICING_ATTRIBUTE3>
											   <PRICING_ATTRIBUTE4>1</PRICING_ATTRIBUTE4>
											   <PRICING_ATTRIBUTE5>1</PRICING_ATTRIBUTE5>
											   <PRICING_ATTRIBUTE6>1</PRICING_ATTRIBUTE6>
											   <PRICING_ATTRIBUTE8>626.00</PRICING_ATTRIBUTE8>
											   <PRICING_ATTRIBUTE9>USD</PRICING_ATTRIBUTE9>
											   <PRICING_ATTRIBUTE10>TTK060KD00FA</PRICING_ATTRIBUTE10>
											   <PRICING_ATTRIBUTE12>626</PRICING_ATTRIBUTE12>
											</PRICE_ATTR_LINES>
										 </G_PRICING_ATTRS>
									  </ORDER_LINE>
									  <ORDER_LINE>
										 <LINE_NUMBER>4</LINE_NUMBER>
										 <INVENTORY_ITEM>TTA200ED00QB</INVENTORY_ITEM>
										 <ORDERED_QUANTITY>2</ORDERED_QUANTITY>
										 <ORDERED_QUANTITY_UOM>EA</ORDERED_QUANTITY_UOM>
										 <FOB>CIF</FOB>
										 <SHIPMENT_PRIORITY>Standard Priority</SHIPMENT_PRIORITY>
										 <REQUEST_DATE>15-Sep-2018</REQUEST_DATE>
										 <PROJECT_NUMBER>'||p_rec.p_project_number||'-'|| p_rec.p_ext_message_id ||'</PROJECT_NUMBER>
										 <TASK_NUMBER>010</TASK_NUMBER>
										 <G_ADDITIONAL_ATTRS>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE15</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>Thailand ILC Team</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>'||p_rec.p_so_number||'</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE1</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE2</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>THBKK</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE3</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>2004</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE9</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>EXPEDITORS INTERNATIONAL</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE16</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5/F, VORAWAT BUILDING||</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE17</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>BANGKOK|||10500|TH</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE10</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE13</ATTRIBUTE_NAME>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE14</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>38127012|0419</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE6</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>665643</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE20</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>TTA200ED00QB</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>ATTRIBUTE8</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>15-Sep-2018</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>GLOBAL_ATTRIBUTE11</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>N</ATTRIBUTE_VALUE>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762328</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762328</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-1</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762328</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>PARTNER_LINE_TAG_LINK</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>5762329</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762329</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
											<ADDITIONAL_ATTRIBUTE>
											   <ATTRIBUTE_NAME>line_tag</ATTRIBUTE_NAME>
											   <ATTRIBUTE_VALUE>*** UNIT1-2</ATTRIBUTE_VALUE>
											   <ATTRIBUTE_TYPE>linetags</ATTRIBUTE_TYPE>
											   <ATTRIBUTE_GROUP>5762329</ATTRIBUTE_GROUP>
											</ADDITIONAL_ATTRIBUTE>
										 </G_ADDITIONAL_ATTRS>
										 <G_PRICING_ATTRS>
											<PRICE_ATTR_LINES>
											   <PRICING_CONTEXT>IR MANUAL LIST</PRICING_CONTEXT>
											   <PRICING_ATTRIBUTE1>0</PRICING_ATTRIBUTE1>
											   <PRICING_ATTRIBUTE2>0</PRICING_ATTRIBUTE2>
											   <PRICING_ATTRIBUTE3>1</PRICING_ATTRIBUTE3>
											   <PRICING_ATTRIBUTE4>1</PRICING_ATTRIBUTE4>
											   <PRICING_ATTRIBUTE5>1</PRICING_ATTRIBUTE5>
											   <PRICING_ATTRIBUTE6>1</PRICING_ATTRIBUTE6>
											   <PRICING_ATTRIBUTE8>2734.00</PRICING_ATTRIBUTE8>
											   <PRICING_ATTRIBUTE9>USD</PRICING_ATTRIBUTE9>
											   <PRICING_ATTRIBUTE10>TTA200ED00QB</PRICING_ATTRIBUTE10>
											   <PRICING_ATTRIBUTE12>2734</PRICING_ATTRIBUTE12>
											</PRICE_ATTR_LINES>
										 </G_PRICING_ATTRS>
									  </ORDER_LINE>
								   </G_ORDER_LINE>
								</ORDER_HEADER>
							 </G_ORDER>
						  </G_PROJECT_ORDERS>
					   </DATA_AREA>
					</EBS_PROJECT_ORDER>
								';

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

/****************************************************************************
Prog Unit:  invalid_partner
Desc:       Returns Failure for Invalid Partner
****************************************************************************/
	procedure invalid_partner IS
		l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
		--
		l_retcode     number;
		l_msg_data    varchar2(200);
		--
		l_rec 		xxut_xxpa2592_pkg.rec_type_xxpa2592;
		l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
		--
		l_clob    CLOB;
		l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
		l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
	begin
		--Data selection to use in Payload build
		l_rec.p_request_type		:=	'P';
		l_rec.p_partner_code		:=  'SPECTRUM_MEA';
		l_rec.p_ext_message_id      :=  '15052019';
		l_rec.p_agreement_number	:=  'TEST-CR-24';
		l_rec.p_agreement_desc		:=  'utplsql - Test Event Creation for SPECTRUM_MEA CR 24090';
		l_rec.p_cust_po_number		:=  '052SGVN/TEST/19';
		l_rec.p_project_number		:=  'TEST-CR-24090';
		l_rec.p_project_name		:=  '052SGVN/TESTCR/19';
		l_rec.p_project_desc		:=  'utPLSQL Test Partner Validation';
		l_rec.p_project_type		:=  'Billing';

		-------------------------------------------------------------------------------------
		create_event(p_rec      			=> l_rec,
					 x_api_return_TYPE   	=> l_api_return_TYPE
					);
		-------------------------------------------------------------------------------------
		--#1. Expects Event validation failure,  hence retcode as 1.
		ut.expect(l_api_return_TYPE.retcode,l_api_return_TYPE.guid|| ' Event created wtih no validation error, in an expected error case. Need further analysis. Return Msg: '||l_api_return_TYPE.retmesg).to_equal(1);
	end invalid_partner;

	procedure proj_level_funding IS
		l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
		--
		l_retcode     number;
		l_msg_data    varchar2(200);
		--
		l_rec 		xxut_xxpa2592_pkg.rec_type_xxpa2592;
		l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
		--
		l_clob    CLOB;
		l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
		l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
		l_test_guid l_api_return_TYPE.guid%TYPE;
		l_current_event_phase varchar2(15);
		l_current_event_status varchar2(15);
		l_project_id pa_projects_all.project_id%TYPE;
		l_funding_created varchar2(1);
		l_task_level_funding_cnt number;
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
		l_rec.p_agreement_desc		:=  'Test Proj Level Funding for SPECTRUM_MEA CR 24100';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Proj Level Funding';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;

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

			--Keeps waiting for the event to halt at Phase03 in Ready status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute6,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'PHASE03' AND l_current_event_status = 'READY' and l_last_process_msg like '%PHASE03 HOOK completed status=1%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

			 --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;

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
			process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--#2. Expects event to be processed and with above expected messages. If not throw error.
			ut.expect(l_retcode,'Caught error in Phase 03 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

			if l_retcode = 0 then

				 --Process Event Phase 04
				----------------------------------------------------------
				process_event(l_test_guid,l_retcode,l_msg_data);
				----------------------------------------------------------

				--#3. Expects event to be processed and with above expected messages. If not throw error.
				ut.expect(l_retcode,'Caught error in Phase 04 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

				end if;

				select decode(count(1),0,'N','Y')
				into l_funding_created
				from pa_project_fundings
				where project_id = l_project_id;

				--#4. Expects funding to have been created by now. If not, throw error
				ut.expect(l_funding_created,'Funding is not created yet.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));

				IF l_funding_created = 'Y' THEN

					select count(1)
					into l_task_level_funding_cnt
					from pa_project_fundings
					where project_id = l_project_id
					and task_id is not null;

					--#5. Expects only task level funding to be created, and hence comparison with 0 records.
					ut.expect(l_task_level_funding_cnt,'Funding not created at Project Level, not as expected. See Setups for Project: '||l_rec.p_project_number).to_equal(0);

				END IF;

		END IF;

	end proj_level_funding;

    procedure task_level_funding IS
		l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
		--
		l_retcode     number;
		l_msg_data    varchar2(200);
		--
		l_rec 		xxut_xxpa2592_pkg.rec_type_xxpa2592;
		l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
		--
		l_clob    CLOB;
		l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
		l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
		l_test_guid l_api_return_TYPE.guid%TYPE;
		l_current_event_phase varchar2(15);
		l_current_event_status varchar2(15);
		l_project_id pa_projects_all.project_id%TYPE;
		l_funding_created varchar2(1);
		l_proj_level_funding_cnt number;
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
		l_rec.p_agreement_desc		:=  'Test Task Level Funding for SPECTRUM_MEA CR 24100';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Task Level Funding';
		l_rec.p_project_type		:=  'Billing';
		l_rec.p_so_number			:=  l_date;

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

			--Keeps waiting for the event to halt at Phase03 in Ready status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute6,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'PHASE03' AND l_current_event_status = 'READY' and l_last_process_msg like '%PHASE03 HOOK completed status=1%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

			 --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;

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
			process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--#2. Expects event to be processed and with above expected messages. If not throw error.
			ut.expect(l_retcode,'Caught error in Phase 03 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

			if l_retcode = 0 then

				 --Process Event Phase 04
				----------------------------------------------------------
				process_event(l_test_guid,l_retcode,l_msg_data);
				----------------------------------------------------------

				--#3. Expects event to be processed and with above expected messages. If not throw error.
				ut.expect(l_retcode,'Caught error in Phase 04 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

				end if;

				select decode(count(1),0,'N','Y')
				into l_funding_created
				from pa_project_fundings
				where project_id = l_project_id;

				--#4. Expects funding to have been created by now. If not, throw error
				ut.expect(l_funding_created,'Funding is not created yet.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));

				IF l_funding_created = 'Y' THEN

					select count(1)
					into l_proj_level_funding_cnt
					from pa_project_fundings
					where project_id = l_project_id
					and task_id is null;

					--#5. Expects only task level funding to be created, and hence comparison with 0 records.
					ut.expect(l_proj_level_funding_cnt,'Funding not created at Task Level, not as expected. See Setups for Project: '||l_rec.p_project_number).to_equal(0);

				END IF;

		END IF;

	end task_level_funding;

	procedure create_bill_rev_events IS
		l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
		--
		l_retcode     number;
		l_msg_data    varchar2(200);
		--
		l_rec 		xxut_xxpa2592_pkg.rec_type_xxpa2592;
		l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
		--
		l_clob    CLOB;
		l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
		l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
		l_test_guid l_api_return_TYPE.guid%TYPE;
		l_current_event_phase varchar2(15);
		l_current_event_status varchar2(15);
		l_project_id pa_projects_all.project_id%TYPE;
		l_proj_event_created varchar2(1);
		l_proj_level_funding_cnt number;
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
		l_create_event_setup_yn varchar2(1);
	begin
		--Data selection to use in Payload build
		l_rec.p_request_type		:=	'P';
		l_rec.p_partner_code		:=  'SPECTRUM_AP';
		l_rec.p_ext_message_id      :=  l_date;
		l_rec.p_agreement_number	:=  l_date;
		l_rec.p_agreement_desc		:=  'Test Billing Event Creation for SPECTRUM_MEA CR 24082';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Billing Event Creation';
		l_rec.p_project_type		:=  'Billing';
		l_rec.p_so_number			:=  l_date;

		--#0. Expects Partner to be setup with CREATE_PROJECT_EVENT key value setup as Y

		BEGIN
			SELECT nvl(key_value,'N')
			  INTO l_create_event_setup_yn
			  FROM xxint_event_type_key_vals
			 WHERE event_type = 'XXPA2592_EQUIP_ORDER_IN'
			   AND key_type = 'PARTNER'
			   AND key_type_value = l_rec.p_partner_code
			   AND key_name = 'CREATE_PROJECT_EVENT';

		EXCEPTION
			WHEN OTHERS THEN
				l_create_event_setup_yn := 'N';
		END;

		ut.expect(l_create_event_setup_yn,'Partner system :'||l_rec.p_partner_code || ' does not have the XXINT Key Value CREATE_PROJECT_EVENT setup as required. Not proceeding to event creation').to_(be_like('Y'));
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

			--Keeps waiting for the event to halt at Phase03 in Ready status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute6,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'PHASE03' AND l_current_event_status = 'READY' and l_last_process_msg like '%PHASE03 HOOK completed status=1%';

				DBMS_LOCK.sleep(60);
			END LOOP;

			--ut.expect(l_api_return_TYPE.retcode,'Project Number: '||l_project_number).to_equal(3);

			 --Get the project id for the newly created project
			 select project_id
			   into l_project_id
			   from pa_projects_all
			  where segment1 = l_project_number;

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
			process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--#2. Expects event to be processed and with above expected messages. If not throw error.
			ut.expect(l_retcode,'Caught error in Phase 03 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

			if l_retcode = 0 then

				 --Process Event Phase 04
				----------------------------------------------------------
				process_event(l_test_guid,l_retcode,l_msg_data);
				----------------------------------------------------------

				--#3. Expects event to be processed and with above expected messages. If not throw error.
				ut.expect(l_retcode,'Caught error in Phase 04 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

				end if;

				select decode(count(1),0,'N','Y')
				into l_proj_event_created
				from pa_events
				where project_id = l_project_id;

				--#4. Expects billing events to have been created by now. If not, throw error
				ut.expect(l_proj_event_created,'Billing Events not created.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));


		END IF;

	end create_bill_rev_events;

  procedure test_agr_dff_cr_from_spectrum IS
		l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
		--
		l_retcode     number;
		l_msg_data    varchar2(200);
		--
		l_rec 		xxut_xxpa2592_pkg.rec_type_xxpa2592;
		l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
		--
		l_clob    CLOB;
		l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
		l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
		l_test_guid l_api_return_TYPE.guid%TYPE;
		l_current_event_phase varchar2(15);
		l_current_event_status varchar2(15);
		l_project_id pa_projects_all.project_id%TYPE;
		l_agr_dff_as_expected varchar2(1);
    l_agreement_id pa_Agreements_all.agreement_id%TYPE;
		l_task_level_funding_cnt number;
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
		l_rec.p_agreement_desc		:=  'Test Agr DFF creation for SPECTRUM_MEA CR 24090';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Agr DFF Creation';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;
    l_rec.p_agr_dff_attributes := '<ATTRIBUTE1>2</ATTRIBUTE1><ATTRIBUTE2>Y</ATTRIBUTE2>';    

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

			--Keeps waiting for the event to halt at Phase03 in Ready status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute6,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'PHASE03' AND l_current_event_status = 'READY' and l_last_process_msg like '%PHASE03 HOOK completed status=1%';

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
			process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--#2. Expects event to be processed and with above expected messages. If not throw error.
			ut.expect(l_retcode,'Caught error in Phase 03 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

			if l_retcode = 0 then

				 --Process Event Phase 04
				----------------------------------------------------------
				process_event(l_test_guid,l_retcode,l_msg_data);
				----------------------------------------------------------

				--#3. Expects event to be processed and with above expected messages. If not throw error.
				ut.expect(l_retcode,'Caught error in Phase 04 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

				end if;

				select decode(count(1),0,'N','Y')
				into l_agr_dff_as_expected
				from pa_agreements_all pa,
        pa_project_fundings ppf 
				where ppf.project_id = l_project_id
        and ppf.agreement_id = pa.agreement_id
        and pa.attribute1 = '2'
        and pa.attribute2 = 'Y';

				--#4. Expects DFF to have been created as per the SPECTRUM Payload. If not, throw error
				ut.expect(l_agr_dff_as_expected,'Agreement DFF not created as expected.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));
				
		END IF;

	end test_agr_dff_cr_from_spectrum;

  procedure test_agr_dff_cr_from_r12 IS
		l_api_return_TYPE XXINT_EVENT_API_Pub.GT_EVENT_API_TYPE;
		--
		l_retcode     number;
		l_msg_data    varchar2(200);
		--
		l_rec 		xxut_xxpa2592_pkg.rec_type_xxpa2592;
		l_date		VARCHAR2(100) := TO_CHAR(SYSDATE,'DDMMYYHHMISS');
		--
		l_clob    CLOB;
		l_clob_code CONSTANT xxint_event_clobs_v.clob_code%type := 'HTTP_RECEIVE_XML_PAYLOAD_IN';
		l_string  VARCHAR2(500);		l_flag		VARCHAR2(10):='N';
		l_test_guid l_api_return_TYPE.guid%TYPE;
		l_current_event_phase varchar2(15);
		l_current_event_status varchar2(15);
		l_project_id pa_projects_all.project_id%TYPE;
		l_agr_dff_as_expected varchar2(1);
    l_ou_dff_1 varchar2(30);
    l_ou_dff_2 varchar2(30);
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
		l_rec.p_agreement_desc		:=  'Test Agr DFF creation for SPECTRUM_MEA CR 24090';
		l_rec.p_cust_po_number		:=  l_date;
		l_rec.p_project_number		:=  l_date;
		l_rec.p_project_name		:=  l_date;
		l_rec.p_project_desc		:=  'utPLSQL Test Agr DFF Creation';
		l_rec.p_project_type		:=  'Advance Billing';
		l_rec.p_so_number			:=  l_date;
    l_rec.p_agr_dff_attributes := NULL;    
    
    begin
    
      select attribute4, attribute5
      into l_ou_dff_1, l_ou_dff_2
       from fnd_lookup_Values_vl
      where lookup_type = 'XXPA2078_OU_DETAILS'
       and lookup_code = 'SGOUHUB'
       and enabled_flag = 'Y';
       
    exception 
     when others then
       l_ou_dff_1 := null;
       l_ou_dff_2 := null;
       
    end;   
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

			--Keeps waiting for the event to halt at Phase03 in Ready status
			loop
				SELECT current_phase,
					   current_Status,
					   attribute6,
					   lasT_process_msg
				  INTO l_current_event_phase,
					   l_current_event_status,
					   l_project_number,
					   l_last_process_msg
				  FROM xxint_events
				 WHERE guid = l_test_guid;

				EXIT WHEN l_current_event_phase = 'PHASE03' AND l_current_event_status = 'READY' and l_last_process_msg like '%PHASE03 HOOK completed status=1%';

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
			process_event(l_test_guid,l_retcode,l_msg_data);
			----------------------------------------------------------

			--#2. Expects event to be processed and with above expected messages. If not throw error.
			ut.expect(l_retcode,'Caught error in Phase 03 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

			if l_retcode = 0 then

				 --Process Event Phase 04
				----------------------------------------------------------
				process_event(l_test_guid,l_retcode,l_msg_data);
				----------------------------------------------------------

				--#3. Expects event to be processed and with above expected messages. If not throw error.
				ut.expect(l_retcode,'Caught error in Phase 04 , not as expected. l_msg_data:'||l_msg_data||CHR(10)||'See Inbound payload/CLOB at Guid: '||l_api_return_TYPE.guid).to_equal(0);

				end if;

				select decode(count(1),0,'N','Y')
				into l_agr_dff_as_expected
				from pa_agreements_all pa,
                     pa_project_fundings ppf 
				where ppf.project_id = l_project_id
					and ppf.agreement_id = pa.agreement_id
					and pa.attribute1 = l_ou_dff_1
					and pa.attribute2 = l_ou_dff_2;

				--#4. Expects DFF to have been created as per the SPECTRUM Payload. If not, throw error
				ut.expect(l_agr_dff_as_expected,'Agreement DFF not created as expected.'||CHR(10)||'See Log files at Guid: '||l_api_return_TYPE.guid).to_(be_like('Y'));
				
		END IF;

	end test_agr_dff_cr_from_r12;
	
end xxut_xxpa2592_pkg;
/
show errors package body xxut_xxpa2592_pkg