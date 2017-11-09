package edu.xhu.mobilee.controller;

import com.alibaba.fastjson.JSON;
import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.ManufacturerEntity;
import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.service.MobilePhoneService;
import edu.xhu.mobilee.service.OptionService;
import edu.xhu.mobilee.service.ProcedureService;
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
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("mobilePhone")
public class MobilePhoneController {
    @Autowired
    private MobilePhoneService mobilePhoneService;
    @Autowired
    private ProcedureService procedureService;
    @Autowired
    private OptionService optionService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("manufacturer", JSON.toJSON(optionService.getManufacturer()));
        modelAndView.setViewName("mobilePhone");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "mobile_phone_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex, MobilePhoneEntity mobilePhoneEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_manufacturer manufacturer,t_admin admin,t_mobile_phone mobile_phone");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "mobile_phone.id mobile_phone_id," +
                "mobile_phone.name mobile_phone_name," +
                "date_format(mobile_phone.list_time,'%Y/%m/%d %H:%i') mobile_phone_list_time, " +
                "admin.name mobile_phone_author ");
        where+=" mobile_phone.author=admin.id and mobile_phone.manufacturer = manufacturer.id ";
        if(mobilePhoneEntity!=null) {
            if (mobilePhoneEntity.getName() != null)
                where += " and mobile_phone.name like '%" + mobilePhoneEntity.getName() + "%'";
            if (mobilePhoneEntity.getId() >0 )
                where += " and mobile_phone.id = " + mobilePhoneEntity.getId();
            if(mobilePhoneEntity.getAuthor()!=null) {
                if (mobilePhoneEntity.getAuthor().getName() != null)
                    where += "and admin.name like '%" + mobilePhoneEntity.getAuthor().getName() + "%'";
            }
        }
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
            MobilePhoneEntity temp=mobilePhoneService.findMobilePhoneById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(HttpServletRequest request, MobilePhoneEntity mobilePhoneEntity,
                    @RequestParam(value = "id") long id, @RequestParam(value = "edition") long edition){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(mobilePhoneService.updateMobilePhoneById(mobilePhoneEntity)>0)
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
        mobilePhoneService.deleteMobilePhone(arrayList);
        return dataMap;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map add(MobilePhoneEntity mobilePhoneEntity, HttpSession session){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(mobilePhoneEntity !=null) {
            AdminEntity adminEntity=new AdminEntity();
            adminEntity.setId((long)session.getAttribute("USER_ID"));
            mobilePhoneEntity.setAuthor(adminEntity);
            if (mobilePhoneService.insertMobilePhone(mobilePhoneEntity) > 0) {
                dataMap.put("id",mobilePhoneEntity.getId());
                msg = "success";
            }
        }
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public Map upload(HttpServletRequest request, @RequestParam("headPortrait") MultipartFile file, @RequestParam("id") long id) {
        Map dataMap = new HashMap<String, Object>();
        String msg="";
        msg= Upload.uploadJpg(file,request,id,"mobilePhone");
        dataMap.put("msg",msg);
        return dataMap;
    }
}
