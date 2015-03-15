select
  table_name,
  constraint_name,
  listagg(column_name,',') within group(order by table_name) as primary_key_columns
from
  dba_cons_columns
where 
  owner='CC3' and 
  (constraint_name, owner) in (select constraint_name, owner from dba_constraints where constraint_type = 'P')
group by
  table_name, constraint_name;