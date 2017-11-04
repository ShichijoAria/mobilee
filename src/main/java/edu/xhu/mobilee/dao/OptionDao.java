package edu.xhu.mobilee.dao;


import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.OptionEntity;
import edu.xhu.mobilee.entity.UserEntity;

import java.util.List;

public interface OptionDao {

    List<OptionEntity> getManufacturer();

    List<UserEntity> getUser();

    List<AdminEntity> getAdmin();

}
