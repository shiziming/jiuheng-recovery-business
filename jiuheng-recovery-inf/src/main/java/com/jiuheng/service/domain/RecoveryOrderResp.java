package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/1.
 */
@Data
public class RecoveryOrderResp implements Serializable{
    /**
     * 订单号
     */
    private String orderId;
    /**
     * 用户id
     */
    private Long userId;
    /**
     * 状态
     */
    private int status;
    /**
     * 订单类型
     */
    private int orderType;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 用户电话
     */
    private Long userPhone;
    /**
     * 用户地址
     */
    private String userAdd;
    /**
     * 用户地址Id
     */
    private int addId;
    /**
     * 商品
     */
    private String goodsName;
    /**
     * 商品Id
     */
    private int goodsId;
    /**
     * 估价金额
     */
    private int valuationPrice;
    /**
     * 成交金额
     */
    private int dealPrice;
    /**
     * 运费金额
     */
    private int freightPrice;
    /**
     * 支付方式
     */
    private int payType;
    /**
     * 上门时间
     */
    private String onDoorTime;
    /**
     * 提交时间
     */
    private String subTime;
    /**
     * 支付时间
     */
    private String payTime;
    /**
     * 备注
     */
    private String message;
    /**
     * 回收方式(1:上门;2:邮寄)
     */
    private int recoveryType;
    /**
     * 省编码
     */
    private int province;
    /**
     * 市编码
     */
    private int city;
    /**
     * 区编码
     */
    private int district;
    /**
     * 详细地址
     */
    private String detailed;
}
