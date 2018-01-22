package edu.xhu.mobilee.shiro;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.AdminService;
import edu.xhu.mobilee.service.TouristService;
import edu.xhu.mobilee.util.Format;
import edu.xhu.mobilee.util.Reflect;
import edu.xhu.mobilee.util.Validator;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.lang.reflect.InvocationTargetException;

public class UserRealm extends AuthorizingRealm {
    @Autowired
    private TouristService touristService;

    public static final String SESSION_USER_KEY = "secret";

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 把token转换成User对象
        UserEntity userLogin = null;
        try {
            userLogin = (UserEntity) Reflect.getEntity((CustomizedToken)authenticationToken);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        // 验证用户是否可以登录
        UserEntity principal = touristService.userLogin(userLogin);
        if(principal == null)
            throw new UnknownAccountException("用户不存在或密码错误！");
        //当前 Realm 的 name
        String realmName = this.getName();
        return new SimpleAuthenticationInfo(principal, userLogin.getPassword(), realmName);
    }
}
