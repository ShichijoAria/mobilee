package edu.xhu.mobilee.util;

import edu.xhu.mobilee.shiro.CustomizedToken;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;

import java.util.HashMap;
import java.util.Map;

public class ShiroMessage {

    public static Map login(Subject subject,String name,String password,String loginType){
        Map<String,Object> dataMap = new HashMap<String, Object>();
        String msg="success";
        if(name!=null) {
            if (password != null && password.trim().length() < 6) {
                msg = "用户密码不应少于6位";
            } else {
                if (!ShiroMessage.isLogin(subject)) {
                    CustomizedToken customizedToken = new CustomizedToken(name, password.toCharArray(), loginType);
                    try {
                        subject.login(customizedToken);
                    } catch (UnknownAccountException ex) {
                        msg = "用户不存在或者密码错误！";
                    } catch (IncorrectCredentialsException ex) {
                        msg = "用户不存在或者密码错误！";
                    } catch (AuthenticationException ex) {
                        ex.printStackTrace(); // 自定义报错信息
                        msg = "AuthenticationException";
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        msg = "内部错误，请重试！";
                    }
                }

            }
        }else {
            msg="不合法的数据";
        }
        dataMap.put("msg", msg);
        return dataMap;
    }

    public static boolean isLogin(Subject subject) {
        if (subject.isAuthenticated()) {
            return true; // 参数未改变，无需重新登录，默认为已经登录成功
        }
        return false; // 需要重新登陆
    }
}
