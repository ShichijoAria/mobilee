package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.MobilePhoneDao;
import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.service.MobilePhoneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("mobilePhoneService")
public class MobilePhoneServiceImpl implements MobilePhoneService{

    @Autowired
    MobilePhoneDao mobilePhoneDao;

    @Override
    public MobilePhoneEntity findMobilePhoneById(long id) {
        return mobilePhoneDao.findMobilePhoneById(id);
    }

    @Override
    public int updateMobilePhoneById(MobilePhoneEntity mobilePhoneEntity) {
        return mobilePhoneDao.updateMobilePhoneById(mobilePhoneEntity);
    }

    @Override
    public int deleteMobilePhone(List<String> id) {
        return mobilePhoneDao.deleteMobilePhone(id);
    }

    @Override
    public long insertMobilePhone(MobilePhoneEntity mobilePhoneEntity) {
        return mobilePhoneDao.insertMobilePhone(mobilePhoneEntity);
    }

}
