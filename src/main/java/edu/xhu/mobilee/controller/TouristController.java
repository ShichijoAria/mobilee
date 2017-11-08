package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.CollectionEntity;
import edu.xhu.mobilee.entity.CommentEntity;
import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("tourist")
public class TouristController {
    @Autowired
    private MobilePhoneService mobilePhoneService;
    @Autowired
    private TouristService touristService;
    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private CollectionService collectionService;

    @RequestMapping("welcome")
    public ModelAndView welcome(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("touristLogin");
        return modelAndView;
    }

    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    public Map login(@RequestParam(value = "id",defaultValue = "0") long id, @RequestParam("password") String password, HttpSession session) {
        Map<String,Object> dataMap = new HashMap<String, Object>();
        boolean flag=false;
        String msg;
        if(id>0) {
            if (password != null && password.trim().length() < 6) {
                msg = "用户密码不应少于6位";
            } else {
                UserEntity temp = new UserEntity();
                temp.setId(id);
                temp.setPassword(password);
                String name=touristService.userLogin(temp);
                if (temp != null && password.equals(temp.getPassword())) {
                    flag = true;
                }
                if (flag) {
                    session.setAttribute("TOURIST_ID", id);
                    session.setAttribute("TOURIST_NAME", name);
                    session.setAttribute("TOURIST_PASSWORD", password);
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

    @RequestMapping("cancel")
    public String cancel(HttpSession session){
        session.removeAttribute("TOURIST_ID");
        session.removeAttribute("TOURIST_NAME");
        session.removeAttribute("TOURIST_PASSWORD");
        return "touristLogin";
    }

    @RequestMapping("index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("data",touristService.getMobilePhoneIndex());
        modelAndView.setViewName("tourist");
        return modelAndView;
    }

    @RequestMapping("detail")
    public ModelAndView detail(@RequestParam("id") long id,HttpSession session){
        long touristId=0;
        if(session.getAttribute("TOURIST_ID")!=null)
            touristId= (long) session.getAttribute("TOURIST_ID");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("detail",touristService.getMobilePhoneDetail(id, touristId));
        modelAndView.setViewName("detail");
        return modelAndView;
    }

    @RequestMapping("add")
    @ResponseBody
    public Map add(CommentEntity commentEntity,@RequestParam("content") String content,HttpSession session){
        Map<String,Object> dataMap=new HashMap<String, Object>();
        String msg="参数错误";
        UserEntity userEntity=new UserEntity();
        userEntity.setId((long)session.getAttribute("TOURIST_ID"));
        commentEntity.setAuthor(userEntity);
        if(commentService.insertComment(commentEntity)>0)
            msg="success";
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping("collect")
    @ResponseBody
    public Map collect(@RequestParam("id") long id,HttpSession session){
        Map<String,Object> dataMap=new HashMap<String,Object>();
        CollectionEntity collectionEntity=new CollectionEntity();
        collectionEntity.setId(id);
        UserEntity userEntity=new UserEntity();
        userEntity.setId((Long) session.getAttribute("TOURIST_ID"));
        collectionEntity.setUser(userEntity);
        MobilePhoneEntity mobilePhoneEntity=new MobilePhoneEntity();
        mobilePhoneEntity.setId(id);
        collectionEntity.setMobilePhone(mobilePhoneEntity);
        String msg="非法的数据";
        if(collectionService.targetCollection(collectionEntity)>0)
            msg="success";
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(UserEntity userEntity,@RequestParam("edition") long edition,HttpSession session){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        userEntity.setId((Long) session.getAttribute("TOURIST_ID"));
        if(userService.updateUserById(userEntity)>0)
            msg="success";
        else
            msg="保存失败或无信息更新";
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping("register")
    @ResponseBody
    public Map register(UserEntity userEntity,@RequestParam("name") String name,@RequestParam String password){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的请求";
        long id=touristService.register(userEntity);
        if(id>0) {
            msg = "success";
            dataMap.put("id",userEntity.getId());
        }
        dataMap.put("msg",msg);
        return dataMap;
    }
}
