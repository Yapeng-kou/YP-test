CREATE OR REPLACE PACKAGE BODY APPS.xxpa_events_extra_info_tapi IS
/*********************************************************
   ** Title:       Package to Insert, Update and Delete Records in Custom Table XXPA_EVENTS_EXTRA_INFO
   ** File:        XXPA_EVENTS_EXTRA_INFO_Tapi.pkb
   ** Description: This script creates a package body
   ** Parameters:  {None.}
   ** Run as:      APPS
   ** Keyword Tracking:
   **
   **   $Header: xxpa/patch/115/sql/XXPA_EVENTS_EXTRA_INFO_Tapi.pkb
   **   $Change History$ (*ALL VERSIONS*)
   **   Revision 1.0 (COMPLETE)
   **   Created:  07-JUL-2015       CCBGYK
   **   Initial revision.
   **
   ** HISTORY
   ** -----------   ------------------         	-------------------------------------------------
   ** 07-JUL-2015   Sanket Sinha (CCBGYK)		Initial Version
   ** 15-OCT-2019	John Markham				CR 24146 Added update_all extended DFFs.
   ** 04-SEP-2020   Mites K Rathod (CCKRAV)      CR24255  XXPA_INSERT_UPD_PRC added 
*************************************************************************************/
 --Added for CR24255
  
     PROCEDURE xxpa_insert_upd_prc (
        p_extra_rec   IN OUT xxpa_eve_ext_info_tapi_rec,
        x_error_code  OUT  VARCHAR2,
        x_error_msg   OUT  VARCHAR2
    ) IS
        ln_event_cnt NUMBER;
    BEGIN
        BEGIN
            SELECT
                COUNT(1)
            INTO ln_event_cnt
            FROM
                xxpa_events_extra_info
            WHERE
                event_id = p_extra_rec.event_id;

        EXCEPTION
            WHEN OTHERS THEN
                ln_event_cnt := 0;
        END;

        IF ln_event_cnt = 0 THEN
        
        if p_extra_rec.event_id is not null then 
            select nvl(p_extra_rec.project_id,pe.project_id),
                   nvl(p_extra_rec.project_name,ppa.name),
                   nvl(p_extra_rec.task_id,pe.task_id),
                   nvl(p_extra_rec.org_id,ppa.org_id),
                   nvl(p_extra_rec.operating_unit_name,hou.name)
            into p_extra_rec.project_id,
                 p_extra_rec.project_name,
                 p_extra_rec.task_id,
                 p_extra_rec.org_id,
                 p_extra_rec.operating_unit_name
            from pa_events pe, 
                 pa_projects_all ppa, 
                 hr_operating_units hou
            where event_id = p_extra_rec.event_id
            and ppa.project_id = pe.project_id
            and hou.organization_id = ppa.org_id;
                 
        end if;
        
            INSERT INTO xxpa_events_extra_info (
                operating_unit_name,
                task_id,
                last_updated_by,
                project_id,
                context,
                global_attribute13,
                global_attribute14,
                global_attribute11,
                global_attribute12,
                global_attribute17,
                global_attribute18,
                global_attribute15,
                global_attribute16,
                global_attribute19,
                task_name,
                global_attribute20,
                project_name,
                global_attribute10,
                attribute13,
                attribute14,
                attribute11,
                attribute12,
                attribute10,
                last_update_login,
                created_by,
                attribute3,
                global_attribute6,
                event_type,
                attribute2,
                global_attribute7,
                attribute1,
                global_attribute4,
                global_attribute5,
                task_number,
                global_attribute2,
                global_attribute3,
                global_attribute1,
                attribute9,
                attribute8,
                attribute7,
                creation_date,
                last_update_date,
                attribute6,
                attribute5,
                global_attribute8,
                attribute20,
                attribute4,
                org_id,
                global_attribute9,
                attribute19,
                attribute16,
                attribute15,
                attribute18,
                event_id,
                attribute17,
                event_num,
                global_attribute_category,
                attribute21,
                attribute22,
                attribute23,
                attribute24,
                attribute25,
                attribute26,
                attribute27,
                attribute28,
                attribute29,
                attribute30,
                attribute31,
                attribute32,
                attribute33,
                attribute34,
                attribute35,
                attribute36,
                attribute37,
                attribute38,
                attribute39,
                attribute40,
                attribute41,
                attribute42,
                attribute43,
                attribute44,
                attribute45,
                attribute46,
                attribute47,
                attribute48,
                attribute49,
                attribute50,
                attribute51,
                attribute52,
                attribute53,
                attribute54,
                attribute55,
                attribute56,
                attribute57,
                attribute58,
                attribute59,
                attribute60,
                attribute61,
                attribute62,
                attribute63,
                attribute64,
                attribute65,
                attribute66,
                attribute67,
                attribute68,
                attribute69
            ) VALUES (
                p_extra_rec.operating_unit_name,
                p_extra_rec.task_id,
                fnd_global.user_id, --p_extra_rec.last_updated_by,
                p_extra_rec.project_id,
                p_extra_rec.context,
                p_extra_rec.global_attribute13,
                p_extra_rec.global_attribute14,
                p_extra_rec.global_attribute11,
                p_extra_rec.global_attribute12,
                p_extra_rec.global_attribute17,
                p_extra_rec.global_attribute18,
                p_extra_rec.global_attribute15,
                p_extra_rec.global_attribute16,
                p_extra_rec.global_attribute19,
                p_extra_rec.task_name,
                p_extra_rec.global_attribute20,
                p_extra_rec.project_name,
                p_extra_rec.global_attribute10,
                p_extra_rec.attribute13,
                p_extra_rec.attribute14,
                p_extra_rec.attribute11,
                p_extra_rec.attribute12,
                p_extra_rec.attribute10,
                fnd_global.login_id, --p_extra_rec.last_update_login,
                fnd_global.user_id, --p_extra_rec.created_by,
                p_extra_rec.attribute3,
                p_extra_rec.global_attribute6,
                p_extra_rec.event_type,
                p_extra_rec.attribute2,
                p_extra_rec.global_attribute7,
                p_extra_rec.attribute1,
                p_extra_rec.global_attribute4,
                p_extra_rec.global_attribute5,
                p_extra_rec.task_number,
                p_extra_rec.global_attribute2,
                p_extra_rec.global_attribute3,
                p_extra_rec.global_attribute1,
                p_extra_rec.attribute9,
                p_extra_rec.attribute8,
                p_extra_rec.attribute7,
                sysdate,--p_extra_rec.creation_date,
                sysdate,--p_extra_rec.last_update_date,
                p_extra_rec.attribute6,
                p_extra_rec.attribute5,
                p_extra_rec.global_attribute8,
                p_extra_rec.attribute20,
                p_extra_rec.attribute4,
                p_extra_rec.org_id,
                p_extra_rec.global_attribute9,
                p_extra_rec.attribute19,
                p_extra_rec.attribute16,
                p_extra_rec.attribute15,
                p_extra_rec.attribute18,
                p_extra_rec.event_id,
                p_extra_rec.attribute17,
                p_extra_rec.event_num,
                p_extra_rec.global_attribute_category,
                p_extra_rec.attribute21,
                p_extra_rec.attribute22,
                p_extra_rec.attribute23,
                p_extra_rec.attribute24,
                p_extra_rec.attribute25,
                p_extra_rec.attribute26,
                p_extra_rec.attribute27,
                p_extra_rec.attribute28,
                p_extra_rec.attribute29,
                p_extra_rec.attribute30,
                p_extra_rec.attribute31,
                p_extra_rec.attribute32,
                p_extra_rec.attribute33,
                p_extra_rec.attribute34,
                p_extra_rec.attribute35,
                p_extra_rec.attribute36,
                p_extra_rec.attribute37,
                p_extra_rec.attribute38,
                p_extra_rec.attribute39,
                p_extra_rec.attribute40,
                p_extra_rec.attribute41,
                p_extra_rec.attribute42,
                p_extra_rec.attribute43,
                p_extra_rec.attribute44,
                p_extra_rec.attribute45,
                p_extra_rec.attribute46,
                p_extra_rec.attribute47,
                p_extra_rec.attribute48,
                p_extra_rec.attribute49,
                p_extra_rec.attribute50,
                p_extra_rec.attribute51,
                p_extra_rec.attribute52,
                p_extra_rec.attribute53,
                p_extra_rec.attribute54,
                p_extra_rec.attribute55,
                p_extra_rec.attribute56,
                p_extra_rec.attribute57,
                p_extra_rec.attribute58,
                p_extra_rec.attribute59,
                p_extra_rec.attribute60,
                p_extra_rec.attribute61,
                p_extra_rec.attribute62,
                p_extra_rec.attribute63,
                p_extra_rec.attribute64,
                p_extra_rec.attribute65,
                p_extra_rec.attribute66,
                p_extra_rec.attribute67,
                p_extra_rec.attribute68,
                p_extra_rec.attribute69
            );

        ELSE
            UPDATE xxpa_events_extra_info
            SET
                operating_unit_name = p_extra_rec.operating_unit_name,
                task_id = p_extra_rec.task_id,
                last_updated_by = p_extra_rec.last_updated_by,
                project_id = p_extra_rec.project_id,
                context = p_extra_rec.context,
                global_attribute13 = p_extra_rec.global_attribute13,
                global_attribute14 = p_extra_rec.global_attribute14,
                global_attribute11 = p_extra_rec.global_attribute11,
                global_attribute12 = p_extra_rec.global_attribute12,
                global_attribute17 = p_extra_rec.global_attribute17,
                global_attribute18 = p_extra_rec.global_attribute18,
                global_attribute15 = p_extra_rec.global_attribute15,
                global_attribute16 = p_extra_rec.global_attribute16,
                global_attribute19 = p_extra_rec.global_attribute19,
                task_name = p_extra_rec.task_name,
                global_attribute20 = p_extra_rec.global_attribute20,
                project_name = p_extra_rec.project_name,
                global_attribute10 = p_extra_rec.global_attribute10,
                attribute13 = p_extra_rec.attribute13,
                attribute14 = p_extra_rec.attribute14,
                attribute11 = p_extra_rec.attribute11,
                attribute12 = p_extra_rec.attribute12,
                attribute10 = p_extra_rec.attribute10,
                last_update_login = p_extra_rec.last_update_login,
                created_by = p_extra_rec.created_by,
                attribute3 = p_extra_rec.attribute3,
                global_attribute6 = p_extra_rec.global_attribute6,
                event_type = p_extra_rec.event_type,
                attribute2 = p_extra_rec.attribute2,
                global_attribute7 = p_extra_rec.global_attribute7,
                attribute1 = p_extra_rec.attribute1,
                global_attribute4 = p_extra_rec.global_attribute4,
                global_attribute5 = p_extra_rec.global_attribute5,
                task_number = p_extra_rec.task_number,
                global_attribute2 = p_extra_rec.global_attribute2,
                global_attribute3 = p_extra_rec.global_attribute3,
                global_attribute1 = p_extra_rec.global_attribute1,
                attribute9 = p_extra_rec.attribute9,
                attribute8 = p_extra_rec.attribute8,
                attribute7 = p_extra_rec.attribute7,
                creation_date = p_extra_rec.creation_date,
                last_update_date = p_extra_rec.last_update_date,
                attribute6 = p_extra_rec.attribute6,
                attribute5 = p_extra_rec.attribute5,
                global_attribute8 = p_extra_rec.global_attribute8,
                attribute20 = p_extra_rec.attribute20,
                attribute4 = p_extra_rec.attribute4,
                org_id = p_extra_rec.org_id,
                global_attribute9 = p_extra_rec.global_attribute9,
                attribute19 = p_extra_rec.attribute19,
                attribute16 = p_extra_rec.attribute16,
                attribute15 = p_extra_rec.attribute15,
                attribute18 = p_extra_rec.attribute18,
                attribute17 = p_extra_rec.attribute17,
                event_num = p_extra_rec.event_num,
                global_attribute_category = p_extra_rec.global_attribute_category,
                attribute21 = p_extra_rec.attribute21,
                attribute22 = p_extra_rec.attribute22,
                attribute23 = p_extra_rec.attribute23,
                attribute24 = p_extra_rec.attribute24,
                attribute25 = p_extra_rec.attribute25,
                attribute26 = p_extra_rec.attribute26,
                attribute27 = p_extra_rec.attribute27,
                attribute28 = p_extra_rec.attribute28,
                attribute29 = p_extra_rec.attribute29,
                attribute30 = p_extra_rec.attribute30,
                attribute31 = p_extra_rec.attribute31,
                attribute32 = p_extra_rec.attribute32,
                attribute33 = p_extra_rec.attribute33,
                attribute34 = p_extra_rec.attribute34,
                attribute35 = p_extra_rec.attribute35,
                attribute36 = p_extra_rec.attribute36,
                attribute37 = p_extra_rec.attribute37,
                attribute38 = p_extra_rec.attribute38,
                attribute39 = p_extra_rec.attribute39,
                attribute40 = p_extra_rec.attribute40,
                attribute41 = p_extra_rec.attribute41,
                attribute42 = p_extra_rec.attribute42,
                attribute43 = p_extra_rec.attribute43,
                attribute44 = p_extra_rec.attribute44,
                attribute45 = p_extra_rec.attribute45,
                attribute46 = p_extra_rec.attribute46,
                attribute47 = p_extra_rec.attribute47,
                attribute48 = p_extra_rec.attribute48,
                attribute49 = p_extra_rec.attribute49,
                attribute50 = p_extra_rec.attribute50,
                attribute51 = p_extra_rec.attribute51,
                attribute52 = p_extra_rec.attribute52,
                attribute53 = p_extra_rec.attribute53,
                attribute54 = p_extra_rec.attribute54,
                attribute55 = p_extra_rec.attribute55,
                attribute56 = p_extra_rec.attribute56,
                attribute57 = p_extra_rec.attribute57,
                attribute58 = p_extra_rec.attribute58,
                attribute59 = p_extra_rec.attribute59,
                attribute60 = p_extra_rec.attribute60,
                attribute61 = p_extra_rec.attribute61,
                attribute62 = p_extra_rec.attribute62,
                attribute63 = p_extra_rec.attribute63,
                attribute64 = p_extra_rec.attribute64,
                attribute65 = p_extra_rec.attribute65,
                attribute66 = p_extra_rec.attribute66,
                attribute67 = p_extra_rec.attribute67,
                attribute68 = p_extra_rec.attribute68,
                attribute69 = p_extra_rec.attribute69
            WHERE
                event_id = p_extra_rec.event_id;

        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            x_error_msg := sqlerrm;
            x_error_code := 'E';
    END xxpa_insert_upd_prc;
  

  -- insert
    PROCEDURE ins (
        p_operating_unit_name        IN  xxpa_events_extra_info.operating_unit_name%TYPE DEFAULT NULL,
        p_task_id                    IN  xxpa_events_extra_info.task_id%TYPE DEFAULT NULL,
        p_last_updated_by            IN  xxpa_events_extra_info.last_updated_by%TYPE DEFAULT NULL,
        p_project_id                 IN  xxpa_events_extra_info.project_id%TYPE DEFAULT NULL,
        p_context                    IN  xxpa_events_extra_info.context%TYPE DEFAULT NULL,
        p_global_attribute13         IN  xxpa_events_extra_info.global_attribute13%TYPE DEFAULT NULL,
        p_global_attribute14         IN  xxpa_events_extra_info.global_attribute14%TYPE DEFAULT NULL,
        p_global_attribute11         IN  xxpa_events_extra_info.global_attribute11%TYPE DEFAULT NULL,
        p_global_attribute12         IN  xxpa_events_extra_info.global_attribute12%TYPE DEFAULT NULL,
        p_global_attribute17         IN  xxpa_events_extra_info.global_attribute17%TYPE DEFAULT NULL,
        p_global_attribute18         IN  xxpa_events_extra_info.global_attribute18%TYPE DEFAULT NULL,
        p_global_attribute15         IN  xxpa_events_extra_info.global_attribute15%TYPE DEFAULT NULL,
        p_global_attribute16         IN  xxpa_events_extra_info.global_attribute16%TYPE DEFAULT NULL,
        p_global_attribute19         IN  xxpa_events_extra_info.global_attribute19%TYPE DEFAULT NULL,
        p_task_name                  IN  xxpa_events_extra_info.task_name%TYPE DEFAULT NULL,
        p_global_attribute20         IN  xxpa_events_extra_info.global_attribute20%TYPE DEFAULT NULL,
        p_project_name               IN  xxpa_events_extra_info.project_name%TYPE DEFAULT NULL,
        p_global_attribute10         IN  xxpa_events_extra_info.global_attribute10%TYPE DEFAULT NULL,
        p_attribute13                IN  xxpa_events_extra_info.attribute13%TYPE DEFAULT NULL,
        p_attribute14                IN  xxpa_events_extra_info.attribute14%TYPE DEFAULT NULL,
        p_attribute11                IN  xxpa_events_extra_info.attribute11%TYPE DEFAULT NULL,
        p_attribute12                IN  xxpa_events_extra_info.attribute12%TYPE DEFAULT NULL,
        p_attribute10                IN  xxpa_events_extra_info.attribute10%TYPE DEFAULT NULL,
        p_last_update_login          IN  xxpa_events_extra_info.last_update_login%TYPE DEFAULT NULL,
        p_created_by                 IN  xxpa_events_extra_info.created_by%TYPE DEFAULT NULL,
        p_attribute3                 IN  xxpa_events_extra_info.attribute3%TYPE DEFAULT NULL,
        p_global_attribute6          IN  xxpa_events_extra_info.global_attribute6%TYPE DEFAULT NULL,
        p_event_type                 IN  xxpa_events_extra_info.event_type%TYPE DEFAULT NULL,
        p_attribute2                 IN  xxpa_events_extra_info.attribute2%TYPE DEFAULT NULL,
        p_global_attribute7          IN  xxpa_events_extra_info.global_attribute7%TYPE DEFAULT NULL,
        p_attribute1                 IN  xxpa_events_extra_info.attribute1%TYPE DEFAULT NULL,
        p_global_attribute4          IN  xxpa_events_extra_info.global_attribute4%TYPE DEFAULT NULL,
        p_global_attribute5          IN  xxpa_events_extra_info.global_attribute5%TYPE DEFAULT NULL,
        p_task_number                IN  xxpa_events_extra_info.task_number%TYPE DEFAULT NULL,
        p_global_attribute2          IN  xxpa_events_extra_info.global_attribute2%TYPE DEFAULT NULL,
        p_global_attribute3          IN  xxpa_events_extra_info.global_attribute3%TYPE DEFAULT NULL,
        p_global_attribute1          IN  xxpa_events_extra_info.global_attribute1%TYPE DEFAULT NULL,
        p_attribute9                 IN  xxpa_events_extra_info.attribute9%TYPE DEFAULT NULL,
        p_attribute8                 IN  xxpa_events_extra_info.attribute8%TYPE DEFAULT NULL,
        p_attribute7                 IN  xxpa_events_extra_info.attribute7%TYPE DEFAULT NULL,
        p_creation_date              IN  xxpa_events_extra_info.creation_date%TYPE DEFAULT NULL,
        p_last_update_date           IN  xxpa_events_extra_info.last_update_date%TYPE DEFAULT NULL,
        p_attribute6                 IN  xxpa_events_extra_info.attribute6%TYPE DEFAULT NULL,
        p_attribute5                 IN  xxpa_events_extra_info.attribute5%TYPE DEFAULT NULL,
        p_global_attribute8          IN  xxpa_events_extra_info.global_attribute8%TYPE DEFAULT NULL,
        p_attribute20                IN  xxpa_events_extra_info.attribute20%TYPE DEFAULT NULL,
        p_attribute4                 IN  xxpa_events_extra_info.attribute4%TYPE DEFAULT NULL,
        p_org_id                     IN  xxpa_events_extra_info.org_id%TYPE DEFAULT NULL,
        p_global_attribute9          IN  xxpa_events_extra_info.global_attribute9%TYPE DEFAULT NULL,
        p_attribute19                IN  xxpa_events_extra_info.attribute19%TYPE DEFAULT NULL,
        p_attribute16                IN  xxpa_events_extra_info.attribute16%TYPE DEFAULT NULL,
        p_attribute15                IN  xxpa_events_extra_info.attribute15%TYPE DEFAULT NULL,
        p_attribute18                IN  xxpa_events_extra_info.attribute18%TYPE DEFAULT NULL,
        p_event_id                   IN  xxpa_events_extra_info.event_id%TYPE,
        p_attribute17                IN  xxpa_events_extra_info.attribute17%TYPE DEFAULT NULL,
        p_event_num                  IN  xxpa_events_extra_info.event_num%TYPE DEFAULT NULL,
        p_global_attribute_category  IN  xxpa_events_extra_info.global_attribute_category%TYPE DEFAULT NULL
    ) IS
    BEGIN
        INSERT INTO xxpa_events_extra_info (
            operating_unit_name,
            task_id,
            last_updated_by,
            project_id,
            context,
            global_attribute13,
            global_attribute14,
            global_attribute11,
            global_attribute12,
            global_attribute17,
            global_attribute18,
            global_attribute15,
            global_attribute16,
            global_attribute19,
            task_name,
            global_attribute20,
            project_name,
            global_attribute10,
            attribute13,
            attribute14,
            attribute11,
            attribute12,
            attribute10,
            last_update_login,
            created_by,
            attribute3,
            global_attribute6,
            event_type,
            attribute2,
            global_attribute7,
            attribute1,
            global_attribute4,
            global_attribute5,
            task_number,
            global_attribute2,
            global_attribute3,
            global_attribute1,
            attribute9,
            attribute8,
            attribute7,
            creation_date,
            last_update_date,
            attribute6,
            attribute5,
            global_attribute8,
            attribute20,
            attribute4,
            org_id,
            global_attribute9,
            attribute19,
            attribute16,
            attribute15,
            attribute18,
            event_id,
            attribute17,
            event_num,
            global_attribute_category
        ) VALUES (
            p_operating_unit_name,
            p_task_id,
            p_last_updated_by,
            p_project_id,
            p_context,
            p_global_attribute13,
            p_global_attribute14,
            p_global_attribute11,
            p_global_attribute12,
            p_global_attribute17,
            p_global_attribute18,
            p_global_attribute15,
            p_global_attribute16,
            p_global_attribute19,
            p_task_name,
            p_global_attribute20,
            p_project_name,
            p_global_attribute10,
            p_attribute13,
            p_attribute14,
            p_attribute11,
            p_attribute12,
            p_attribute10,
            p_last_update_login,
            p_created_by,
            p_attribute3,
            p_global_attribute6,
            p_event_type,
            p_attribute2,
            p_global_attribute7,
            p_attribute1,
            p_global_attribute4,
            p_global_attribute5,
            p_task_number,
            p_global_attribute2,
            p_global_attribute3,
            p_global_attribute1,
            p_attribute9,
            p_attribute8,
            p_attribute7,
            p_creation_date,
            p_last_update_date,
            p_attribute6,
            p_attribute5,
            p_global_attribute8,
            p_attribute20,
            p_attribute4,
            p_org_id,
            p_global_attribute9,
            p_attribute19,
            p_attribute16,
            p_attribute15,
            p_attribute18,
            p_event_id,
            p_attribute17,
            p_event_num,
            p_global_attribute_category
        );

    END;
-- update
    PROCEDURE upd (
        p_operating_unit_name        IN  xxpa_events_extra_info.operating_unit_name%TYPE DEFAULT NULL,
        p_task_id                    IN  xxpa_events_extra_info.task_id%TYPE DEFAULT NULL,
        p_last_updated_by            IN  xxpa_events_extra_info.last_updated_by%TYPE DEFAULT NULL,
        p_project_id                 IN  xxpa_events_extra_info.project_id%TYPE DEFAULT NULL,
        p_context                    IN  xxpa_events_extra_info.context%TYPE DEFAULT NULL,
        p_global_attribute13         IN  xxpa_events_extra_info.global_attribute13%TYPE DEFAULT NULL,
        p_global_attribute14         IN  xxpa_events_extra_info.global_attribute14%TYPE DEFAULT NULL,
        p_global_attribute11         IN  xxpa_events_extra_info.global_attribute11%TYPE DEFAULT NULL,
        p_global_attribute12         IN  xxpa_events_extra_info.global_attribute12%TYPE DEFAULT NULL,
        p_global_attribute17         IN  xxpa_events_extra_info.global_attribute17%TYPE DEFAULT NULL,
        p_global_attribute18         IN  xxpa_events_extra_info.global_attribute18%TYPE DEFAULT NULL,
        p_global_attribute15         IN  xxpa_events_extra_info.global_attribute15%TYPE DEFAULT NULL,
        p_global_attribute16         IN  xxpa_events_extra_info.global_attribute16%TYPE DEFAULT NULL,
        p_global_attribute19         IN  xxpa_events_extra_info.global_attribute19%TYPE DEFAULT NULL,
        p_task_name                  IN  xxpa_events_extra_info.task_name%TYPE DEFAULT NULL,
        p_global_attribute20         IN  xxpa_events_extra_info.global_attribute20%TYPE DEFAULT NULL,
        p_project_name               IN  xxpa_events_extra_info.project_name%TYPE DEFAULT NULL,
        p_global_attribute10         IN  xxpa_events_extra_info.global_attribute10%TYPE DEFAULT NULL,
        p_attribute13                IN  xxpa_events_extra_info.attribute13%TYPE DEFAULT NULL,
        p_attribute14                IN  xxpa_events_extra_info.attribute14%TYPE DEFAULT NULL,
        p_attribute11                IN  xxpa_events_extra_info.attribute11%TYPE DEFAULT NULL,
        p_attribute12                IN  xxpa_events_extra_info.attribute12%TYPE DEFAULT NULL,
        p_attribute10                IN  xxpa_events_extra_info.attribute10%TYPE DEFAULT NULL,
        p_last_update_login          IN  xxpa_events_extra_info.last_update_login%TYPE DEFAULT NULL,
        p_created_by                 IN  xxpa_events_extra_info.created_by%TYPE DEFAULT NULL,
        p_attribute3                 IN  xxpa_events_extra_info.attribute3%TYPE DEFAULT NULL,
        p_global_attribute6          IN  xxpa_events_extra_info.global_attribute6%TYPE DEFAULT NULL,
        p_event_type                 IN  xxpa_events_extra_info.event_type%TYPE DEFAULT NULL,
        p_attribute2                 IN  xxpa_events_extra_info.attribute2%TYPE DEFAULT NULL,
        p_global_attribute7          IN  xxpa_events_extra_info.global_attribute7%TYPE DEFAULT NULL,
        p_attribute1                 IN  xxpa_events_extra_info.attribute1%TYPE DEFAULT NULL,
        p_global_attribute4          IN  xxpa_events_extra_info.global_attribute4%TYPE DEFAULT NULL,
        p_global_attribute5          IN  xxpa_events_extra_info.global_attribute5%TYPE DEFAULT NULL,
        p_task_number                IN  xxpa_events_extra_info.task_number%TYPE DEFAULT NULL,
        p_global_attribute2          IN  xxpa_events_extra_info.global_attribute2%TYPE DEFAULT NULL,
        p_global_attribute3          IN  xxpa_events_extra_info.global_attribute3%TYPE DEFAULT NULL,
        p_global_attribute1          IN  xxpa_events_extra_info.global_attribute1%TYPE DEFAULT NULL,
        p_attribute9                 IN  xxpa_events_extra_info.attribute9%TYPE DEFAULT NULL,
        p_attribute8                 IN  xxpa_events_extra_info.attribute8%TYPE DEFAULT NULL,
        p_attribute7                 IN  xxpa_events_extra_info.attribute7%TYPE DEFAULT NULL,
        p_creation_date              IN  xxpa_events_extra_info.creation_date%TYPE DEFAULT NULL,
        p_last_update_date           IN  xxpa_events_extra_info.last_update_date%TYPE DEFAULT NULL,
        p_attribute6                 IN  xxpa_events_extra_info.attribute6%TYPE DEFAULT NULL,
        p_attribute5                 IN  xxpa_events_extra_info.attribute5%TYPE DEFAULT NULL,
        p_global_attribute8          IN  xxpa_events_extra_info.global_attribute8%TYPE DEFAULT NULL,
        p_attribute20                IN  xxpa_events_extra_info.attribute20%TYPE DEFAULT NULL,
        p_attribute4                 IN  xxpa_events_extra_info.attribute4%TYPE DEFAULT NULL,
        p_org_id                     IN  xxpa_events_extra_info.org_id%TYPE DEFAULT NULL,
        p_global_attribute9          IN  xxpa_events_extra_info.global_attribute9%TYPE DEFAULT NULL,
        p_attribute19                IN  xxpa_events_extra_info.attribute19%TYPE DEFAULT NULL,
        p_attribute16                IN  xxpa_events_extra_info.attribute16%TYPE DEFAULT NULL,
        p_attribute15                IN  xxpa_events_extra_info.attribute15%TYPE DEFAULT NULL,
        p_attribute18                IN  xxpa_events_extra_info.attribute18%TYPE DEFAULT NULL,
        p_event_id                   IN  xxpa_events_extra_info.event_id%TYPE,
        p_attribute17                IN  xxpa_events_extra_info.attribute17%TYPE DEFAULT NULL,
        p_event_num                  IN  xxpa_events_extra_info.event_num%TYPE DEFAULT NULL,
        p_global_attribute_category  IN  xxpa_events_extra_info.global_attribute_category%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE xxpa_events_extra_info
        SET
            operating_unit_name = p_operating_unit_name,
            task_id = p_task_id,
            last_updated_by = p_last_updated_by,
            project_id = p_project_id,
            context = p_context,
            global_attribute13 = p_global_attribute13,
            global_attribute14 = p_global_attribute14,
            global_attribute11 = p_global_attribute11,
            global_attribute12 = p_global_attribute12,
            global_attribute17 = p_global_attribute17,
            global_attribute18 = p_global_attribute18,
            global_attribute15 = p_global_attribute15,
            global_attribute16 = p_global_attribute16,
            global_attribute19 = p_global_attribute19,
            task_name = p_task_name,
            global_attribute20 = p_global_attribute20,
            project_name = p_project_name,
            global_attribute10 = p_global_attribute10,
            attribute13 = p_attribute13,
            attribute14 = p_attribute14,
            attribute11 = p_attribute11,
            attribute12 = p_attribute12,
            attribute10 = p_attribute10,
            last_update_login = p_last_update_login,
            created_by = p_created_by,
            attribute3 = p_attribute3,
            global_attribute6 = p_global_attribute6,
            event_type = p_event_type,
            attribute2 = p_attribute2,
            global_attribute7 = p_global_attribute7,
            attribute1 = p_attribute1,
            global_attribute4 = p_global_attribute4,
            global_attribute5 = p_global_attribute5,
            task_number = p_task_number,
            global_attribute2 = p_global_attribute2,
            global_attribute3 = p_global_attribute3,
            global_attribute1 = p_global_attribute1,
            attribute9 = p_attribute9,
            attribute8 = p_attribute8,
            attribute7 = p_attribute7,
            creation_date = p_creation_date,
            last_update_date = p_last_update_date,
            attribute6 = p_attribute6,
            attribute5 = p_attribute5,
            global_attribute8 = p_global_attribute8,
            attribute20 = p_attribute20,
            attribute4 = p_attribute4,
            org_id = p_org_id,
            global_attribute9 = p_global_attribute9,
            attribute19 = p_attribute19,
            attribute16 = p_attribute16,
            attribute15 = p_attribute15,
            attribute18 = p_attribute18,
            attribute17 = p_attribute17,
            event_num = p_event_num,
            global_attribute_category = p_global_attribute_category
        WHERE
            event_id = p_event_id;

    END;
-- del
    PROCEDURE del (
        p_event_id IN xxpa_events_extra_info.event_id%TYPE
    ) IS
    BEGIN
        DELETE FROM xxpa_events_extra_info
        WHERE
            event_id = p_event_id;

    END;

	--
	-- CR 24146 Add extended DFFs.
	    PROCEDURE update_all (
        p_event IN xxpa_events_extra_info%rowtype
    ) IS
    BEGIN
		--
		--
		        UPDATE xxpa_events_extra_info xeei
        SET
            row = p_event
        WHERE
            xeei.event_id = p_event.event_id;
		--
		--
	    EXCEPTION
        WHEN OTHERS THEN
            xx_pk_fnd_file.put_line(xx_pk_fnd_file.log, 'Error in XXPA_EVENTS_EXTRA_INFO_tapi.update_all ' || sqlerrm);
            RAISE;
    END update_all;
	--
	--
	-- CR 24329 Retrieve extended DFFs
	    FUNCTION retrieve_dff_value (
        p_event_id  IN  xxpa_events_extra_info.event_id%TYPE,
        p_dff_name  IN  VARCHAR2
    ) RETURN VARCHAR2 IS
        l_sql     VARCHAR2(4000);
        l_result  xxpa_events_extra_info.attribute20%TYPE;
    BEGIN
        l_sql := 'SELECT '
                 || p_dff_name
                 || ' FROM XXPA_EVENTS_EXTRA_INFO WHERE EVENT_ID = :1';
        EXECUTE IMMEDIATE l_sql
        INTO l_result
            USING p_event_id;
        RETURN l_result;
    END retrieve_dff_value;
	--
	--
	    PROCEDURE selected (
        p_dff_table  IN OUT  tr_dffs_tbl,
        p_event_id   IN      xxpa_events_extra_info.event_id%TYPE
    ) IS
		--
		        CURSOR c1 (
            p_event_id IN xxpa_events_extra_info.event_id%TYPE
        ) IS
        SELECT
            context
        FROM
            xxpa_events_extra_info xpe
        WHERE
            xpe.event_id = p_event_id;
		--
		--
		        l_main_query  SYS_REFCURSOR;
        l_query       VARCHAR2(32000);
		--
		        l_context     xxpa_events_extra_info.context%TYPE;
    BEGIN
		--
		        FOR r1 IN c1(p_event_id) LOOP
            l_context := r1.context;
        END LOOP;
		--
		--
		        l_query := Q'[SELECT  FORM_LEFT_PROMPT,
							XXPA_EVENTS_EXTRA_INFO_tapi.RETRIEVE_DFF_VALUE( ]'
                   || p_event_id
                   || ' , '
                   || q'[ APPLICATION_COLUMN_NAME) THE_COL_VAL -- Write a function that takes this value and returns from dynamic (select APPLICATION_COLUMN_NAME from XXPA_EVENTS_EXTRA_INFO where )
					FROM 	FND_DESCR_FLEX_COL_USAGE_VL B
					WHERE 	DESCRIPTIVE_FLEXFIELD_NAME = 'XXPA_EVENT_EXTRA_INFO'
					AND 	DESCRIPTIVE_FLEX_CONTEXT_CODE = ]'
                   || q'[']'
                   || l_context
                   || q'['
					ORDER BY COLUMN_SEQ_NUM]';
		--
		--
		        OPEN l_main_query FOR l_query;

        FETCH l_main_query BULK COLLECT INTO p_dff_table;
        CLOSE l_main_query;
		--
	    END selected;
	--
	--
	    PROCEDURE updated (
        p_dff_table  IN OUT  tr_dffs_tbl,
        p_event_id   IN      xxpa_events_extra_info.event_id%TYPE
    ) IS
		--
		        CURSOR ccontext (
            p_event_id IN xxpa_events_extra_info.event_id%TYPE
        ) IS
        SELECT
            context
        FROM
            xxpa_events_extra_info xpe
        WHERE
            xpe.event_id = p_event_id;
		--
		--
		        CURSOR cdynamic (
            p_event_id  IN xxpa_events_extra_info.event_id%TYPE,
            p_context   IN xxpa_events_extra_info.context%TYPE,
            p_prompt    IN VARCHAR2
        ) IS
        SELECT
            form_left_prompt,
            xxpa_events_extra_info_tapi.retrieve_dff_value(p_event_id, application_column_name) the_col_val,
            b.application_column_name
        FROM
            fnd_descr_flex_col_usage_vl b
        WHERE
                descriptive_flexfield_name = 'XXPA_EVENT_EXTRA_INFO'
            AND descriptive_flex_context_code = p_context
            AND form_left_prompt = p_prompt;
		--
		        l_context  xxpa_events_extra_info.context%TYPE;
        l_sql      VARCHAR2(2000) := '';
    BEGIN
		--
		        FOR r1 IN ccontext(p_event_id) LOOP
            l_context := r1.context;
        END LOOP;
		--
		--
		        FOR indx IN 1..p_dff_table.count LOOP
            FOR r1 IN cdynamic(p_event_id, l_context, p_dff_table(indx).prompt) LOOP
				--
				                l_sql := l_sql
                         || r1.application_column_name
                         || ' = '
                         || q'[']'
                         || p_dff_table(indx).col_value
                         || ''', ';

                NULL;
            END LOOP;
        END LOOP;

        l_sql := 'UPDATE XXPA_EVENTS_EXTRA_INFO SET '
                 || substr(l_sql, 1, length(l_sql) - 2)
                 || 'WHERE	EVENT_ID = :1';

        EXECUTE IMMEDIATE l_sql
            USING p_event_id;
		--
		--
	    END updated;

    PROCEDURE locked (
        p_dff_table IN OUT tr_dffs_tbl
    ) IS
    BEGIN
        NULL;
    END locked;

END xxpa_events_extra_info_tapi;
/

