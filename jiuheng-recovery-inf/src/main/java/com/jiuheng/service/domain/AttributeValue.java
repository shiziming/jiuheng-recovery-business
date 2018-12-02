package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/20.
 */
@Data
public class AttributeValue implements Serializable{

    /**
     * 属性值id
     */
    private Integer attributeValueId;
    /**
     * 属性值描述
     */
    private String attributeValueName;
}
