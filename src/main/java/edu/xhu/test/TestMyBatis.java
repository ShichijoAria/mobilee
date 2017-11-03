package edu.xhu.test;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSON;
import edu.xhu.mobilee.dao.ManufacturerDao;
import edu.xhu.mobilee.dao.OptionDao;
import edu.xhu.mobilee.dao.ProcedureDao;
import edu.xhu.mobilee.dao.UserDao;
import edu.xhu.mobilee.entity.ManufacturerEntity;
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
    private ManufacturerDao manufacturerDao = null;
    @Resource
    private OptionDao optionDao;

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
        System.out.println(1);
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

}  