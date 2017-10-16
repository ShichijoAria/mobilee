package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.AdminDao;
import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl implements AdminService{

    @Autowired
    private AdminDao adminDao;

    //登陆用户密码校验
    public AdminEntity findAdminById(long id) {
        return adminDao.findAdminById(id);
    }
}
