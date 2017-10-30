package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.AdminEntity;

import java.util.Map;

public interface AdminService {

    AdminEntity findAdminById(long id);

    Map<String,Object> selectAdmin(Map<String, Object> paramMap);

    int updateAdminById(AdminEntity adminEntity);
}
