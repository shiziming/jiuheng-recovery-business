package com.jiuheng.service.repository;

import com.jiuheng.service.domain.CategoryReq;
import com.jiuheng.service.domain.CategoryResp;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/7/14.
 */
public interface CategoryMapper {

    List<CategoryResp> getCategoryList(CategoryReq categoryReq);

    int getCategoryListCount(CategoryReq categoryReq);

    CategoryResp getCategoryById(CategoryReq categoryReq);

    void updateDeviceCategory(@Param("category") CategoryReq categoryReq);

    void insertDeviceCategory(CategoryReq categoryReq);

    CategoryResp getDeviceCategory(long id);
}
