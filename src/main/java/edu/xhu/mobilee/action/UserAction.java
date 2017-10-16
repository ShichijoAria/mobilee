package edu.xhu.mobilee.action;

import edu.xhu.mobilee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

public class UserAction {

    @Autowired
    private UserService userService;
    private Map<String,Object> dataMap;

    public String list(){
        dataMap = new HashMap<String, Object>();
        dataMap.put("list", userService.selectUser(1));
        return "success";
    }

    public String index(){
        return "success";
    }

    public Map<String, Object> getDataMap() {
        return dataMap;
    }
}
