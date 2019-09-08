package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.Order;
import com.jiuheng.service.dto.OrderResp;
import com.jiuheng.service.dto.RecoveryProp;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.respResult.CommonResponse;
import java.util.List;

/**
 * Created by shiziming on 2018/9/20.
 */
public interface DubboTmpOrderService {

    CommonResponse saveTemplateOrder(TemplateOrder tmpOrder);

    List<TemplateOrder> getTemplateOrder(long userId);

    List<RecoveryProp> getTemplateOrderByOrderId(String orderId);

    List<OrderResp> getOrderList(long userId);

    OrderResp getOrderDatail(Long userId,String orderId);
}
