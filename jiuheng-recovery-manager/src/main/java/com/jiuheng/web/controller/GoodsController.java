package com.jiuheng.web.controller;

import com.jiuheng.order.domain.BrandReq;
import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.domain.GoodsReq;
import com.jiuheng.order.domain.GoodsResp;
import com.jiuheng.order.dubbo.DubboBrandService;
import com.jiuheng.order.dubbo.DubboCategoryService;
import com.jiuheng.order.dubbo.DubboGoodsService;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.web.utils.SysUser;
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
 * 商品
 */
@Controller
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private DubboGoodsService dubboGoodsService;
    @Autowired
    private DubboCategoryService dubboCategoryService;
    @Autowired
    DubboBrandService dubboBrandService;

    @RequestMapping("/index")
    @ResponseBody
    public ModelAndView index(){
        ModelAndView m = new ModelAndView("goods/index");
        CategoryReq categoryReq = new CategoryReq();
        m.addObject("categories", dubboCategoryService.getCategoryList(categoryReq,0, 0).getResult().getRows());
        //加入-2的条件 停用的品牌也需要显示出来
        BrandReq brand = new BrandReq();
        brand.setStatus(-2);
        m.addObject("brands", dubboBrandService.getAllBranch(brand, 0,0).getResult().getRows());
        return m;
    }
    @RequestMapping("/getGoodsList")
    @ResponseBody
    public SearchResult getDeviceList(GoodsReq goodsReq,HttpServletRequest request){
        ModelMap model = new ModelMap();
        if(goodsReq.getStatus()==null){
            goodsReq.setStatus(-2);
        }
        Response<SearchResult> result = dubboGoodsService.getGoodsList(goodsReq, Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows")));
        return result.getResult();
    }

    @RequestMapping("/editGoods")
    public ModelAndView editDevice(GoodsReq goodsReq){
        if(goodsReq.getId() == null || goodsReq.getId() <= 0){
            throw new IllegalArgumentException("修改设备信息出错：参数不正确");
        }
        ModelAndView model = new ModelAndView("goods/goodsEdit");
        Response<GoodsResp> result= dubboGoodsService.getGoodsById(goodsReq.getId());
        model.addObject("device", result.getResult());
        return model;
    }

    @RequestMapping("saveGoods")
    @ResponseBody
    public Response<Boolean> saveDevice(GoodsReq goodsReq, String updateToken, HttpServletRequest request){
        Response<Boolean> result = null;
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        goodsReq.setUpdator(sysUser.getUserName());
        if(goodsReq.getId() == null){
            result = dubboGoodsService.saveGoods(goodsReq);
        }else{
            result = dubboGoodsService.updateGoods(goodsReq);
            /*List<DeviceAttributeValue> usedValues = deviceService.checkAttributeValue(device.getAttrs());

            if(usedValues == null){
                deviceService.updateDevice(device);
                model.addAttribute("result", 1);
            }else{
                //属性已经在方案中使用，提示用户。
                //如果用户未确认强制更新
                if(StringUtils.isTrimEmpty(updateToken)){
                    model.clear();
                    model.addAttribute("result", 2);
                    String token = RandomCodeUtils.makeLetterCode(32);
                    request.getSession().setAttribute(FORCE_UPDATE, token);

                    model.addAttribute("updateToken", token);
                }else{
                    //用户确认强制更新，执行更新
                    Object token = request.getSession().getAttribute(FORCE_UPDATE);
                    if(token == null || !updateToken.equals(token)){
                        throw new IllegalArgumentException("未找到该token，请重新提交");
                    }else{
                        deviceService.updateDevice(device);
                        model.addAttribute("result", 1);
                        request.getSession().removeAttribute(FORCE_UPDATE);
                    }
                }
            }*/
        }
        return result;
    }

    @RequestMapping("editStatus")
    @ResponseBody
    public Response<Boolean> editStatus(Integer id, Integer status, HttpServletRequest request) {
        Response<Boolean> result = null;
        GoodsReq goodsReq = new GoodsReq();
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        goodsReq.setId(id);
        goodsReq.setStatus(status);
        goodsReq.setUpdator(sysUser.getUserAccount());
        result = dubboGoodsService.updateGoodsStatus(goodsReq);
        return result;
    }

    @RequestMapping("deleteGoods")
    @ResponseBody
    public Response<Boolean> deleteGoods(Integer id ,HttpServletRequest request){
        Response<Boolean> result = null;
        if(id == null || id <= 0){
            throw new IllegalArgumentException("未找到设备");
        }
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        GoodsReq goodsReq = new GoodsReq();
        goodsReq.setId(id);
        goodsReq.setStatus(-1);
        goodsReq.setUpdator(sysUser.getUserName());
        result = dubboGoodsService.deleteGoods(goodsReq);
        return result;
    }

    @RequestMapping("duplicateGoods")
    public Response<Boolean> duplicateGoods(Integer id,HttpServletRequest request){
        if(id == null || id <= 0){
            throw new IllegalArgumentException("未找到设备");
        }
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        Response<Boolean> result = dubboGoodsService.duplicateGoods(id,sysUser.getUserName());
        return result;
    }
}
