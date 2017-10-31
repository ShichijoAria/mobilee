package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.ManufacturerEntity;

import java.util.List;
import java.util.Map;

public interface ManufacturerService {

    Map<String,Object> selectManufacturer(Map<String, Object> paramMap);

    ManufacturerEntity findManufacturerById(long id);

    int updateManufacturerById(ManufacturerEntity manufacturerEntity);

    int deleteManufacturer(List<String> id);

}
