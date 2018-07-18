package com.jiuheng.order.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.order.domain.CategoryReq;
import com.jiuheng.order.domain.CategoryResp;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.order.repository.CategoryMapper;
import com.jiuheng.order.utils.EasyUiDataGridUtil;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/7/6.
 */
@Service("dubboCategoryService")
public class DubboCategoryServiceImpl implements DubboCategoryService{

    private Logger log = LoggerFactory.getLogger(DubboCategoryService.class);

    @Autowired
    private CategoryMapper categoryMapper;

    public Response<SearchResult> getCategoryList(CategoryReq categoryReq, int pageNo, int pageSize){
        try {
            if(pageSize != 0){
                PageHelper.startPage(pageNo, pageSize);
            }
            if(categoryReq == null){
                categoryReq = new CategoryReq();
            }
            List<CategoryResp> list=categoryMapper.getCategoryList(categoryReq);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
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

}
