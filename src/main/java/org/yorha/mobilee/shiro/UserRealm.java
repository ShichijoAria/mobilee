package org.yorha.mobilee.shiro;

import org.yorha.mobilee.entity.UserEntity;
import org.yorha.mobilee.service.TouristService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

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
        roles.add("frontUser");
        info.setRoles(roles);
        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UserEntity principal = null;
        principal = touristService.findUserByLoginInfo(authenticationToken.getPrincipal().toString());
        if(principal == null)
            throw new UnknownAccountException("用户不存在或密码错误！");
        //当前 Realm 的 name
        String realmName = this.getName();
        return new SimpleAuthenticationInfo(principal, principal.getPassword()
                , ByteSource.Util.bytes(String.valueOf(principal.getId())+"user"),realmName);
    }
}
