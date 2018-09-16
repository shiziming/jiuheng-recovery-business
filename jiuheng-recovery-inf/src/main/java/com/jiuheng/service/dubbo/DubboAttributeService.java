package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.AttributeReq;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import java.util.List;

/**
 * Created by shiziming on 2018/7/22.
 */
public interface DubboAttributeService {

    Response<SearchResult> getAttributeList(AttributeReq attribute, int page,int pageSize);

    Response<SearchResult> getCategoryAttributesByCategory(Long categoryId);

    Response<Boolean> saveCategoryAttribute(Long categoryId, List<Long> attributeIds,String type);

    Response<Boolean> insertGoodsRecycleAttributeValue(GoodsAttribute goodsAttribute);

    Response<Boolean>  updateGoodsRecycleAttributeValue(GoodsAttribute goodsAttribute);
    /**
     * 获取所有回收属性 （包括设置的值）
     * @return
     */
    Response<SearchResult> getAllRecycleAttibuteWithValue(Integer categoryId,Integer goodsId,Integer attributeType);

    Response<Boolean> updateAttribute(AttributeReq attribute);

    Response<Boolean> saveAttribute(AttributeReq attribute);

}
