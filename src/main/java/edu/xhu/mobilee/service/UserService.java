package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.UserEntity;

import java.util.List;

public interface UserService {

    public UserEntity findUserById(long id);

    public List<UserEntity> selectUser(int page);
}
