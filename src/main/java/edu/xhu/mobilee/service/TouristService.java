package edu.xhu.mobilee.service;

import java.util.Map;

public interface TouristService {

    Map<String,Object> getMobilePhoneDetail(long id,long touristId);

    Map<String,Object> getMobilePhoneIndex();
}
