create or replace PACKAGE BODY xxap_utility_pkg
IS

/****************************************************************************
** Program:   xxap_utility_pkg.pkb
** Version:
** Object:    PACKAGE
** Description:  pl/sql package that contains common utilities for AP
** Modificaiton Log:
** Date         Who                  Request     Description
** ---------    -------------------- ----------- -----------------------------------------
** 15-JUL-2020  Harivardhan Gonchi                  New
** 08-AUG-2020 Harivardhan G RT8856589 - Invoice Import from Beeline - Remove special characters from invoice description
*/


/****************************************************************************
** Function Name: replace_spl_char
**
** Purpose: Remove Special Characters
**
** Procedure History:
** Date         Who                   Description
** ---------    ---------------       ----------------------------------------
** 15-JUL-2020  Harivardhan Gonchi    PM#344: Function to handle special character
** 08-AUG-2020 Harivardhan G RT8856589 - Invoice Import from Beeline - Remove special characters from invoice description
** 11-Nov-2020  Ravi Alapati    RT8959634 - Concur Expense Invoice Interface - Update invoice description to remove special character > as it is an EDI data delimiter
*/

FUNCTION replace_spl_char(p_text IN VARCHAR2)
RETURN VARCHAR2 IS
   l_text VARCHAR2(4000):= p_text;

   CURSOR c_spl_char
   IS
     SELECT chr(meaning) spl_char
       FROM fnd_lookup_values
      WHERE lookup_type = 'XXAP_EXCLUDE_SPECIAL_CHAR_LKP'
        AND enabled_flag = 'Y'
        AND language = 'US'
        AND sysdate BETWEEN nvl(TRUNC(start_date_active), sysdate -1) AND nvl(TRUNC(end_date_active), sysdate + 1) ;

BEGIN
   FOR rec_spl IN c_spl_char
   LOOP
      l_text := REPLACE(REPLACE(REPLACE(l_text, CHR(10),''), CHR(13), ''), rec_spl.spl_char, '');---Changes for RT#8259449
   END LOOP;

   RETURN(l_text);

EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
END replace_spl_char;

-- Added below function w.r.to RT8856589
FUNCTION replace_non_match_char(p_text IN VARCHAR2,
                                p_rice_id IN VARCHAR2) 
RETURN VARCHAR2 IS
   l_text VARCHAR2(4000):= p_text;
   v_text VARCHAR2(4000):= p_text;

   CURSOR c_spl_char
   IS
     SELECT meaning spl_char
       FROM fnd_lookup_values
      WHERE lookup_type = 'XXAP_NON_MATCH_CHAR_LIST_LKP'
        AND enabled_flag = 'Y'
		AND lower(tag) = lower(p_rice_id)
        AND language = 'US'
        AND sysdate BETWEEN nvl(TRUNC(start_date_active), sysdate -1) AND nvl(TRUNC(end_date_active), sysdate + 1) ;

BEGIN
   FOR rec_spl IN c_spl_char
   LOOP
    select REGEXP_REPLACE(''||p_text||'',''||rec_spl.spl_char||'','') INTO l_text from dual ;

   END LOOP;

   RETURN(l_text);

EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
END replace_non_match_char;

/*Added new function for RT8959634 */ 
-- copied this code from xxont_common_utility_pkg.remove_spl_char  
FUNCTION remove_spl_char_by_rice(
                          p_rice               IN VARCHAR2,
                          p_lookup_type  IN VARCHAR2,
                          p_text              IN VARCHAR2
                          )
RETURN VARCHAR2 IS
   l_text VARCHAR2(4000):= p_text;

   CURSOR spl_char
   IS
     SELECT chr(description) spl_char
       FROM fnd_lookup_values
      WHERE lookup_type = p_lookup_type
        AND tag = p_rice
        AND enabled_flag = 'Y'
        AND language =USERENV('lang')
        AND trunc(sysdate) between trunc(nvl(start_date_active , sysdate)) and trunc(nvl(end_date_active, sysdate)) ;

BEGIN
   FOR rec_spl IN spl_char
   LOOP
      l_text := REPLACE(l_text,rec_spl.spl_char, '');
   END LOOP;

   RETURN(l_text);

EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
       xx_pk_fnd_file.put_line (xx_pk_fnd_file.LOG,'Exception occurred while removing spcl char:  ' || SQLERRM );
                                
END remove_spl_char_by_rice;

END xxap_utility_pkg;
/
