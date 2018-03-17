package org.yorha.mobilee.controller;

import org.yorha.mobilee.entity.CommentEntity;
import org.yorha.mobilee.service.CommentService;
import org.yorha.mobilee.service.ProcedureService;
import org.yorha.mobilee.util.Proper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("comment")
public class CommentController {
    @Autowired
    private ProcedureService procedureService;
    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("comment");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(@RequestParam(value = "orderBy",required = false,defaultValue = "comment_id") String orderBy,
                    @RequestParam(value = "sequence",required = false) String sequence,
                    @RequestParam(value = "page",required = false) long pageIndex, CommentEntity commentEntity) {
        Map<String, Object> paramMap=new HashMap<String,Object>();
        Map dataMap = new HashMap<String, Object>();
        String where="";
        pageIndex=pageIndex>0?pageIndex:1;
        if(sequence!=null&&sequence.trim().length()>0)
            sequence="DESC";
        else
            sequence="ASC";
        paramMap.put("tables","t_comment comment,t_user user,t_mobile_phone mobile_phone ");
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields", "comment.id comment_id," +
                "user.name user_name," +
                "mobile_phone.name mobile_phone_name");
        where+=" mobile_phone.id =comment.mobile_phone and user.id=comment.author ";
        if(commentEntity !=null) {
            if (commentEntity.getMobilePhone() != null) {
                if(commentEntity.getMobilePhone().getName()!=null)
                    where += "and mobile_phone.name like '%" + commentEntity.getMobilePhone().getName() + "%'";
            }
            if (commentEntity.getAuthor() != null) {
                if(commentEntity.getAuthor().getName()!=null)
                    where += "and user.name like '%" + commentEntity.getAuthor().getName() + "%'";
            }
            if (commentEntity.getId() >0 )
                where += "and comment.id = " + commentEntity.getId();
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
            CommentEntity temp=commentService.findCommentById(id);
            dataMap.put("entity", temp);
            dataMap.put("msg","success");
        }else {
            dataMap.put("msg","非法的数据");
        }
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
        commentService.deleteComment(arrayList);
        return dataMap;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map add(CommentEntity commentEntity, HttpSession session){
        Map dataMap = new HashMap<String, Object>();
        String msg="非法的数据";
        if (commentService.insertComment(commentEntity) > 0) {
            dataMap.put("id",commentEntity.getId());
            msg = "success";
        }
        dataMap.put("msg",msg);
        return dataMap;
    }
}
