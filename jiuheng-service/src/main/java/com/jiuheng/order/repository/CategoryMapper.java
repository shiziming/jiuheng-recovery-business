package com.jiuheng.order.repository;

import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.domain.CategoryResp;
import java.util.List;

/**
 * Created by shiziming on 2018/7/14.
 */
public interface CategoryMapper {

    List<CategoryResp> getCategoryList(CategoryReq categoryReq);

    CategoryResp getCategoryById(CategoryReq categoryReq);
}
