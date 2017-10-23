package edu.xhu.mobilee.dao.impl;

import edu.xhu.mobilee.dao.UserDao;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.util.QuerySql;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
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
    public List<UserEntity> selectUserPage(String hql) {
        List<UserEntity> userEntityList = this.getSession()
                .createQuery(hql,UserEntity.class).list();
        return userEntityList;
    }

    @Override
    public void saveUser(UserEntity userEntity) {
        getSession().update(userEntity);
    }

    @Override
    public void deleteUser(long [] list) {
        for (int i = 0; i < list.length; i++) {
            UserEntity userEntity=new UserEntity();
            userEntity.setId(list[i]);
            getSession().delete(userEntity);
        }
    }

}
