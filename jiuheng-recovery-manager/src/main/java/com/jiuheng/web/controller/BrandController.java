package com.jiuheng.web.controller;

import com.alibaba.fastjson.JSON;
import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.BrandResp;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.dubbo.DubboBrandService;
import com.jiuheng.service.dubbo.DubboCategoryService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    @Autowired
    private DubboCategoryService dubboCategoryService;
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
    @RequestMapping("/getBranchByCategoryId")
    @ResponseBody
    public SearchResult getBranchByCategoryId(Integer id){
        Response<SearchResult> result=dubboBrandService.getBrandByCategory(id);
        return result.getResult();
    }
    @RequestMapping("/editBrand")
    public ModelAndView editBrand(BrandReq brandreq,HttpServletResponse response) throws IOException {
        if(brandreq == null || brandreq.getId() <= 0){
            throw new IllegalArgumentException("错误的品牌标识id");
        }

        ModelAndView model=new ModelAndView("brand/brandEdit");
        //查询所有品类
        Response<SearchResult> result=dubboCategoryService.getCategoryList(null,0,0);
        //查询品牌信息
        Response<Brand> brand=dubboBrandService.getBrandById(brandreq);
        //查询已拥有品类
        Response<SearchResult> brandResult=dubboBrandService.getAllBranch(brandreq,0,0);
        List json=new ArrayList();
        SearchResult searchResult=brandResult.getResult();
        List<BrandResp> lists=(List<BrandResp>)searchResult.getRows();
        if(null != lists && lists.size()>0){
            json.add(lists.get(0).getCategories());
        }
        model.addObject("brand", brand.getResult());
        model.addObject("json", JSON.toJSONString(json));
        model.addObject("deviceCategories",result.getResult().getRows());
        return model;
    }
    @RequestMapping("/saveBrand")
    @ResponseBody
    public Response<Boolean> saveBrand(BrandReq brand){
        Response<Boolean> resp = null;
        if(brand == null) throw new IllegalArgumentException("错误的品牌信息");
        ModelMap model = new ModelMap();
        if(brand.getId() == null){
            resp=dubboBrandService.saveBrand(brand);
        }else if(brand.getId() > 0){
            resp=dubboBrandService.updateBrand(brand);
        }else{
            resp=Response.fail("错误的品牌标识id");
        }
        return resp;
    }
    @RequestMapping("editBrandStatus")
    @ResponseBody
    public Response<Boolean> editBrandStatus(Integer id, Integer status){
        Response<Boolean> resp = null;
        try {
            if(id == null || id <= 0){
                throw new IllegalArgumentException("错误的品牌标识id");
            }

            BrandReq brand = new BrandReq();
            brand.setId(id);
            brand.setStatus(status);
            resp=dubboBrandService.updateBrandStatus(brand);
            return resp;
        } catch (IllegalArgumentException e) {
            return Response.fail(e.getMessage());
        }
    }

    @RequestMapping("addBrand")
    public ModelAndView addBrand(){
        ModelAndView model=new ModelAndView("brand/brandEdit");
        Response<SearchResult> result=dubboCategoryService.getCategoryList(null,0,0);
        model.addObject("deviceCategories",result.getResult().getRows());
        return model;
    }

    @RequestMapping("deleteBrand")
    @ResponseBody
    public Response<Boolean> deleteBrand(Integer id){
        Response<Boolean> resp = null;
        try {
            if(id == null || id <= 0){
                throw new IllegalArgumentException("错误的品牌标识id");
            }
            BrandReq brand = new BrandReq();
            brand.setId(id);
            resp=dubboBrandService.deleteBrand(brand);
            return resp;
        } catch (IllegalArgumentException e) {
            return Response.fail(e.getMessage());
        }
    }

}
