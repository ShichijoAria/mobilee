package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.service.ManufacturerService;
import edu.xhu.mobilee.util.Field;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("manufacturer")
@Controller
public class ManufacturerController {

    @Autowired
    private ManufacturerService manufacturerService;

    @RequestMapping(value = "view",method = RequestMethod.GET)
    public ModelAndView view(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("fields", Field.textField("manufacturer"));
        modelAndView.setViewName("template");
        return modelAndView;
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map list(HttpServletRequest request){
        Map dataMap = new HashMap<String, Object>();
        dataMap = manufacturerService.selectManufacturer(Field.getParamMap("manufacturer",request));
        return dataMap;
    }

}
