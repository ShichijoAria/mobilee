package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.UserEntity;

import java.util.Map;

public interface TouristService {

    Map<String,Object> getMobilePhoneDetail(long id,long touristId);

    Map<String,Object> getMobilePhoneIndex();

    long register(UserEntity userEntity);

    UserEntity findUserByLoginInfo(String temp);
}
