package com.jiuheng.service.repository;

import com.jiuheng.service.domain.RecycleQuotation;
import com.jiuheng.service.domain.RecycleQuotationItem;
import com.jiuheng.service.domain.RecycleQuotationItemVo;
import com.jiuheng.service.domain.RecycleQuotationVo;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by liubh on 2015/12/14.
 */
public interface RecoveryQuotationMapper {

   public List<RecycleQuotationItemVo> getRecycleQuotationItem(@Param("deviceId") Integer deviceId,
       @Param("quotationId") Long quotationId);

    public RecycleQuotationVo getRecycleQuotation(@Param("deviceId") Integer deviceId);

    public RecycleQuotationVo getRecycleQuotationById(@Param("id") Long id);

    public void addRecycleQuotation(@Param("recycleQuotation") RecycleQuotation recycleQuotation);

    public void updateRecycleQuotation(@Param("recycleQuotation") RecycleQuotation recycleQuotation);

    public void addRecycleQuotationItem(
        @Param("recycleQuotationItem") RecycleQuotationItem recycleQuotationItem);

    public void updateRecycleQuotationItem(
        @Param("recycleQuotationItem") RecycleQuotationItem recycleQuotationItem);

    public List<RecycleQuotationVo> getRecycleQuotationList(
        @Param("recycleQuotation") RecycleQuotation recycleQuotation, @Param("start") int start,
        @Param("pageSize") int pageSize);

    public int getRecycleQuotationCount(
        @Param("recycleQuotation") RecycleQuotation recycleQuotation);

}
