package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.UserEntity;

import java.util.List;

public interface UserService {

    UserEntity findUserById(long id);

    int updateUserById(UserEntity userEntity);

    void deleteUser(List<String> id);
}
