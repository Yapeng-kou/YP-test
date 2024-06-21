CREATE OR REPLACE PACKAGE xxap_utility_pkg IS

  -- Author  : IRIIEB
  -- Created : 7/15/2020 4:09:26 PM
  -- Purpose :
  /****************************************************************************
  Program:   xxap_utility_pkg.pks
  Version:
  Object:    PACKAGE
  Description:  pl/sql package that contains common utilities for AP
  Modificaiton Log:
  Date        Who           Request     Description
  ---------   -----------   ----------- -----------------------------------------
  15-JUL-2020 Harivardhan G              New
  08-AUG-2020 Harivardhan G RT8856589 - Invoice Import from Beeline - Remove special characters from invoice description
  11-Nov-2020  Ravi Alapati    RT8959634 - Concur Expense Invoice Interface - Update invoice description to remove special character > as it is an EDI data delimiter  
  */

  -- Public function and procedure declarations

FUNCTION replace_spl_char(p_text IN VARCHAR2) RETURN VARCHAR2;
FUNCTION replace_non_match_char(p_text IN VARCHAR2,
                                p_rice_id IN VARCHAR2)
RETURN VARCHAR2; -- Added w.r.to RT8856589
/*Added new function for RT8959634 */   
FUNCTION remove_spl_char_by_rice(
                          p_rice               IN VARCHAR2,
                          p_lookup_type  IN VARCHAR2,
                          p_text              IN VARCHAR2
                          )
                RETURN VARCHAR2;           
END XXAP_UTILITY_PKG;
/