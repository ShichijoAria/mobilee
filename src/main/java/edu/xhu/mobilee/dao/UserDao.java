package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.UserEntity;

public interface UserDao {

    public UserEntity findUserById(long id);

}
