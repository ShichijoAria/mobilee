package edu.xhu.mobilee.dao;

import java.util.List;
import java.util.Map;

public interface ProcedureDao {

    List<Object> pagedQuery(Map<String, Object> paramMap);

}
