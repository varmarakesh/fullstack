-- run this script in the xtra@dlink in the source (RACD)
-- Change the directory to the appropriate one where the dump file should be created.
set timing on;
spool export_lp.log

CREATE TABLE lp_xt
ORGANIZATION EXTERNAL
    (
      TYPE ORACLE_DATAPUMP
      DEFAULT DIRECTORY data_pump_dir
      LOCATION ('lp.dmp')
    )
AS SELECT 
		DEALID, 
		SYS.XMLTYPE.GETCLOBVAL(lender_programs) as lender_programs 
	FROM 
		xtra.dl_deals_lender_programs;

-- verify lp_xt
desc lp_xt

select count(*) from lp_txt;

spool off;


