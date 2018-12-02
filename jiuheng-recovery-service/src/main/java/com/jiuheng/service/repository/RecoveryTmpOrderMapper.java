package com.jiuheng.service.repository;

import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.respResult.CommonResponse;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/9/20.
 */
public interface RecoveryTmpOrderMapper {

    void saveTemplateOrder(@Param("tmpOrder") TemplateOrder tmpOrder);

    List<TemplateOrder> getTemplateOrder(long userId);
}
