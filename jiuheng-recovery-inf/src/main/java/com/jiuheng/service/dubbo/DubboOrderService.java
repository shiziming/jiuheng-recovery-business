package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.RecoveryOrderReq;
import com.jiuheng.service.domain.RecoveryOrderResp;
import com.jiuheng.service.dto.Order;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;

/**
 * Created by shiziming on 2018/6/23.
 */
public interface DubboOrderService {
    Response<SearchResult> getOrderList(RecoveryOrderReq req,int page,int size);

    CommonResponse saveOrder(Order order);

    Response<RecoveryOrderResp> getOrderDetail(String orderId);

    Response<Boolean> updateOrder(RecoveryOrderReq orderReq);


}
