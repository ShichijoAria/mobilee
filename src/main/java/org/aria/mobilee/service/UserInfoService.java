package org.aria.mobilee.service;

import java.util.List;
  
import org.aria.mobilee.entity.UserInfo;
  

  
public interface UserInfoService {  
    UserInfo load(Integer id);  
  
    UserInfo get(Integer id);  
  
    List<UserInfo> findAll();  
  
    void persist(UserInfo entity);  
  
    Integer save(UserInfo entity);  
  
    void saveOrUpdate(UserInfo entity);  
  
    void delete(Integer id);  
  
    void flush();  
}  