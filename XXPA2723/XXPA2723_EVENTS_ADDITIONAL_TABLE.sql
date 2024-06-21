/*********************************************************
** Title:       Create custom table XXPA.XXPA_EVENTS_EXTRA_INFO
** File:        XXPA2723_EVENTS_ADDITIONAL_TABLE.sql
** Description: This script creates table XXPA_EVENTS_EXTRA_INFO
** Parameters:  {None.}
** Run as:      XXPA
** Keyword Tracking:
**   
**   $Header: xxpa/patch/115/sql/XXPA2723_EVENTS_ADDITIONAL_TABLE.sql 1.0 11-MAY-2015 00:00:00 CCBGYK $
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

-- Create table
CREATE TABLE XXPA.XXPA_EVENTS_EXTRA_INFO
(
  EVENT_ID                   NUMBER             NOT NULL,
  EVENT_NUM                  NUMBER(15),
  EVENT_TYPE                 VARCHAR2(240 BYTE),
  PROJECT_ID                 NUMBER(15),
  PROJECT_NAME               VARCHAR2(30 BYTE),
  TASK_ID                    NUMBER(15),
  TASK_NUMBER                VARCHAR2(25 BYTE),
  TASK_NAME                  VARCHAR2(240 BYTE),
  ORG_ID                     NUMBER,
  OPERATING_UNIT_NAME        VARCHAR2(60 BYTE),
  CONTEXT                    VARCHAR2(60 BYTE),
  ATTRIBUTE1                 VARCHAR2(500 BYTE),
  ATTRIBUTE2                 VARCHAR2(500 BYTE),
  ATTRIBUTE3                 VARCHAR2(500 BYTE),
  ATTRIBUTE4                 VARCHAR2(500 BYTE),
  ATTRIBUTE5                 VARCHAR2(500 BYTE),
  ATTRIBUTE6                 VARCHAR2(500 BYTE),
  ATTRIBUTE7                 VARCHAR2(500 BYTE),
  ATTRIBUTE8                 VARCHAR2(500 BYTE),
  ATTRIBUTE9                 VARCHAR2(500 BYTE),
  ATTRIBUTE10                VARCHAR2(500 BYTE),
  ATTRIBUTE11                VARCHAR2(500 BYTE),
  ATTRIBUTE12                VARCHAR2(500 BYTE),
  ATTRIBUTE13                VARCHAR2(500 BYTE),
  ATTRIBUTE14                VARCHAR2(500 BYTE),
  ATTRIBUTE15                VARCHAR2(500 BYTE),
  ATTRIBUTE16                VARCHAR2(500 BYTE),
  ATTRIBUTE17                VARCHAR2(500 BYTE),
  ATTRIBUTE18                VARCHAR2(500 BYTE),
  ATTRIBUTE19                VARCHAR2(500 BYTE),
  ATTRIBUTE20                VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE_CATEGORY  VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE1          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE2          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE3          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE4          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE5          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE6          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE7          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE8          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE9          VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE10         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE11         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE12         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE13         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE14         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE15         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE16         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE17         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE18         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE19         VARCHAR2(500 BYTE),
  GLOBAL_ATTRIBUTE20         VARCHAR2(500 BYTE),
  CREATED_BY                 NUMBER,
  CREATION_DATE              DATE,
  LAST_UPDATED_BY            NUMBER,
  LAST_UPDATE_DATE           DATE,
  LAST_UPDATE_LOGIN          NUMBER,
  CONSTRAINT XXPA_EVENTS_EXTRA_INFO_PK PRIMARY KEY (EVENT_ID)
);

COMMENT ON TABLE XXPA.XXPA_EVENTS_EXTRA_INFO IS '$Header: xxpa/patch/115/sql/xxpa_event_extra_info.sql 1.0 26-APR-2015 11:05:16 CCBGYK $';

/