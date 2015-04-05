impdp system/manager@dlink remap_schema=xtra:xtrak directory=dir_edp dumpfile=xtrap_full%U_mon.dmp exclude=table:"IN('DL_DEALS_LENDER_PROGRAMS','DL_AUDIT_DEALS')"

create or replace procedure delete_deals(deal_date in varchar2) is
v_date date := to_date(deal_date, 'DD-MM-YYYY');
begin
        delete from dl_deals where dealid not in (select saved_dealid from dl_deals where saved_dealid is not null) and trunc(last_modified) = trunc(v_date);
        dbms_output.put_line('No of deals deleted with date# '||to_char(v_date, 'DD-MM-YYYY')||'='||sql%rowcount);
end delete_deals;
/
show errors

declare
	f_delete utl_file.file_type;
	begin_date date := to_date('31-12-2013', 'dd-mm-yyyy');
    start_date date := to_date('31-12-2013', 'dd-mm-yyyy');
    stop_date date := to_date('01-01-2006', 'dd-mm-yyyy');
    v_date_string varchar2(100);
begin
	f_delete := utl_file.fopen('DATA_PUMP_DIR','delete_deals.sql','w');
	utl_file.put_line(f_delete, 'spool purge.log');
	utl_file.put_line(f_delete, 'set serveroutput on echo on');
	while(start_date > stop_date) loop
				v_date_string := ' exec delete_deals('||chr(39)||to_char(start_date,'DD-MM-YYYY')||chr(39)||');';
                utl_file.put_line(f_delete, v_date_string);
                utl_file.put_line(f_delete, 'COMMIT;'); 
                start_date := start_date-1;
    end loop;
    utl_file.put_line(f_delete, 'spool off;');
    utl_file.fflush(f_delete);
    utl_file.fclose(f_delete);
END;
/
show errors


