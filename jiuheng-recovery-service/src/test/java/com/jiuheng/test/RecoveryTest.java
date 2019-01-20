package com.jiuheng.test;

import com.jiuheng.service.ServiceApp;
import com.jiuheng.service.dto.RegionList;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.dubbo.DubboRegionService;
import com.jiuheng.service.dubbo.DubboTmpOrderService;
import com.jiuheng.service.respResult.CommonResult;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest(classes = ServiceApp.class)
@RunWith(SpringRunner.class)
public class RecoveryTest {

    @Autowired
    private DubboTmpOrderService dubboTmpOrderService;
    @Autowired
    private DubboRegionService dubboRegionService;
    @Test
    public void testEncodeCert(){
        TemplateOrder tmpOrder =new TemplateOrder();
        tmpOrder.setGoodsName("小米3");
        tmpOrder.setGoodsId(16);
        tmpOrder.setStatus(1);
        tmpOrder.setOrderId("H1539267975438");
        dubboTmpOrderService.saveTemplateOrder(tmpOrder);
    }
    @Test
    public void testGetRegion(){
        CommonResult<RegionList> result1= dubboRegionService.getProvinces();
        CommonResult<RegionList> result2= dubboRegionService.getCitys("13000000");
        CommonResult<RegionList> result3= dubboRegionService.getCountys("13110000");
        System.out.print("success");
    }

}
