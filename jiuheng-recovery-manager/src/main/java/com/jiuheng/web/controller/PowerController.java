package com.jiuheng.web.controller;

import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import com.jiuheng.service.dubbo.DubboPowerService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.web.utils.SysUser;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2019/2/8.
 * 权限管理
 */
@Controller
@RequestMapping("/power")
public class PowerController {

    @Autowired
    private DubboPowerService dubboPowerService;
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("power/index");
        return m;
    }
    @RequestMapping("/resetPassword")
    public ModelAndView resetPassword(int userId){
        ModelAndView m = new ModelAndView("power/resetPassword");
        Response<UserAccount> resp = dubboPowerService.getUserAccountByUserId(userId);
        m.addObject("userAccount",resp.getResult());
        return m;
    }
    @RequestMapping("/getPowers")
    @ResponseBody
    public SearchResult getPowers(HttpServletRequest request){
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        if(null == sysUser || null == sysUser.getUserId()){
            return new SearchResult();
        }
        Response<SearchResult> resp = dubboPowerService.getPowers(sysUser.getUserId());
        List<UserPower> list = (List<UserPower>)resp.getResult().getRows();
        boolean flag = false;
        for (UserPower userPower :list) {
            if(userPower.getMenuId() == 1001){
                flag = true;
            }
        }
        if(flag){
            String page = request.getParameter("page");
            String rows = request.getParameter("rows");
            Response<SearchResult> userAccount = dubboPowerService.getUserAccount(Integer.parseInt(page), Integer.parseInt(rows));
            return userAccount.getResult();
        }else{
           return new SearchResult();
        }
    }



}
