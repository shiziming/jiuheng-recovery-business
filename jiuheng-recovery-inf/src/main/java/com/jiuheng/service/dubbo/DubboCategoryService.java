package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.CategoryReq;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;

/**
 * Created by shiziming on 2018/7/6.
 */
public interface DubboCategoryService {

    Response<SearchResult> getCategoryList(CategoryReq categoryReq, int pageNo, int pageSize);

    Response<Boolean> deleteDeviceCategory(CategoryReq categoryReq);

    Response<Boolean> saveCategory(CategoryReq categoryReq);

    Response<CategoryResp> getDeviceCategory(long id);

    Response<Boolean> updateCategory(CategoryReq categoryReq);

}
