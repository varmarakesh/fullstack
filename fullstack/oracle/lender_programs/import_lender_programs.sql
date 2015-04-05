-- to be run in target (xtra@dlink exadata)
-- copy the lp.dmp file from the source to the required directory in the dest
--create the original table, dl_deals_lender_programs (without constraints)
set timing on;
spool import_lender_programs.log

 create table DL_DEALS_LENDER_PROGRAMS
(
	DEALID                 number,
	LENDER_PROGRAMS        XMLTYPE
)
tablespace DBDATA nocache nomonitoring pctfree 30 pctused 65 initrans 30
storage (pctincrease 0 maxextents unlimited freelists 12 freelist groups 3)
xmltype column LENDER_PROGRAMS store as object relational
XMLSCHEMA "http://www.dealertrack.com/desklink/Programs_Inc.xsd"
ELEMENT "ArrayOfProgram";

--create the external table.
CREATE TABLE lp_xt (dealid number, lender_programs clob)
ORGANIZATION EXTERNAL
    (
      TYPE ORACLE_DATAPUMP
      DEFAULT DIRECTORY data_pump_dir
      LOCATION ('lp.dmp')
    );
    

declare
    cursor cur_lp is select dealid, sys.xmltype.createxml(lender_programs) as lender_programs from lp_xt;
    v_commit pls_integer := 0;
    v_commit_freq pls_integer := 1000;
begin
    for lprograms in cur_lp loop
        insert into dl_deals_lender_programs(dealid, lender_programs) values (lprograms.dealid, lprograms.lender_programs);
        v_commit := v_commit + 1;
        if v_commit = v_commit_freq then
            commit;
            v_commit := 0;
        end if;
    end loop;
end;
/
show errors

--last residual commit;
commit;

spool off;

