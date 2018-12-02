package com.jiuheng.web.controller;

import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.CategoryReq;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.domain.GoodsReq;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.domain.RecycleQuotation;
import com.jiuheng.service.domain.RecycleQuotationItemVo;
import com.jiuheng.service.domain.RecycleQuotationVo;
import com.jiuheng.service.dubbo.DubboBrandService;
import com.jiuheng.service.dubbo.DubboCategoryService;
import com.jiuheng.service.dubbo.DubboGoodsService;
import com.jiuheng.service.dubbo.DubboRecoveryQuotationService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.web.domain.CurrentSysUser;
import com.jiuheng.web.utils.SysUser;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/10/29.
 */
@Controller
@RequestMapping("/recovery")
public class RecoveryController {

    @Autowired
    private DubboCategoryService dubboCategoryService;
    @Autowired
    private DubboBrandService dubboBrandService;
    @Autowired
    private DubboGoodsService dubboGoodsService;
    @Autowired
    private DubboRecoveryQuotationService dubboRecoveryQuotationService;
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("recovery/index");
        return m;
    }
    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(RecycleQuotation recycleQuotation,int page, int rows){
        Map model = new HashMap();
        List<RecycleQuotationVo> list = dubboRecoveryQuotationService.getRecycleQuotationList(recycleQuotation, page, rows);
        model.put("rows", list);
        model.put("total", dubboRecoveryQuotationService.getRecycleQuotationCount(recycleQuotation));
        return model;
    }
    @RequestMapping("getProduct")
    @ResponseBody
    public Map getProduct(RecycleQuotationVo recycleQuotationVo){
        Map model = new HashMap();
        CategoryResp category=new CategoryResp();
        Brand brand = new Brand();
        GoodsResp device=new GoodsResp();
        if(recycleQuotationVo.getCategoryId()!=null){
            Response<CategoryResp>  responseCategoryResp = dubboCategoryService.getDeviceCategory(recycleQuotationVo.getCategoryId());
            if(responseCategoryResp.getResult() != null){
                category = responseCategoryResp.getResult();
            }
        }
        if(recycleQuotationVo.getBrandId()!=null){
            BrandReq brandReq = new BrandReq();
            brandReq.setId(recycleQuotationVo.getBrandId());
            Response<Brand> responseBrand = dubboBrandService.getBrandById(brandReq);
            if(responseBrand.getResult() != null){
                brand = responseBrand.getResult();
            }
        }
        if(recycleQuotationVo.getDeviceId()!=null){
            Response<GoodsResp> responseGoodsResp = dubboGoodsService.getGoodsById(recycleQuotationVo.getDeviceId());
            if(responseGoodsResp.getResult() != null){
                device = responseGoodsResp.getResult();
            }
        }
        /*if(user!=null){
            if(user.getCpId()==null||user.getCpId()==0){
                cpId="-1";
            }else{
                cpId=user.getCpId().toString();
            }
        }
        List<Cp> cpList = new ArrayList<Cp>();
        try{
            cpList = cpService.getCpUserList(new HashMap<String, Object>(),null);
        }catch (Exception e){
            e.printStackTrace();
        }*/
        CategoryReq categoryReq = new CategoryReq();
        model.put("categories", dubboCategoryService.getCategoryList(categoryReq, 0,0).getResult());
        model.put("brands", dubboBrandService.getAllBranch(new BrandReq(), 0,0).getResult());
        model.put("devices", dubboGoodsService.getGoodsList(new GoodsReq(), 0,0).getResult());
        model.put("category",category);
        model.put("brand",brand);
        model.put("device",device);
        return model;
    }

    /**
     * 编辑回收报价页
     * @param recycleQuotation
     * @return
     */
    @RequestMapping("editRecycleQuotation")
    public ModelAndView editRecycleQuotation(Long id,RecycleQuotation recycleQuotation) {

        ModelAndView model=new ModelAndView("recovery/recoveryQuotation");
        if(recycleQuotation != null && recycleQuotation.getId() != null){
            recycleQuotation = dubboRecoveryQuotationService.getRecycleQuotationById(recycleQuotation.getId());
        }
        if(id != null ){
            recycleQuotation = dubboRecoveryQuotationService.getRecycleQuotationById(id);
        }
        model.addObject("recycleQuotation", recycleQuotation);
        model.addObject("categories", dubboCategoryService.getCategoryList(new CategoryReq(), 0,0).getResult());
        model.addObject("brands", dubboBrandService.getAllBranch(new BrandReq(), 0,0).getResult());
        return model;
    }

    /**
     * 选择好设备id
     * @param recycleQuotation
     * @return
     */
    @RequestMapping("recycleQuotation")
    @ResponseBody
    public Map recycleQuotation(RecycleQuotation recycleQuotation) {
        Map model = new HashMap();
        Integer deviceid=recycleQuotation.getDeviceId();
        if(recycleQuotation != null && recycleQuotation.getId() != null && recycleQuotation.getId() >0){
            recycleQuotation = dubboRecoveryQuotationService.getRecycleQuotationById(recycleQuotation.getId());
        }else{
            recycleQuotation = dubboRecoveryQuotationService.getRecycleQuotation(recycleQuotation.getDeviceId());
        }
        Long quotationId = recycleQuotation != null && recycleQuotation.getId() != null ? recycleQuotation.getId() : null;
        List<RecycleQuotationItemVo> recycleQuotationItemList = dubboRecoveryQuotationService.getRecycleQuotationItem(deviceid,quotationId);

        model.put("recycleQuotation",recycleQuotation);
        model.put("recycleQuotationItemList",recycleQuotationItemList);
        return model;
    }
}
