package org.yorha.mobilee.dao;

import org.yorha.mobilee.entity.UserEntity;

import java.util.List;

public interface UserDao {

    UserEntity findUserById(long id);

    UserEntity findUserByName(String name);

    UserEntity findUserByEmail(String email);

    UserEntity findUserByPhone(String phone);

    int updateUserById(UserEntity userEntity);

    int deleteUser(List<String> id);

    long insertUser(UserEntity userEntity);

    UserEntity userLogin(String temp,String password,int type);
}
