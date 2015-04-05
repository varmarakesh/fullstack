--This can be used to compute checksum in oracle.

--Install dbms_crypto package

cd $ORACLE_HOME/rdbms/admin
sqlplus / as sysdba
@dbmsobtk.sql
@prvtobtk.plb

Grant execute on dbms_crypto to public;

  

create or replace function checksum( p_lob in clob ) return RAW as
  begin

            return  dbms_crypto.hash(src => p_lob, typ => DBMS_CRYPTO.HASH_MD5 );  
   end checksum;
   /

select dealid, checksum(sys.xmltype.getclobval(lender_programs)) from dl_deals_lender_programs where dealid = 9821853;
