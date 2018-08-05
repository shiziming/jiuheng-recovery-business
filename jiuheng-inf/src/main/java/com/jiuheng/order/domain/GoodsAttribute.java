package com.jiuheng.order.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/29.
 * 商品属性关联实体
 */
@Data
public class GoodsAttribute implements Serializable{

    private static final long serialVersionUID = 58670723805505671L;
    /**
     * 设备的属性值id
     */
    private Integer Id;
    /**
     * 设备id
     */
    private Integer goodsId;
    /**
     * 属性id
     */
    private Integer attributeId;
    /**
     * 属性值
     */
    private String attributeValue;
    /**
     * 该属性是否可供用户选择，作为维修方案的参考值,0：不可选择  1：可选择
     */
    private byte canChoose;

    private String name;
}
