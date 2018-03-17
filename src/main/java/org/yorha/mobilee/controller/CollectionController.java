package org.yorha.mobilee.controller;

import org.yorha.mobilee.entity.CollectionEntity;
import org.yorha.mobilee.service.CollectionService;
import org.yorha.mobilee.service.ProcedureService;
import org.yorha.mobilee.util.Proper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("collection")
public class CollectionController {
    @Autowired
    private CollectionService collectionService;
    @Autowired
    private ProcedureService procedureService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("collection");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "collection_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex, CollectionEntity collectionEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_collection collection,t_user user,t_mobile_phone mobile_phone ");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "collection.id collection_id," +
                "user.name user_name," +
                "mobile_phone.name mobile_phone_name");
        where+=" mobile_phone.id =collection.mobile_phone and user.id=collection.user ";
        if(collectionEntity!=null) {
            if (collectionEntity.getMobilePhone() != null) {
                if(collectionEntity.getMobilePhone().getName()!=null)
                where += "and mobile_phone.name like '%" + collectionEntity.getMobilePhone().getName() + "%'";
            }
            if (collectionEntity.getUser() != null) {
                if(collectionEntity.getUser().getName()!=null)
                    where += "and user.name like '%" + collectionEntity.getUser().getName() + "%'";
            }
            if (collectionEntity.getId() >0 )
                where += "and collection.id = " + collectionEntity.getId();
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
            CollectionEntity temp=collectionService.findCollectionById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
        return dataMap;
    }
}
