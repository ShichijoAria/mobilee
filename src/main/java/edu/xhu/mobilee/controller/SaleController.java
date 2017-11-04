package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.AdminEntity;
import edu.xhu.mobilee.entity.SaleEntity;
import edu.xhu.mobilee.service.ProcedureService;
import edu.xhu.mobilee.service.SaleService;
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

@RequestMapping("sale")
@Controller
public class SaleController {
    @Autowired
    private SaleService saleService;

    @Autowired
    private ProcedureService procedureService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("sale");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "sale_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex, SaleEntity saleEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_sale sale,t_admin admin");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "sale.id sale_id," +
                "sale.name sale_name," +
                "admin.name sale_author");
        where+="and sale.author=admin.id ";
        if(saleEntity!=null) {
            if (saleEntity.getName() != null)
                where += "and sale.name like '%" + saleEntity.getName() + "%'";
            if (saleEntity.getId() >0 )
                where += "and sale.id = " + saleEntity.getId();
            if(saleEntity.getAuthor()!=null) {
                if (saleEntity.getAuthor().getName() != null)
                    where += "and admin.name like '%" + saleEntity.getAuthor().getName() + "%'";
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
            SaleEntity temp= saleService.findSaleById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(HttpServletRequest request, SaleEntity saleEntity,
                    @RequestParam(value = "id") long id, @RequestParam(value = "edition") long edition){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(saleService.updateSaleById(saleEntity)>0)
            msg="success";
        else
            msg="保存失败";
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
        saleService.deleteSale(arrayList);
        return dataMap;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map add(SaleEntity saleEntity, HttpSession session){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(saleEntity !=null) {
            AdminEntity adminEntity=new AdminEntity();
            adminEntity.setId((long)session.getAttribute("USER_ID"));
            saleEntity.setAuthor(adminEntity);
            if (saleService.insertSale(saleEntity) > 0) {
                dataMap.put("id",saleEntity.getId());
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
        msg= Upload.uploadJpg(file,request,id,"sale");
        dataMap.put("msg",msg);
        return dataMap;
    }
}
