package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.UserEntity;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface UserDao {

    UserEntity findUserById(long id);

    int updateUserById(UserEntity userEntity);

    int deleteUser(List<String> id);
}
