package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/8/15.
 * 品类属性
 */
@Data
public class CategoryAttribute implements Serializable {

    private static final long serialVersionUID = -4886157204119029823L;
    /**
     * 编号
     */
    private Long id;

    /**
     * 属性名称
     */
    private String name;

    /**
     *属性类型
     * 1:基本属性/2:功能异常/3:外观异常
     */
    private Integer type;
}
