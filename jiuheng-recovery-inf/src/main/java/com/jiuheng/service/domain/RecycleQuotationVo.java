package com.jiuheng.service.domain;

import java.util.List;

/**
 * Created by liubh on 2016/2/20.
 * 回收报价
 */
public class RecycleQuotationVo extends RecycleQuotation{
    private List<RecycleQuotationItemVo> recycleQuotationItemList;

    public List<RecycleQuotationItemVo> getRecycleQuotationItemList() {
        return recycleQuotationItemList;
    }

    public void setRecycleQuotationItemList(List<RecycleQuotationItemVo> recycleQuotationItemList) {
        this.recycleQuotationItemList = recycleQuotationItemList;
    }



}
