package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.UserEntity;

import java.util.List;
import java.util.Map;

public interface UserService {

    UserEntity findUserById(long id);

    Map<String,Object> selectUser(Map<String, Object> paramMap);

    int updateUserById(UserEntity userEntity);

    void deleteUser(List<String> id);
}
