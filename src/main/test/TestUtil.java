package org.yorha.test;

import org.yorha.mobilee.entity.AdminEntity;
import org.yorha.mobilee.entity.UserEntity;
import org.yorha.mobilee.shiro.CustomizedToken;
import org.yorha.mobilee.util.Reflect;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.lang.reflect.InvocationTargetException;

@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml","classpath:spring.xml"})
public class TestUtil {

    @Test
    public void test1(){
        UserEntity userEntity=null;
        AdminEntity adminEntity=null;
        CustomizedToken customizedToken = new CustomizedToken("1231@515.com", "ssss".toCharArray(),"user");
        try {
            userEntity=(UserEntity)Reflect.getEntity(customizedToken);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        System.out.println(1);
    }

}
