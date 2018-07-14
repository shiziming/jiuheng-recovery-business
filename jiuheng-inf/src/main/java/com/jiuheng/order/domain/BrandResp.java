package com.jiuheng.order.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/10.
 * 商品品牌
 */
@Data
public class BrandResp implements Serializable{

    /**
     *品牌id
     */
    private int id;
    /**
     *父级id,root为-1
     */
    private int fid;
    /**
     *品牌名称
     */
    private String name;
    /**
     *品牌图标相对路径
     */
    private String pic;
    /**
     *排序值
     */
    private int sort;
    /**
     *状态：-1删除，0停用，1正常
     */
    private int status;
    /**
     *记录创建时间
     */
    private String createTime;
    /**
     *最近更新时间
     */
    private String updateTime;
    /**
     *最近更新人名称
     */
    private String updator;
    /**
     * 品类id
     */
    private int categoryId;
    /**
     * 品类名称
     */
    private String cname;
}
