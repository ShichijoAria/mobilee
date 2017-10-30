package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.ProcedureDao;
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
    @Autowired
    private ProcedureDao procedureDao;


    public UserEntity findUserById(long id) {
        return userDao.findUserById(id);
    }

    @Override
    public Map<String,Object> selectUser(Map<String, Object> paramMap) {
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("list",procedureDao.pagedQuery(paramMap));
        //total为总页数
        map.put("total",paramMap.get("pageCount"));
        //page为当前页
        map.put("page",paramMap.get("pageIndex"));
        map.put("msg","success");
        return map;
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
