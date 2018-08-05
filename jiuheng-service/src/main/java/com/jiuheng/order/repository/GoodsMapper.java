package com.jiuheng.order.repository;

import com.jiuheng.order.domain.GoodsReq;
import com.jiuheng.order.domain.GoodsResp;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/7/25.
 */
public interface GoodsMapper {

    List<GoodsResp> getGoodsList(@Param("goodsReq") GoodsReq goodsReq);

    GoodsResp getGoodsById(Integer goodsId);

    void insertGoods(@Param("goodsReq")GoodsReq goodsReq);

    void updateGoods(@Param("goodsReq")GoodsReq goodsReq);
}
