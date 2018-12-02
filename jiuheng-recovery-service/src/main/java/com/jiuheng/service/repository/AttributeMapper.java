package com.jiuheng.service.repository;

import com.jiuheng.service.domain.AttributeReq;
import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.AttributeValue;
import com.jiuheng.service.domain.CategoryRecycleAttribute;
import com.jiuheng.service.domain.GoodsAttribute;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/7/22.
 */
public interface AttributeMapper {

    List<AttributeResp> getAttributeList(@Param("attribute")AttributeReq attribute);

    List<AttributeResp> getCategoryAttributesByCategory(@Param("categoryId") Long categoryId);

    void deleteCategoryAttribute(@Param("categoryId")Long categoryId, @Param("attributeId") Long attributeId, @Param("type") String type);

    void insertCategoryAttribute(@Param("categoryId")Long categoryId,@Param("attributeId") Long attributeId);

    void insertGoodsAttributeValue(@Param("goodsAttribute")GoodsAttribute goodsAttribute);

    void updateGoodsAttributeValue(@Param("goodsAttribute")GoodsAttribute goodsAttribute);

    void insertGoodsRecycleAttributeValue(@Param("goodsAttribute")GoodsAttribute goodsAttribute);

    void updateGoodsRecycleAttributeValue(@Param("goodsAttribute")GoodsAttribute goodsAttribute);

    List<CategoryRecycleAttribute> getAllRecycleAttibuteWithValue(@Param("categoryId")Integer categoryId,@Param("goodsId")Integer goodsId,@Param("attributeType")Integer attributeType);

    void updateAttribute(@Param("attribute")AttributeReq attribute);

    void saveAttribute(@Param("attribute")AttributeReq attribute);

    AttributeValue getAttributeValueById(Integer id);

}
