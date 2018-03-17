package org.yorha.mobilee.util;

import org.yorha.mobilee.entity.AdminEntity;
import org.yorha.mobilee.entity.UserEntity;
import org.yorha.mobilee.shiro.CustomizedToken;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Reflect {
    public static Object getEntity(CustomizedToken customizedToken) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        Object object=new Object();
        if(customizedToken.getLoginType().equals("User"))
            object=new UserEntity();
        else
            object=new AdminEntity();
        String temp=customizedToken.getUsername();
        Class clazz=object.getClass();
        Method method=clazz.getDeclaredMethod("setPassword", String.class);
        method.invoke(object, String.valueOf(customizedToken.getPassword()));
        if(Validator.isMobile(temp)) {
            method = clazz.getDeclaredMethod("setPhone", String.class);
            method.invoke(object, temp);
        } else if(Validator.isEmail(temp)){
            method = clazz.getDeclaredMethod("setEmail", String.class);
            method.invoke(object, temp);
        }else {
            method = clazz.getDeclaredMethod("setName", String.class);
            method.invoke(object, temp);
        }
        return object;
    }
}
