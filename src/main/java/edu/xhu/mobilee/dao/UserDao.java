package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.UserEntity;

import java.util.List;

public interface UserDao {

    public UserEntity findUserById(long id);

    public List<UserEntity> selectUserPage(int start,int end);
}
