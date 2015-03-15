select
	distinct client_version,
	machine
from
	gv$session_connect_info client_info,
	gv$session sess
where
	client_info.inst_id = sess.inst_id and
	client_info.sid = sess.sid and
	client_info.serial# = sess.serial#;

	62920343