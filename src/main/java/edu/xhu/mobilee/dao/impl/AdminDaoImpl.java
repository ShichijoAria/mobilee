package edu.xhu.mobilee.dao.impl;

import edu.xhu.mobilee.dao.AdminDao;
import edu.xhu.mobilee.entity.AdminEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("adminDao")
public class AdminDaoImpl implements AdminDao{
    @Autowired
    private SessionFactory sessionFactory;

    //获取和当前线程绑定的Seesion
    private Session getSession()
    {
        return sessionFactory.getCurrentSession();
    }

    public AdminEntity findAdminById(long id) {
        return (AdminEntity) this.getSession().get(AdminEntity.class, id);
    }
}
