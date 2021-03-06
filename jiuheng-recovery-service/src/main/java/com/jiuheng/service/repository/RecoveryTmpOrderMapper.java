package com.jiuheng.service.repository;

import com.jiuheng.service.dto.OrderResp;
import com.jiuheng.service.dto.TemplateOrder;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/9/20.
 */
public interface RecoveryTmpOrderMapper {

    void saveTemplateOrder(@Param("tmpOrder") TemplateOrder tmpOrder);

    List<TemplateOrder> getTemplateOrder(long userId);

    TemplateOrder getTemplateOrderId(String orderId);

    TemplateOrder getTemplateOrderIds(String orderId);

    void updateTemplateOrder(String orderId);

    List<OrderResp> getOrderList(long userId);

    OrderResp getOrderDatail(@Param("userId") Long userId,@Param("orderId") String orderId);

}
