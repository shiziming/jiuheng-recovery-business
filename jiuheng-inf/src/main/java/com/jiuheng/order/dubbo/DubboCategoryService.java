package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;

/**
 * Created by shiziming on 2018/7/6.
 */
public interface DubboCategoryService {

    Response<SearchResult> getCategoryList(CategoryReq categoryReq, int pageNo, int pageSize);
}
