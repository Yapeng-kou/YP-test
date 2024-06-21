/******************************************************************************
  *                           - COPYRIGHT NOTICE -                              *
  *******************************************************************************
  ** Title          : XXAU_R122_PRE_COMPLIANCE_REPORT.sql
  ** File           : XXAU_R122_PRE_COMPLIANCE_REPORT.sql.sql
  ** Description    : This script validate r122 coding compilance for preupgrade development
  ** Parameters     : v_input_object
  ** Run as         : APPS
  ** Keyword Tracking :
  **   
  **   $Header: xxau/12.0.0/sql/XXAU_R122_PRE_COMPLNCE_RPRT.sql 1.4 05-APR-2023 11:38:37 U112816 $
  **   $Change History$ (*ALL VERSIONS*)
  **   Revision 1.4 (COMPLETE)
  **     Created:  05-APR-2023 11:38:37      U112816 (Dhrubojyoti Ray)
  **       latest severoutput size increased
  **   
  **   Revision 1.3 (COMPLETE)
  **     Created:  05-APR-2023 10:58:40      U112816 (Dhrubojyoti Ray)
  **       Latest
  **   
  **   Revision 1.2 (COMPLETE)
  **     Created:  05-APR-2023 09:54:32      U112816 (Dhrubojyoti Ray)
  **       PLSQL block
  **   
  **   Revision 1.1 (COMPLETE)
  **     Created:  22-MAR-2023 13:05:46      U112816 (Dhrubojyoti Ray)
  **       Latest as per PPM behave
  **   
  **   Revision 1.0 (COMPLETE)
  **     Created:  22-MAR-2023 12:31:53      U112816 (Dhrubojyoti Ray)
  **       Initial revision.
  **   
  **
  **
  ** History:
  ** Date          Who                Description
  ** -----------   ------------------ ----------------------------------------------------
  ** 05-Apr-2023   Dhrubo               Initial Version
  ****************************************************************************************/
Whenever sqlerror exit failure
set serveroutput on size 1000000;

declare	
v_input_object VARCHAR2(4000);
SEC_INPUT_CNT	number;
SEC_INVLD_CNT   number;
SEC_15_CNT   number;
SEC_18_CNT   number;
SEC_10_CNT   number;
SEC_17_CNT	number;
SEC_21_CNT	number;	
SEC_22_CNT	number;	
SEC_33_CNT	number;	
SEC_38_CNT	number;	
SEC_43_CNT	number;	
SEC_40_CNT	number;
SEC_19_CNT	number;	
SEC_24_CNT	number;	
SEC_25_CNT	number;
SEC_26_CNT	number;	
SEC_37_CNT	number;	
    
BEGIN

--v_input_object	:= p_input_object_list;
--v_input_object := 'XXVTX_OIC_ACR_RES_GT1,JL_BR_PO_FISC_CLASSIF,XXWSH_WSHDA_BKP_INC0425073190,XXONT_OEOLA_BKP_INC0425073190,AR_CASH_RECPT_HIST_RT7241615_,AQ$_FND_MBL_NOTIFICATION_OUT_,XXWSH_WSHDD_BKP_INC0425073180,XXWSH_WSHDA_BKP_INC0425073190,XXINV,XXAR_DATAFIX_RT7028972_BKP,XXPO_PER_ADDRESSES,XXAU_PROMOSHEET_DCONV_PKG,XXGL_XLA_TXN_ARC_TBL';

v_input_object := '&1';
    

-- "Section for LIST OF INPUT OBJECTS provided as INPUT Parameter"
    
    SEC_INPUT_CNT := 0;
 begin
 
 for rec in (select * from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1)
 loop
    IF ( SEC_INPUT_CNT = 0 ) THEN 
    
	dbms_output.put_line('-------------------------------LIST OF INPUT OBJECTS provided as INPUT Parameter-------------------------------------');
	
    dbms_output.put_line('-------------------------------------------------------------------------------------------------');
	
    END IF;
    dbms_output.put_line('                        '||rec.INPUT_OBJECT||'                                                   ');
	
    SEC_INPUT_CNT := SEC_INPUT_CNT + 1;
 
 end loop;
    IF ( SEC_INPUT_CNT <> 0) THEN
    dbms_output.put_line('---------------------------------------------------------------------------------------------------');
	
    END IF;
 
 exception
 when others then
    dbms_output.put_line(' Error111 '|| SQLERRM);
	
 end;
    
	
	-- "Section for LIST OF INPUT OBJECTS NOT EXIST in DATABASE"
    
    SEC_INVLD_CNT := 0;
 begin
 
 for rec in (select * from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and not exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT)

																)
 loop
    IF ( SEC_INVLD_CNT = 0 ) THEN 
    
	dbms_output.put_line('-------------------------------LIST OF INPUT OBJECTS NOT EXIST in DATABASE-------------------------------------');
	
    dbms_output.put_line('-------------------------------------------------------------------------------------------------');
	
    END IF;
    dbms_output.put_line('                        '||rec.INPUT_OBJECT||'                                                   ');
	
    SEC_INVLD_CNT := SEC_INVLD_CNT + 1;
 
 end loop;
    IF ( SEC_INVLD_CNT <> 0) THEN
    dbms_output.put_line('---------------------------------------------------------------------------------------------------');
	
    END IF;
 
 exception
 when others then
    dbms_output.put_line(' Error11 '|| SQLERRM);
	
 end;
 
 
 -- SECTION - 10 APPS object (PACKAGE, VIEW, SYNONYM, TYPE) names must end with alphanumeric character.
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-10  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "APPS object names must end with alphanumeric character."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: May cause object name conflicts during online patching.');
dbms_output.put_line('DOC>         Use of special characters as the last character of an');
dbms_output.put_line('DOC>         object name is reserved for the Online Patching tool.');
dbms_output.put_line('DOC>   - Fix: Change the object name to use an ordinary identifier character');
dbms_output.put_line('DOC>         as the last character: A-Z a-z 0-9 _ # $');
dbms_output.put_line('DOC>   - Unused objects can be ignored or dropped.');
dbms_output.put_line('DOC>#');



 begin
 SEC_10_CNT := 0;
 for rec3 in (
    select obj.owner, obj.object_name, obj.object_type
from   dba_objects obj
where obj.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('U') )
  and obj.object_type in
        ( 'PACKAGE', 'VIEW', 'SYNONYM', 'TYPE')
  and not regexp_like(obj.object_name, '[A-Za-z0-9_#$]$', 'c')
  and object_name not like 'SYSTP%==' /* ignore junk types from collect */
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = obj.owner
            and aoo.object_name = obj.object_name
            and aoo.object_type in ('PACKAGE', 'VIEW', 'SYNONYM', 'TYPE') )
  --and obj.object_name = :1          
  and obj.object_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))   )                                                          

loop
    IF ( SEC_10_CNT = 0 ) THEN 
    
    dbms_output.put_line('                                                                                                                               ');
	
    dbms_output.put_line('     '||'OWNER'||'           '||'OBJECT NAME'||'                   '||'OBJECT TYPE');
	
    dbms_output.put_line('------------------------------------------------------');
	
       
    END IF;
    dbms_output.put_line('     '||rec3.OWNER||'             '||rec3.OBJECT_NAME||'                '||rec3.OBJECT_TYPE);    
	
    SEC_10_CNT := SEC_10_CNT + 1;
 
 end loop;
    IF ( SEC_10_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
	ELSE
	dbms_output.put_line('                                                              ');
	dbms_output.put_line('no rows selected');

	END IF;
    

exception
    when others then
    dbms_output.put_line(' Error SECTION - 10 '|| SQLERRM);
end;

-- SECTION - 17 Table name must not end with '#' character.
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-17  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Table name must not end with ''#'' character."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>  - P2: The ''#'' character in table and view names is reserved for use by');
dbms_output.put_line('DOC>        the Online Patching tools.  Online patching may not operate');
dbms_output.put_line('DOC>        correctly on tables that violate this standard.');
dbms_output.put_line('DOC>  - Fix: Rename the table and correct any code references to the new');
dbms_output.put_line('DOC>         table name.');
dbms_output.put_line('DOC>#');


 begin
 SEC_17_CNT := 0;
 for rec_sec_17 in (
    select tab.owner, tab.table_name
from dba_tables tab
where tab.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and tab.temporary = 'N'
  and tab.secondary = 'N'
  and tab.tablespace_name <> 'APPS_TS_NOLOGGING'
  and not regexp_like(tab.table_name, '[A-Za-z0-9_$]$', 'c')
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = tab.owner
            and aoo.object_name = tab.table_name
            and aoo.object_type = 'TABLE' )
 and  tab.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              			
order by 1, 2) 

loop
    IF ( SEC_17_CNT = 0 ) THEN 
    
    dbms_output.put_line('                                                                                                                               ');
	
    dbms_output.put_line('     '||'OWNER'||'           TABLE');
	
    dbms_output.put_line('------------------------------------------------------');
	
       
    END IF;
    dbms_output.put_line('     '||rec_sec_17.OWNER||'             '||rec_sec_17.TABLE_NAME);    
	
    SEC_17_CNT := SEC_17_CNT + 1;
 
 end loop;
    IF ( SEC_17_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
	ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');
    END IF;

exception
    when others then
    dbms_output.put_line(' Error SECTION - 17 '|| SQLERRM);
	--fnd_file.put_line(--fnd_file.log,' Error SECTION - 17 '|| SQLERRM);
end;

-- SECTION - 18 Table name must be unique within the first 29 bytes.

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-18  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Table name must be unique within the first 29 bytes."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P3: Duplicate table names may cause confusion as to which is the');
dbms_output.put_line('DOC>         "real" table.  Tables that only differ in the 30th character');
dbms_output.put_line('DOC>         may have a conflict in their editioning view names.');
dbms_output.put_line('DOC>   - Fix:  Rename table or drop unwanted table.');
dbms_output.put_line('DOC>#');


 begin
 SEC_18_CNT := 0;
 for rec2 in (
    select
    substrb(tab.table_name, 1, 29) table_name_to_29_chars
  , count(tab.table_name) matches
from dba_tables tab
where tab.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and tab.temporary = 'N'
  and tab.secondary = 'N'  
  and tab.iot_type is null
  and tab.tablespace_name not in ('APPS_TS_NOLOGGING', 'APPS_TS_QUEUES')
  and length(tab.table_name) > 29
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = tab.owner
            and aoo.object_name = tab.table_name
            and aoo.object_type = 'TABLE' )
--  and tab.table_name = :1 
-- and substrb(tab.table_name, 1, 29) in ( select regexp_substr(v_input_object,'[^,]+', 1, level) from dual
--                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null)                            
 and substrb(tab.table_name, 1, 29) in (select substrb(INPUT_OBJECT, 1, 29) from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              		
group by substrb(tab.table_name, 1, 29)
having count(tab.table_name) > 1) 

loop
    IF ( SEC_18_CNT = 0 ) THEN 
    
    dbms_output.put_line('                                                                                                                               ');
	
    dbms_output.put_line('     '||'TABLE_NAME_TO_29_CHARS'||'           MATCHES');
	
    dbms_output.put_line('------------------------------------------------------');
	
       
    END IF;
    dbms_output.put_line('     '||rec2.TABLE_NAME_TO_29_CHARS||'             '||rec2.MATCHES);    
	
    SEC_18_CNT := SEC_18_CNT + 1;
 
 end loop;
    IF ( SEC_18_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
	ELSE
	dbms_output.put_line('                                                                                                           ');
	dbms_output.put_line('no rows selected');
    END IF;

exception
    when others then
    dbms_output.put_line(' Error SECTION - 18'|| SQLERRM);
	--fnd_file.put_line(--fnd_file.log,' Error SECTION - 18'|| SQLERRM);
end;


-- SECTION - 40 Materialized View name must be unique within the first 29 bytes.

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-40  [minimal]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Materialized View name must be unique within the first 29 bytes."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P1: Matching materialized views will not upgrade correctly');
dbms_output.put_line('DOC>         and will be non-functional.');
dbms_output.put_line('DOC>   - Fix: Rename materialized views so that names are unique');
dbms_output.put_line('DOC>         within the first 29 bytes.');
dbms_output.put_line('DOC>#');

 begin
 SEC_40_CNT := 0;
 for rec_sec_40 in (
    select mv.owner, substrb(mv.mview_name, 1, 29) MV_NAME, count(mv.mview_name) CNT
from dba_mviews mv
where mv.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E', 'U') )
  and length(mv.mview_name) > 29
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = mv.owner
            and aoo.object_name = mv.mview_name
            and aoo.object_type = 'MATERIALIZED VIEW' )
			and substrb(mv.mview_name, 1, 29) in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and substrb(do.object_name, 1, 29) = v.INPUT_OBJECT))                              
group by mv.owner, substrb(mv.mview_name, 1, 29)
having count(mv.mview_name) > 1) 

loop
    IF ( SEC_40_CNT = 0 ) THEN 
    
    dbms_output.put_line('                                                                                                                               ');
	
    dbms_output.put_line('     '||'OWNER'||'           MVIEW_NAME'||'             '||'COUNT');
	
    dbms_output.put_line('-------------------------------------------------------------------');
	
       
    END IF;
    dbms_output.put_line('     '||rec_sec_40.OWNER||'             '||rec_sec_40.MV_NAME||'         '||rec_sec_40.CNT);    
	
    SEC_40_CNT := SEC_40_CNT + 1;
 
 end loop;
    IF ( SEC_40_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
	ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');
    END IF;

exception
    when others then
    dbms_output.put_line(' Error SECTION - 40'|| SQLERRM);
	--fnd_file.put_line(--fnd_file.output,' Error SECTION - 40'|| SQLERRM);
end;
 
 -- SECTION - 15 Synonym must point to an object. When dropping an object, drop the synonym as well.
 
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-15  [minimal]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Synonym must point to an object."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P3: broken synonyms cause clutter and confusion.');
dbms_output.put_line('DOC>   - Fix: Correct or drop these synonyms.');
dbms_output.put_line('DOC>#');

 begin
 SEC_15_CNT := 0;
 for rec1 in (
    select syn.owner, syn.synonym_name, syn.table_owner, syn.table_name
from  dba_synonyms syn
where syn.table_owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'C', 'E', 'U') )
  and not exists
        ( select obj.object_name
          from   dba_objects obj
          where  obj.owner       = syn.table_owner
            and  obj.object_name = syn.table_name )
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = syn.owner
            and ((aoo.object_name = syn.synonym_name and aoo.object_type = 'SYNONYM') or
                 (aoo.object_name = syn.table_name   and aoo.object_type = 'TABLE')) )
   and syn.synonym_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                                                             
order by 1, 2) 

loop
    IF ( SEC_15_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'synonym_name'||'                '||'table_owner'||'             '||'table_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'             '||rec1.synonym_name||'                '||rec1.table_owner||'             '||rec1.table_name);    

    SEC_15_CNT := SEC_15_CNT + 1;
 
 end loop;
    IF ( SEC_15_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 15 '|| SQLERRM);

end;

-- SECTION - 21 "List of Table names with Base columns which contains '#' not as a last character."
  -- "('#' allowed as only as last character for Base column names)"
 
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-21  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Base column name can only use ''#'' as the last character."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: These columns will not show correctly in the editioning view.');
dbms_output.put_line('DOC>   - Fix: Rename the column');
dbms_output.put_line('DOC>       SQL> alter table table_owner.table_name');
dbms_output.put_line('DOC>            rename column column_name to new_column_name;');
dbms_output.put_line('DOC>   - Unused tables and columns can be ignored.');
dbms_output.put_line('DOC>   Note: This check only works prior to Online Patching Enablement.');
dbms_output.put_line('DOC>#');

 begin
 SEC_21_CNT := 0;
 for rec1 in (
    select col.owner, col.table_name, col.column_name
from
   dba_tab_columns col
where exists
     ( select null from dba_tables tab
       where tab.owner in
           ( select oracle_username from fnd_oracle_userid
             where  read_only_flag in ('A', 'B', 'E') )
         and tab.temporary = 'N'
         and tab.secondary = 'N'
         and tab.tablespace_name  <> 'APPS_TS_NOLOGGING'
         and tab.owner = col.owner
         and tab.table_name = col.table_name )
  and regexp_like(col.column_name, '^..*#..*$', 'c')
  and not exists
        ( select null from dba_editioning_views ev
          where ev.owner = col.owner
            and ev.table_name = col.table_name )
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = col.owner
            and aoo.object_name = col.table_name
            and aoo.object_type = 'TABLE' )
  and col.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              			
order by 1, 2, 3
) 

loop
    IF ( SEC_21_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'table_name'||'                '||'column_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'             '||rec1.table_name||'                '||rec1.column_name);    

    SEC_21_CNT := SEC_21_CNT + 1;
 
 end loop;
    IF ( SEC_21_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 21 '|| SQLERRM);

end;

-- SECTION-22 := "List of Table names where Base column names are not unique within 28 bytes."
   
  
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-22  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Base column name must be unique within 28 bytes."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P3: these columns cannot be revised using the same logical name');
dbms_output.put_line('DOC>         during online patching.');
dbms_output.put_line('DOC>   - Fix violations by renaming the column to a shorter base name.');
dbms_output.put_line('DOC>       SQL> alter table table_owner.table_name');
dbms_output.put_line('DOC>            rename column column_name to new_column_name;');
dbms_output.put_line('DOC>       SQL> ad_zd_table.patch(table_owner, table_name)');
dbms_output.put_line('DOC>   - Fixes can be deferred until there is a reason to patch the column.');
dbms_output.put_line('DOC>     Unused columns can be ignored.');
dbms_output.put_line('DOC>   Note: This check only works after Online Patching Enablement.');
dbms_output.put_line('DOC>#  ');
 

 begin
 SEC_22_CNT := 0;
 for rec1 in (
    select
    col.owner owner
  , col.table_name table_name
  , substrb(col.column_name, 1, 28) column_name_to_28_chars
  , count(col.column_name) matches
from
    dba_editioning_views ev
  , dba_tab_columns col
where ev.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and col.owner = ev.owner
  and col.table_name = ev.table_name
  and length(col.column_name) > 28
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = ev.owner
            and ((aoo.object_name = ev.view_name and aoo.object_type = 'VIEW') or
                 (aoo.object_name = ev.table_name and aoo.object_type = 'TABLE')) )
	and col.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              				 
group by col.owner, col.table_name, substrb(col.column_name, 1, 28)
having count(col.column_name) > 1
order by 1, 2, 3
) 

loop
    IF ( SEC_22_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'table_name'||'                '||'column_name_to_28_chars'||'                     '||'matches');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'             '||rec1.table_name||'                '||rec1.column_name_to_28_chars||'                   '||rec1.matches);    

    SEC_22_CNT := SEC_22_CNT + 1;
 
 end loop;
    IF ( SEC_22_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 22 '|| SQLERRM);

end;


-- SECTION-33 := "Index Name must contain an underscore ('_') character."

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-33  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Index Name must contain an underscore (''_'') character."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: These indexes cannot be revised during online patching.');
dbms_output.put_line('DOC>   - Fix: Renaming index according to EBS naming standards:');
dbms_output.put_line('DOC>       Unique:     TABLE_NAME_U1, TABLE_NAME_U2, ...');
dbms_output.put_line('DOC>       Non-Unique: TABLE_NAME_N1, TABLE_NAME_N2, ...');
dbms_output.put_line('DOC>   - Unused indexes should be dropped.');
dbms_output.put_line('DOC>   Note: This check only works after Online Patching Enablement.');
dbms_output.put_line('DOC>#');
   

 begin
 SEC_33_CNT := 0;
 for rec1 in (
    select idx.owner, idx.index_name, idx.table_name
from   dba_indexes idx, dba_editioning_views ev
where ev.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and idx.table_owner = ev.owner
  and idx.table_name  = ev.table_name
  and idx.temporary = 'N'
  and idx.secondary = 'N'
  and idx.generated = 'N'
  and not regexp_like(idx.index_name, '^.*_.*', 'c')
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = idx.owner
            and ((aoo.object_name = idx.index_name and aoo.object_type = 'INDEX') or
                 (aoo.object_name = ev.table_name and aoo.object_type = 'TABLE')) )
	and idx.table_name   	in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              				 
order by 1, 2, 3
) 

loop
    IF ( SEC_33_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'index_name'||'                '||'table_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'             '||rec1.index_name||'                '||rec1.table_name);    

    SEC_33_CNT := SEC_33_CNT + 1;
 
 end loop;
    IF ( SEC_33_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 33 '|| SQLERRM);

end;


-- SECTION-38 := "List Of Constraint details which are not having an underscore ('_') character."

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-38  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Constraint name must contain an underscore (''_'') character."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: These constraints cannot be revised during online patching.');
dbms_output.put_line('DOC>   - Fix:  Rename constraints according to EBS naming standards.');
dbms_output.put_line('DOC>       Unique:     TABLE_NAME_U1, TABLE_NAME_U2, ...');
dbms_output.put_line('DOC>       Non-Unique: TABLE_NAME_N1, TABLE_NAME_N2, ...');
dbms_output.put_line('DOC>   - Unused constraints should be dropped.');
dbms_output.put_line('DOC>   Note: This check only works after Online Patching Enablement.');
dbms_output.put_line('DOC>#');
   

 begin
 SEC_38_CNT := 0;
 for rec1 in (
    select con.owner, con.constraint_name, con.table_name
from   dba_constraints con, dba_editioning_views ev
where ev.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and con.owner = ev.owner
  and con.table_name = ev.table_name
  and con.generated = 'USER NAME'
  and not regexp_like(con.constraint_name, '^.*_.*$', 'c')
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = ev.owner
            and ((aoo.object_name = ev.view_name and aoo.object_type = 'VIEW') or
                 (aoo.object_name = ev.table_name and aoo.object_type = 'TABLE')) )
	  and con.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              					 
order by 1, 2, 3
) 

loop
    IF ( SEC_38_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'constraint_name'||'                '||'table_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'             '||rec1.constraint_name||'                '||rec1.table_name);    

    SEC_38_CNT := SEC_38_CNT + 1;
 
 end loop;
    IF ( SEC_38_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 38 '|| SQLERRM);

end;

-- SECTION-43 := "List of Object names matched with any E-Business Suite schema name."

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-43  [minimal]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Object name must not match any E-Business Suite schema name."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P1: These object names conflict with schema names and may cause');
dbms_output.put_line('DOC>         errors during upgrade or online patching.');
dbms_output.put_line('DOC>   - Fix: Drop or rename the object.');
dbms_output.put_line('DOC>#   ');

 begin
 SEC_43_CNT := 0;
 for rec1 in (
    select obj.owner, obj.object_name
from dba_objects obj
where obj.owner in
       (select oracle_username
        from system.fnd_oracle_userid
        where  read_only_flag in ('A', 'B', 'E', 'U')
        )
and exists
       (select null
        from system.fnd_oracle_userid
        where oracle_username = obj.object_name
          and read_only_flag in ('A', 'B', 'E', 'U') )
and obj.object_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              							  
) 

loop
    IF ( SEC_43_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'object_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'             '||rec1.object_name);    

    SEC_43_CNT := SEC_43_CNT + 1;
 
 end loop;
    IF ( SEC_43_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 43 '|| SQLERRM);

end;

-- SECTION-19 := "List of Table names not owned by an EBS product schema."  

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-19  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Table must be owned by an EBS product schema, not APPS."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: Tables owned by APPS cannot be patched using online patching.');
dbms_output.put_line('DOC>   - Fix: Move table to a product schema and then call the table');
dbms_output.put_line('DOC>         upgrade procedure.');
dbms_output.put_line('DOC>       SQL> ad_zd_table.upgrade(new_owner, table_name)');
dbms_output.put_line('DOC>   - Note: An unused table can be ignored or dropped.  Tables that are');
dbms_output.put_line('DOC>           managed dynamically by application runtime can be ignored.');
dbms_output.put_line('DOC>#');

 begin
 SEC_19_CNT := 0;
 for rec1 in (
    select tab.table_name
from user_tables tab
where tab.temporary = 'N'
  and tab.secondary = 'N'
  and tab.iot_type is null
  and tab.tablespace_name not in ('APPS_TS_NOLOGGING', 'APPS_TS_QUEUES')
  and not regexp_like(tab.table_name, '^AQ\$', 'c')
  and not regexp_like(tab.table_name, '^AW\$', 'c')
  and not regexp_like(tab.table_name, '^OWB\$', 'c')
  and not regexp_like(tab.table_name, '^MLOG\$', 'c')
  and not regexp_like(tab.table_name, '^PROF\$', 'c')
  and not regexp_like(tab.table_name, '^RUPD\$_', 'c')
  and not regexp_like(tab.table_name, '^DR_', 'c')
  and not regexp_like(tab.table_name, '^AP_TEMP_DATA_DRIVER', 'c')
  and not regexp_like(tab.table_name, '^BSC_DI_[0-9_]+$', 'c')
  and not regexp_like(tab.table_name, '^BSC_D_.+$', 'c')
  and not regexp_like(tab.table_name, '^BIM_.*_TEMP$', 'c')
  and not regexp_like(tab.table_name, '^FA_ARCHIVE_ADJUSTMENT_.+$', 'c')
  and not regexp_like(tab.table_name, '^FA_ARCHIVE_DETAIL_.+$', 'c')
  and not regexp_like(tab.table_name, '^FA_ARCHIVE_SUMMARY_.+$', 'c')
  and not regexp_like(tab.table_name, '^GL_DAILY_POST_INT_.+$', 'c')
  and not regexp_like(tab.table_name, '^GL_INTERCO_BSV_INT_[0-9]+$', 'c')
  and not regexp_like(tab.table_name, '^GL_MOVEMERGE_BAL_[0-9]+$', 'c')
  and not regexp_like(tab.table_name, '^GL_MOVEMERGE_INTERIM_[0-9]+$', 'c')
  and not regexp_like(tab.table_name, '^XLA_GLT_[0-9]+$', 'c')
  and not regexp_like(tab.table_name, '^ICX_POR_C[0-9]+.*$', 'c')
  and not regexp_like(tab.table_name, '^ICX_POR_UPLOAD_[0-9]+.*$', 'c')
  and not regexp_like(tab.table_name, '^IGI_SLS_[0-9]+$', 'c')
  and not regexp_like(tab.table_name, '^JTF_TAE_[0-9]+.*$', 'c')
  and not regexp_like(tab.table_name, '^JTY_[0-9]+_.*$', 'c')
  and not regexp_like(tab.table_name, '^ZPBDATA[0-9]+_EXCPT_T$', 'c')
  and not regexp_like(tab.table_name, '^ZX_DATA_UPLOAD_.*$', 'c')
  and not regexp_like(tab.table_name, '_BACKUP', 'c')
  and not regexp_like(tab.table_name, '_TEMP$', 'c')
  and not regexp_like(tab.table_name, '^EUL.+$', 'c')
  and not regexp_like(tab.table_name, '^MISCN_TMP_.+$', 'c')
  and not regexp_like(tab.table_name, '^TEMP_.+$', 'c')
  /* EXCLUDE MVs */
  and not exists
        ( select mview_name from user_mviews dmv
          where  ( dmv.mview_name = tab.table_name or
                   dmv.container_name = tab.table_name or
                   dmv.update_log = tab.table_name ) )
  /* EXCLUDE normal AQ tables.*/
  and not exists
        ( select 1 from user_queue_tables qt
          where qt.queue_table=tab.table_name )
  and not exists
        ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and aoo.object_name = tab.table_name
            and ((fou.oracle_username = user and aoo.object_type = 'TABLE') or
                 (aoo.object_type = 'MATERIALIZED VIEW')) )
   and tab.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              					    				 
group by tab.table_name
order by tab.table_name
) 

loop
    IF ( SEC_19_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('        '||'table_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('        '||rec1.table_name);

    SEC_19_CNT := SEC_19_CNT + 1;
 
 end loop;
    IF ( SEC_19_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 19 '|| SQLERRM);

end;

-- SECTION-24 := "Column Type must not be LONG or LONG RAW."  

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-24  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Column Type must not be LONG or LONG RAW."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: These columns cannot be patched using Online Patching.');
dbms_output.put_line('DOC>   - Fix: Alter the column datatype to CLOB or BLOB.');
dbms_output.put_line('DOC>       SQL> alter table owner.table_name modify column_name CLOB;');
dbms_output.put_line('DOC>   - Note: The LONG-to-CLOB datatype change should be implemented before');
dbms_output.put_line('DOC>           Online Patching Enablement.');
dbms_output.put_line('DOC>   - Note: If you alter the column type via ''ALTER TABLE'' DDL (instead of using');
dbms_output.put_line('DOC>           using XDF/ODF) you will need to rebuild indexes on the affected');
dbms_output.put_line('DOC>           table manually.');
dbms_output.put_line('DOC>       SQL> alter index owner.index_name rebuild;');
dbms_output.put_line('DOC>   - Note: Changing a LONG to CLOB will cause any trigger that references the');
dbms_output.put_line('DOC>           CLOB column in the "UPDATE OF" clause of a trigger to go invalid.');
dbms_output.put_line('DOC>           Fix this by referencing the table in the "ON" clause of the trigger');
dbms_output.put_line('DOC>   - Unused LONG columns can be ignored, but should be dropped.');
dbms_output.put_line('DOC>#');

 begin
 SEC_24_CNT := 0;
 for rec1 in (
    select col.owner, col.table_name, col.column_name, col.data_type
from
    dba_tables tab
  , dba_tab_columns col
where tab.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'E') )
  and tab.temporary = 'N'
  and tab.secondary = 'N'
  and tab.tablespace_name  <> 'APPS_TS_NOLOGGING'
  and col.owner      = tab.owner
  and col.table_name = tab.table_name
  and col.data_type  in ('LONG', 'LONG RAW')
  and not exists
        ( select /*+ push_subq no_unnest */ 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = tab.owner
            and aoo.object_name = tab.table_name
            and aoo.object_type = 'TABLE' )
	and col.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              					      		
order by 1, 2
) 

loop
    IF ( SEC_24_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'table_name'||'                '||'column_name'||'             '||'data_type');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'           '||rec1.table_name||'                '||rec1.column_name||'             '||rec1.data_type);

    SEC_24_CNT := SEC_24_CNT + 1;
 
 end loop;
    IF ( SEC_24_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 24 '|| SQLERRM);

end;

-- SECTION-25 := "List of Column details which are of Type ROWID."

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-25  [minimal]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Column Type should not be ROWID."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: Stored ROWID references may be broken when tables are patched.');
dbms_output.put_line('DOC>   - Fix: Re-design table to reference the target table primary key.');
dbms_output.put_line('DOC>   - Unused columns or columns that only store the ROWID temporarily');
dbms_output.put_line('DOC>     can be ignored.');
dbms_output.put_line('DOC>   Note: this check does not work prior to Online Patching Enablement.');
dbms_output.put_line('DOC>#');

 begin
 SEC_25_CNT := 0;
 for rec1 in (
    select col.owner, col.table_name, col.column_name, col.data_type
from
    dba_editioning_views ev
  , dba_tab_columns col
where ev.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and col.table_name not in /* Exclusion list: tables with temporary data */
        (
          /* bug 14760688 */
          'AD_PARALLEL_WORKERS',
          /* bug 14771654 */
          'AMS_LIST_ENTRIES_PURGE',
          /* bug 14771817 */
          'AS_TAP_PURGE_WORKING',
          /* bug 15874106 */
          'BOM_ODI_WS_REVISIONS',
          /* bug 15876194 */
          'CN_NOT_TRX_ALL',
          /* bug 15843184 */
          'CST_BIS_MARGIN_SUMMARY',
          'CST_MARGIN_SUMMARY',
          'CST_MARGIN_TEMP',
          /* bug 17673256 */
          'CSI_EID_CUST_INST_PROCESS_TEMP',
           /* bug 16165233 */
          'DDR_I_RTL_SL_RTN_ITEM',
          'DDR_I_SLS_FRCST_ITEM',
           /* bug 17673261 */
          'EAM_EID_WO_PROCESS_TEMP',
          'EAM_EID_WR_PROCESS_TEMP',
          /* bug 14774307 */
          'FND_OAM_DSCRAM_ARG_VALUES',
          /* bug 15828807, 16190549 */
          'GL_BC_PACKETS',
          'GL_BC_PACKETS_HISTS',
          /* bug 14789658 */
          'HZ_IMP_ADDRESSES_SG',
          'HZ_IMP_ADDRESSUSES_SG',
          'HZ_IMP_CLASSIFICS_SG',
          'HZ_IMP_CONTACTPTS_SG',
          'HZ_IMP_CONTACTROLES_SG',
          'HZ_IMP_CONTACTS_SG',
          'HZ_IMP_CREDITRTNGS_SG',
          'HZ_IMP_FINNUMBERS_SG',
          'HZ_IMP_FINREPORTS_SG',
          'HZ_IMP_PARTIES_SG',
          'HZ_IMP_RELSHIPS_SG',
          'HZ_IMP_TMP_ERRORS',
          'HZ_IMP_TMP_REL_END_DATE',
          'HZ_SRCH_CONTACTS',
          'HZ_SRCH_CPTS',
          'HZ_SRCH_PARTIES',
          'HZ_SRCH_PSITES',
          'HZ_THIN_ST_CONTACTS',
          'HZ_THIN_ST_CPTS',
          'HZ_THIN_ST_PARTIES',
          'HZ_THIN_ST_PSITES',
           /* bug 16507311 */
          'IGI_MHC_DEPRN_DETAIL',
          'IGI_MHC_DEPRN_SUMMARY',
          'IGI_MHC_LEDGER',
          /* bug 18221984 */
          'JE_PT_INTERFACE_LINES_EXTS',
          /* bug 14762204 */
          'JL_BR_INTERFACE_LINES_EXTS',
          /* bug 15836849 */
          'MSC_PQ_RESULTS',
          /* bug 14770945 */
          'MTL_ONHAND_DISCREPANCIES',
          'MTL_ONHAND_QUANTITIES_BACKUP',
          'MTL_ONHAND_QUANTITIES_D_BKP',
          /* bug 14843267 */
          'OKC_KEXP_REPORT',
          /* bug 14812560 */
          'OKS_INT_ERROR_STG_TEMP',
          'OKS_INT_HEADER_STG_TEMP',
          'OKS_INT_LINE_STG_TEMP',
          'OKS_INT_SALES_CREDIT_STG_TEMP',
          'OKS_INT_USAGE_COUNTER_STG_TEMP',
          /* bug 16767837 */
          'PA_PJT_EVENTS',
          'PA_PJT_EVENTS_02',
          /* Bug 14811177 */
          'PA_TXN_ACCUM_DETAILS_AR',
          'PA_TXN_UPGRADE_TEMP',
          'PJI_AC_RMAP_ACR',
          'PJI_FM_AGGR_ACT2',
          'PJI_FM_AGGR_FIN2',
          'PJI_FM_DNGL_ACT',
          'PJI_FM_DNGL_FIN',
          'PJI_FM_EXTR_ARINV',
          'PJI_FM_EXTR_DINVC',
          'PJI_FM_EXTR_DREVN',
          'PJI_FM_EXTR_FUNDG',
          'PJI_FM_EXTR_PLNVER2',
          'PJI_FM_REXT_CDL',
          'PJI_FM_REXT_CRDL',
          'PJI_FM_REXT_ERDL',
          'PJI_FM_RMAP_ACT',
          'PJI_FM_RMAP_FIN',
          'PJI_FP_RMAP_FPR',
          'PJI_FM_RMAP_PSI',
          'PJI_MERGE_HELPER',
          'PJI_PA_PROJ_EVENTS_LOG',
          'PJI_PJP_RMAP_ACR',
          'PJI_PJP_RMAP_FPR',
          'PJI_RM_DNGL_RES',
          'PJI_RM_REXT_FCSTITEM',
          /* bug 14766363 */
          'QA_BUG1339720_TEMP',
          /* bug 14793655 */
          'WF_UR_VALIDATE_STG',
          /* bug 18816616 */
          'HR_COUNTRY_DELTA_SYNC',
          /* bug 15877660 */
          'XTR_JOURNALS_EFC'
        )
  and col.owner      = ev.owner
  and col.table_name = ev.table_name
  and col.data_type  = 'ROWID'
  and not exists
         ( select 1
          from system.fnd_oracle_userid fou
             , fnd_product_installations fpi
             , ad_obsolete_objects aoo
          where fpi.application_id = aoo.application_id
            and fou.oracle_id = fpi.oracle_id
            and fou.oracle_username = col.owner
            and (aoo.object_name = col.table_name
                 and aoo.object_type = 'TABLE') )
	and col.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              					        			 
order by 1, 2, 3
) 

loop
    IF ( SEC_25_CNT = 0 ) THEN 
	
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'table_name'||'                '||'column_name'||'             '||'data_type');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'           '||rec1.table_name||'                '||rec1.column_name||'             '||rec1.data_type);

    SEC_25_CNT := SEC_25_CNT + 1;
 
 end loop;
    IF ( SEC_25_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 25 '|| SQLERRM);

end;

-- SECTION-26 := "List of Objects which contains Query/DML Statements which are not accessing tables via the APPS table synonym"

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-26  [minimal]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Query/DML statements must access tables via the APPS table synonym."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P2: These objects may operate incorrectly after the referenced table');
dbms_output.put_line('DOC>         has been patched.');
dbms_output.put_line('DOC>   - Fix:  Change the object to reference tables via the APPS table synonym.');
dbms_output.put_line('DOC>#');

 begin
 SEC_26_CNT := 0;
 for rec1 in (
    select
    dep.owner              owner
  , dep.name               object_name
  , dep.type               object_type
  , dep.referenced_owner   referenced_owner
  , dep.referenced_name    referenced_name
from
    dba_dependencies dep
  , dba_tables tab
where dep.referenced_type = 'TABLE'
  and dep.referenced_owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'E') )
  and dep.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A', 'B', 'C', 'E', 'U') )
    /* ignore reference to AQ objects */
  and not dep.referenced_name like 'AQ$%'
    /* ignore synonyms */
  and not dep.type in ('UNDEFINED', 'SYNONYM')
    /* ignore materialized view on editioned system */
  and not ( dep.type = 'MATERIALIZED VIEW' and
            exists
              ( select null from dba_users
                where username = user
                  and editions_enabled = 'Y' ) )
    /* ignore editioning view */
  and not ( dep.type = 'VIEW' and
            dep.owner = dep.referenced_owner and
            dep.name  = substrb(dep.referenced_name, 1, 29)||'#' )
    /* ignore trigger if no EV or special */
  and not ( dep.type = 'TRIGGER' and
            ( not exists
                ( select null from dba_editioning_views ev
                  where ev.owner     = dep.referenced_owner
                    and ev.view_name = substrb(dep.referenced_name, 1, 29)||'#' ) or
             (dep.owner, dep.name) in
                ( select owner, trigger_name from dba_triggers
                  where crossedition <> 'NO'
                    or  trigger_name like '%_WHO'
                    or  trigger_name like 'DR$%') ) )
    /* ignore queue tables */
  and not exists
        ( select null from dba_queue_tables qt
          where qt.owner = dep.referenced_owner
            and qt.queue_table = dep.referenced_name )
    /* only check ordinary tables */
  and tab.owner = dep.referenced_owner
  and tab.table_name = dep.referenced_name
  and tab.temporary = 'N'
  and tab.secondary = 'N'
  and tab.iot_type is null
    /* only check tables visible to APPS */
  and exists
        ( select null from user_synonyms
          where table_owner = dep.referenced_owner
            and table_name in (dep.referenced_name, substrb(dep.referenced_name, 1, 29)||'#' ) )
	and dep.name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              					          		
order by 1, 2, 3, 4, 5
) 

loop
    IF ( SEC_26_CNT = 0 ) THEN 
	 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'object_name'||'                '||'object_type'||'             '||'referenced_owner'||'                 '||'referenced_name');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'           '||rec1.object_name||'                '||rec1.object_type||'             '||rec1.referenced_owner||'                 '||rec1.referenced_name);

    SEC_26_CNT := SEC_26_CNT + 1;
 
 end loop;
    IF ( SEC_26_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 26 '|| SQLERRM);

end;

-- SECTION-37 := "List of Index details which has Index key size greated than 3215."  

dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  SECTION-37  [full]');
dbms_output.put_line('DOC>  **********************************************************************');
dbms_output.put_line('DOC>  "Index key size should be less than 3215."');
dbms_output.put_line('DOC>');
dbms_output.put_line('DOC>   - P3: Possible runtime locking when patching this index.  Application');
dbms_output.put_line('DOC>         users may see delayed response for transactions against these');
dbms_output.put_line('DOC>         tables while the index is being patched.');
dbms_output.put_line('DOC>   - Fix: Remove unnecessary columns from the index.');
dbms_output.put_line('DOC>   - Unfixed violations can be ignored.');
dbms_output.put_line('DOC>#');

 begin
 SEC_37_CNT := 0;
 for rec1 in (
    select idx.owner, idx.index_name, idx.table_name, sum(idc.column_length+1) index_key_length
from   dba_indexes idx, dba_ind_columns idc
where idx.owner in
        ( select oracle_username from fnd_oracle_userid
          where  read_only_flag in ('A','B', 'E', 'U') )
  and idx.temporary = 'N'
  and idx.secondary = 'N'
  and idx.generated = 'N'
  and idx.index_type <> 'DOMAIN'
  and idc.index_owner = idx.owner
  and idc.index_name  = idx.index_name
  and idc.index_name not in
       (/* bug-14790493, OTA's indexes for Performance */
        'HZ_STAGED_PARTIES_N1',
        /* bug-14789821 */
        'IBC_DIRECTORY_NODES_B_U2',
        /* bug-14797672 */
        'AME_STRING_VALUES_UK1',
        /* bug-14812354 */
        'XNP_MSGS_N6',
        /* bug-14839334 */
        'GMO_DISPENSE_CONFIG_INST_U1',
        /* bug-14848132 */
        'PER_ENTERPRISES_UK2',
        'PER_ENT_SECURITY_GROUPS_UK3',
        /* bug-15857082 */
        'CZ_PROPERTIES_N1',
        'CZ_RP_ENTRIES_N2',
        'CZ_RP_ENTRIES_N3',
        'CZ_RP_ENTRIES_NF1',
        'CZ_RP_ENTRIES_U1',
        /* bug-15855178 */
        'JDR_ATTRIBUTES_N2',
        'BISM_EXPORT_PK',
        /*bug-18088447 */
        'FND_EID_DDR_MGD_ATT_VALS_U1',
        /*bug-18502422 */
        'FND_EID_DDR_MGD_ATT_VALS_ZD_U1',
        /*bug-18680711 */
        'CMI_GPA_RPD_TL_U1'
       )
  and not exists
       ( select 1
         from system.fnd_oracle_userid fou
            , fnd_product_installations fpi
            , ad_obsolete_objects aoo
         where fpi.application_id = aoo.application_id
           and fou.oracle_id = fpi.oracle_id
           and fou.oracle_username = idx.owner
           and ((aoo.object_name = idx.index_name and aoo.object_type = 'INDEX') or
                (aoo.object_name = idx.table_name and aoo.object_type = 'TABLE')) )
	and idx.table_name in (select INPUT_OBJECT from
 (select regexp_substr(v_input_object,'[^,]+', 1, level) "INPUT_OBJECT" from dual
                                                                connect by regexp_substr(v_input_object, '[^,]+', 1, level) is not null) v where 1 = 1
                                                                and exists (select 1 from dba_objects do where 1 = 1 and do.object_name = v.INPUT_OBJECT))                              					          				
group by idx.owner, idx.index_name, idx.table_name
having   sum(idc.column_length+1) > 3215
order by idx.owner, idx.index_name
) 

loop
    IF ( SEC_37_CNT = 0 ) THEN 
    dbms_output.put_line('                                                                                                           ');
	
    dbms_output.put_line('     '||'owner'||'           '||'index_name'||'                '||'table_name'||'             '||'index_key_length');
	
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
    
    END IF;
    dbms_output.put_line('     '||rec1.owner||'           '||rec1.index_name||'                '||rec1.table_name||'             '||rec1.index_key_length);

    SEC_37_CNT := SEC_37_CNT + 1;
 
 end loop;
    IF ( SEC_37_CNT <> 0) THEN
    dbms_output.put_line('-----------------------------------------------------------------------------------------------------------');
	
    ELSE
	dbms_output.put_line('                                                                                                            ');
	dbms_output.put_line('no rows selected');

	END IF;

exception

    when others then
    dbms_output.put_line(' Error SECTION - 37 '|| SQLERRM);

end;



----fnd_file.put_line(--fnd_file.output, 'Start');
----fnd_file.put_line(--fnd_file.log, 'Start log');
    
	IF ( SEC_15_CNT <> 0 OR SEC_17_CNT <> 0 OR SEC_18_CNT <> 0 OR SEC_10_CNT <> 0 OR SEC_40_CNT <> 0
		OR SEC_21_CNT <> 0 OR SEC_22_CNT <> 0 OR SEC_33_CNT <> 0 OR SEC_38_CNT <> 0 OR SEC_43_CNT <> 0
		OR SEC_19_CNT <> 0 OR SEC_24_CNT <> 0 OR SEC_25_CNT <> 0 OR SEC_26_CNT <> 0 OR SEC_37_CNT <> 0
		) THEN
	
	DBMS_OUTPUT.PUT_LINE('                                                                               ');
	DBMS_OUTPUT.PUT_LINE('                                                                               ');
	
		IF ( SEC_15_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-15 has some Non compliant Objects. Please check section-15 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_17_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-17 has some Non compliant Objects. Please check section-17 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_10_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-10 has some Non compliant Objects. Please check section-10 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_18_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-18 has some Non compliant Objects. Please check section-18 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_40_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-40 has some Non compliant Objects. Please check section-40 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_21_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-21 has some Non compliant Objects. Please check section-21 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_22_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-22 has some Non compliant Objects. Please check section-22 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_33_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-33 has some Non compliant Objects. Please check section-33 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_38_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-38 has some Non compliant Objects. Please check section-38 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_43_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-43 has some Non compliant Objects. Please check section-43 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_19_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-19 has some Non compliant Objects. Please check section-19 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_24_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-24 has some Non compliant Objects. Please check section-24 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_25_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-25 has some Non compliant Objects. Please check section-25 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_26_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-26 has some Non compliant Objects. Please check section-26 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		IF ( SEC_37_CNT <> 0) THEN
			DBMS_OUTPUT.PUT_LINE('SECTION-37 has some Non compliant Objects. Please check section-37 for details.');
			DBMS_OUTPUT.PUT_LINE('                                                                               ');
		END IF;
		
		
    Raise_Application_Error(-20343, 'there is some error.'); 
    
	END IF;
	
    
 EXCEPTION
        WHEN OTHERS THEN
            --x_errbuf := 'Error in main procedure ' || sqlerrm;
            --fnd_file.put_line(--fnd_file.log, x_errbuf);
           -- log_debug(x_errbuf);
		   dbms_output.put_line(' Error MAIN'|| SQLERRM);
		   Raise_Application_Error(-20343, 'there is some error.');
END ; 
/