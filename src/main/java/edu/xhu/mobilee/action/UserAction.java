package edu.xhu.mobilee.action;

import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Format;
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
        page=page>0?page:1;
        dataMap = new HashMap<String, Object>();
        dataMap = userService.selectUser(page);
        return "success";
    }

    public String index(){
        HttpServletRequest request = ServletActionContext.getRequest();
        Map<String,Object> head=new LinkedHashMap<String, Object>();
        Map<String,Object> id=new HashMap<String,Object>();
        id.put("value","用户编号");
        head.put("id",id);
        head.put("name","用户名称");
        head.put("gender","用户性别");
        head.put("created","注册时间");
        request.setAttribute("title","网站用户");
        request.setAttribute("extra","Website User");
        request.setAttribute("icon","user");
        request.setAttribute("namespace","user");
        request.setAttribute("head",head);
        return "success";
    }

    public Map<String, Object> getDataMap() {
        return dataMap;
    }

}
