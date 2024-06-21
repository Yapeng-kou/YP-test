CREATE OR REPLACE PACKAGE APPS.xxpa_events_extra_info_tapi IS
  /*********************************************************
     ** Title:       Package to Insert, Update and Delete Records in Custom Table XXPA_EVENTS_EXTRA_INFO
     ** File:        XXPA_EVENTS_EXTRA_INFO_Tapi.pks
     ** Description: This script creates a package spec
     ** Parameters:  {None.}
     ** Run as:      APPS
     ** Keyword Tracking:
     **
     **   $Header: xxpa/patch/115/sql/XXPA_EVENTS_EXTRA_INFO_Tapi.pks
     **   $Change History$ (*ALL VERSIONS*)
     **   Revision 1.0 (COMPLETE)
     **   Created:  07-JUL-2015       CCBGYK
     **   Initial revision.
     **
     ** HISTORY
     ** -----------   ------------------           -------------------------------------------------
     ** 07-JUL-2015   Sanket Sinha (CCBGYK)        Initial Version
     ** 15-OCT-2019  John Markham        		   CR 24146 Added update_all extended DFFs.
     ** 04-SEP-2020   Mites K Rathod (CCKRAV)      CR24255  XXPA_INSERT_UPD_PRC added 
  *************************************************************************************/

  TYPE xxpa_eve_ext_info_tapi_rec IS RECORD(
    xxbe_header_id            NUMBER,--xxbe_planned_billing_headers.header_id%TYPE,
    xxbe_line_id              NUMBER,--xxbe_planned_billing_lines.line_id%TYPE,
    pm_event_reference        pa_events.pm_event_reference%type,
    event_id                  xxpa_events_extra_info.event_id%TYPE,
    event_num                 xxpa_events_extra_info.event_num%TYPE,
    event_type                xxpa_events_extra_info.event_type%TYPE,
    operating_unit_name       xxpa_events_extra_info.operating_unit_name%TYPE,
    org_id                    xxpa_events_extra_info.org_id%TYPE,
    project_id                xxpa_events_extra_info.project_id%TYPE,
    project_name              xxpa_events_extra_info.project_name%TYPE,
    task_id                   xxpa_events_extra_info.task_id%TYPE,
    task_name                 xxpa_events_extra_info.task_name%TYPE,
    task_number               xxpa_events_extra_info.task_number%TYPE,
    context                   xxpa_events_extra_info.context%TYPE,
    attribute1                xxpa_events_extra_info.attribute1%TYPE,
    attribute2                xxpa_events_extra_info.attribute2%TYPE,
    attribute3                xxpa_events_extra_info.attribute3%TYPE,
    attribute4                xxpa_events_extra_info.attribute4%TYPE,
    attribute5                xxpa_events_extra_info.attribute5%TYPE,
    attribute6                xxpa_events_extra_info.attribute6%TYPE,
    attribute7                xxpa_events_extra_info.attribute7%TYPE,
    attribute8                xxpa_events_extra_info.attribute8%TYPE,
    attribute9                xxpa_events_extra_info.attribute9%TYPE,
    attribute10               xxpa_events_extra_info.attribute10%TYPE,
    attribute11               xxpa_events_extra_info.attribute11%TYPE,
    attribute12               xxpa_events_extra_info.attribute12%TYPE,
    attribute13               xxpa_events_extra_info.attribute13%TYPE,
    attribute14               xxpa_events_extra_info.attribute14%TYPE,
    attribute15               xxpa_events_extra_info.attribute15%TYPE,
    attribute16               xxpa_events_extra_info.attribute16%TYPE,
    attribute17               xxpa_events_extra_info.attribute17%TYPE,
    attribute18               xxpa_events_extra_info.attribute18%TYPE,
    attribute19               xxpa_events_extra_info.attribute19%TYPE,
    attribute20               xxpa_events_extra_info.attribute20%TYPE,
    global_attribute_category xxpa_events_extra_info.global_attribute_category%TYPE,
    global_attribute1         xxpa_events_extra_info.global_attribute1%TYPE,
    global_attribute2         xxpa_events_extra_info.global_attribute2%TYPE,
    global_attribute3         xxpa_events_extra_info.global_attribute3%TYPE,
    global_attribute4         xxpa_events_extra_info.global_attribute4%TYPE,
    global_attribute5         xxpa_events_extra_info.global_attribute5%TYPE,
    global_attribute6         xxpa_events_extra_info.global_attribute6%TYPE,
    global_attribute7         xxpa_events_extra_info.global_attribute7%TYPE,
    global_attribute8         xxpa_events_extra_info.global_attribute8%TYPE,
    global_attribute9         xxpa_events_extra_info.global_attribute9%TYPE,
    global_attribute10        xxpa_events_extra_info.global_attribute10%TYPE,
    global_attribute11        xxpa_events_extra_info.global_attribute11%TYPE,
    global_attribute12        xxpa_events_extra_info.global_attribute12%TYPE,
    global_attribute13        xxpa_events_extra_info.global_attribute13%TYPE,
    global_attribute14        xxpa_events_extra_info.global_attribute14%TYPE,
    global_attribute15        xxpa_events_extra_info.global_attribute15%TYPE,
    global_attribute16        xxpa_events_extra_info.global_attribute16%TYPE,
    global_attribute17        xxpa_events_extra_info.global_attribute17%TYPE,
    global_attribute18        xxpa_events_extra_info.global_attribute18%TYPE,
    global_attribute19        xxpa_events_extra_info.global_attribute19%TYPE,
    global_attribute20        xxpa_events_extra_info.global_attribute20%TYPE,
    last_update_login         xxpa_events_extra_info.last_update_login%TYPE,
    created_by                xxpa_events_extra_info.created_by%TYPE,
    creation_date             xxpa_events_extra_info.creation_date%TYPE,
    last_updated_by           xxpa_events_extra_info.last_updated_by%TYPE,
    last_update_date          xxpa_events_extra_info.last_update_date%TYPE,
    --Added for CR24146
    attribute21 xxpa_events_extra_info.attribute21%TYPE,
    attribute22 xxpa_events_extra_info.attribute22%TYPE,
    attribute23 xxpa_events_extra_info.attribute23%TYPE,
    attribute24 xxpa_events_extra_info.attribute24%TYPE,
    attribute25 xxpa_events_extra_info.attribute25%TYPE,
    attribute26 xxpa_events_extra_info.attribute26%TYPE,
    attribute27 xxpa_events_extra_info.attribute27%TYPE,
    attribute28 xxpa_events_extra_info.attribute28%TYPE,
    attribute29 xxpa_events_extra_info.attribute29%TYPE,
    attribute30 xxpa_events_extra_info.attribute30%TYPE,
    attribute31 xxpa_events_extra_info.attribute31%TYPE,
    attribute32 xxpa_events_extra_info.attribute32%TYPE,
    attribute33 xxpa_events_extra_info.attribute33%TYPE,
    attribute34 xxpa_events_extra_info.attribute34%TYPE,
    attribute35 xxpa_events_extra_info.attribute35%TYPE,
    attribute36 xxpa_events_extra_info.attribute36%TYPE,
    attribute37 xxpa_events_extra_info.attribute37%TYPE,
    attribute38 xxpa_events_extra_info.attribute38%TYPE,
    attribute39 xxpa_events_extra_info.attribute39%TYPE,
    attribute40 xxpa_events_extra_info.attribute40%TYPE,
    attribute41 xxpa_events_extra_info.attribute41%TYPE,
    attribute42 xxpa_events_extra_info.attribute42%TYPE,
    attribute43 xxpa_events_extra_info.attribute43%TYPE,
    attribute44 xxpa_events_extra_info.attribute44%TYPE,
    attribute45 xxpa_events_extra_info.attribute45%TYPE,
    attribute46 xxpa_events_extra_info.attribute46%TYPE,
    attribute47 xxpa_events_extra_info.attribute47%TYPE,
    attribute48 xxpa_events_extra_info.attribute48%TYPE,
    attribute49 xxpa_events_extra_info.attribute49%TYPE,
    attribute50 xxpa_events_extra_info.attribute50%TYPE,
    attribute51 xxpa_events_extra_info.attribute51%TYPE,
    attribute52 xxpa_events_extra_info.attribute52%TYPE,
    attribute53 xxpa_events_extra_info.attribute53%TYPE,
    attribute54 xxpa_events_extra_info.attribute54%TYPE,
    attribute55 xxpa_events_extra_info.attribute55%TYPE,
    attribute56 xxpa_events_extra_info.attribute56%TYPE,
    attribute57 xxpa_events_extra_info.attribute57%TYPE,
    attribute58 xxpa_events_extra_info.attribute58%TYPE,
    attribute59 xxpa_events_extra_info.attribute59%TYPE,
    attribute60 xxpa_events_extra_info.attribute60%TYPE,
    attribute61 xxpa_events_extra_info.attribute61%TYPE,
    attribute62 xxpa_events_extra_info.attribute62%TYPE,
    attribute63 xxpa_events_extra_info.attribute63%TYPE,
    attribute64 xxpa_events_extra_info.attribute64%TYPE,
    attribute65 xxpa_events_extra_info.attribute65%TYPE,
    attribute66 xxpa_events_extra_info.attribute66%TYPE,
    attribute67 xxpa_events_extra_info.attribute67%TYPE,
    attribute68 xxpa_events_extra_info.attribute68%TYPE,
    attribute69 xxpa_events_extra_info.attribute69%TYPE,
    --End of Added for CR24146
    --    --added these for ship to location creation
    ship_to_address_1 VARCHAR2(250),
    ship_to_address_2 VARCHAR2(250),
    ship_to_address_3 VARCHAR2(250),
    ship_to_address_4 VARCHAR2(250),
    city              VARCHAR2(250),
    state             VARCHAR2(250),
    postal_code       VARCHAR2(250),
    county            VARCHAR2(250),
    country           VARCHAR2(250),
    province          VARCHAR2(250)
    );
  TYPE xxpa_eve_ext_info_tapi_tab IS TABLE OF xxpa_eve_ext_info_tapi_rec;
  
  xxpa_events_extra_tab xxpa_eve_ext_info_tapi_tab;
  -- insert
  PROCEDURE ins(p_operating_unit_name       IN xxpa_events_extra_info.operating_unit_name%TYPE DEFAULT NULL,
                p_task_id                   IN xxpa_events_extra_info.task_id%TYPE DEFAULT NULL,
                p_last_updated_by           IN xxpa_events_extra_info.last_updated_by%TYPE DEFAULT NULL,
                p_project_id                IN xxpa_events_extra_info.project_id%TYPE DEFAULT NULL,
                p_context                   IN xxpa_events_extra_info.context%TYPE DEFAULT NULL,
                p_global_attribute13        IN xxpa_events_extra_info.global_attribute13%TYPE DEFAULT NULL,
                p_global_attribute14        IN xxpa_events_extra_info.global_attribute14%TYPE DEFAULT NULL,
                p_global_attribute11        IN xxpa_events_extra_info.global_attribute11%TYPE DEFAULT NULL,
                p_global_attribute12        IN xxpa_events_extra_info.global_attribute12%TYPE DEFAULT NULL,
                p_global_attribute17        IN xxpa_events_extra_info.global_attribute17%TYPE DEFAULT NULL,
                p_global_attribute18        IN xxpa_events_extra_info.global_attribute18%TYPE DEFAULT NULL,
                p_global_attribute15        IN xxpa_events_extra_info.global_attribute15%TYPE DEFAULT NULL,
                p_global_attribute16        IN xxpa_events_extra_info.global_attribute16%TYPE DEFAULT NULL,
                p_global_attribute19        IN xxpa_events_extra_info.global_attribute19%TYPE DEFAULT NULL,
                p_task_name                 IN xxpa_events_extra_info.task_name%TYPE DEFAULT NULL,
                p_global_attribute20        IN xxpa_events_extra_info.global_attribute20%TYPE DEFAULT NULL,
                p_project_name              IN xxpa_events_extra_info.project_name%TYPE DEFAULT NULL,
                p_global_attribute10        IN xxpa_events_extra_info.global_attribute10%TYPE DEFAULT NULL,
                p_attribute13               IN xxpa_events_extra_info.attribute13%TYPE DEFAULT NULL,
                p_attribute14               IN xxpa_events_extra_info.attribute14%TYPE DEFAULT NULL,
                p_attribute11               IN xxpa_events_extra_info.attribute11%TYPE DEFAULT NULL,
                p_attribute12               IN xxpa_events_extra_info.attribute12%TYPE DEFAULT NULL,
                p_attribute10               IN xxpa_events_extra_info.attribute10%TYPE DEFAULT NULL,
                p_last_update_login         IN xxpa_events_extra_info.last_update_login%TYPE DEFAULT NULL,
                p_created_by                IN xxpa_events_extra_info.created_by%TYPE DEFAULT NULL,
                p_attribute3                IN xxpa_events_extra_info.attribute3%TYPE DEFAULT NULL,
                p_global_attribute6         IN xxpa_events_extra_info.global_attribute6%TYPE DEFAULT NULL,
                p_event_type                IN xxpa_events_extra_info.event_type%TYPE DEFAULT NULL,
                p_attribute2                IN xxpa_events_extra_info.attribute2%TYPE DEFAULT NULL,
                p_global_attribute7         IN xxpa_events_extra_info.global_attribute7%TYPE DEFAULT NULL,
                p_attribute1                IN xxpa_events_extra_info.attribute1%TYPE DEFAULT NULL,
                p_global_attribute4         IN xxpa_events_extra_info.global_attribute4%TYPE DEFAULT NULL,
                p_global_attribute5         IN xxpa_events_extra_info.global_attribute5%TYPE DEFAULT NULL,
                p_task_number               IN xxpa_events_extra_info.task_number%TYPE DEFAULT NULL,
                p_global_attribute2         IN xxpa_events_extra_info.global_attribute2%TYPE DEFAULT NULL,
                p_global_attribute3         IN xxpa_events_extra_info.global_attribute3%TYPE DEFAULT NULL,
                p_global_attribute1         IN xxpa_events_extra_info.global_attribute1%TYPE DEFAULT NULL,
                p_attribute9                IN xxpa_events_extra_info.attribute9%TYPE DEFAULT NULL,
                p_attribute8                IN xxpa_events_extra_info.attribute8%TYPE DEFAULT NULL,
                p_attribute7                IN xxpa_events_extra_info.attribute7%TYPE DEFAULT NULL,
                p_creation_date             IN xxpa_events_extra_info.creation_date%TYPE DEFAULT NULL,
                p_last_update_date          IN xxpa_events_extra_info.last_update_date%TYPE DEFAULT NULL,
                p_attribute6                IN xxpa_events_extra_info.attribute6%TYPE DEFAULT NULL,
                p_attribute5                IN xxpa_events_extra_info.attribute5%TYPE DEFAULT NULL,
                p_global_attribute8         IN xxpa_events_extra_info.global_attribute8%TYPE DEFAULT NULL,
                p_attribute20               IN xxpa_events_extra_info.attribute20%TYPE DEFAULT NULL,
                p_attribute4                IN xxpa_events_extra_info.attribute4%TYPE DEFAULT NULL,
                p_org_id                    IN xxpa_events_extra_info.org_id%TYPE DEFAULT NULL,
                p_global_attribute9         IN xxpa_events_extra_info.global_attribute9%TYPE DEFAULT NULL,
                p_attribute19               IN xxpa_events_extra_info.attribute19%TYPE DEFAULT NULL,
                p_attribute16               IN xxpa_events_extra_info.attribute16%TYPE DEFAULT NULL,
                p_attribute15               IN xxpa_events_extra_info.attribute15%TYPE DEFAULT NULL,
                p_attribute18               IN xxpa_events_extra_info.attribute18%TYPE DEFAULT NULL,
                p_event_id                  IN xxpa_events_extra_info.event_id%TYPE,
                p_attribute17               IN xxpa_events_extra_info.attribute17%TYPE DEFAULT NULL,
                p_event_num                 IN xxpa_events_extra_info.event_num%TYPE DEFAULT NULL,
                p_global_attribute_category IN xxpa_events_extra_info.global_attribute_category%TYPE DEFAULT NULL);
  -- update
  PROCEDURE upd(p_operating_unit_name       IN xxpa_events_extra_info.operating_unit_name%TYPE DEFAULT NULL,
                p_task_id                   IN xxpa_events_extra_info.task_id%TYPE DEFAULT NULL,
                p_last_updated_by           IN xxpa_events_extra_info.last_updated_by%TYPE DEFAULT NULL,
                p_project_id                IN xxpa_events_extra_info.project_id%TYPE DEFAULT NULL,
                p_context                   IN xxpa_events_extra_info.context%TYPE DEFAULT NULL,
                p_global_attribute13        IN xxpa_events_extra_info.global_attribute13%TYPE DEFAULT NULL,
                p_global_attribute14        IN xxpa_events_extra_info.global_attribute14%TYPE DEFAULT NULL,
                p_global_attribute11        IN xxpa_events_extra_info.global_attribute11%TYPE DEFAULT NULL,
                p_global_attribute12        IN xxpa_events_extra_info.global_attribute12%TYPE DEFAULT NULL,
                p_global_attribute17        IN xxpa_events_extra_info.global_attribute17%TYPE DEFAULT NULL,
                p_global_attribute18        IN xxpa_events_extra_info.global_attribute18%TYPE DEFAULT NULL,
                p_global_attribute15        IN xxpa_events_extra_info.global_attribute15%TYPE DEFAULT NULL,
                p_global_attribute16        IN xxpa_events_extra_info.global_attribute16%TYPE DEFAULT NULL,
                p_global_attribute19        IN xxpa_events_extra_info.global_attribute19%TYPE DEFAULT NULL,
                p_task_name                 IN xxpa_events_extra_info.task_name%TYPE DEFAULT NULL,
                p_global_attribute20        IN xxpa_events_extra_info.global_attribute20%TYPE DEFAULT NULL,
                p_project_name              IN xxpa_events_extra_info.project_name%TYPE DEFAULT NULL,
                p_global_attribute10        IN xxpa_events_extra_info.global_attribute10%TYPE DEFAULT NULL,
                p_attribute13               IN xxpa_events_extra_info.attribute13%TYPE DEFAULT NULL,
                p_attribute14               IN xxpa_events_extra_info.attribute14%TYPE DEFAULT NULL,
                p_attribute11               IN xxpa_events_extra_info.attribute11%TYPE DEFAULT NULL,
                p_attribute12               IN xxpa_events_extra_info.attribute12%TYPE DEFAULT NULL,
                p_attribute10               IN xxpa_events_extra_info.attribute10%TYPE DEFAULT NULL,
                p_last_update_login         IN xxpa_events_extra_info.last_update_login%TYPE DEFAULT NULL,
                p_created_by                IN xxpa_events_extra_info.created_by%TYPE DEFAULT NULL,
                p_attribute3                IN xxpa_events_extra_info.attribute3%TYPE DEFAULT NULL,
                p_global_attribute6         IN xxpa_events_extra_info.global_attribute6%TYPE DEFAULT NULL,
                p_event_type                IN xxpa_events_extra_info.event_type%TYPE DEFAULT NULL,
                p_attribute2                IN xxpa_events_extra_info.attribute2%TYPE DEFAULT NULL,
                p_global_attribute7         IN xxpa_events_extra_info.global_attribute7%TYPE DEFAULT NULL,
                p_attribute1                IN xxpa_events_extra_info.attribute1%TYPE DEFAULT NULL,
                p_global_attribute4         IN xxpa_events_extra_info.global_attribute4%TYPE DEFAULT NULL,
                p_global_attribute5         IN xxpa_events_extra_info.global_attribute5%TYPE DEFAULT NULL,
                p_task_number               IN xxpa_events_extra_info.task_number%TYPE DEFAULT NULL,
                p_global_attribute2         IN xxpa_events_extra_info.global_attribute2%TYPE DEFAULT NULL,
                p_global_attribute3         IN xxpa_events_extra_info.global_attribute3%TYPE DEFAULT NULL,
                p_global_attribute1         IN xxpa_events_extra_info.global_attribute1%TYPE DEFAULT NULL,
                p_attribute9                IN xxpa_events_extra_info.attribute9%TYPE DEFAULT NULL,
                p_attribute8                IN xxpa_events_extra_info.attribute8%TYPE DEFAULT NULL,
                p_attribute7                IN xxpa_events_extra_info.attribute7%TYPE DEFAULT NULL,
                p_creation_date             IN xxpa_events_extra_info.creation_date%TYPE DEFAULT NULL,
                p_last_update_date          IN xxpa_events_extra_info.last_update_date%TYPE DEFAULT NULL,
                p_attribute6                IN xxpa_events_extra_info.attribute6%TYPE DEFAULT NULL,
                p_attribute5                IN xxpa_events_extra_info.attribute5%TYPE DEFAULT NULL,
                p_global_attribute8         IN xxpa_events_extra_info.global_attribute8%TYPE DEFAULT NULL,
                p_attribute20               IN xxpa_events_extra_info.attribute20%TYPE DEFAULT NULL,
                p_attribute4                IN xxpa_events_extra_info.attribute4%TYPE DEFAULT NULL,
                p_org_id                    IN xxpa_events_extra_info.org_id%TYPE DEFAULT NULL,
                p_global_attribute9         IN xxpa_events_extra_info.global_attribute9%TYPE DEFAULT NULL,
                p_attribute19               IN xxpa_events_extra_info.attribute19%TYPE DEFAULT NULL,
                p_attribute16               IN xxpa_events_extra_info.attribute16%TYPE DEFAULT NULL,
                p_attribute15               IN xxpa_events_extra_info.attribute15%TYPE DEFAULT NULL,
                p_attribute18               IN xxpa_events_extra_info.attribute18%TYPE DEFAULT NULL,
                p_event_id                  IN xxpa_events_extra_info.event_id%TYPE,
                p_attribute17               IN xxpa_events_extra_info.attribute17%TYPE DEFAULT NULL,
                p_event_num                 IN xxpa_events_extra_info.event_num%TYPE DEFAULT NULL,
                p_global_attribute_category IN xxpa_events_extra_info.global_attribute_category%TYPE DEFAULT NULL);
  -- delete
  PROCEDURE del(p_event_id IN xxpa_events_extra_info.event_id%TYPE);
  --
  -- CR 24146 Add extended DFFs.
  PROCEDURE update_all(p_event IN xxpa_events_extra_info%rowtype);
  --
  -- CR 24329 Retrieve extended DFFs

  TYPE tr_dffs IS RECORD(
    prompt    VARCHAR2(200),
    col_value VARCHAR2(500));
  TYPE tr_dffs_tbl IS TABLE OF tr_dffs INDEX BY BINARY_INTEGER;
  PROCEDURE selected(p_dff_table IN OUT tr_dffs_tbl,
                     p_event_id  IN xxpa_events_extra_info.event_id%TYPE);

  FUNCTION retrieve_dff_value(p_event_id IN xxpa_events_extra_info.event_id%TYPE,
                              p_dff_name IN VARCHAR2) RETURN VARCHAR2;
  --
  --
  PROCEDURE updated(p_dff_table IN OUT tr_dffs_tbl,
                    p_event_id  IN xxpa_events_extra_info.event_id%TYPE);
  --
  --
  PROCEDURE locked(p_dff_table IN OUT tr_dffs_tbl);
  --added for CR24255
  PROCEDURE xxpa_insert_upd_prc(p_extra_rec  IN OUT xxpa_eve_ext_info_tapi_rec,
                                x_error_code OUT VARCHAR2,
                                x_error_msg  OUT VARCHAR2);

END xxpa_events_extra_info_tapi;
/

