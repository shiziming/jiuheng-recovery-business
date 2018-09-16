package com.jiuheng.service.dto;

import java.math.BigDecimal;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/10.
 */
@Data
public class HotGoods {

    /**
     * 商品Id
     */
    private int goodsId;
    /**
     * 商品名称
     */
    private String goodsName;
    /**
     * 图片url
     */
    private String imageUrl;
    /**
     * 回收均价
     */
    private BigDecimal recoveryAveragePrice;
}
