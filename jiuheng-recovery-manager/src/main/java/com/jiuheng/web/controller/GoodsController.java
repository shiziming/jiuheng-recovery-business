package com.jiuheng.web.controller;

import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.CategoryReq;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.domain.GoodsReq;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.dubbo.DubboAttributeService;
import com.jiuheng.service.dubbo.DubboBrandService;
import com.jiuheng.service.dubbo.DubboCategoryService;
import com.jiuheng.service.dubbo.DubboGoodsService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.web.utils.SysUser;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
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
    private DubboBrandService dubboBrandService;
    @Autowired
    private DubboAttributeService dubboAttributeService;

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
        String page = request.getParameter("page");
        String rows = request.getParameter("rows");
        if(null ==page  || null ==rows ){
            page ="0";
            rows ="0";
        }
        Response<SearchResult> result = dubboGoodsService.getGoodsList(goodsReq, Integer.parseInt(page), Integer.parseInt(rows));
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

    @RequestMapping("/saveGoods")
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

    @RequestMapping("/deleteGoods")
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

    @RequestMapping("/duplicateGoods")
    @ResponseBody
    public Response<Boolean> duplicateGoods(Integer id,HttpServletRequest request){
        if(id == null || id <= 0){
            throw new IllegalArgumentException("未找到设备");
        }
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        Response<Boolean> result = dubboGoodsService.duplicateGoods(id,sysUser.getUserName());
        return result;
    }

    @RequestMapping("/recycle")
    @ResponseBody
    public ModelAndView recycle(Integer id,Integer type){
        GoodsReq goods=new GoodsReq();
        goods.setId(id);
        if(goods.getId() == null || goods.getId() <= 0){
            throw new IllegalArgumentException("修改设备信息出错：参数不正确");
        }
        Response<GoodsResp> result = dubboGoodsService.getGoodsById(goods.getId());
        ModelAndView model = new ModelAndView("goods/goodsRecycleAttribute");
        model.addObject("device", result.getResult());
        return model;
    }

    @RequestMapping("/saveRecycle")
    @ResponseBody
    public Response<Boolean> saveRecycle(GoodsReq goods, String updateToken, HttpServletRequest request){
        List<GoodsAttribute> attrs = goods.getAttrs();
        //移除掉value为空的值
        for(int i = attrs.size()-1;i>=0;i--){
            if(attrs.get(i).getId()==null){
                if(attrs.get(i).getAttributeValue()==""){
                    attrs.remove(i);
                }
            }
        }

        if(goods.getId() != null){
            if(attrs!=null&&attrs.size()>0){
                for (int i = 0; i <attrs.size() ; i++) {
                    GoodsAttribute goodsAttribute = attrs.get(i);
                    goodsAttribute.setGoodsId(goods.getId());
                    if(goodsAttribute.getId()== null){
                        dubboAttributeService.insertGoodsRecycleAttributeValue(goodsAttribute);
                    }else{
                        dubboAttributeService.updateGoodsRecycleAttributeValue(goodsAttribute);
                    }
                }
            }
        }
        return Response.ok(Boolean.TRUE);
    }

    @RequestMapping("goodsRecycleAttributeValue")
    @ResponseBody
    public ModelAndView goodsRecycleAttributeValue(Integer id,Integer type){
        GoodsReq goods=new GoodsReq();
        goods.setId(id);
        if(goods.getId() == null || goods.getId() <= 0){
            throw new IllegalArgumentException("修改设备信息出错：参数不正确");
        }
        Response<GoodsResp> goodsResp = dubboGoodsService.getGoodsById(goods.getId());
        Response<SearchResult> recycleAttributeList = dubboAttributeService.getAllRecycleAttibuteWithValue(goodsResp.getResult().getCategoryId(), goodsResp.getResult().getId(), type);
        ModelAndView model = new ModelAndView("goods/goodsRecycleAttributeValue");
        model.addObject("recycleAttributeList",recycleAttributeList.getResult().getRows());
        model.addObject("device", goodsResp.getResult());
        model.addObject("type", type);
        return model;
    }
}
