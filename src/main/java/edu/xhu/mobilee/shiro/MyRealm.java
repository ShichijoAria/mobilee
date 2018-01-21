package edu.xhu.mobilee.shiro;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.AdminService;
import edu.xhu.mobilee.service.TouristService;
import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Format;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {
    @Autowired
    private TouristService touristService;
    @Autowired
    private AdminService adminService;

    public static final String SESSION_USER_KEY = "secret";

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 把token转换成User对象
        UserEntity userLogin = tokenToUser((UsernamePasswordToken) authenticationToken);
        // 验证用户是否可以登录
        UserEntity principal = touristService.userLogin(userLogin);
        if(principal == null)
            return null; // 异常处理，找不到数据
        // 设置session
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute(MyRealm.SESSION_USER_KEY, principal);
        //当前 Realm 的 name
        String realmName = this.getName();
        return new SimpleAuthenticationInfo(principal, userLogin.getPassword(), realmName);
    }

    private UserEntity tokenToUser(UsernamePasswordToken authcToken) {
        UserEntity userEntity = new UserEntity();
        userEntity.setId(Format.stringToLong(authcToken.getUsername()));
        userEntity.setPassword(String.valueOf(authcToken.getPassword()));
        return userEntity;
    }
}
