package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/6/28.
 * 回收订单查询参数
 */
@Data
public class RecoveryOrderReq implements Serializable{

    private static final long serialVersionUID = 4545645145458124698L;
    /**
     * 订单金额
     */
    private String orderId;
    /**
     * 订单状态
     */
    private Integer orderStatus;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 用户id
     */
    private String userId;
    /**
     * 用户手机号
     */
    private Long userPhone;
    /**
     * 支付类型
     */
    private Integer payType;
    /**
     * 订单查询开始日期
     */
    private String subStartTime;
    /**
     * 订单查询结束日期
     */
    private String subEndTime;
    /**
     * 回收方式
     */
    private int recoveryType;
    /**
     * 顾客留言
     */
    private String message;
    /**
     * 成交金额
     */
    private double dealPrice;
    /**
     * 运费
     */
    private double freightPrice;
    /**
     * 预约上门时间
     */
    private String onDoorTime;
    /**
     * 地址id
     */
    private int addId;
    /**
     * 省编码
     */
    private String province;
    /**
     * 市编码
     */
    private String city;
    /**
     * 乡镇编码
     */
    private String county;
    /**
     * 详细地址
     */
    private String detailed;
}
