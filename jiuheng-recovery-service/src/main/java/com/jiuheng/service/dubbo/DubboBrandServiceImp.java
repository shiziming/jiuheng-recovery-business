package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandCategory;
import com.jiuheng.service.domain.BrandResp;
import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.repository.CategoryMapper;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.repository.BranchMapper;
import com.jiuheng.service.utils.DateUtils;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/7/6.
 */
@Service("dubboBrandService")
public class DubboBrandServiceImp implements DubboBrandService{

    private Logger log = LoggerFactory.getLogger(DubboBrandService.class);

    @Autowired
    private BranchMapper branchMapper;
    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public Response<SearchResult> getAllBranch(BrandReq req,int page,int row){
        try{
            List<BrandResp> list= branchMapper.getAllBranch(req,(page-1)*row,row);
            int count =branchMapper.getAllBranchCount(req);
            SearchResult result= EasyUiDataGridUtil.convertToResult(list);
            result.setTotal(count);
            return Response.ok(result);
        }catch (Exception e){
            log.error("DubboBrandService.getAllBranch",e);
            return Response.fail(e.getMessage());
        }

    }
    @Override
    public Response<Brand> getBrandById(BrandReq brandReq){
        try{
            Brand brand= branchMapper.getBrandById(brandReq);
            return Response.ok(brand);
        }catch (Exception e){
            log.error("DubboBrandService.getBrandById",e);
            return Response.fail(e.getMessage());
        }

    }

    @Override
    public Response<Boolean> saveBrand(BrandReq brand) {
        try {
            if(brand == null) throw new IllegalArgumentException("无效的品牌信息");
            brand.setStatus(1);
            brand.setCreateTime(DateUtils.getCurrDate(DateUtils.FORMAT_ONE));
            branchMapper.insertBrands(brand);
            List<BrandCategory> categories = brand.getCategories();
            if(categories != null && !categories.isEmpty()){
                for (BrandCategory category : categories) {
                    if(StringUtils.isNotEmpty(category.getCategoryId().toString())){
                        category.setBrandId(brand.getId());
                        branchMapper.insertBrandCategory(category);
                    }
                }
            }
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboBrandService.saveBrand",e);
            return Response.fail("4001","无效的品牌信息");
        }catch (Exception e){
            log.error("DubboBrandService.saveBrand",e);
            return Response.fail(e.getMessage());
        }
    }

    @Override
    public Response<Boolean> updateBrand(BrandReq brand) {
        try {
            if(brand == null || brand.getId() == null || brand.getId() <= 0) throw new IllegalArgumentException("无效的品牌信息");
            branchMapper.updateBrand(brand);
            BrandCategory brandCategory = new BrandCategory();
            brandCategory.setBrandId(brand.getId());
            branchMapper.deleteBrandCategory(brandCategory);

            List<BrandCategory> categories = brand.getCategories();
            if(categories != null && !categories.isEmpty()){
                for (BrandCategory category : categories) {
                    if(StringUtils.isNotEmpty(category.getCategoryId().toString())){
                        category.setBrandId(brand.getId());
                        branchMapper.insertBrandCategory(category);
                    }
                }
            }
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboBrandService.updateBrand",e);
            return Response.fail("4001","无效的品牌信息");
        }catch (Exception e){
            log.error("DubboBrandService.updateBrand",e);
            return Response.fail(e.getMessage());
        }

    }
    @Override
    public Response<Boolean> updateBrandStatus(BrandReq brand){
        try {
            if(brand == null || brand.getId() == null || brand.getId() <= 0) throw new IllegalArgumentException("无效的品牌信息");
            branchMapper.updateBrand(brand);
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboBrandService.updateBrandStatus",e);
            return Response.fail(e.getMessage());
        }
    }

    @Override
    public Response<Boolean> deleteBrand(BrandReq brand) {
        try {
            if(brand == null || brand.getId() == null || brand.getId() <= 0) throw new IllegalArgumentException("无效的品牌信息");
            brand.setStatus(-1);
            branchMapper.updateBrand(brand);
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboBrandService.deleteBrand",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<SearchResult> getBrandByCategory(int categoryId){
        SearchResult result = new SearchResult(0, null);
        try {
            CategoryResp resp= branchMapper.getBrandByCategory(categoryId);
            if(null != resp){
                result= EasyUiDataGridUtil.convertToResult(resp.getBrands());
            }
            return Response.ok(result);
        } catch (Exception e) {
            log.error("DubboBrandService.getBrandByCategory",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public CommonResult<BrandResp> getGoodsByBrand(int brandId){
        CommonResult<BrandResp> result = null;
        try {
            BrandResp resp= branchMapper.getGoodsByBrand(brandId);
            result = new CommonResult<BrandResp>(resp);
            return result;
        } catch (Exception e) {
            log.error("DubboBrandService.getGoodsByBrand",e);
            return result;
        }
    }

    @Override
    public CommonResult<List<GoodsAttribute>> getAttrByGoodsId(int goodsId){
        CommonResult<List<GoodsAttribute>> result = null;
        try {
            List<GoodsAttribute> resp= branchMapper.getAttrByGoodsId(goodsId);
            result = new CommonResult<List<GoodsAttribute>>(resp);
            return result;
        } catch (Exception e) {
            log.error("DubboBrandService.getGoodsByBrand",e);
            return result;
        }
    }

}
