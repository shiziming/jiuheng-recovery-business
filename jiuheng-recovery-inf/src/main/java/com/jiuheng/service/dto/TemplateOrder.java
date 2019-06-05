package com.jiuheng.service.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/19.
 */
@Data
public class TemplateOrder implements Serializable{

    /**
     * 订单id
     */
    private String orderId;
    /**
     * 用户id
     */
    private long userId;
    /**
     * 商品id
     */
    private int goodsId;
    /**
     * 商品名称
     */
    private String goodsName;
    /**
     * 状态（0：失效 1有效）
     */
    private int status;
    /**
     * 提交属性集合
     */
    private List<RecoveryProp> props;
    /**
     * 零时订单bean转成的json
     */
    private String orderDetail;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 订单金额
     */
    private BigDecimal price;
}
