package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.UserDao;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Format;
import edu.xhu.mobilee.util.Proper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("userService")
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;


    public UserEntity findUserById(long id) {
        return userDao.findUserById(id);
    }

    @Override
    public Map<String,Object> selectUser(int page,String hql) {
        int pageSize=Proper.pageSize();
        Map<String,Object> map=new HashMap<String, Object>();
        List<UserEntity> userEntityList=userDao.selectUserPage(hql);
        List<Object> subList=Format.sublist(page,userEntityList);
        map.put("total",userEntityList.size()/pageSize+1);
        map.put("page",page);
        map.put("list",subList);
        map.put("msg","success");
        return map;
    }

    @Override
    public void saveUser(UserEntity userEntity) {
        userDao.saveUser(userEntity);
    }

    @Override
    public void deleteUser(long[] list) {
        userDao.deleteUser(list);
    }
}
