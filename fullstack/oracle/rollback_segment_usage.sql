select 
	a.os_user_name "OS User",
	a.oracle_username "DB User",
	b.owner "Schema",
	b.object_name "Object Name",
	c.segment_name "RBS",
	d.used_urec "# of Records",
	d.used_ublk "# of Undo Blocks",
	e.sid,
	e.serial#
from 
	gv$locked_object a,
	dba_objects b,
	dba_rollback_segs c,
	gv$transaction d,
	gv$session e
where 
	a.object_id = b.object_id and 
	a.xidusn = c.segment_id and 
	a.xidusn = d.xidusn and 
	a.xidslot = d.xidslot and 
	d.addr = e.taddr; 