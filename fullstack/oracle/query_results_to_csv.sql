
declare
        v_output utl_file.file_type;
        v_cursor integer default dbms_sql.open_cursor;
        v_columnValue varchar2(4000);
        v_status integer;
        v_colCount integer;
        v_delimiter varchar2(1) := '|';
        v_descTbl dbms_sql.desc_tab;
        v_filename varchar2(40) := 'drs_partners_info.csv';
        v_query varchar2(2000) := q'[SELECT CP_ID, FUSION_PROD_CD,LGCY_ID,CREATED_TS,STUS_CD,UPDTD_TS FROM CP.PARTNER_PROFILE where lgcy_id in ('EBS', 'DLM', 'DLR','ATN', 'NDG')]';
        v_dir varchar2(20) := 'DATA_PUMP_DIR';
        begin
            v_output := utl_file.fopen(v_dir, v_filename, 'w', 32627);
            --execute immediate 'alter session set nls_date_format=''dd-mon-yyyy hh24:mi:ss''
            dbms_sql.parse(v_cursor, v_query, dbms_sql.native);
            dbms_sql.describe_columns(v_cursor, v_colCount, v_descTbl);
            for i in 1 .. v_colCount loop
                utl_file.put(v_output, v_delimiter||v_descTbl(i).col_name);
                dbms_sql.define_column( v_cursor, i, v_columnValue, 4000 );
            end loop;
            utl_file.new_line(v_output);
            v_status := dbms_sql.execute(v_cursor);
            while (dbms_sql.fetch_rows(v_cursor) > 0) loop
                 v_delimiter := '';
                 for i in 1 .. v_colCount loop
                    dbms_sql.column_value(v_cursor, i, v_columnValue);
                    utl_file.put(v_output, v_delimiter||v_columnValue);
                    v_delimiter := '|';
                 end loop;
                 utl_file.new_line(v_output);
            end loop;
            dbms_sql.close_cursor(v_cursor);
            utl_file.fclose(v_output);
        exception
            when others then
                if utl_file.is_open(v_output) then
                    utl_file.fclose(v_output);
                end if;
                raise;
end;
/
show errors

