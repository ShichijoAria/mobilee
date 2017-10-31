package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.ManufacturerDao;
import edu.xhu.mobilee.dao.ProcedureDao;
import edu.xhu.mobilee.service.ManufacturerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("manufacturerService")
public class ManufacturerServiceImpl implements ManufacturerService{
    @Autowired
    private ManufacturerDao manufacturerDao;
    @Autowired
    private ProcedureDao procedureDao;

    @Override
    public Map<String, Object> selectManufacturer(Map<String, Object> paramMap) {
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("list",procedureDao.pagedQuery(paramMap));
        map.put("msg","success");
        return map;
    }
}
