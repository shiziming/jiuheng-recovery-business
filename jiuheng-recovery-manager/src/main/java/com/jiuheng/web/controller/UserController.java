package com.jiuheng.web.controller;

import com.jiuheng.service.dto.UserInfo;
import com.jiuheng.service.dubbo.DubboUserInfoService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/10/13.
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private DubboUserInfoService dubboUserInfoService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("user/index");
        return m;
    }

    @RequestMapping("/list")
    @ResponseBody
    public SearchResult list(UserInfo userInfo,HttpServletRequest request){
        Response<SearchResult> result = dubboUserInfoService.getUserList(userInfo, Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows")));
        return result.getResult();
    }
}
