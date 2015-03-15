set echo on
spool cre_django.log

connect / as sysdba
sho user


create user django_user identified by django_user
default   tablespace DBDATA
temporary tablespace TEMP
--quota unlimited on DBLOB
quota unlimited on DBINDX
quota unlimited on DBDATA
quota 0 on SYSTEM;

grant connect, resource, dba to django_user;
grant unlimited tablespace   to django_user;
grant javadebugpriv          to django_user with admin option;
grant javaidpriv             to django_user with admin option;
grant javasyspriv            to django_user with admin option;
grant javauserpriv           to django_user with admin option;

alter tablespace DBDATA coalesce;
alter tablespace DBINDX coalesce;
--alter tablespace DBLOB coalesce;

select username as "Schema_Name", created as "Create_Date"
  from dba_users
 where username not in ('SYS','SYSTEM','OUTLN','DBSNMP','DIP','TSMSYS','ANONYMOUS','XDB','WMSYS','XS$NULL',
                        'EXFSYS','DMSYS','MDSYS','ORDPLUGINS','SI_INFORMTN_SCHEMA','ORDSYS','APPQOSSYS','SYSMAN','MGMT_VIEW')
order by created;

--as xtra
conn xtra/5pecial5
col privilege  for a12
col grantee    for a12
col owner      for a10
col table_name for a25
col grantor    for a15
select grantee, owner, table_name, grantor, privilege from user_tab_privs;
exit;
