package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.HotGoods;
import com.jiuheng.service.dto.IndexPicture;
import com.jiuheng.service.respResult.Response;
import java.util.List;

/**
 * Created by shiziming on 2018/9/10.
 */
public interface DubboIndexService {

    List<BannerImage> getBannerImage();

    Response<Boolean> savePicture(IndexPicture pics);

    List<HotGoods> getHotGoodsList();

    Response<Boolean> saveHotModels(List<HotGoods> hotModels);

}
