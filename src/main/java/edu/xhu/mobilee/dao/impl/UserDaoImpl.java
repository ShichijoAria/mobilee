package edu.xhu.mobilee.dao.impl;

import edu.xhu.mobilee.dao.UserDao;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.util.QuerySql;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("userDao")
public class UserDaoImpl implements UserDao{

    @Autowired
    private SessionFactory sessionFactory;

    //获取和当前线程绑定的session
    private Session getSession()
    {
        return sessionFactory.getCurrentSession();
    }

    public UserEntity findUserById(long id)
    {
        return (UserEntity) this.getSession().get(UserEntity.class, id);
    }

    @Override
    public List<UserEntity> selectUserPage(int start,int end) {
        String sql=QuerySql.pagination.replaceAll("TABLENAME","T_USER");
        List<UserEntity> userEntityList = this.getSession()
                .createNativeQuery(sql,UserEntity.class).setParameter(1,10).setParameter(2,0).list();
        return userEntityList;
    }

}
