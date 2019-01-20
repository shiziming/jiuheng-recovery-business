package com.jiuheng.web.controller;

import com.jiuheng.service.domain.CategoryReq;
import com.jiuheng.service.dubbo.DubboCategoryService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/7/2.
 * 品类
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private DubboCategoryService dubboCategoryService;
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("category/index");
        return m;
    }
    @RequestMapping("/getCategoryList")
    @ResponseBody
    public SearchResult getCategoryList(CategoryReq categoryReq,HttpServletRequest request){
        String page = request.getParameter("page");
        String rows = request.getParameter("rows");
        Response<SearchResult> result = null;
        if(page == null || rows == null){
            result = dubboCategoryService.getCategoryList(categoryReq,0,0);
        }else{
            result = dubboCategoryService.getCategoryList(categoryReq,Integer.parseInt(page),Integer.parseInt(rows));
        }
        return result.getResult();
    }

    @RequestMapping("/selectAttribute")
    public ModelAndView selectAttribute(Long categoryid,String type){
        ModelAndView model = new ModelAndView("category/selectAttribute");
        model.addObject("categoryId", categoryid);
        model.addObject("type", type);
        return model;
    }

    @RequestMapping("saveCategory")
    @ResponseBody
    public Response<Boolean> saveCategory(CategoryReq categoryReq, HttpServletRequest request){
        Response<Boolean> result = null;
        if(categoryReq.getId() != null && categoryReq.getId() <= 0){
            throw new IllegalArgumentException("设备分类参数不正确");
        }
        if(null == categoryReq.getId()){
            result = dubboCategoryService.saveCategory(categoryReq);
        }else{
            result = dubboCategoryService.updateCategory(categoryReq);
        }
        return result;
    }
}
