package com.jiuheng.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/7/9.
 */
@Controller
@RequestMapping("/attribute")
public class AttributeController {

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("attribute/index");
        return m;
    }

}
