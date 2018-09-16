package com.jiuheng.service.domain;

import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/8/15.
 */
@Data
public class CategoryAttributeVo extends CategoryAttribute{

    /**
     * 设备分类id
     */
    private Long categoryId;

    /**
     * 属性id集合
     */
    private List<Long> attributeIds;
}
