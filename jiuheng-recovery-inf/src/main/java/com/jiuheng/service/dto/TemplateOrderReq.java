package com.jiuheng.service.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/19.
 */
@Data
public class TemplateOrderReq implements Serializable{

    /**
     * 订单编号
     */
    private String orderId;
    /**
     * 报价
     */
    private BigDecimal price;
}
