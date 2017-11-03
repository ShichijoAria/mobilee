package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.MobilePhoneEntity;

import java.util.List;

public interface MobilePhoneDao {

    MobilePhoneEntity findMobilePhoneById(long id);

    int updateMobilePhoneById(MobilePhoneEntity mobilePhoneEntity);

    int deleteMobilePhone(List<String> id);

    long insertMobilePhone(MobilePhoneEntity mobilePhoneEntity);

}
