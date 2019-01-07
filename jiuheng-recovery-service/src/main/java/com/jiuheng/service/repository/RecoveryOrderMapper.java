package com.jiuheng.service.repository;

import com.jiuheng.service.domain.RecoveryOrderDto;
import com.jiuheng.service.domain.RecoveryOrderReq;
import com.jiuheng.service.domain.RecoveryOrderResp;
import com.jiuheng.service.respResult.Response;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface RecoveryOrderMapper {

    List<RecoveryOrderResp> getOrderList(RecoveryOrderReq req,int page,int size);

    void saveOrder(@Param("recoveryOrderDto") RecoveryOrderDto recoveryOrderDto);

    RecoveryOrderResp getOrderDetail(String orderId);

    void updateOrder(@Param("recoveryOrderReq") RecoveryOrderReq recoveryOrderReq);
}