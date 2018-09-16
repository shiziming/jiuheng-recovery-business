package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.AttributeReq;
import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.CategoryRecycleAttribute;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.repository.AttributeMapper;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/7/22.
 */
@Service("dubboAttributeService")
public class DubboAttributeServiceImp implements DubboAttributeService{

    private Logger log = LoggerFactory.getLogger(DubboAttributeService.class);

    @Autowired
    private AttributeMapper attributeMapper;
    @Override
    public Response<SearchResult> getAttributeList(AttributeReq attribute, int page,int pageSize){
        try {
            if(pageSize != 0){
                PageHelper.startPage(page, pageSize);
            }
            List<AttributeResp> attributeList = attributeMapper.getAttributeList(attribute);
            return Response.ok(EasyUiDataGridUtil.convertToResult(attributeList));
        } catch (Exception e) {
            log.error("DubboCategoryService.getAttributeList",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<SearchResult> getCategoryAttributesByCategory(Long categoryId){
        try {
            List<AttributeResp> result = null;
            if(categoryId == null || categoryId <= 0)
                return Response.ok(EasyUiDataGridUtil.convertToResult(result));
            result = attributeMapper.getCategoryAttributesByCategory(categoryId);
            return Response.ok(EasyUiDataGridUtil.convertToResult(result));
        } catch (Exception e) {
            log.error("DubboCategoryService.getCategoryAttributesByCategory",e);
            return Response.fail(e.getMessage());
        }

    }
    @Override
    public Response<Boolean> saveCategoryAttribute(Long categoryId, List<Long> attributeIds,String type){
        try {
            if(categoryId == null || categoryId <= 0){
                throw new IllegalArgumentException("错误的分类编号");
            }

            if(attributeIds == null || attributeIds.isEmpty()){
                throw new IllegalArgumentException("属性id为空");
            }

            attributeMapper.deleteCategoryAttribute(categoryId,null,type);

            StringBuilder builder = new StringBuilder(100);
            for (Long attributeId : attributeIds) {
                attributeMapper.insertCategoryAttribute(categoryId, attributeId);
                builder.append(attributeId + ",");
            }
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboCategoryService.saveCategoryAttribute",e);
            return Response.fail(e.getMessage());
        }catch (Exception e){
            log.error("DubboCategoryService.saveCategoryAttribute",e);
            return Response.fail(e.getMessage());
        }

    }
    @Override
    public Response<Boolean> insertGoodsRecycleAttributeValue(GoodsAttribute goodsAttribute){
        try {
            if(goodsAttribute != null){
                attributeMapper.insertGoodsRecycleAttributeValue(goodsAttribute);
            }
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboCategoryService.insertGoodsRecycleAttributeValue",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<Boolean>  updateGoodsRecycleAttributeValue(GoodsAttribute goodsAttribute){
        try {
            if(goodsAttribute != null){
                attributeMapper.updateGoodsRecycleAttributeValue(goodsAttribute);
            }
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboCategoryService.updateGoodsRecycleAttributeValue",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<SearchResult> getAllRecycleAttibuteWithValue(Integer categoryId,Integer goodsId,Integer attributeType){
        try {
            if(categoryId==null || goodsId == null)
                throw new IllegalArgumentException("categoryId and goodsId must be not null");
            List<CategoryRecycleAttribute>  recycleAttributeList = attributeMapper.getAllRecycleAttibuteWithValue(categoryId,goodsId,attributeType);
            return Response.ok(EasyUiDataGridUtil.convertToResult(recycleAttributeList));
        } catch (IllegalArgumentException e) {
            log.error("DubboCategoryService.getAllRecycleAttibuteWithValue",e);
            return Response.fail(e.getMessage());
        }

    }
    @Override
    public Response<Boolean> updateAttribute(AttributeReq attribute){
        try {
            if(attribute == null || attribute.getId() == null || attribute.getId() <= 0){
                throw new IllegalArgumentException("属性id为空");
            }
            attributeMapper.updateAttribute(attribute);
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboCategoryService.updateAttribute",e);
            return Response.fail(e.getMessage());
        }

    }

    @Override
    public Response<Boolean> saveAttribute(AttributeReq attribute){
        try {
            attributeMapper.saveAttribute(attribute);
            return Response.ok(Boolean.TRUE);
        } catch (IllegalArgumentException e) {
            log.error("DubboCategoryService.updateAttribute",e);
            return Response.fail(e.getMessage());
        }

    }
}
