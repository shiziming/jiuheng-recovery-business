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


}
