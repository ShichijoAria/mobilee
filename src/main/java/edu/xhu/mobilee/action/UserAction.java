package edu.xhu.mobilee.action;

import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Field;
import edu.xhu.mobilee.util.Format;
import edu.xhu.mobilee.util.GenderEnum;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class UserAction {

    @Autowired
    private UserService userService;
    private Map<String,Object> dataMap;


    public String list(){
        HttpServletRequest request = ServletActionContext.getRequest();
        int page= Format.stringToInt(request.getParameter("page"));
        String hql=Field.getHql("user",request);
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

    public Map<String, Object> getDataMap() {
        return dataMap;
    }

}
