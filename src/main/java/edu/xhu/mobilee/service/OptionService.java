package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.entity.OptionEntity;
import edu.xhu.mobilee.entity.SaleEntity;

import java.util.HashMap;
import java.util.List;

public interface OptionService {
    List<OptionEntity> getManufacturer();

    List<MobilePhoneEntity> getMobilePhone();

    List<SaleEntity> getSale();
}
