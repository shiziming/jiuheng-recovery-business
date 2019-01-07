package com.jiuheng.api.controller;

import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandResp;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.dubbo.DubboBrandService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by shiziming on 2018/9/13.
 */
@RestController
@RequestMapping("goods")
@Slf4j
public class GoodsController {

    @Autowired
    private DubboBrandService dubboBrandService;

    @RequestMapping(value = "/getBrandByCategory", method = RequestMethod.GET)
    public CommonResponse getBrandByCategory(Long categoryId){
        CommonResponse response = null;
        try {
            Response<SearchResult> result =  dubboBrandService.getBrandByCategory(categoryId);
            if(result.getResult() != null && result.getResult().getRows() != null && result.getResult().getRows().size()>0){
                response = new WebResponse<>(result.getResult().getRows());
            }else{
                response = new CommonResponse();
            }
        } catch (Exception e) {
            log.error("getBrandByCategory.error",e);
            response = new UnknowResponse();
        }
        return response;

    }

    @RequestMapping(value = "/getGoodsByBrand", method = RequestMethod.GET)
    public CommonResponse getGoodsByBrand(int brandId){
    CommonResponse response = null;
    try {
        CommonResult<BrandResp> result =  dubboBrandService.getGoodsByBrand(brandId);
        if(null != result && result.getData() != null){
            response = new WebResponse<>(result.getData());
        }else{
            response = new CommonResponse();
        }
    } catch (Exception e) {
        log.error("getGoodsByBrand.error",e);
        response = new UnknowResponse();
    }
    return response;
    }

    @RequestMapping(value = "/getAttrByGoodsId", method = RequestMethod.GET)
    public CommonResponse getAttrByGoodsId(int goodsId){
        CommonResponse response = null;
        try {
            CommonResult<List<GoodsAttribute>> result =  dubboBrandService.getAttrByGoodsId(goodsId);
            if(null != result && result.getData() != null){
                response = new WebResponse<>(result.getData());
            }else{
                response = new CommonResponse();
            }
        } catch (Exception e) {
            log.error("getAttrByGoodsId.error",e);
            response = new UnknowResponse();
        }
        return response;
    }
}
