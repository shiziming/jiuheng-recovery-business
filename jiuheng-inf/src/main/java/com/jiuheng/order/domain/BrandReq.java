package com.jiuheng.order.domain;

import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/10.
 * 品牌接收参数
 */
@Data
public class BrandReq implements Serializable{
    /**
     * 品牌id
     */
    private Integer id;
    /**
     * 品牌名称
     */
    private String name;
    /**
     * 品牌拥有的设备分类
     */
    private List<BrandCategory> categories;
    /**
     * 状态
     */
    private Integer status;
}
