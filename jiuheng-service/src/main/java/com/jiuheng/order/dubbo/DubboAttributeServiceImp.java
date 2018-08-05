package com.jiuheng.order.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.order.domain.AttributeReq;
import com.jiuheng.order.domain.AttributeResp;
import com.jiuheng.order.repository.AttributeMapper;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.order.utils.EasyUiDataGridUtil;
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

    public Response<SearchResult> getCategoryAttributesByCategory(Long categoryId){
        List<AttributeResp> result = null;
        if(categoryId == null || categoryId <= 0)
            return Response.ok(EasyUiDataGridUtil.convertToResult(result));
        result = attributeMapper.getCategoryAttributesByCategory(categoryId);
        return Response.ok(EasyUiDataGridUtil.convertToResult(result));

    }

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
            return Response.ok(Boolean.FALSE);
        }catch (Exception e){
            log.error("DubboCategoryService.saveCategoryAttribute",e);
            return Response.ok(Boolean.FALSE);
        }

    }

}
