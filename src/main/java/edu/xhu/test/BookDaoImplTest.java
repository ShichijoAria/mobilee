package edu.xhu.test;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.sql.DataSource;

public class BookDaoImplTest
{
    private ApplicationContext context=null;
    private UserService userService =null;
    
    {
         context= new ClassPathXmlApplicationContext("spring.xml");
         userService =context.getBean(UserService.class);
    }

    @Test
    public void test2()
    {
        UserEntity userEntity= userService.findUserById(1);
        System.out.println(userEntity);
    }

}