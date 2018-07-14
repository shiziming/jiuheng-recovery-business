package com.jiuheng.web.controller;

import com.jiuheng.order.domain.BrandReq;
import com.jiuheng.order.domain.RecoveryOrderReq;
import com.jiuheng.order.domain.Response;
import com.jiuheng.order.domain.SearchResult;
import com.jiuheng.order.dubbo.DubboBrandService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/7/2.
 * 品牌
 */
@Controller
@RequestMapping("/brand")
public class BrandController {
    @Autowired
    private DubboBrandService dubboBrandService;
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("brand/index");
        return m;
    }
    @RequestMapping("/getAllBranch")
    @ResponseBody
    public SearchResult getAllBranch(BrandReq req,HttpServletRequest request){
        Response<SearchResult> result=dubboBrandService.getAllBranch(req,Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows")));
        return result.getResult();
    }
    /*@RequestMapping("addBrand")
    public ModelAndView addBrand(){
        ModelMap model = new ModelMap();

        List<DeviceCategory> allCategories = deviceCategoryService.getDeviceCategoryList(null, null);
        model.addAttribute("deviceCategories", allCategories);
        return new ModelAndView("device.brandEdit", model);
    }*/

}
