package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.AdminEntity;

import java.util.Map;

public interface AdminDao {

    AdminEntity findAdminById(long id);

    int updateAdminById(AdminEntity adminEntity);

    Map<String,Object> CountTableRows();
}
