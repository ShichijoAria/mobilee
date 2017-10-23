package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.UserEntity;

import java.util.List;
import java.util.Map;

public interface UserService {

    UserEntity findUserById(long id);

    Map<String,Object> selectUser(int page,String hql);

    void saveUser(UserEntity userEntity);

    void deleteUser(long[] list);
}
