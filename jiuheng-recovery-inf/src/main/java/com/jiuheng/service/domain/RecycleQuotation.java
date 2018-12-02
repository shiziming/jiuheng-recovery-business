package com.jiuheng.service.domain;

import java.math.BigDecimal;
import java.util.Comparator;
import java.util.Date;
import lombok.Data;

/**
 * Created by liubh on 2016/2/20.
 * 回收报价
 */
@Data
public class RecycleQuotation extends Base implements Comparator<RecycleQuotation> {

    private Long id;
    private Integer categoryId;//分类id
    private Integer brandId;//品牌id
    private Integer deviceId;//设备id
    private Integer cpId;//服务商id
    private BigDecimal basicPrice;//基础报价
    private Integer status;//状态 停用 启用
    private Date createTime;
    private Date updateTime;
    private Long  operatorId;//操作员id

    @Override
    public int compare(RecycleQuotation recycleQuotation, RecycleQuotation o2) {
        return this.getBasicPrice().subtract(recycleQuotation.getBasicPrice()).intValue() ;
    }
}
