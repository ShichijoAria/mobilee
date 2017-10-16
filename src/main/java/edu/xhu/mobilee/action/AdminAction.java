package edu.xhu.mobilee.action;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.service.AdminService;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

public class AdminAction implements SessionAware{

    @Autowired
    private AdminService adminService;
    private AdminEntity adminEntity;
    private Map<String,Object> dataMap;
    private Map session;

    public String index(){
        adminEntity=new AdminEntity();
        return "success";
    }

    public String login() {
        dataMap = new HashMap<String, Object>();
        boolean flag=false;
        String msg;
        if(adminEntity==null){
            msg="非法的数据";
        }else if(adminEntity.getPassword()!=null&&adminEntity.getPassword().trim().length()<6){
            msg="管理员密码不应少于6位";
        }else {
            AdminEntity temp=adminService.findAdminById(adminEntity.getId());
            if(temp!=null) {
                String password=temp.getPassword();
                if (password != null && password.equals(adminEntity.getPassword())) {
                    flag=true;
                }
            }
            if(flag){
                this.session.put("USER_ID",adminEntity.getId());
                this.session.put("USER_NAME",temp.getName());
                this.session.put("USER_PASSWORD",adminEntity.getPassword());
                msg="success";
            }else {
                msg="用户名或密码不正确";
            }
        }
        dataMap.put("msg", msg);
        return "success";
    }

    public String welcome(){
        return "success";
    }

    public AdminEntity getAdminEntity() {
        return adminEntity;
    }

    public void setAdminEntity(AdminEntity adminEntity) {
        this.adminEntity = adminEntity;
    }

    public Map<String, Object> getDataMap() {
        return dataMap;
    }

    @Override
    public void setSession(Map session) {
        this.session=session;
    }
}
