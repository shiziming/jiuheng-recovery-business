package com.jiuheng.order.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/22.
 */
@Data
public class AttributeResp implements Serializable{

    private static final long serialVersionUID = 5009129817445866373L;

    /**
     * 属性id
     */
    private Integer id;
    /**
     * 属性名称
     */
    private String name;
    /**
     * 属性类型（1、基本属性，2、功能属性，3、外观属性）
     */
    private String type;
    /**
     * 商品id
     */
    private Integer goodsId;

}
