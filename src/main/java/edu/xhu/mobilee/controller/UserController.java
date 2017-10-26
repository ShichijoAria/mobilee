package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Field;
import edu.xhu.mobilee.util.Format;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("user")
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "index",method = RequestMethod.GET)
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("fields", Field.textField("user"));
        modelAndView.setViewName("template");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list( HttpServletRequest request){
        int page= Format.stringToInt(request.getParameter("page"));
        String hql=Field.getHql("User",request);
        page=page>0?page:1;
        Map dataMap = new HashMap<String, Object>();
        dataMap = userService.selectUser(page,hql);
        return dataMap;
    }

    @RequestMapping(value = "info",method = RequestMethod.POST)
    @ResponseBody
    public Map info(@RequestParam(value = "id") long id){
        Map dataMap = new HashMap<String, Object>();
        if(id>0) {
            UserEntity temp=userService.findUserById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(HttpServletRequest request,@RequestParam(value = "id") long id){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        UserEntity user=userService.findUserById(id);
        user= (UserEntity) Field.getObject(user,request);
        userService.saveUser(user);
        msg="success";
        dataMap.put("msg",msg);
        return dataMap;
    }


    @RequestMapping(value = "delete",method = RequestMethod.POST)
    @ResponseBody
    public Map delete(@RequestParam(value = "deleteArr") String arr){
        String []list=arr.split(",");
        long []newList =new long[list.length];
        for (int i = 0; i < list.length; i++) {
            newList[i]=Format.stringToLong(list[i]);
        }
        Map dataMap = new HashMap<String, Object>();
        String msg="success";
        dataMap.put("msg",msg);
        userService.deleteUser(newList);
        return dataMap;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map add(UserEntity userEntity){
        Map dataMap = new HashMap<String, Object>();
        return dataMap;
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public void upload(HttpServletRequest request, @RequestParam("file") MultipartFile file, ModelMap model) {
        System.out.println("开始");
        String path = request.getSession().getServletContext().getRealPath("upload");
        String fileName = file.getOriginalFilename();
        // String fileName = new Date().getTime()+".jpg";
        System.out.println(path);
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }

        // 保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
