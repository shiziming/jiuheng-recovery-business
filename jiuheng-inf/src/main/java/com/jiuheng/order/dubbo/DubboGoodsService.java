package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.GoodsReq;
import com.jiuheng.order.domain.GoodsResp;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import java.util.List;

/**
 * Created by shiziming on 2018/7/6.
 */
public interface DubboGoodsService {

    Response<SearchResult> getGoodsList(GoodsReq goodsReq, int pageNo, int pageSize);

    Response<GoodsResp> getGoodsById(Integer goodsId);

    Response<Boolean> saveGoods(GoodsReq goodsReq);

    Response<Boolean> updateGoods(GoodsReq goodsReq);

}
