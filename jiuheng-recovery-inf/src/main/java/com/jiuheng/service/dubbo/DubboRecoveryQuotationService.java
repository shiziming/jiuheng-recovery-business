package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.RecycleQuotation;
import com.jiuheng.service.domain.RecycleQuotationItem;
import com.jiuheng.service.domain.RecycleQuotationItemVo;
import com.jiuheng.service.domain.RecycleQuotationVo;
import java.util.List;

/**
 * Created by shiziming on 2018/11/12.
 */
public interface DubboRecoveryQuotationService{

    public List<RecycleQuotationVo> getRecycleQuotationList(RecycleQuotation recycleQuotation,int page,int pageSize) ;

    public int getRecycleQuotationCount(RecycleQuotation recycleQuotation) ;

    public RecycleQuotationVo getRecycleQuotationById(Long id) ;

    public RecycleQuotationVo getRecycleQuotation(Integer deviceId);

    public List<RecycleQuotationItemVo> getRecycleQuotationItem(Integer deviceId,Long quotationId);

    public void saveRecycleQuotation(RecycleQuotation recycleQuotation);

    public void saveRecycleQuotationItem(RecycleQuotationItem recycleQuotationItem);
}
