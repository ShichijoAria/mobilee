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
        map.put("commentAndCollection",adminDao.getCommentAndCollection());
        return map;
    }

    @Override
    public AdminEntity adminLogin(AdminEntity adminEntity) {
        if (adminEntity.getName()!=null)
            return adminDao.adminLogin(adminEntity.getName(),adminEntity.getPassword(),0);
        else if (adminEntity.getPhone()!=null)
            return adminDao.adminLogin(adminEntity.getPhone(),adminEntity.getPassword(),0);
        else
            return adminDao.adminLogin(adminEntity.getEmail(),adminEntity.getPassword(),0);
    }

}
