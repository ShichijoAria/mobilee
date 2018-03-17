package org.yorha.mobilee.controller;

import org.yorha.mobilee.entity.CollectionEntity;
import org.yorha.mobilee.entity.CommentEntity;
import org.yorha.mobilee.entity.MobilePhoneEntity;
import org.yorha.mobilee.entity.UserEntity;
import org.yorha.mobilee.service.*;
import org.yorha.mobilee.util.ShiroMessage;
import org.yorha.mobilee.util.Upload;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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
    public Map login(@RequestParam(value = "name") String name, @RequestParam("password") String password) {
        return ShiroMessage.login(SecurityUtils.getSubject(),name,password,"User");
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
        Session session =SecurityUtils.getSubject().getSession();
        UserEntity userEntity= (UserEntity) session.getAttribute("principal");
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

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public Map upload(HttpServletRequest request, @RequestParam("headPortrait") MultipartFile file, @RequestParam("id") long id) {
        Map dataMap = new HashMap<String, Object>();
        String msg="上传失败";
        msg= Upload.uploadJpg(file,request,id,"user");
        dataMap.put("msg", msg);
        return dataMap;
    }
}
