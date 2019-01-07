package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.AttributeReq;
import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.AttributeValue;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.domain.RecycleQuotationItemVo;
import com.jiuheng.service.domain.RecycleQuotationVo;
import com.jiuheng.service.dto.Goods;
import com.jiuheng.service.dto.RecoveryProp;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.dto.TemplateOrderReq;
import com.jiuheng.service.repository.AttributeMapper;
import com.jiuheng.service.repository.GoodsMapper;
import com.jiuheng.service.repository.RecoveryQuotationMapper;
import com.jiuheng.service.repository.RecoveryTmpOrderMapper;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import com.jiuheng.service.utils.SerializableUtils;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/9/20.
 */
@Service("dubboTmpOrderService")
public class DubboTmpOrderServiceImpl implements DubboTmpOrderService{

    private Logger log = LoggerFactory.getLogger(DubboTmpOrderService.class);

    @Autowired
    private RecoveryTmpOrderMapper recoveryTmpOrderMapper;
    @Autowired
    private AttributeMapper attributeMapper;
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private RecoveryQuotationMapper recoveryQuotationMapper;
    @Override
    public CommonResponse saveTemplateOrder(TemplateOrder tmpOrder){
        CommonResponse resp = null;
        try {
            tmpOrder.setOrderDetail(SerializableUtils.json.writeValueAsString(tmpOrder));
            recoveryTmpOrderMapper.saveTemplateOrder(tmpOrder);
            RecycleQuotationVo recycleQuotationVo = recoveryQuotationMapper.getRecycleQuotation(tmpOrder.getGoodsId());
            if(null != recycleQuotationVo){
                List<RecycleQuotationItemVo> list = recoveryQuotationMapper.getRecycleQuotationItemByQuotationId(recycleQuotationVo.getId());
                BigDecimal basePrice = recycleQuotationVo.getBasicPrice();
                BigDecimal baseAttrPrice = new BigDecimal("0");
                BigDecimal funAttrPrice = new BigDecimal("0");
                for(RecycleQuotationItemVo itemVo:list){
                    if(itemVo.getType() == 1){
                        baseAttrPrice = baseAttrPrice.add(itemVo.getPrice());
                    }else if(itemVo.getType() == 2){
                        baseAttrPrice = baseAttrPrice.subtract(itemVo.getPrice());
                    }else if(itemVo.getType() == 4){
                        funAttrPrice = funAttrPrice.add(itemVo.getPrice());
                    }

                }
                //以分为单位所以百分百没有除以100
                BigDecimal offerPrice=basePrice.add(baseAttrPrice).multiply(funAttrPrice);
                TemplateOrderReq orderReq = new TemplateOrderReq();
                orderReq.setOrderId(tmpOrder.getOrderId());
                orderReq.setPrice(offerPrice);
                resp = new WebResponse<TemplateOrderReq>(orderReq);
            }else{
                resp = new CommonResponse(200,"当前商品未设置回收金额，请加微信联系");
            }
        } catch (Exception e) {
            log.error("saveTemplateOrder.error",e);
            resp = new UnknowResponse();
        }
        return resp;
    }
    @Override
    public List<TemplateOrder> getTemplateOrder(long userId){
        List<TemplateOrder> list = null;
        try {
            list = recoveryTmpOrderMapper.getTemplateOrder(userId);
            if(null != list && list.size()>0){
                //获取所有零时订单
                for (TemplateOrder templateOrder : list) {
                    TemplateOrder templateOrdere = SerializableUtils.json.readValue(templateOrder.getOrderDetail(),TemplateOrder.class);
                    List<RecoveryProp> pops=templateOrdere.getProps();
                    //获取所有属性
                    for (RecoveryProp recoveryProp:pops) {
                        AttributeReq attribute = new AttributeReq();
                        attribute.setId(recoveryProp.getId());
                        List<AttributeResp> attributeResps = attributeMapper.getAttributeList(attribute);
                        if(null != attributeResps && attributeResps.size()>0){
                            recoveryProp.setName(attributeResps.get(0).getName());
                        }
                        //获取所有属性值
                        List<AttributeValue> attributeValues = recoveryProp.getAttributeValues();
                        for (AttributeValue attributeValue : attributeValues) {
                            if(null != attributeValue.getAttributeValueId()){
                                attributeValue.setAttributeValueName(attributeMapper.getAttributeValueById(attributeValue.getAttributeValueId()).getAttributeValueName());
                            }
                        }
                    }
                    Goods goods=goodsMapper.queryGoodsByGoodId(templateOrdere.getGoodsId());
                    templateOrder.setGoodsName(goods.getGoodsName());
                    templateOrder.setProps(pops);
                    templateOrder.setOrderDetail(null);
                }
            }
        } catch (Exception e) {
            log.error("getTemplateOrder.error",e);
        }
        return list;
    }

    @Override
    public List<RecoveryProp> getTemplateOrderByOrderId(String orderId){
        List<RecoveryProp> pops = null;
        try {
            TemplateOrder templateOrder = recoveryTmpOrderMapper.getTemplateOrderIds(orderId);
            TemplateOrder templateOrdere = SerializableUtils.json.readValue(templateOrder.getOrderDetail(),TemplateOrder.class);
            pops=templateOrdere.getProps();
            for (RecoveryProp pop:pops) {
                AttributeReq attribute = new AttributeReq();
                attribute.setId(pop.getId());
                List<AttributeResp> attrList = attributeMapper.getAttributeList(attribute);
                pop.setName(attrList.get(0).getName());
                for (AttributeValue value:pop.getAttributeValues()) {
                    AttributeValue newValue = attributeMapper.getAttributeValueById(value.getAttributeValueId());
                    value.setAttributeValueName(newValue.getAttributeValueName());
                }
            }
        } catch (IOException e) {
            log.error("getTemplateOrderByOrderId.error",e);
        }
        return pops;
    }

}
