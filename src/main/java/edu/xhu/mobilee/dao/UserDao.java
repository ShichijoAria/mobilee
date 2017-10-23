package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.UserEntity;

import java.util.ArrayList;
import java.util.List;

public interface UserDao {

    UserEntity findUserById(long id);

    List<UserEntity> selectUserPage(String hql);

    void saveUser(UserEntity userEntity);

    void deleteUser(long [] list);
}
