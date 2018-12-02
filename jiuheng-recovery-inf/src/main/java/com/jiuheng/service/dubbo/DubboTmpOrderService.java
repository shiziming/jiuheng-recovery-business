package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.respResult.CommonResponse;
import java.util.List;

/**
 * Created by shiziming on 2018/9/20.
 */
public interface DubboTmpOrderService {

    CommonResponse saveTemplateOrder(TemplateOrder tmpOrder);

    List<TemplateOrder> getTemplateOrder(long userId);
}
