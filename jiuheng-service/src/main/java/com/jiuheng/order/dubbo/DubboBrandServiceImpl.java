package com.jiuheng.order.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.order.domain.Brand;
import com.jiuheng.order.domain.BrandCategory;
import com.jiuheng.order.domain.BrandResp;
import com.jiuheng.order.domain.BrandReq;
import com.jiuheng.order.repository.CategoryMapper;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.order.repository.BranchMapper;
import com.jiuheng.order.utils.EasyUiDataGridUtil;
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
public class DubboBrandServiceImpl implements DubboBrandService{

    private Logger log = LoggerFactory.getLogger(DubboBrandService.class);

    @Autowired
    private BranchMapper branchMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    public Response<SearchResult> getAllBranch(BrandReq req,int page,int row){
        try{
            List<BrandResp> list= branchMapper.getAllBranch(req,(page-1)*row,row);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
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
        Response<Boolean> req=new Response<Boolean>();
        try {
            branchMapper.saveBrand(brand);
            req.setResult(Boolean.TRUE);
            return req;
        } catch (Exception e) {
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
}
