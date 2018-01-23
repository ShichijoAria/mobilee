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
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.lang.reflect.InvocationTargetException;
import java.util.HashSet;
import java.util.Set;

public class UserRealm extends AuthorizingRealm {
    @Autowired
    private TouristService touristService;

    public static final String SESSION_USER_KEY = "principal";

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        Set<String> roles=new HashSet<String>();
        roles.add("user");
        info.setRoles(roles);
        return info;
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
        Session session=SecurityUtils.getSubject().getSession();
        UserEntity principal = touristService.userLogin(userLogin);
        if(principal == null)
            throw new UnknownAccountException("用户不存在或密码错误！");
        else {
            principal.setPassword(null);
            session.setAttribute(SESSION_USER_KEY,principal);
        }
        //当前 Realm 的 name
        String realmName = this.getName();
        return new SimpleAuthenticationInfo(principal, userLogin.getPassword(), realmName);
    }
}
