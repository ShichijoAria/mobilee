package edu.xhu.mobilee.shiro;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.service.AdminService;
import edu.xhu.mobilee.util.Reflect;
import edu.xhu.mobilee.util.Validator;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.lang.reflect.InvocationTargetException;

public class AdminRealm extends AuthorizingRealm {
    @Autowired
    private AdminService adminService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        AdminEntity principal = null;
        principal = adminService.findAdminByLoginInfo(authenticationToken.getPrincipal().toString());
        if(principal == null)
            throw new UnknownAccountException("管理员不存在或密码错误！");
        //当前 Realm 的 name
        String realmName = this.getName();
        return new SimpleAuthenticationInfo(principal, principal.getPassword()
                , ByteSource.Util.bytes(String.valueOf(principal.getId())+"user"),realmName);
    }
}
