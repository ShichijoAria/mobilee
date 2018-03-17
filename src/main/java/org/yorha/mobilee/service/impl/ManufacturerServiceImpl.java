package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.ManufacturerDao;
import org.yorha.mobilee.entity.ManufacturerEntity;
import org.yorha.mobilee.service.ManufacturerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("manufacturerService")
public class ManufacturerServiceImpl implements ManufacturerService{
    @Autowired
    private ManufacturerDao manufacturerDao;

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

    @Override
    public long insertManufacturer(ManufacturerEntity manufacturerEntity) {
        return manufacturerDao.insertManufacturer(manufacturerEntity);
    }
}
