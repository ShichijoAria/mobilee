package org.aria.mobilee.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.aria.mobilee.entity.UserInfo;
import org.aria.mobilee.service.UserInfoService;
import org.apache.log4j.Logger;  
import org.apache.struts2.ServletActionContext;  
import org.apache.struts2.convention.annotation.Namespace;  
import org.springframework.beans.factory.annotation.Autowired;  
  
import com.opensymphony.xwork2.ActionSupport;  
import com.opensymphony.xwork2.ModelDriven;  
import com.opensymphony.xwork2.Preparable;  
  
/** 
 * 创建时间：2015-2-13 下午2:49:22 
 *  
 * @author andy 
 * @version 2.2 描述： user的Action 
 */  
@Namespace("/user")
@Results( { @Result(name = "success", location = "/user/userinfo.jsp"),
        @Result(name = "error", location = "/error.jsp") })
public class UserinfoAction extends ActionSupport implements  
        ModelDriven<UserInfo>, Preparable {  
    private static final long serialVersionUID = -2301203156032690317L;  
  
    private static final Logger LOGGER = Logger.getLogger(UserinfoAction.class);  
    private Integer id;  
    private UserInfo userInfo;  
    private List<UserInfo> userInfos;  
  
    @Autowired
    private UserInfoService userInfoService;  
  
    public Integer getId() {  
        return id;  
    }  
  
    public void setId(Integer id) {  
        this.id = id;  
    }  
  
    public UserInfo getUserInfo() {  
        return userInfo;  
    }  
  
    public void setUserInfo(UserInfo userInfo) {  
        this.userInfo = userInfo;  
    }  
  
    public List<UserInfo> getUserInfos() {  
        return userInfos;  
    }  
  
    public void setUserInfos(List<UserInfo> userInfos) {  
        this.userInfos = userInfos;  
    }  

    public UserInfo getModel() {  
        if (null != id) {  
            userInfo = userInfoService.get(id);  
        } else {  
            userInfo = new UserInfo();  
        }  
        return userInfo;  
    }  
  
    @Override  
    public String execute() throws Exception {  
        LOGGER.info("查询所有用户");  
        userInfos = userInfoService.findAll();  
        return SUCCESS;  
          
    }  
  
    public void detail() {  
        String id = ServletActionContext.getRequest().getParameter("id");  
        LOGGER.info("查看用户详情：" + id);  
        userInfo = userInfoService.get(Integer.valueOf(id));
  
    }  

    public void prepare() throws Exception {  
          
    }  
  
}  