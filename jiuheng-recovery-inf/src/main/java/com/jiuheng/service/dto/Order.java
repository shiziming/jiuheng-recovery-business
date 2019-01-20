package com.jiuheng.service.dto;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/20.
 */
@Data
public class Order implements Serializable{

    /**
     * 零时订单号
     */
    private String templateOrderId;
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
    private Long userId;
}
