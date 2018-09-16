package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.BrandResp;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import java.util.List;

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

    CommonResult<CategoryResp> getBrandByCategory(int categoryId);

    CommonResult<BrandResp> getGoodsByBrand(int brandId);
}
