package com.jiuheng.order.domain;

import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/24.
 */
@Data
public class GoodsResp implements Serializable{


    private static final long serialVersionUID = -3496245635084635031L;

    /**
     * 商品id
     */
    private Integer id;
    /**
     * 商品名称
     */
    private String model;
    /**
     * 图片路径
     */
    private String pic;
    /**
     * 品牌id
     */
    private Integer brandId;
    /**
     * 品类id
     */
    private Integer categoryId;
    /**
     * 商品分类路径
     */
    private String indexPath;
    /**
     * 排序字段
     */
    private Integer sequence;
    /**
     * 状态（0:停用,1启用）
     */
    private Integer status;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 修改时间
     */
    private String updateTime;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 品类路径
     */
    private String categoryPathName;
    /**
     * 属性值
     */
    private List<AttributeResp> attrs;
    /**
     * 修改/创建人
     */
    private String updator;
}
