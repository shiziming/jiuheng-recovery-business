package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/1.
 */
@Data
public class RecoveryOrder implements Serializable{

    /**
     *订单Id
     */
    private String orderId;
    /**
     *1:回收
     */
    private int orderType;
    /**
     *订单状态
     */
    private int status;
    /**
     *回收方式(1:上门;2:邮寄)
     */
    private int recoveryType;
    /**
     *用户id
     */
    private Long userId;
    /**
     *用户地址id
     */
    private int addrId;
    /**
     *商品id
     */
    private int skuId;
    /**
     *估价金额(单位：分)
     */
    private int valuationPrice;
    /**
     *成交金额(单位：分)
     */
    private int dealPrice;
    /**
     *运费金额(单位：分)
     */
    private int freightPrice;
    /**
     *支付类型
     */
    private int payType;
    /**
     *上门时间
     */
    private String onDoorTime;
    /**
     *订单提交时间
     */
    private String subTime;
    /**
     *支付时间
     */
    private String payTime;
    /**
     *客户留言
     */
    private String message;
    /**
     *创建时间
     */
    private String createTime;
    /**
     *修改时间
     */
    private String updateTime;
}
