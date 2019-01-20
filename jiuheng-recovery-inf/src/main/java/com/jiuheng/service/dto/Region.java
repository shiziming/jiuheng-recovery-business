package com.jiuheng.service.dto;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/11.
 */
@Data
public class Region implements Serializable{

    /**
     * 区域code
     */
    private String regionCode;
    /**
     * 区域名称
     */
    private String regionName;
}
