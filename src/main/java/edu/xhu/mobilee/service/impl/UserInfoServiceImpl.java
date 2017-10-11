package edu.xhu.mobilee.service.impl;

import java.util.List;

import edu.xhu.mobilee.dao.UserInfoDao;
import edu.xhu.mobilee.entity.UserInfo;
import edu.xhu.mobilee.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;  
  
/** 
 * 创建时间：2015-2-13 下午1:03:47 
 *  
 * @author andy 
 * @version 2.2 描述： 
 */  
@Service("userInfoService")  
public class UserInfoServiceImpl implements UserInfoService {

    @Autowired
    private UserInfoDao userInfoDao;

    public UserInfo load(Integer id) {
    return null;
    }

    public UserInfo get(Integer id) {
    return userInfoDao.get(id);
    }

    public List<UserInfo> findAll() {
    return userInfoDao.findAll();
    }

    public void persist(UserInfo entity) {
    userInfoDao.persist(entity);
    }

    public Integer save(UserInfo entity) {
    return userInfoDao.save(entity);
    }

    public void saveOrUpdate(UserInfo entity) {
    userInfoDao.saveOrUpdate(entity);
    }

    public void delete(Integer id) {
    userInfoDao.delete(id);
    }

    public void flush() {
    userInfoDao.flush();
    }

}  