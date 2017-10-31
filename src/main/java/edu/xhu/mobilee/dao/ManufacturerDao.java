package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.ManufacturerEntity;

import java.util.List;

public interface ManufacturerDao {

    ManufacturerEntity findManufacturerById(long id);

    int updateManufacturerById(ManufacturerEntity manufacturerEntity);

    int deleteManufacturer(List<String> id);
}
