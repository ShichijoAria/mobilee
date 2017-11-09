package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.ProcedureService;
import edu.xhu.mobilee.service.UserService;
import edu.xhu.mobilee.util.Field;
import edu.xhu.mobilee.util.Format;
import edu.xhu.mobilee.util.Proper;
import edu.xhu.mobilee.util.Upload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("user")
@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private ProcedureService procedureService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "user_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "createdStart",required = false)Timestamp createdStart,
                    @RequestParam(value = "createdEnd",required = false)Timestamp createdEnd,
                    @RequestParam(value = "page",required = false) long pageIndex,UserEntity userEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_user user");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "user.id user_id," +
                "user.name user_name," +
                "if(user.gender=1,'男','女') user_gender," +
                "date_format(user.created,'%Y/%m/%d %H:%i') user_created," +
                "date_format(user.birthday,'%Y/%m/%d') user_birthday");
        if(createdStart!=null)
            where += "and user.created >= '"+createdStart+"' ";
        if(createdEnd!=null)
            where += "and user.created <= '"+createdEnd+"' ";
        if(userEntity!=null) {
            if (userEntity.getGender() != null && userEntity.getGender() != 0) {
                if (userEntity.getGender() == 1)
                    where += "and user.gender= 1 ";
                else
                    where += "and user.gender= 2 ";
            }
            if (userEntity.getName() != null)
                where += "and user.name like '%" + userEntity.getName() + "%'";
            if (userEntity.getId() >0 )
                where += "and user.id = " + userEntity.getId();
        }
        if (where.length()>3)
            where=where.substring(3);
        paramMap.put("where",where);
        paramMap.put("orderBy",orderBy+" "+sequence);
        paramMap.put("pageSize", Proper.pageSize());
        dataMap = procedureService.pagedQuery(paramMap);
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
    public Map save(UserEntity userEntity,@RequestParam("id") long id,@RequestParam("edition") long edition){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(userService.updateUserById(userEntity)>0)
            msg="success";
        else
            msg="保存失败或无信息更新";
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping(value = "delete",method = RequestMethod.POST)
    @ResponseBody
    public Map delete(@RequestParam(value = "deleteArr") String arr){
        String []list=arr.split(",");
        ArrayList<String> arrayList = new ArrayList<String>(Arrays.asList(list));
        Map dataMap = new HashMap<String, Object>();
        String msg="success";
        dataMap.put("msg",msg);
        userService.deleteUser(arrayList);
        return dataMap;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map add(UserEntity userEntity){
        Map dataMap = new HashMap<String, Object>();
        return dataMap;
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public Map upload(HttpServletRequest request, @RequestParam("headPortrait") MultipartFile file,@RequestParam("id") long id) {
        Map dataMap = new HashMap<String, Object>();
        String msg="";
        msg= Upload.uploadJpg(file,request,id,"user");
        dataMap.put("msg",msg);
        return dataMap;
    }

}
