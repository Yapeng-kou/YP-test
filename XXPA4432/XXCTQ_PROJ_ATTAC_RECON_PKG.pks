create or replace PACKAGE XXCTQ_PROJ_ATTAC_RECON_PKG AUTHID DEFINER
IS
   /************************************************************************
   ** Title:   xxctq_task_comm_splt_recon_pkg
   ** File:        XXCTQ_PROJ_ATTAC_RECON_PKG.pks
   ** Description: This script creates a package specification
   ** Parameters:
   ** Run as:      APPS
   ** Keyword Tracking:
   **
   **
   ** History:
   ** Date          Who                Description
   ** -----------   ------------------ ----------------------------------
   ** 04-Nov-23     Sowmya shetty          Initial Creation
   **
   ************************************************************************/


   PROCEDURE main (p_operating_unit       IN     NUMBER,
                   p_creation_date_low    IN     VARCHAR2,
                   p_creation_date_high   IN     VARCHAR2,
                   p_update_date_low      IN     VARCHAR2,
                   p_update_date_high     IN     VARCHAR2,
                   p_created_by           IN     NUMBER,
                   p_last_updated_by      IN     NUMBER,
                   x_ref_cursor              OUT SYS_REFCURSOR);
END XXCTQ_PROJ_ATTAC_RECON_PKG;