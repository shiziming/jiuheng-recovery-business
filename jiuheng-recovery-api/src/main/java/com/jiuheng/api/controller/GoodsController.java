package com.jiuheng.api.controller;

import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandResp;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.dubbo.DubboBrandService;
import com.jiuheng.service.dubbo.DubboCategoryService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
    @Autowired
    private DubboCategoryService dubboCategoryService;
    @Value("${imageUrl}")
    private String imageUrl;

    @RequestMapping(value = "/getBrandByCategory", method = RequestMethod.GET)
    public CommonResponse getBrandByCategory(Long categoryId){
        CommonResponse response = null;
        try {
            Response<SearchResult> result =  dubboBrandService.getBrandByCategory(categoryId);
            if(result.getResult() != null && result.getResult().getRows() != null && result.getResult().getRows().size()>0){
                List<Brand> brands = (List<Brand>)result.getResult().getRows();
                if(null != brands && brands.size()>0){
                    for (Brand brand:brands) {
                        brand.setPic(imageUrl + brand.getPic());
                    }
                }
                response = new WebResponse<>(brands);
            }else if(result.getError() != null){
                response = new CommonResponse(500,"服务器内部错误");
            }else{
                response = new CommonResponse(200,"");

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
            BrandResp resp = result.getData();
            resp.setPic(imageUrl + resp.getPic());
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
    @RequestMapping(value = "/getCategory", method = RequestMethod.GET)
    public CommonResponse getCategory(){
        CommonResponse response = null;
        Response<SearchResult> result = dubboCategoryService.getCategory();
        if(result.getResult() != null && result.getResult().getRows() != null && result.getResult().getRows().size()>0){
            List<CategoryResp> list = (List<CategoryResp>)result.getResult().getRows();
            for (CategoryResp categoryResp:list) {
                categoryResp.setCategoryPic(imageUrl+categoryResp.getCategoryPic());
            }
            response = new WebResponse<>();
        }else if(result.getError() != null){
            response = new CommonResponse(Integer.parseInt(result.getError()),result.getErrorMessage());
        }else{
            response = new CommonResponse(200,"");
        }
        return response;
    }
}
