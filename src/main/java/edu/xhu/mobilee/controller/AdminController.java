package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.AdminService;
import edu.xhu.mobilee.util.Field;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("admin")
@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping(value = "welcome",method = RequestMethod.GET)
    public String welcome(){
        return "login";
    }


    /**
     * @RequestParam 映射请求参数
     * value 请求参数的参数名 ，作为参数映射名称
     * required 该参数是否必填，默认为true(必填)，当设置成必填时，如果没有传入参数，报错
     * defaultValue 设置请求参数的默认值
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    public Map login(@RequestParam(value = "id",defaultValue = "0") long id, @RequestParam("password") String password, HttpSession session) {
        Map<String,Object> dataMap = new HashMap<String, Object>();
        boolean flag=false;
        String msg;
        if(id>0) {
            if (password != null && password.trim().length() < 6) {
                msg = "管理员密码不应少于6位";
            } else {
                AdminEntity temp = adminService.findAdminById(id);
                if (temp != null && password.equals(temp.getPassword())) {
                    flag = true;
                }
                if (flag) {
                    session.setAttribute("USER_ID", temp.getId());
                    session.setAttribute("USER_NAME", temp.getName());
                    session.setAttribute("USER_PASSWORD", temp.getPassword());
                    msg = "success";
                } else {
                    msg = "用户名或密码不正确";
                }
            }
        }else {
            msg="不合法的数据";
        }
        dataMap.put("msg", msg);
        return dataMap;
    }

    @RequestMapping(value = "index",method = RequestMethod.GET)
    public String index(){
        return "index";
    }

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("fields", Field.textField("admin"));
        modelAndView.setViewName("template");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list( HttpServletRequest request){
        Map dataMap = new HashMap<String, Object>();
        dataMap = adminService.selectAdmin(Field.getParamMap("admin",request));
        return dataMap;
    }

}
