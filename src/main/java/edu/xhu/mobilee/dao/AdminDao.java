package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.AdminEntity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AdminDao {

    AdminEntity findAdminById(long id);

    int updateAdminById(AdminEntity adminEntity);

    Map<String,Object> CountTableRows();

    List<HashMap<String,Object>> getLoginLog();

    List<HashMap<String,Object>> getMaxTenComment();

    List<HashMap<String,Object>> getCommentAndCollection();

    AdminEntity adminLogin(String temp,String password,int type);
}
