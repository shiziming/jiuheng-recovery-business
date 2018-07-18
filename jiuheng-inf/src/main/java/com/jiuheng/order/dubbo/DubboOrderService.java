package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.RecoveryOrderReq;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;

/**
 * Created by shiziming on 2018/6/23.
 */
public interface DubboOrderService {
    Response<SearchResult> getOrderList(RecoveryOrderReq req,int page,int size);
}
