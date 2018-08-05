package com.jiuheng.order.repository;

import com.jiuheng.order.domain.Brand;
import com.jiuheng.order.domain.BrandCategory;
import com.jiuheng.order.domain.BrandResp;
import com.jiuheng.order.domain.BrandReq;
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
}
