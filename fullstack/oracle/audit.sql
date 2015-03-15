show parameter audit;

--if the below alter does not work then put audit_trail = db_extended in the init.ora file
ALTER SYSTEM SET audit_trail=db_extended SCOPE=BOTH;

-- the db needs to be shutdown and started.

--enable auditing by running
audit all by xtra;
AUDIT SELECT TABLE, UPDATE TABLE, INSERT TABLE, DELETE TABLE BY XTRA BY ACCESS;
AUDIT EXECUTE PROCEDURE BY XTRA BY ACCESS;


--Once the audit statements are run, you can find the audit logs in db_audit_trail;

select returncode, object_name from dba_audit_Trail where username='XTRA_DTC' and owner = 'XTRA_DTC'  where returncode <> 0;

--use returncode=942 to filter only the object not found errors. It will capture all the objects that are not found in the db. eg, if table1 does not exist, you can check obj_name column.

SELECT
	A.FIRST,
	B.SECOND
FROM
	TABLE1 A,
	TABLE2 B
WHERE
	A.THIRD = B.THIRD;

--this will stop all kinds of auditing;
noaudit all;
NOAUDIT SELECT TABLE, INSERT TABLE, DELETE TABLE, EXECUTE PROCEDURE;
NOAUDIT session;

--this will remove all audit logs. This needs to be done regularly otherwise the sys tablespace will be full.
delete from sys.aud$;



