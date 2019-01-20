package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/22.
 */
@Data
public class RecoveryOrderDto implements Serializable {

    private static final long serialVersionUID = 1687104242752547887L;

    /**
     * 订单号
     */
    private String orderId;
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
    private int userAddId;
    /**
     * 商品
     */
    private String goodsName;
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
     * 用户id
     */
    private Long userId;
    /**
     * 商品id
     */
    private Integer model;
    /**
     * 省/市编码
     */
    private Integer provinceCode;
    /**
     * 市编码
     */
    private Integer cityCode;
    /**
     * 乡镇编码
     */
    private Integer districtCode;
    /**
     * 详细地址
     */
    private String detailed;
}
