package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.MobilePhoneEntity;

import java.util.List;

public interface MobilePhoneService {
    MobilePhoneEntity findMobilePhoneById(long id);

    int updateMobilePhoneById(MobilePhoneEntity mobilePhoneEntity);

    int deleteMobilePhone(List<String> id);

    long insertMobilePhone(MobilePhoneEntity mobilePhoneEntity);
}
