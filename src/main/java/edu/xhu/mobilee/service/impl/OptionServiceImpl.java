package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.OptionDao;
import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.entity.OptionEntity;
import edu.xhu.mobilee.entity.SaleEntity;
import edu.xhu.mobilee.service.OptionService;
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
