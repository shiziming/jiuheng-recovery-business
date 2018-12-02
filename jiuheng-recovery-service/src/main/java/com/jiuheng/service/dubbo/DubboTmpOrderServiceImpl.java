package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.AttributeReq;
import com.jiuheng.service.domain.AttributeResp;
import com.jiuheng.service.domain.AttributeValue;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.dto.Goods;
import com.jiuheng.service.dto.RecoveryProp;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.repository.AttributeMapper;
import com.jiuheng.service.repository.GoodsMapper;
import com.jiuheng.service.repository.RecoveryTmpOrderMapper;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import com.jiuheng.service.utils.SerializableUtils;
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
    @Override
    public CommonResponse saveTemplateOrder(TemplateOrder tmpOrder){
        CommonResponse resp = null;
        try {
            tmpOrder.setOrderDetail(SerializableUtils.json.writeValueAsString(tmpOrder));
            recoveryTmpOrderMapper.saveTemplateOrder(tmpOrder);
            resp = new WebResponse<String>(tmpOrder.getOrderId());
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

}
