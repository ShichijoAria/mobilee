package edu.xhu.mobilee.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

public class CustomizedToken extends UsernamePasswordToken {

    //区别用户与管理员
    private String loginType;

    public CustomizedToken(final String username, final char[]  password,String loginType) {
        super(username,password);
        this.loginType = loginType;
    }

    public CustomizedToken(final String username, final char[]  password,String loginType,boolean rememberMe) {
        super(username,password,rememberMe);
        this.loginType = loginType;
    }

    public CustomizedToken(final String username, final char[]  password,String loginType,boolean rememberMe,String host) {
        super(username,password,rememberMe,host);
        this.loginType = loginType;
    }

    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }
}