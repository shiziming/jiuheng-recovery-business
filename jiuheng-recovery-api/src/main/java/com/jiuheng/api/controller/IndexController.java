package com.jiuheng.api.controller;

import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.HotGoods;
import com.jiuheng.service.dubbo.DubboIndexService;
import com.jiuheng.service.respResult.CommonResponse;
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
 * Created by shiziming on 2018/9/10.
 */
@RestController
@RequestMapping("index")
@Slf4j
public class IndexController {

    @Autowired
    private DubboIndexService dubboIndexService;
    @Value("${imageUrl}")
    private String imageUrl;

    /**
     *首页banner图接口
     * @return
     */
    @RequestMapping(value = "/bannerList", method = RequestMethod.GET)
    public CommonResponse getBannerImage(){
        CommonResponse response = null;
        try {
            List<BannerImage> images = dubboIndexService.getBannerImage();
            if(images == null){
                response = new CommonResponse(5001,"image is null");
                return response;
            }else{
                for (BannerImage image:images) {
                    image.setImageUrl(imageUrl+image.getImageUrl());
                }
                response = new WebResponse<List<BannerImage>>(images);
                return response;
            }
        } catch (Exception e) {
            log.error("bannerList.error",e);
            response = new UnknowResponse();
            return response;
        }
    }

    /**
     * 首页热门机型接口
     * @return
     */
    @RequestMapping(value = "/hotGoodsList", method = RequestMethod.GET)
    public CommonResponse getHotGoodsList(){
        CommonResponse response = null;
        try {
            List<HotGoods> hotGoodses = dubboIndexService.getHotGoodsList();
            if(hotGoodses == null){
                response = new CommonResponse(5002,"hotGoods is null");
                return response;
            }else{
                for (HotGoods hotGoods:hotGoodses) {
                    hotGoods.setImageUrl(imageUrl + hotGoods.getImageUrl());
                }
                response = new WebResponse<List<HotGoods>>(hotGoodses);
                return response;
            }
        } catch (Exception e) {
            log.error("hotGoodsList.error",e);
            response = new UnknowResponse();
            return response;
        }
    }

}
