package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.AdminEntity;

public interface AdminDao {

    AdminEntity findAdminById(long id);

    int updateAdminById(AdminEntity adminEntity);
}
