package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.HotGoods;
import com.jiuheng.service.repository.IndexMapper;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/9/10.
 */
@Service("dubboIndexService")
public class DubboIndexServiceImpl implements DubboIndexService{

    private Logger log = LoggerFactory.getLogger(DubboIndexService.class);

    @Autowired
    private IndexMapper indexMapper;
    public List<BannerImage> getBannerImage(){
        try {
            List<BannerImage> images = indexMapper.getBannerImage();
            return images;
        } catch (Exception e) {
            log.error("DubboIndexService.getBannerImage",e);
            return null;
        }
    }

    public List<HotGoods> getHotGoodsList(){
        try {
            List<HotGoods> hotGoodses = indexMapper.getHotGoodsList();
            return hotGoodses;
        } catch (Exception e) {
            log.error("DubboIndexService.getHotGoodsList",e);
            return null;
        }
    }


}
