package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.AttributeReq;
import com.jiuheng.order.domain.AttributeResp;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import java.util.List;

/**
 * Created by shiziming on 2018/7/22.
 */
public interface DubboAttributeService {

    Response<SearchResult> getAttributeList(AttributeReq attribute, int page,int pageSize);

    Response<SearchResult> getCategoryAttributesByCategory(Long categoryId);

    Response<Boolean> saveCategoryAttribute(Long categoryId, List<Long> attributeIds,String type);

}
