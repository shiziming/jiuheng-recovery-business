package com.jiuheng.order.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/10.
 */
@Data
public class BrandReq implements Serializable{
    /**
     * 品牌id
     */
    private int id;
    /**
     * 品牌名称
     */
    private String name;
}
