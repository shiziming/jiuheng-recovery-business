package com.jiuheng.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class IndexController {
	
	@RequestMapping("/index")
	public ModelAndView stockView(){		
		return new ModelAndView("index");
	}
	
	@RequestMapping("/login")
	public ModelAndView loginView(){		
		return new ModelAndView("login");
	}
	

}
