package com.jiuheng.api.controller;

import com.jiuheng.api.domain.CommonValues;
import com.jiuheng.api.exception.LoginException;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.dto.error.LoginErrorResponse;
import com.jiuheng.service.dubbo.DubboOrderService;
import com.jiuheng.service.dubbo.DubboTmpOrderService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import java.util.List;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by shiziming on 2018/9/19.
 */
@RestController
@RequestMapping("order")
@Slf4j
public class OrderController {

    @Autowired
    private DubboOrderService dubboOrderService;
    @Autowired
    private DubboTmpOrderService dubboTmpOrderService;

    /**
     * 手机平板类提交零时订单
     * @param tmpOrder
     * @return
     */
    @RequestMapping(value = "/saveTemplateOrder", method = RequestMethod.POST)
    public CommonResponse saveTemplateOrder(@RequestBody TemplateOrder tmpOrder,HttpSession httpSession){
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            tmpOrder.setOrderId("H"+System.currentTimeMillis());
            tmpOrder.setUserId(userId);
            response = dubboTmpOrderService.saveTemplateOrder(tmpOrder);
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        } catch (Exception e) {
            log.error("saveTemplateOrder.error",e);
            response = new UnknowResponse();
        }
        return response;

    }

    /**
     * 手机平板类查询订单
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/getTemplateOrder", method = RequestMethod.GET)
    public CommonResponse getTemplateOrder(HttpSession httpSession){
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            List<TemplateOrder> list = dubboTmpOrderService.getTemplateOrder(userId);
            response = new WebResponse<List<TemplateOrder>>(list);
        } catch (LoginException e) {
                response = new LoginErrorResponse();
        } catch (Exception e) {
            log.error("saveTemplateOrder.error",e);
            response = new UnknowResponse();
        }
        return response;
    }

    /*@RequestMapping(value = "/saveOrder", method = RequestMethod.GET)
    public CommonResponse saveOrder(HttpSession httpSession){
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            List<TemplateOrder> list = dubboOrderService.saveOrder();
            response = new WebResponse<List<TemplateOrder>>(list);
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        } catch (Exception e) {
            log.error("saveTemplateOrder.error",e);
            response = new UnknowResponse();
        }
        return response;
    }*/
}
