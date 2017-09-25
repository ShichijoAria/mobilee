package org.aria.mobilee.dao.impl;

import java.util.List;
  
import org.aria.mobilee.dao.UserInfoDao;
import org.aria.mobilee.entity.UserInfo;
import org.hibernate.Session;  
import org.hibernate.SessionFactory;  
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Repository;  
  

  
@Repository("userInfoDao")  
public class UserInfoDaoImpl implements UserInfoDao {  
  
    @Autowired  
    private SessionFactory sessionFactory;  
  
    private Session getCurrentSession() {  
        return this.sessionFactory.getCurrentSession();  
    }  

    public UserInfo load(Integer id) {  
        return (UserInfo) this.getCurrentSession().load(UserInfo.class, id);  
    }  

    public UserInfo get(Integer id) {  
        return (UserInfo) this.getCurrentSession().get(UserInfo.class, id);  
    }  
  
    @SuppressWarnings("unchecked")
    public List<UserInfo> findAll() {  
        List<UserInfo> userInfos = this.getCurrentSession()
                .createQuery("from UserInfo").list();
        return userInfos;  
    }  

    public void persist(UserInfo entity) {  
        this.getCurrentSession().persist(entity);  
  
    }  

    public Integer save(UserInfo entity) {  
        return (Integer) this.getCurrentSession().save(entity);  
    }  

    public void saveOrUpdate(UserInfo entity) {  
        this.getCurrentSession().saveOrUpdate(entity);  
    }  

    public void delete(Integer id) {  
        UserInfo entity = this.load(id);  
        this.getCurrentSession().delete(entity);  
    }  

    public void flush() {  
        this.getCurrentSession().flush();  
  
    }  
  
}  
