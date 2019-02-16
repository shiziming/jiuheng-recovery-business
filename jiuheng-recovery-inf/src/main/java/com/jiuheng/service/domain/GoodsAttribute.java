package com.jiuheng.service.domain;

import java.io.Serializable;
import java.util.List;
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
    private Integer id;
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
    /**
     * 属性名称
     */
    private String name;
    /**
     * 属性的类型
     */
    private Integer attributeType;
    /**
     * 属性集合
     */
    private List<AttributeValue> attributeValueList;
    /**
     * 是否必选
     * 0 是单选 1 是多选 2 单选非必选 3 多选非必选
     */
    private Integer choice;
}
