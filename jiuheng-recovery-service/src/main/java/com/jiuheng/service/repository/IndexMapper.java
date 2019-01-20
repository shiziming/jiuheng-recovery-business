package com.jiuheng.service.repository;

import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.HotGoods;
import com.jiuheng.service.dto.IndexPicture;
import java.util.List;

/**
 * Created by shiziming on 2018/9/10.
 */
public interface IndexMapper {

    List<BannerImage> getBannerImage();

    List<HotGoods> getHotGoodsList();

    void savePicture(List<BannerImage> pics);

    void updatePicture();
}
