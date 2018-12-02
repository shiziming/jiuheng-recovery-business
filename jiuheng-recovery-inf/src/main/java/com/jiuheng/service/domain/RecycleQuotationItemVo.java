package com.jiuheng.service.domain;

/**
 * Created by liubh on 2016/2/20.
 * 回收报价
 */
public class RecycleQuotationItemVo extends RecycleQuotationItem{

    private String attributeName;//属性名
    private String attributeValue;//属性值
    private Integer attributeType;//属性类型

    public String getAttributeName() {
        return attributeName;
    }

    public void setAttributeName(String attributeName) {
        this.attributeName = attributeName;
    }

    public String getAttributeValue() {
        return attributeValue;
    }

    public void setAttributeValue(String attributeValue) {
        this.attributeValue = attributeValue;
    }

    public Integer getAttributeType() {
        return attributeType;
    }

    public void setAttributeType(Integer attributeType) {
        this.attributeType = attributeType;
    }
}
