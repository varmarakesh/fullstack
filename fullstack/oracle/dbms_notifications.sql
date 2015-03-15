DECLARE
  l_regds     SYS.CHNF$_REG_INFO;
  l_regid     NUMBER;
  l_qosflags  NUMBER;
  v_count pls_integer;
BEGIN
  l_qosflags := DBMS_CHANGE_NOTIFICATION.QOS_RELIABLE  +
                DBMS_CHANGE_NOTIFICATION.QOS_ROWIDS;
  l_regds := SYS.CHNF$_REG_INFO ('tables_changed_chnt', l_qosflags, 0,0,0);
  l_regid := DBMS_CHANGE_NOTIFICATION.new_reg_start (l_regds);
  select count(*) into v_count from t1;
  select count(*) into v_count from t2;
  DBMS_CHANGE_NOTIFICATION.reg_end;
END;
/: