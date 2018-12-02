package com.jiuheng.service.domain;

import java.math.BigDecimal;
import lombok.Data;

/**
 * Created by liubh on 2016/2/20.
 * 回收报价
 */
@Data
public class RecycleQuotationItem extends Base {
    private Integer id;
    private Integer quotationId;//报价id
    private Integer attributeId;//属性id
    private Integer attributeValueId;//设备id
    private Integer type;//报价项类型  参考 RecycleQuotationItemTypeConstant
    private BigDecimal price;//报价

}
