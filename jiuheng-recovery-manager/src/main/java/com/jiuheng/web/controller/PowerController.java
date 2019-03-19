package com.jiuheng.web.controller;

import com.jiuheng.service.domain.Menu;
import com.jiuheng.service.domain.PasswordReq;
import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import com.jiuheng.service.dubbo.DubboPowerService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.web.utils.SysUser;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
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
    @RequestMapping("/functionShow")
    public ModelAndView functionShow(int userId){
        ModelAndView m = new ModelAndView("power/updatePower");
        m.addObject("userId",userId);
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
    public SearchResult getPowers(HttpServletRequest request,String account,Integer status){
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        if(null == sysUser || null == sysUser.getUserId()){
            return new SearchResult();
        }
        Response<SearchResult> resp = dubboPowerService.getPowers(sysUser.getUserId());
        List<UserPower> list = (List<UserPower>)resp.getResult().getRows();
        boolean flag = false;
        for (UserPower userPower :list) {
            if("1001".equals(userPower.getMenuId())){
                flag = true;
            }
        }
        if(flag){
            String page = request.getParameter("page");
            String rows = request.getParameter("rows");
            Response<SearchResult> userAccount = dubboPowerService.getUserAccount(Integer.parseInt(page), Integer.parseInt(rows),account,status);
            return userAccount.getResult();
        }else{
           return new SearchResult();
        }
    }
    @RequestMapping("/updatePassword")
    @ResponseBody
    public Response<Boolean> updatePassword(HttpServletRequest request,PasswordReq passwordReq){
        Response<Boolean> result = null;
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        passwordReq.setUpdateUserId(sysUser.getUserId());
        result = dubboPowerService.updatePassword(passwordReq);
        return result;
    }
    @RequestMapping("/editUserStatus")
    @ResponseBody
    public Response<Boolean> editUserStatus(HttpServletRequest request,Integer userId, Integer status){
        Response<Boolean> resp = null;
        try {
            if(userId == null || userId <= 0){
                throw new IllegalArgumentException("错误的用户id");
            }
            SysUser sysUser = (SysUser) request.getSession().getAttribute("user");

            UserAccount account = new UserAccount();
            account.setStatus(status);
            account.setUserId(userId);
            account.setCreateUser(sysUser.getUserId());
            resp=dubboPowerService.editUserStatus(account);
            return resp;
        } catch (IllegalArgumentException e) {
            return Response.fail(e.getMessage());
        }
    }

    @RequestMapping("/addFunction")
    @ResponseBody
    public ModelAndView addFunction(HttpServletRequest request,int userId){
        ModelAndView m = new ModelAndView("power/addFunction");
        Response<UserAccount> resp = dubboPowerService.getUserAccountByUserId(userId);
        m.addObject("userAccount",resp.getResult());
        return m;
    }
    @RequestMapping("/addPower")
    @ResponseBody
    public Response<Boolean> addPower(HttpServletRequest request,String modelid,String fatherFunctionId,int userId){
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        if(StringUtils.isEmpty(modelid)){
            return Response.fail("模块不能为空");
        }
        if(StringUtils.isEmpty(fatherFunctionId)){
            return Response.fail("功能名称不能为空");
        }
        return dubboPowerService.addPower(userId,modelid,fatherFunctionId,sysUser.getUserId());
    }

    @RequestMapping("/addAccount")
    @ResponseBody
    public Response<Boolean> addAccount(HttpServletRequest request,String account,String password,String name){
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        if(StringUtils.isEmpty(account)){
            return Response.fail("账号不能为空");
        }
        if(StringUtils.isEmpty(password)){
            return Response.fail("密码不能为空");
        }
        return dubboPowerService.addAccount(account,password,name,sysUser.getUserId());
    }
    @RequestMapping(value="/queryModel")
    @ResponseBody
    public List<Menu> queryModel(){
        //查询对应系统全部模块
        Response<List<Menu>> menus = dubboPowerService.queryModel();
        return menus.getResult();
    }

    @RequestMapping(value="/queryFunctionByFatherId")
    @ResponseBody
    public List<Menu> queryFunctionByFatherId(String modelid){
        //查询对应系统全部模块
        Response<List<Menu>> menus = dubboPowerService.queryFunctionByFatherId(modelid);
        return menus.getResult();
    }

    @RequestMapping(value="/queryAllMenu")
    @ResponseBody
    public List<UserPower> queryAllMenu(int userId){
        Response<SearchResult> menus = dubboPowerService.getPowers(userId);
        return (List<UserPower>)menus.getResult().getRows();
    }
    @RequestMapping(value="/delPower")
    @ResponseBody
    public Response<Boolean> delPower(int userId,String menuId, int type){
        Response<Boolean> resp = null;
        try {
            return dubboPowerService.delPower(userId,menuId,type);
        } catch (Exception e) {
            return Response.fail(e.getMessage());
        }
    }
    @RequestMapping(value="/addAccountPanel")
    public ModelAndView addAccountPanel(){
        ModelAndView m = new ModelAndView("power/addAccount");
        return m;
    }

}
