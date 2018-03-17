package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.OptionDao;
import org.yorha.mobilee.entity.MobilePhoneEntity;
import org.yorha.mobilee.entity.OptionEntity;
import org.yorha.mobilee.entity.SaleEntity;
import org.yorha.mobilee.service.OptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("optionService")
public class OptionServiceImpl implements OptionService{
    @Autowired
    private OptionDao optionDao;

    @Override
    public List<OptionEntity> getManufacturer() {
        return optionDao.getManufacturer();
    }

    @Override
    public List<MobilePhoneEntity> getMobilePhone() {
        return optionDao.getMobilePhone();
    }

    @Override
    public List<SaleEntity> getSale() {
        return optionDao.getSale();
    }
}
