package com.jiuheng.order.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.order.domain.BrandResp;
import com.jiuheng.order.domain.BrandReq;
import com.jiuheng.order.domain.Response;
import com.jiuheng.order.domain.SearchResult;
import com.jiuheng.order.repository.BranchMapper;
import com.jiuheng.order.utils.EasyUiDataGridUtil;
import java.util.List;
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
    public Response<SearchResult> getAllBranch(BrandReq req,int page,int row){
        try{
            PageHelper.startPage(page, row);
            List<BrandResp> list= branchMapper.getAllBranch(req,page,row);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        }catch (Exception e){
            log.error("DubboBrandService.getAllBranch",e);
            return Response.fail(e.getMessage());
        }

    }

}
