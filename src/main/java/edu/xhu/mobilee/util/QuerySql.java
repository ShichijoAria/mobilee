package edu.xhu.mobilee.util;

public interface QuerySql {
    String pagination="SELECT * FROM(SELECT U.*, ROWNUM RN FROM (SELECT * FROM TABLENAME) U WHERE ROWNUM <= ? )WHERE RN >= ? ";
}
