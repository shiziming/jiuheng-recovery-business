package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.BrandReq;
import com.jiuheng.order.domain.Response;
import com.jiuheng.order.domain.SearchResult;

/**
 * Created by shiziming on 2018/7/6.
 */
public interface DubboBrandService {

    Response<SearchResult> getAllBranch(BrandReq req,int page,int row);

}
