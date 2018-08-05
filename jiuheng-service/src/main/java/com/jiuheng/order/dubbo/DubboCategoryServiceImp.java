package com.jiuheng.order.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.domain.CategoryResp;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.order.repository.CategoryMapper;
import com.jiuheng.order.utils.EasyUiDataGridUtil;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/7/6.
 */
@Service("dubboCategoryService")
public class DubboCategoryServiceImp implements DubboCategoryService{

    private Logger log = LoggerFactory.getLogger(DubboCategoryService.class);

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public Response<SearchResult> getCategoryList(CategoryReq categoryReq, int pageNo, int pageSize){
        try {
            if(pageSize != 0){
                PageHelper.startPage(pageNo, pageSize);
            }
            if(categoryReq == null){
                categoryReq = new CategoryReq();
            }
            List<CategoryResp> list=categoryMapper.getCategoryList(categoryReq);
            //按子父级排序
            List<CategoryResp> queryList = null;
            if(list != null && !list.isEmpty()){
                queryList = new ArrayList<CategoryResp>();
                for (CategoryResp category : list) {
                    queryList.add(category);
                    List<CategoryResp> subCategories = category.getSubCategories();
                    if(subCategories != null && !subCategories.isEmpty()) {
                        queryList.addAll(subCategories);
                    }
                }

            }
            return Response.ok(EasyUiDataGridUtil.convertToResult(queryList));
        } catch (Exception e) {
            log.error("DubboCategoryService.getCategoryList",e);
            return Response.fail(e.getMessage());
        }
    }
    public Response<CategoryResp> getCategoryById(CategoryReq categoryReq){
        try {
            CategoryResp categoryResp=categoryMapper.getCategoryById(categoryReq);
            return Response.ok(categoryResp);
        } catch (Exception e) {
            log.error("DubboCategoryService.getCategoryById",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<Boolean> deleteDeviceCategory(CategoryReq categoryReq){
        try {
            categoryMapper.updateDeviceCategory(categoryReq);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboCategoryService.deleteDeviceCategory",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<Boolean> saveCategory(CategoryReq categoryReq){
        try {
            if(categoryReq == null) {
                throw new IllegalArgumentException("无效的设备分类");
            }
            categoryReq.setStatus((byte)1);

            if(categoryReq.getFid() == null || categoryReq.getFid() == -1){
                categoryReq.setFid(-1);
                categoryReq.setPathName(categoryReq.getName());
                categoryMapper.insertDeviceCategory(categoryReq);

                categoryReq.setPathId(String.valueOf(categoryReq.getId()));
                categoryMapper.updateDeviceCategory(categoryReq);
            }else {
                //获取节点
                CategoryResp parentCategory = categoryMapper.getDeviceCategory(categoryReq.getFid());
                categoryReq.setPathName(parentCategory.getPathName() + " >> " + categoryReq.getName());
                categoryMapper.insertDeviceCategory(categoryReq);
                categoryReq.setPathId(parentCategory.getPathId() + "," + categoryReq.getId());
                categoryMapper.updateDeviceCategory(categoryReq);
            }
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboCategoryService.saveCategory",e);
            return Response.fail(e.getMessage());
        }
    }

}
