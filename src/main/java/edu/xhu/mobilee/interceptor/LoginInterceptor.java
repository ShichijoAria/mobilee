package edu.xhu.mobilee.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.service.AdminService;
import edu.xhu.mobilee.util.Format;
import org.springframework.beans.factory.annotation.Autowired;

public class LoginInterceptor extends AbstractInterceptor{

    @Autowired
    private AdminService adminService;

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        String actionName=actionInvocation.getProxy().getActionName();
        if("login".equals(actionName)||"welcome".equals(actionName)){//登录操作
            return actionInvocation.invoke();
        }
        Object obj=actionInvocation.getInvocationContext().getSession().get("USER_ID");
        long id=-1;
        if(obj!=null)
            id=(long)obj;
        String password=(String) actionInvocation.getInvocationContext().getSession().get("USER_PASSWORD");
        AdminEntity temp=adminService.findAdminById(id);
        if(temp!=null) {
            if (password != null && password.equals(temp.getPassword())) {
                return actionInvocation.invoke();
            }
        }
        return "illegal";
    }
}
