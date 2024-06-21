create or replace PACKAGE BODY XXCTQ_PROJ_ATTAC_RECON_PKG
IS
   /************************************************************************
   ** Title:   XXCTQ_PROJ_ATTAC_RECON_PKG
   ** File:        XXCTQ_PROJ_ATTAC_RECON_PKG.pkb
   ** Description: This script creates a package body
   ** Parameters:
   ** Run as:      APPS
   ** Keyword Tracking:
   **
   **
   ** History:
   ** Date          Who                Description
   ** -----------   ------------------ ----------------------------------
   ** 04-Nov-23     Sowmya shetty      Initial Creation
   **
   ************************************************************************/
   PROCEDURE log_message (p_message VARCHAR2)
   IS
   BEGIN
      xx_pk_fnd_file.put_line (fnd_file.LOG, p_message);
   END log_message;

   PROCEDURE main (p_operating_unit       IN     NUMBER,
                   p_creation_date_low    IN     VARCHAR2,
                   p_creation_date_high   IN     VARCHAR2,
                   p_update_date_low      IN     VARCHAR2,
                   p_update_date_high     IN     VARCHAR2,
                   p_created_by           IN     NUMBER,
                   p_last_updated_by      IN     NUMBER,
                   x_ref_cursor              OUT SYS_REFCURSOR)
   IS
      ln_batch_id     NUMBER;
      ln_days         NUMBER;
      ln_user_id      NUMBER;
      ln_request_id   NUMBER;
   BEGIN
      log_message ('xxctq_safstk_c_safet_recon_pkg.main');
      ln_user_id := fnd_profile.VALUE ('USER_ID');
      ln_request_id := (-1) * (fnd_global.conc_request_id);


      OPEN X_REF_CURSOR FOR
         'select * from XXPA_PROJECT_ATTACHMENTS_STG where batch_id = :1'
         USING ln_request_id;

      log_message ('Created REF CURSOR ');
   END main;
END XXCTQ_PROJ_ATTAC_RECON_PKG;