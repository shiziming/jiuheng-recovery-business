package com.jiuheng.order.repository;

import com.jiuheng.order.domain.AttributeReq;
import com.jiuheng.order.domain.AttributeResp;
import com.jiuheng.order.domain.GoodsAttribute;
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
}
