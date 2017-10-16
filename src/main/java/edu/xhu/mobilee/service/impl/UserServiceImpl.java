package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.UserDao;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
@Component("config")
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;

    @Value("${pageSize}")
    private int size;

    public UserEntity findUserById(long id) {
        return userDao.findUserById(id);
    }

    @Override
    public List<UserEntity> selectUser(int page) {
        int start=(page-1)*size+1;
        int end=(page-1)*size;
        return userDao.selectUserPage(start,end);
    }
}
