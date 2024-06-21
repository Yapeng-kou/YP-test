set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

/****************************************************************************
** Title:       Script to create XNTA
** File:        XNTA.sql
** Description: 
** Parameters:  {None.}
** Run as:      CUX
** 12_2_compliant: YES
** Keyword Tracking:
**   %PCMS_HEADER_SUBSTITUTION_START%
**   $Header: %HEADER% $
**   $Change History$ (*ALL VERSIONS*)
**   %PL%
**   %PCMS_HEADER_SUBSTITUTION_END%
**
**   History:
** Date          Who                Description
** -----------   ------------------ -------------------------------------------
** 27-MAY-2024   Barry Huang        CUXAU0001 Create to Setup WS Configuration
**
*******************************************************************************/

Whenever sqlerror continue
set serveroutput on size 1000000 lines 132 trimout on tab off pages 100

DECLARE
  l_table_exists  NUMBER := 0;
  lv_release_name fnd_product_groups.release_name%TYPE;
BEGIN
  SELECT COUNT(*)
    INTO l_table_exists
    FROM user_objects
   WHERE object_name = 'XNTA'
     AND object_type = 'TABLE';
  dbms_output.put_line('Table Exists or not : ' || l_table_exists);
  IF l_table_exists > 0 THEN
    dbms_output.put_line('Table Already Exists');
    RETURN;
  END IF;

  EXECUTE IMMEDIATE '
  create table XNTA
(
  transaction_date          DATE not null,
  amount                    NUMBER not null,
  entered_amount            NUMBER,
  quantity                  NUMBER,
  currency_code             VARCHAR2(15),
  currency_conversion_type  VARCHAR2(30),
  currency_conversion_rate  NUMBER,
  currency_conversion_date  DATE,
  po_distribution_id        NUMBER not null,
  rcv_transaction_id        NUMBER,
  invoice_distribution_id   NUMBER,
  accrual_account_id        NUMBER not null,
  transaction_type_code     VARCHAR2(25),
  inventory_organization_id NUMBER,
  write_off_id              NUMBER,
  operating_unit_id         NUMBER not null,
  build_id                  NUMBER,
  ae_header_id              NUMBER,
  last_update_date          DATE,
  last_updated_by           NUMBER,
  last_update_login         NUMBER,
  creation_date             DATE,
  created_by                NUMBER,
  request_id                NUMBER,
  program_application_id    NUMBER,
  program_id                NUMBER,
  program_update_date       DATE,
  ae_line_num               NUMBER,
  inventory_transaction_id  NUMBER
)
tablespace APPS_TS_TX_DATA';

  dbms_output.put_line('Table created');
 

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Error: ' || SQLERRM);
    raise_application_error(-20001,
                            'Table Creation Failed - SQLERRM: ' || SQLERRM);
END;
/
