package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.entity.OperateEntity;
import edu.xhu.mobilee.service.OperateService;
import edu.xhu.mobilee.service.ProcedureService;
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
@RequestMapping("operate")
public class OperateController {
    @Autowired
    private OperateService operateService;
    @Autowired
    private ProcedureService procedureService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("operate");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "createdStart",required = false)Timestamp createdStart,
                    @RequestParam(value = "createdEnd",required = false)Timestamp createdEnd,
                    @RequestParam(value = "orderBy",required = false,defaultValue = "operate_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex, OperateEntity operateEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_operate operate,t_admin admin,t_user user ");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "operate.id operate_id," +
                "admin.name admin_name," +
                "operate.remark operate_remark," +
                "operate.created operate_create");
        where+=" operate.admin =admin.id and user.id and operate.user ";
        if(createdStart!=null)
            where += "and user.created >= '"+createdStart+"' ";
        if(createdEnd!=null)
            where += "and user.created <= '"+createdEnd+"' ";
        if(operateEntity !=null) {
            if (operateEntity.getAdmin() != null) {
                if(operateEntity.getAdmin().getName()!=null)
                    where += "and admin.name like '%" + operateEntity.getAdmin().getName() + "%'";
            }
            if (operateEntity.getUser() != null) {
                if(operateEntity.getAdmin().getName()!=null)
                    where += "and user.name like '%" + operateEntity.getUser().getName() + "%'";
            }
            if (operateEntity.getId() >0 )
                where += "and operate.id = " + operateEntity.getId();
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
            OperateEntity temp=operateService.findOperateById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }
}
