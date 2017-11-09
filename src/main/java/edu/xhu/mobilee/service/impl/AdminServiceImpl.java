package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.AdminDao;
import edu.xhu.mobilee.dao.ProcedureDao;
import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;


@Service("adminService")
public class AdminServiceImpl implements AdminService{

    @Autowired
    private AdminDao adminDao;

    //登陆用户密码校验
    public AdminEntity findAdminById(long id) {
        return adminDao.findAdminById(id);
    }

    @Override
    public int updateAdminById(AdminEntity adminEntity) {
        return adminDao.updateAdminById(adminEntity);
    }

    @Override
    public Map<String, Object> getStatistics() {
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("countTableRows",adminDao.CountTableRows());
        map.put("loginLog",adminDao.getLoginLog());
        map.put("maxTenComment",adminDao.getMaxTenComment());
        return map;
    }

}
