package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.ManufacturerDao;
import edu.xhu.mobilee.dao.ProcedureDao;
import edu.xhu.mobilee.entity.ManufacturerEntity;
import edu.xhu.mobilee.service.ManufacturerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
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

    @Override
    public ManufacturerEntity findManufacturerById(long id) {
        return manufacturerDao.findManufacturerById(id);
    }

    @Override
    public int updateManufacturerById(ManufacturerEntity manufacturerEntity) {
        return manufacturerDao.updateManufacturerById(manufacturerEntity);
    }

    @Override
    public int deleteManufacturer(List<String> id) {
        return manufacturerDao.deleteManufacturer(id);
    }
}
