package com.jiuheng.web.controller;

import com.jiuheng.order.domain.AttributeReq;
import com.jiuheng.order.domain.AttributeResp;
import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.domain.CategoryResp;
import com.jiuheng.order.dubbo.DubboAttributeService;
import com.jiuheng.order.dubbo.DubboCategoryService;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.web.utils.StringUtils;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/7/9.
 */
@Controller
@RequestMapping("/attribute")
public class AttributeController {

    @Autowired
    private DubboAttributeService dubboAttributeService;
    @Autowired
    private DubboCategoryService dubboCategoryService;
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("attribute/index");
        return m;
    }

    @RequestMapping("/getAttributeList")
    @ResponseBody
    public Map getAttributeList(AttributeReq attribute,Long categoryId,String type){
        Map model = new HashMap();
        attribute.setType(type);
        Response<SearchResult> attrResult= dubboAttributeService.getAttributeList(attribute, 0, 0);
        Response<SearchResult> attrByCateResult= dubboAttributeService.getCategoryAttributesByCategory(categoryId);
        model.put("rows", attrResult.getResult().getRows());
        model.put("exist", attrByCateResult.getResult().getRows());
        return model;
    }
    @RequestMapping("saveCategoryAttributes")
    @ResponseBody
    public Response<Boolean> saveCategoryAttributes(Long categoryId, String attributes,String type){
        if(categoryId == null || categoryId <= 0){
            throw new IllegalArgumentException("错误的设备分类");
        }

        if(StringUtils.isTrimEmpty(attributes)){
            throw new IllegalArgumentException("未选择属性");
        }

        String[] attrs = attributes.split(",");
        Long[] attrIds = new Long[attrs.length];
        for (int i=0,j= attrs.length;i<j ;i++) {
            attrIds[i] = Long.parseLong(attrs[i]);
        }
        Response<Boolean> result = dubboAttributeService.saveCategoryAttribute(categoryId, Arrays.asList(attrIds),type);

        return result;
    }

    @RequestMapping("deleteDeviceCategory")
    @ResponseBody
    public Response<Boolean> deleteDeviceCategory(Integer id, HttpServletRequest request){
        if(id != null && id <= 0){
            throw new IllegalArgumentException("设备分类参数不正确");
        }

        CategoryReq categoryReq = new CategoryReq();
        categoryReq.setId(id);
        /*Admin user = RequestUtil.getLoginAdmin(request);
        deviceCategory.setUpdator(user.getPin());*/
        categoryReq.setStatus((byte)-1);
        Response<Boolean> result = dubboCategoryService.deleteDeviceCategory(categoryReq);
        return result;
    }
}
