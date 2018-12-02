package com.jiuheng.service.dto;

import com.jiuheng.service.domain.AttributeValue;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/20.
 */
@Data
public class RecoveryProp implements Serializable{

    /**
     * 属性id
     */
    private int id;
    /**
     * 属性名称
     */
    private String name;
    /**
     * 属性值id
     */
    private List<AttributeValue> attributeValues;
}
