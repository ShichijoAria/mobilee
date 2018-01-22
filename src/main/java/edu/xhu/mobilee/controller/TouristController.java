package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.CollectionEntity;
import edu.xhu.mobilee.entity.CommentEntity;
import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.*;
import edu.xhu.mobilee.shiro.CustomizedToken;
import edu.xhu.mobilee.util.Upload;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
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

    private String shiroLogin(UserEntity userEntity) {
        CustomizedToken customizedToken = new CustomizedToken(userEntity.getName(), userEntity.getPassword().toCharArray(),"user");
        try {
            SecurityUtils.getSubject().login(customizedToken);
        } catch (UnknownAccountException ex) {
            return "用户不存在或者密码错误！";
        } catch (IncorrectCredentialsException ex) {
            return "用户不存在或者密码错误！";
        } catch (AuthenticationException ex) {
            return ex.getMessage(); // 自定义报错信息
        } catch (Exception ex) {
            ex.printStackTrace();
            return "内部错误，请重试！";
        }
        return "SUCCESS";
    }

    private boolean isLogin(UserEntity userEntity) {
        Subject us = SecurityUtils.getSubject();
        if (us.isAuthenticated()) {
            return true; // 参数未改变，无需重新登录，默认为已经登录成功
        }
        return false; // 需要重新登陆
    }

    private String userLogin(UserEntity userEntity) {
        if (this.isLogin(userEntity))
            return "SUCCESS";
        return shiroLogin(userEntity);
    }

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
        String msg=null;
        if(id>0) {
            if (password != null && password.trim().length() < 6) {
                msg = "用户密码不应少于6位";
            } else {
                UserEntity temp = new UserEntity();
                temp.setId(id);
                temp.setPassword(password);
                if (this.userLogin(temp) == "SUCCESS") {
                    msg = "success";
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
