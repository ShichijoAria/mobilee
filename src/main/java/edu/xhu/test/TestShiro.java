package edu.xhu.test;


import edu.xhu.mobilee.dao.AdminDao;
import edu.xhu.mobilee.dao.UserDao;
import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.UserEntity;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml","classpath:spring.xml"})
public class TestShiro {

    @Resource
    private UserDao userDao=null;
    @Resource
    private AdminDao adminDao=null;

    public static String getNewPassword(String credentials,String userName){
        String hashAlgorithmName = "MD5";
        int hashIterations = 1024;
        System.out.println(userName+"::"+credentials);
        ByteSource credentialsSalt = ByteSource.Util.bytes(userName);
        Object obj = new SimpleHash(hashAlgorithmName, credentials, credentialsSalt, hashIterations);
        System.out.println(obj.toString());
        return obj.toString();
    }

    /*
    * 测试加密算法
    * */
    @Test
    public void test1(){
        String hashAlgorithmName = "MD5";
        String credentials = "123456";
        int hashIterations = 1024;
        ByteSource credentialsSalt = ByteSource.Util.bytes("user");
        Object obj = new SimpleHash(hashAlgorithmName, credentials, credentialsSalt, hashIterations);
        System.out.println(obj);
    }

    /*
    * 讲数据库里的密码全部md5加密
    * */
    @Test
    public void test2(){
        for (int i=1;i<21;i++){
            if(i==11)
                continue;
            UserEntity userEntity=userDao.findUserById(i);
            userEntity.setPassword(getNewPassword(userEntity.getPassword(),String.valueOf(userEntity.getId())+"user"));
            userDao.updateUserById(userEntity);
        }

    }

    @Test
    public void test3(){
        for (int i=1;i<4;i++){
            AdminEntity adminEntity=adminDao.findAdminById(i);
            adminEntity.setPassword(getNewPassword(adminEntity.getPassword(),String.valueOf(adminEntity.getId())+"admin"));
            adminDao.updateAdminById(adminEntity);
        }

    }
}
