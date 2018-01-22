package edu.xhu.test;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.util.Field;

import java.sql.Connection;
import java.sql.DriverManager;

public class Test {

    public static void invokeSet(Object object){
        Class clazz=object.getClass();
        System.out.println(clazz);
    }

    public static void main(String args[])
    {
        invokeSet(new AdminEntity());
    }
}

