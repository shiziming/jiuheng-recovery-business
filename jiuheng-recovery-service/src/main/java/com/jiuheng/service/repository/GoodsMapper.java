package com.jiuheng.service.repository;

import com.jiuheng.service.domain.GoodsReq;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.dto.Goods;
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

    Goods queryGoodsByGoodId(Integer goodsId);
}
