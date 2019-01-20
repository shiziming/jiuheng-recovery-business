package com.jiuheng.web.controller;

import com.jiuheng.service.dto.RegionList;
import com.jiuheng.service.dubbo.DubboRegionService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by shiziming on 2018/12/11.
 */
@RestController
@RequestMapping("region")
@Slf4j
public class RegionController {

    @Autowired
    private DubboRegionService dubboRegionService;

    @RequestMapping(value = "/getProvinces", method = RequestMethod.GET)
    public CommonResponse getProvinces(){
        CommonResponse response = null;
        try {
            CommonResult<RegionList> result = dubboRegionService.getProvinces();
            if(null != result && result.getData() != null){
                response = new WebResponse<>(result.getData());
            }else{
                response = new CommonResponse();
            }
        } catch (Exception e) {
            log.error("getProvinces.error",e);
            response = new UnknowResponse();
        }
        return response;
    }

    @RequestMapping(value = "/getCitys", method = RequestMethod.GET)
    public CommonResponse getCitys(String provinceId){
        CommonResponse response = null;
        try {
            CommonResult<RegionList> result = dubboRegionService.getCitys(provinceId);
            if(null != result && result.getData() != null){
                response = new WebResponse<>(result.getData());
            }else{
                response = new CommonResponse();
            }
        } catch (Exception e) {
            log.error("getCitys.error",e);
            response = new UnknowResponse();
        }
        return response;
    }

    @RequestMapping(value = "/getCountys", method = RequestMethod.GET)
    public CommonResponse getCountys(String cityId){
        CommonResponse response = null;
        try {
            CommonResult<RegionList> result = dubboRegionService.getCountys(cityId);
            if(null != result && result.getData() != null){
                response = new WebResponse<>(result.getData());
            }else{
                response = new CommonResponse();
            }
        } catch (Exception e) {
            log.error("getCountys.error",e);
            response = new UnknowResponse();
        }
        return response;
    }
}
