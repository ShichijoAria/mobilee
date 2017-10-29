package edu.xhu.test;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.util.Field;

import java.sql.Connection;
import java.sql.DriverManager;

public class Test {

    public static void main(String args[])
    {

        String url = "jdbc:mysql://localhost/mysql";
        String driver = "com.mysql.jdbc.Driver";
        try{
            Class.forName(driver);
        }catch(Exception e){
            System.out.println("无法加载驱动");
        }

        try {
            Connection con = DriverManager.getConnection(url,"root","qwerdf");
            if(!con.isClosed())
                System.out.println("success");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

