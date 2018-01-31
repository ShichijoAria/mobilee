package org.yorha.test;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSON;
import org.yorha.mobilee.dao.*;
import org.yorha.mobilee.entity.*;
import org.yorha.mobilee.service.CollectionService;
import org.yorha.mobilee.service.MobilePhoneService;
import org.apache.log4j.Logger;
import org.junit.Test;  
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml","classpath:spring.xml"})
  
public class TestMyBatis {  
    private static Logger logger = Logger.getLogger(TestMyBatis.class);  
//  private ApplicationContext ac = null;  
    @Resource  
    private ProcedureDao procedureDao = null;
    @Resource
    private UserDao userDao=null;
    @Resource
    private AdminDao adminDao=null;
    @Resource
    private ManufacturerDao manufacturerDao = null;
    @Resource
    private OptionDao optionDao;
    @Resource
    private CollectionDao collectionDao;
    @Resource
    private CollectionService collectionService;
    @Resource
    private MobilePhoneService mobilePhoneService;

//  @Before  
//  public void before() {  
//      ac = new ClassPathXmlApplicationContext("applicationContext.xml");  
//      userService = (IUserService) ac.getBean("userService");  
//  }  
  
    @Test  
    public void test1() {

        Map<String, Object> paramMap=new HashMap<String,Object>();
        paramMap.put("fields","*");
        paramMap.put("tables","t_manufacturer");
        paramMap.put("where",null);
        paramMap.put("orderBy","id");
        paramMap.put("pageIndex",1);
        paramMap.put("pageSize",5);
        System.out.println("a"+procedureDao.pagedQuery(paramMap));
        System.out.println(1);
        // System.out.println(user.getUserName());  
        // logger.info("值："+user.getUserName());
    }

    @Test
    public void test2(){
        ManufacturerEntity manufacturerEntity=manufacturerDao.findManufacturerById(1);
        System.out.println(manufacturerEntity);
    }

    @Test
    public void test3(){
        ArrayList<String> arrayList=new ArrayList<String>();
        System.out.println(arrayList);
        System.out.println(manufacturerDao.deleteManufacturer(arrayList));
    }

    @Test
    public void test4(){
        System.out.println(JSON.toJSON(optionDao.getManufacturer()));
    }

    @Test
    public void test5(){
        System.out.println(collectionDao.findCollectionById(1));
    }

    @Test
    public void test6(){
        CollectionEntity collectionEntity=collectionService.findCollectionById(1);
        System.out.println(collectionEntity);
    }

    @Test
    public void test7(){
        MobilePhoneEntity mobilePhoneEntity=new MobilePhoneEntity();
        AdminEntity adminEntity=new AdminEntity();
        adminEntity.setId(1);
        ManufacturerEntity manufacturerEntity=new ManufacturerEntity();
        manufacturerEntity.setId(1);
        mobilePhoneEntity.setAuthor(adminEntity);
        mobilePhoneEntity.setManufacturer(manufacturerEntity);
        System.out.println(mobilePhoneService.insertMobilePhone(mobilePhoneEntity));
    }

    @Test
    public void test8(){
        System.out.printf("aaa"+userDao.userLogin("卡fd","123456",0)+"bb");
    }

    @Test
    public void test9(){
        System.out.printf("aaa"+adminDao.adminLogin("龙傲天","123456",0)+"bb");
    }
}  