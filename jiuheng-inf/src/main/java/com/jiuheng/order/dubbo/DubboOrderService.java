package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.RecoveryOrderReq;
import com.jiuheng.order.domain.RecoveryOrderResp;
import com.jiuheng.order.domain.Response;
import com.jiuheng.order.domain.SearchResult;
import java.util.List;

/**
 * Created by shiziming on 2018/6/23.
 */
public interface DubboOrderService {
    Response<SearchResult> getOrderList(RecoveryOrderReq req,int page,int size);
}
