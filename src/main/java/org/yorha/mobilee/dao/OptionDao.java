package org.yorha.mobilee.dao;


import org.yorha.mobilee.entity.*;

import java.util.List;

public interface OptionDao {

    List<OptionEntity> getManufacturer();

    List<UserEntity> getUser();

    List<AdminEntity> getAdmin();

    List<MobilePhoneEntity> getMobilePhone();

    List<SaleEntity> getSale();

}
