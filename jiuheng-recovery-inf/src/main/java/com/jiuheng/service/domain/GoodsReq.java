package com.jiuheng.service.domain;

import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/24.
 */
@Data
public class GoodsReq implements Serializable{

    private static final long serialVersionUID = -820213171247989764L;
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
     * 状态(-1删除，0停用，1正常)）
     */
    private Integer status;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 商品ids
     */
    private List<Long> ids;
    /**
     * 属性值
     */
    private List<GoodsAttribute> attrs;
    /**
     * 排序
     */
    private Integer sequence;
    /**
     * 修改/创建人
     */
    private String updator;
    /**
     * 修改时间
     */
    private String updateTime;
}
