package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.domain.RecoveryOrderDto;
import com.jiuheng.service.domain.RecoveryOrderReq;
import com.jiuheng.service.domain.RecoveryOrderResp;
import com.jiuheng.service.dto.Order;
import com.jiuheng.service.dto.Region;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.dto.UserAddr;
import com.jiuheng.service.repository.GoodsMapper;
import com.jiuheng.service.repository.RecoveryTmpOrderMapper;
import com.jiuheng.service.repository.RegionMapper;
import com.jiuheng.service.repository.UserMapper;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.repository.RecoveryOrderMapper;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.utils.DateUtils;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import com.jiuheng.service.utils.SerializableUtils;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

/**
 * Created by shiziming on 2018/6/23.
 */
@Service("dubboOrderService")
public class DubboOrderServiceImp implements DubboOrderService {

    private Logger log = LoggerFactory.getLogger(DubboOrderServiceImp.class);

    @Autowired
    private RecoveryOrderMapper recoveryOrderMapper;
    @Autowired
    private RecoveryTmpOrderMapper recoveryTmpOrderMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RegionMapper regionMapper;
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
    @Override
    @Transactional
    public CommonResponse saveOrder(Order order){
        CommonResponse resp = null;
        try {
            TemplateOrder templateOrder = recoveryTmpOrderMapper.getTemplateOrderId(order.getTemplateOrderId());
            String tmpOrderDetail = templateOrder.getOrderDetail();
            TemplateOrder templateOrdere = SerializableUtils.json.readValue(tmpOrderDetail,TemplateOrder.class);
            GoodsResp goodsResp = goodsMapper.getGoodsById(templateOrdere.getGoodsId());
            RecoveryOrderDto recoveryOrderDto = new RecoveryOrderDto();
            recoveryOrderDto.setGoodsName(goodsResp.getModel());
            recoveryOrderDto.setModel(templateOrdere.getGoodsId());
            recoveryOrderDto.setMessage(order.getRemark());
            recoveryOrderDto.setOnDoorTime(order.getOnDoorTime());
            recoveryOrderDto.setOrderId(order.getTemplateOrderId());
            recoveryOrderDto.setOrderType(1);
            recoveryOrderDto.setPayType(order.getPayType());
            recoveryOrderDto.setRecoveryType(order.getRecoveryType());
            recoveryOrderDto.setUserId(order.getUserId());
            if(1 == order.getRecoveryType()){
                recoveryOrderDto.setStatus(2);
            }else{
                recoveryOrderDto.setStatus(0);
            }
            recoveryOrderDto.setSubTime(DateUtils.currDays());
            Map map= new HashMap();
            map.put("userId",order.getUserId());
            map.put("addrId",order.getAddrId());
            UserAddr userAddr = userMapper.getUserAddrByUserIdAndAddrId(map);
            recoveryOrderDto.setProvinceCode(userAddr.getProvince());
            recoveryOrderDto.setCityCode(userAddr.getCity());
            recoveryOrderDto.setDistrictCode(userAddr.getDistrict());
            recoveryOrderDto.setDetailed(userAddr.getDetailed());
            recoveryOrderDto.setUserName(userAddr.getUserName());
            recoveryOrderDto.setUserPhone(userAddr.getPhone());
            recoveryOrderDto.setValuationPrice(order.getValuationPrice());
            recoveryOrderMapper.saveOrder(recoveryOrderDto);
            recoveryTmpOrderMapper.updateTemplateOrder(order.getTemplateOrderId());
            resp= new CommonResponse(200,"");
        } catch (IOException e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("DubboOrderService.saveOrder",e);
            resp= new UnknowResponse();
        }
        return resp;
    }

    @Override
    public Response<RecoveryOrderResp> getOrderDetail(String orderId){
        try {
            RecoveryOrderResp resp = recoveryOrderMapper.getOrderDetail(orderId);
            return Response.ok(resp);
        } catch (Exception e) {
            log.error("DubboOrderService.getOrderDetail",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    @Transactional
    public Response<Boolean> updateOrder(RecoveryOrderReq orderReq){
        try {
            recoveryOrderMapper.updateOrder(orderReq);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("DubboOrderService.updateOrder",e);
            return Response.fail(e.getMessage());
        }
    }


}
