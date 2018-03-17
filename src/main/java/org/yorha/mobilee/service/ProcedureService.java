package org.yorha.mobilee.service;

import java.util.Map;

public interface ProcedureService {

    Map<String, Object> pagedQuery(Map<String, Object> paramMap);

}
