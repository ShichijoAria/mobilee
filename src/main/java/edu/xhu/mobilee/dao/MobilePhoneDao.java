package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.MobilePhoneEntity;

import java.util.HashMap;
import java.util.List;

public interface MobilePhoneDao {

    MobilePhoneEntity findMobilePhoneById(long id);

    int updateMobilePhoneById(MobilePhoneEntity mobilePhoneEntity);

    int deleteMobilePhone(List<String> id);

    long insertMobilePhone(MobilePhoneEntity mobilePhoneEntity);

    List<Object> selectMobile();

    MobilePhoneEntity findMobilePhoneForTouristById(long id);

    List<HashMap> selectNewMobilePhone();
}
