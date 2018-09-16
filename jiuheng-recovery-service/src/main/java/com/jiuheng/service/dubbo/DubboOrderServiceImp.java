package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.RecoveryOrderReq;
import com.jiuheng.service.domain.RecoveryOrderResp;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.repository.RecoveryOrderMapper;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/6/23.
 */
@Service("dubboOrderService")
public class DubboOrderServiceImp implements DubboOrderService {

    private Logger log = LoggerFactory.getLogger(DubboOrderServiceImp.class);

    @Autowired
    private RecoveryOrderMapper recoveryOrderMapper;
    @Override
    public Response<SearchResult> getOrderList(RecoveryOrderReq req,int page,int size){
        try{
            PageHelper.startPage(page, size);
            List<RecoveryOrderResp> list= recoveryOrderMapper.getOrderList(req,page,size);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        }catch (Exception e){
            log.error("DubboOrderService.getOrderList",e);
            return Response.fail(e.getMessage());
        }

    }

}
