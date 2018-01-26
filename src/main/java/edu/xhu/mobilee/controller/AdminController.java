package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.service.AdminService;
import edu.xhu.mobilee.service.ProcedureService;
import edu.xhu.mobilee.shiro.CustomizedToken;
import edu.xhu.mobilee.util.Proper;
import edu.xhu.mobilee.util.ShiroMessage;
import edu.xhu.mobilee.util.Upload;
import org.apache.shiro.SecurityUtils;
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

@RequestMapping("admin")
@Controller
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private ProcedureService procedureService;

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
    public Map login(@RequestParam(value = "name") String name, @RequestParam("password") String password) {
        return ShiroMessage.login(SecurityUtils.getSubject(),name,password,"Admin");
    }

    @RequestMapping("cancel")
    public String cancel(HttpSession session){
        session.removeAttribute("USER_ID");
        session.removeAttribute("USER_NAME");
        session.removeAttribute("USER_PASSWORD");
        return "touristLogin";
    }

    @RequestMapping(value = "index",method = RequestMethod.GET)
    public String index(){
        return "index";
    }

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("admin");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "admin_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex,AdminEntity adminEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_admin admin");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "admin.id admin_id," +
                "admin.name admin_name");
        if(adminEntity!=null) {
            if (adminEntity.getName() != null)
                where += "and admin.name like '%" + adminEntity.getName() + "%'";
            if (adminEntity.getId() >0 )
                where += "and admin.id = " + adminEntity.getId();
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
            AdminEntity temp=adminService.findAdminById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(HttpSession session,HttpServletRequest request,AdminEntity adminEntity,@RequestParam(value = "id") long id){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(id==(long)session.getAttribute("USER_ID")&&adminService.updateAdminById(adminEntity)>0)
            msg="success";
        else
            msg="保存失败或无信息更新";
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public Map upload(HttpServletRequest request, @RequestParam("headPortrait") MultipartFile file, @RequestParam("id") long id) {
        Map dataMap = new HashMap<String, Object>();
        String msg="";
        msg=Upload.uploadJpg(file,request,id,"admin");
        dataMap.put("msg", msg);
        return dataMap;
    }

    @RequestMapping(value = "statistics",method = RequestMethod.GET)
    public ModelAndView statistics(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("statistics",adminService.getStatistics());
        modelAndView.setViewName("statistics");
        return modelAndView;
    }

}
