package edu.xhu.mobilee.util;

public interface QuerySql {
    String pagination="SELECT * FROM(SELECT U.*, ROW_NUM RN FROM (SELECT * FROM TABLE_NAME) U WHERE ROW_NUM <= ? )WHERE RN >= ? ";
}
