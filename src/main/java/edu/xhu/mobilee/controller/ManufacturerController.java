package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.ManufacturerEntity;
import edu.xhu.mobilee.service.ManufacturerService;
import edu.xhu.mobilee.service.ProcedureService;
import edu.xhu.mobilee.util.Field;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("manufacturer")
@Controller
public class ManufacturerController {

    @Autowired
    private ManufacturerService manufacturerService;

    @Autowired
    private ProcedureService procedureService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("manufacturer");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "manufacturer_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex,ManufacturerEntity manufacturerEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_manufacturer manufacturer,t_admin admin");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "manufacturer.id manufacturer_id," +
                "manufacturer.name manufacturer_name," +
                "admin.name manufacturer_author");
        where+="and manufacturer.author=admin.id ";
        if(manufacturerEntity!=null) {
            if (manufacturerEntity.getName() != null)
                where += "and admin.name like '%" + manufacturerEntity.getName() + "%'";
            if (manufacturerEntity.getId() >0 )
                where += "and admin.id = " + manufacturerEntity.getId();
            if(manufacturerEntity.getAuthor()!=null) {
                if (manufacturerEntity.getAuthor().getName() != null)
                    where += "and admin.name like '%" + manufacturerEntity.getAuthor().getName() + "%'";
            }
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
            ManufacturerEntity temp=manufacturerService.findManufacturerById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(HttpServletRequest request,ManufacturerEntity manufacturerEntity,
                    @RequestParam(value = "id") long id,@RequestParam(value = "edition") long edition){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        manufacturerService.updateManufacturerById(manufacturerEntity);
        msg="success";
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
        manufacturerService.deleteManufacturer(arrayList);
        return dataMap;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map add(ManufacturerEntity manufacturerEntity, HttpSession session){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(manufacturerEntity !=null) {
            AdminEntity adminEntity=new AdminEntity();
            adminEntity.setId((long)session.getAttribute("USER_ID"));
            manufacturerEntity.setAuthor(adminEntity);
            if (manufacturerService.insertManufacturer(manufacturerEntity) > 0) {
                msg = "success";
            }
        }
        dataMap.put("msg",msg);
        return dataMap;
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public Map upload(HttpServletRequest request, @RequestParam("file") MultipartFile file, @RequestParam("fileId") long id) {
        Map dataMap = new HashMap<String, Object>();
        String msg="";
        msg= Upload.uploadJpg(file,request,id,"manufacturer");
        dataMap.put("msg",msg);
        return dataMap;
    }

}
