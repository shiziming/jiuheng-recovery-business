package com.jiuheng.service.dto;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/31.
 */
@Data
public class PropsView implements Serializable{

    /**
     * 属性展示1
     */
    private RecoveryProp prop1;
    /**
     * 属性展示2
     */
    private RecoveryProp prop2;
    /**
     * 属性展示3
     */
    private RecoveryProp prop3;

}
