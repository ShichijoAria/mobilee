package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.UserDao;
import org.yorha.mobilee.entity.UserEntity;
import org.yorha.mobilee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;


    public UserEntity findUserById(long id) {
        return userDao.findUserById(id);
    }

    @Override
    public int updateUserById(UserEntity userEntity) {
        return userDao.updateUserById(userEntity);
    }

    @Override
    public void deleteUser(List<String> id) {
        userDao.deleteUser(id);
    }
}
