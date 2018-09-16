package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.GoodsReq;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;

/**
 * Created by shiziming on 2018/7/6.
 */
public interface DubboGoodsService {

    Response<SearchResult> getGoodsList(GoodsReq goodsReq, int pageNo, int pageSize);

    Response<GoodsResp> getGoodsById(Integer goodsId);

    Response<Boolean> saveGoods(GoodsReq goodsReq);

    Response<Boolean> updateGoods(GoodsReq goodsReq);

    Response<Boolean> updateGoodsStatus(GoodsReq goodsReq);

    Response<Boolean> deleteGoods(GoodsReq goodsReq);

    Response<Boolean> duplicateGoods(Integer goodsId, String userName);
}
