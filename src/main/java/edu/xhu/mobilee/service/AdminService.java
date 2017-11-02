package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.AdminEntity;

import java.util.Map;

public interface AdminService {

    AdminEntity findAdminById(long id);

    int updateAdminById(AdminEntity adminEntity);
}
