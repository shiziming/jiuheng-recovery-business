package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.Brand;
import com.jiuheng.order.domain.BrandReq;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;

/**
 * Created by shiziming on 2018/7/6.
 */
public interface DubboBrandService {

    Response<SearchResult> getAllBranch(BrandReq req,int page,int row);

    Response<Brand> getBrandById(BrandReq brandReq);

    Response<Boolean> saveBrand(BrandReq brand);

    Response<Boolean> updateBrand(BrandReq brand);

    Response<Boolean> updateBrandStatus(BrandReq brand);

    Response<Boolean> deleteBrand(BrandReq brand);
}
