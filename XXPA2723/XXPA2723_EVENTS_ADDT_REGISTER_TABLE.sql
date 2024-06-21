/*********************************************************
** Title:       Registering custom table XXPA.XXPA_EVENTS_EXTRA_INFO
** File:        XXPA2723_EVENTS_ADDT_REGISTER_TABLE.sql
** Description: This script is to register custom table XXPA_EVENTS_EXTRA_INFO
** Parameters:  {None.}
** Run as:      XXPA
** Keyword Tracking:
**   
**   $Header: xxpa/patch/115/sql/XXPA2723_EVENTS_ADDT_REGISTER_TABLE.sql 1.0 11-MAY-2015 00:00:00 CCBGYK $
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
Whenever sqlerror exit failure rollback

BEGIN
ad_dd.register_table ('XXPA','XXPA_EVENTS_EXTRA_INFO','T');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','EVENT_ID',1,'NUMBER',32,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','EVENT_NUM',2,'NUMBER',15,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','EVENT_TYPE',3,'VARCHAR2',240,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','PROJECT_ID',4,'NUMBER',15,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','PROJECT_NAME',5,'VARCHAR2',30,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','TASK_ID',6,'NUMBER',15,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','TASK_NUMBER',7,'VARCHAR2',25,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','TASK_NAME',8,'VARCHAR2',240,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ORG_ID',9,'NUMBER',15,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','OPERATING_UNIT_NAME',10,'VARCHAR2',60,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','CONTEXT',11,'VARCHAR2',60,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE1',12,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE2',13,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE3',14,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE4',15,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE5',16,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE6',17,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE7',18,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE8',19,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE9',20,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE10',21,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE11',22,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE12',23,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE13',24,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE14',25,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE15',26,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE16',27,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE17',28,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE18',29,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE19',30,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','ATTRIBUTE20',31,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE_CATEGORY',32,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE1',33,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE2',34,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE3',35,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE4',36,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE5',37,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE6',38,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE7',39,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE8',40,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE9',41,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE10',42,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE11',43,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE12',44,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE13',45,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE14',46,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE15',47,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE16',48,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE17',49,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE18',50,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE19',51,'VARCHAR2',500,'N','N');
ad_dd.register_column ('XXPA','XXPA_EVENTS_EXTRA_INFO','GLOBAL_ATTRIBUTE20',52,'VARCHAR2',500,'N','N');
COMMIT;
END;
/