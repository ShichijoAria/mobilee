package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.ProcedureDao;
import org.yorha.mobilee.service.ProcedureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("ProcedureService")
public class ProcedureServiceImpl implements ProcedureService {

    @Autowired
    private ProcedureDao procedureDao;

    @Override
    public Map<String, Object> pagedQuery(Map<String, Object> paramMap) {
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("list",procedureDao.pagedQuery(paramMap));
        //total为总页数
        map.put("total",paramMap.get("pageCount"));
        //page为当前页
        map.put("page",paramMap.get("pageIndex"));
        map.put("msg","success");
        return map;
    }
}
