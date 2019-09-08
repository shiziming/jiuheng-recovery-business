package com.jiuheng.service.dto;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/20.
 */
@Data
public class OrderResp extends TemplateOrder implements Serializable{

    /**
     * 地址id
     */
    private int addrId;
    /**
     * 预约时间
     */
    private String onDoorTime;
    /**
     * 备注
     */
    private String remark;
    /**
     * 估价金额
     */
    private int valuationPrice;
    /**
     * 支付方式
     */
    private int payType;
    /**
     * 回收方式(1:上门;2:邮寄)
     */
    private int recoveryType;
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
     * 省名称
     */
    private String provinceName;
    /**
     * 市名称
     */
    private String cityName;
    /**
     * 县名称
     */
    private String districtName;
    /**
     * 详细地址
     */
    private String detailed;
    /**
     * 支付时间
     */
    private String payTime;
}
