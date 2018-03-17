package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.MobilePhoneEntity;
import org.yorha.mobilee.entity.OptionEntity;
import org.yorha.mobilee.entity.SaleEntity;

import java.util.List;

public interface OptionService {
    List<OptionEntity> getManufacturer();

    List<MobilePhoneEntity> getMobilePhone();

    List<SaleEntity> getSale();
}
