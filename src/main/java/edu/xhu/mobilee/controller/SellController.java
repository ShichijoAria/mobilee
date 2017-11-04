package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.SellEntity;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.ProcedureService;
import edu.xhu.mobilee.service.SellService;
import edu.xhu.mobilee.util.Proper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("sell")
public class SellController {
    @Autowired
    private SellService sellService;
    @Autowired
    private ProcedureService procedureService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("sell");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "sell_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "priceStart",required = false)long priceStart,
                    @RequestParam(value = "priceEnd",required = false)long priceEnd,
                    @RequestParam(value = "page",required = false) long pageIndex, SellEntity sellEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_sell sell,t_mobile_phone mobile_phone,t_sale sale,t_admin admin");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "sell.id sell_id," +
                "sell.price sell_price," +
                "mobile_phone.name mobile_phone_name," +
                "sale.name sale_name," +
                "admin.name admin_name ");
        where+="sell.mobile_phone=mobile_phone.id and sell.author=admin.id and sell.sale=sale.id";
        if(priceStart>0)
            where += "and sell.price >= "+priceStart+" ";
        if(priceEnd>0)
            where += "and sell.price <= "+priceEnd+" ";
        if(sellEntity!=null) {
            if(sellEntity.getAuthor()!=null) {
                if (sellEntity.getAuthor().getName() != null)
                    where += "and admin.name like '%" + sellEntity.getAuthor().getName() + "%'";
            }
            if(sellEntity.getSale()!=null) {
                if (sellEntity.getSale().getName() != null)
                    where += "and sale.name like '%" + sellEntity.getAuthor().getName() + "%'";
            }
            if(sellEntity.getMobilePhone()!=null) {
                if (sellEntity.getMobilePhone().getName() != null)
                    where += "and mobile_phone.name like '%" + sellEntity.getMobilePhone().getName() + "%'";
            }
            if (sellEntity.getId() >0 )
                where += "and sell.id = " + sellEntity.getId();
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
            SellEntity temp=sellService.findSellById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }

    @RequestMapping(value = "save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(SellEntity sellEntity,@RequestParam("id") long id,@RequestParam("edition") long edition){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if(sellService.updateSellById(sellEntity)>0)
            msg="success";
        else
            msg="保存失败";
        dataMap.put("msg",msg);
        return dataMap;
    }
}
