package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.AdminEntity;

import java.util.Map;


public interface AdminService {

    AdminEntity findAdminById(long id);

    int updateAdminById(AdminEntity adminEntity);

    Map<String,Object> getStatistics();

    AdminEntity adminLogin(AdminEntity adminEntity);

    AdminEntity findAdminByLoginInfo(String temp);
}
