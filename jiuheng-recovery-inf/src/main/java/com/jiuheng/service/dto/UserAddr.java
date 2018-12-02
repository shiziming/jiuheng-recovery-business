package com.jiuheng.service.dto;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/12.
 */
@Data
public class UserAddr implements Serializable{

    /**
     * 地址id
     */
    private Integer id;
    /**
     * 用户id
     */
    private long userId;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 用户手机号
     */
    private long phone;
    /**
     * 省编码
     */
    private int province;
    /**
     * 省名称
     */
    private String provinceName;
    /**
     * 市编码
     */
    private int city;
    /**
     * 市名称
     */
    private String cityName;
    /**
     * 县编码
     */
    private int district;
    /**
     * 县名称
     */
    private String districtName;
    /**
     * 详细地址
     */
    private String detailed;
    /**
     * 邮政编码
     */
    private String zipCode;
    /**
     * 是否为默认地址
     */
    private int isDefault;
}
