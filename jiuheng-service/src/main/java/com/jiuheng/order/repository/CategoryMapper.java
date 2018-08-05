package com.jiuheng.order.repository;

import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.domain.CategoryResp;
import com.jiuheng.order.respResult.Response;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/7/14.
 */
public interface CategoryMapper {

    List<CategoryResp> getCategoryList(CategoryReq categoryReq);

    CategoryResp getCategoryById(CategoryReq categoryReq);

    void updateDeviceCategory(@Param("category") CategoryReq categoryReq);

    void insertDeviceCategory(CategoryReq categoryReq);

    CategoryResp getDeviceCategory(long id);
}
