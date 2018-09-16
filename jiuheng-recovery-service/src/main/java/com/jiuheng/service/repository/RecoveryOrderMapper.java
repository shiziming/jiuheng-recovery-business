package com.jiuheng.service.repository;

import com.jiuheng.service.domain.RecoveryOrderReq;
import com.jiuheng.service.domain.RecoveryOrderResp;
import java.util.List;

public interface RecoveryOrderMapper {

    List<RecoveryOrderResp> getOrderList(RecoveryOrderReq req,int page,int size);
}