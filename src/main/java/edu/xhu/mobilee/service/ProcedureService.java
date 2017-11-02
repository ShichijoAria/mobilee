package edu.xhu.mobilee.service;

import java.util.Map;

public interface ProcedureService {

    Map<String, Object> pagedQuery(Map<String, Object> paramMap);

}
