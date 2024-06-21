/*********************************************************
** Title:       Script to create Synonym for custom table XXPA.XXPA_EVENTS_EXTRA_INFO
** File:        XXPA2723_EVENTS_ADDITIONAL_SYN.sql
** Description: This script creates table synonym for XXPA_EVENTS_EXTRA_INFO
** Parameters:  {None.}
** Run as:      XXPA
** Keyword Tracking:
**   
**   $Header: xxpa/patch/115/sql/XXPA2723_EVENTS_ADDITIONAL_SYN.sql 1.0 11-MAY-2015 00:00:00 CCBGYK $
**   $Change History$ (*ALL VERSIONS*)
**   Revision 1.0 (COMPLETE)
**     Created:  11-MAY-2015 00:00:00 CCBGYK
**       Initial revision.
**   

** History:
** Date          Who                Description
** -----------   ------------------ ------------------------------------
** 11-May-2015   ccbgyk             Initial Creation
**
********************************************************/

CREATE SYNONYM APPS.XXPA_EVENTS_EXTRA_INFO FOR XXPA.XXPA_EVENTS_EXTRA_INFO;
