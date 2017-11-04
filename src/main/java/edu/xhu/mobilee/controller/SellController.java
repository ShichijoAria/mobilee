package edu.xhu.mobilee.controller;

import edu.xhu.mobilee.service.ProcedureService;
import edu.xhu.mobilee.service.SellService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
}
