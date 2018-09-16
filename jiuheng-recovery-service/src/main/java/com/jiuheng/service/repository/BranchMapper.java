package com.jiuheng.service.repository;

import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandCategory;
import com.jiuheng.service.domain.BrandResp;
import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.respResult.CommonResult;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/7/10.
 */
public interface BranchMapper {

    List<BrandResp> getAllBranch(@Param("brandReq") BrandReq req,@Param("start")int start,@Param("row")int row);

    Brand getBrandById(@Param("brandReq")BrandReq brandReq);

    void insertBrandCategory(@Param("brandCategory")BrandCategory brandCategory);

    void updateBrand(@Param("brand")BrandReq brand);

    void deleteBrandCategory(@Param("brandCategory")BrandCategory brandCategory);

    void insertBrands(@Param("brand")BrandReq brand);

    CategoryResp getBrandByCategory(int categoryId);

    BrandResp getGoodsByBrand(int brandId);

}
