package org.yorha.mobilee.dao;

import org.yorha.mobilee.entity.ManufacturerEntity;

import java.util.List;

public interface ManufacturerDao {

    ManufacturerEntity findManufacturerById(long id);

    int updateManufacturerById(ManufacturerEntity manufacturerEntity);

    int deleteManufacturer(List<String> id);

    long insertManufacturer(ManufacturerEntity manufacturerEntity);
}
