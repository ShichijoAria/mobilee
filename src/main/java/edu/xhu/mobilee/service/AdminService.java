package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.AdminEntity;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;


public interface AdminService {

    AdminEntity findAdminById(long id);

    int updateAdminById(AdminEntity adminEntity);

    Map<String,Object> getStatistics();
}
