package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.ManufacturerEntity;

import java.util.List;

public interface ManufacturerService {

    ManufacturerEntity findManufacturerById(long id);

    int updateManufacturerById(ManufacturerEntity manufacturerEntity);

    int deleteManufacturer(List<String> id);

    long insertManufacturer(ManufacturerEntity manufacturerEntity);
}
