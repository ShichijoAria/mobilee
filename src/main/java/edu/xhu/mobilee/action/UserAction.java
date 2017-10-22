package edu.xhu.mobilee.action;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Field;
import edu.xhu.mobilee.util.Format;
import edu.xhu.mobilee.util.GenderEnum;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class UserAction implements SessionAware{

    @Autowired
    private UserService userService;
    private UserEntity userEntity;
    private Map<String,Object> dataMap;
    private Map session;

    public String info(){
        dataMap = new HashMap<String, Object>();
        if(userEntity!=null) {
            UserEntity temp=userService.findUserById(userEntity.getId());
            this.session.put("user"+userEntity.getId(),temp);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return "success";
    }

    public String list(){
        HttpServletRequest request = ServletActionContext.getRequest();
        int page= Format.stringToInt(request.getParameter("page"));
        String hql=Field.getHql("User",request);
        page=page>0?page:1;
        dataMap = new HashMap<String, Object>();
        dataMap = userService.selectUser(page,hql);
        return "success";
    }

    public String index(){
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("fields",Field.textField("user"));
        return "success";
    }

    public String save(){
        HttpServletRequest request = ServletActionContext.getRequest();
        Object obj=request.getSession().getAttribute("user"+String.valueOf(request.getParameter("id")));
        if(obj!=null){
            UserEntity user=(UserEntity) obj;
            user= (UserEntity) Field.getObject(user,request);userService.saveUser(user);
        }
        return "success";
    }

    public Map<String, Object> getDataMap() {
        return dataMap;
    }

    public UserEntity getUserEntity() {
        return userEntity;
    }

    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }

    @Override
    public void setSession(Map session) {
        this.session=session;
    }
}
