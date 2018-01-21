package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.UserEntity;

import java.util.Map;

public interface TouristService {

    Map<String,Object> getMobilePhoneDetail(long id,long touristId);

    Map<String,Object> getMobilePhoneIndex();

    long register(UserEntity userEntity);

    UserEntity userLogin(UserEntity userEntity);
}
