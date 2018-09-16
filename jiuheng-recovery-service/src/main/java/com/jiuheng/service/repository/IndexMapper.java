package com.jiuheng.service.repository;

import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.HotGoods;
import java.util.List;

/**
 * Created by shiziming on 2018/9/10.
 */
public interface IndexMapper {

    List<BannerImage> getBannerImage();

    List<HotGoods> getHotGoodsList();

}
