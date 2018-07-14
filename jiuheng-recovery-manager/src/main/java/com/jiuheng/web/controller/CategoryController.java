package com.jiuheng.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/7/2.
 * 品类
 */
@Controller
@RequestMapping("/category")
public class CategoryController {
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("category/index");
        return m;
    }
}
