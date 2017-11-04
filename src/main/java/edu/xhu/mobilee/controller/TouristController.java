package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.service.MobilePhoneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("tourist")
public class TouristController {
    @Autowired
    private MobilePhoneService mobilePhoneService;

    @RequestMapping("index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("mobilePhone",mobilePhoneService.selectMobile());
        modelAndView.setViewName("tourist");
        return modelAndView;
    }

}
