set echo on;
set serveroutput on;
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
WHENEVER OSERROR EXIT 2 ROLLBACK

spool purge_deals.log
set timing on;

select count(*) from dl_deals;
select count(*) from dl_deals where last_modified < to_date('12-31-2013', 'mm-dd-yyyy');

create or replace procedure delete_deals(start_date in date, end_date in date) is
        d_count pls_integer := 1000;
begin
        delete from dl_deals where dealid not in (select saved_dealid from dl_deals where saved_dealid is not null) and last_modified between trunc(start_date) and trunc(end_date) and rownum <= d_count;
        dbms_output.put_line('No of deals deleted beginning from -'||to_char(start_date, 'DD-MON-YYYY')||':'||to_char(sql%rowcount));
        if sql%rowcount = d_count then
                commit;
                delete_deals(start_date, end_date);
        end if;
end delete_deals;
/
show errors


declare
        begin_date date := to_date('01-01-2006', 'dd-mm-yyyy');
        start_date date := to_date('01-01-2006', 'dd-mm-yyyy');
        stop_date date := to_date('31-12-2013', 'dd-mm-yyyy');
begin
        dbms_output.put_line('Interval period: 1 day.................');
	while(start_date < stop_date) loop
                delete_deals(start_date, start_date+1);      
                commit;
                start_date := start_date+1;
        end loop;

	start_date := begin_date;
		
	dbms_output.put_line('Interval period: 5 days...............');
	while(start_date < stop_date) loop
                delete_deals(start_date, start_date+5);              
                commit;
                start_date := start_date+5;
        end loop;
		
	start_date := begin_date;
		
	dbms_output.put_line('Interval period: 1 month.................');
	while(start_date < stop_date) loop
                delete_deals(start_date, add_months(start_date,1));
                commit;
                start_date := add_months(start_date,1);
        end loop;

	dbms_output.put_line('Final remaining delete....................');
	delete from dl_deals where dealid not in (select saved_dealid from dl_deals where saved_dealid is not null) and last_modified < trunc(stop_date);
	dbms_output.put_line('No of deals deleted:'|| to_char(sql%rowcount));
	commit;
end;
/
show errors

select count(*) from dl_deals;
select count(*) from dl_deals where last_modified < to_date('12-31-2013', 'mm-dd-yyyy');

spool off;



