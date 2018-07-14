package com.jiuheng.order.repository;

import com.jiuheng.order.domain.RecoveryOrderReq;
import com.jiuheng.order.domain.RecoveryOrderResp;
import java.util.List;

public interface RecoveryOrderMapper {

    List<RecoveryOrderResp> getOrderList(RecoveryOrderReq req,int page,int size);
}