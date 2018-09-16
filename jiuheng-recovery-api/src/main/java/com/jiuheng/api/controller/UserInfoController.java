package com.jiuheng.api.controller;

import com.jiuheng.api.domain.CommonValues;
import com.jiuheng.api.exception.LoginException;
import com.jiuheng.service.dto.UserAddr;
import com.jiuheng.service.dto.UserInfo;
import com.jiuheng.service.dto.error.LoginErrorResponse;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.dubbo.DubboUserInfoService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.UnknowResponse;
import com.jiuheng.service.respResult.WebResponse;
import java.util.List;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by shiziming on 2018/9/11.
 */
@RestController
@RequestMapping("user")
@Slf4j
public class UserInfoController {

    @Autowired
    private DubboUserInfoService dubboUserInfoService;

    /**
     * 获取用户信息接口
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/getUserInfo", method = RequestMethod.GET)
    public CommonResponse getUserInfo(HttpSession httpSession){
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            MemberInfo memberInfo = dubboUserInfoService.getUserInfo(userId);
            response = new WebResponse<MemberInfo>(memberInfo);
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        }catch (Exception e){
            log.error("getUserInfo.error",e);
            response = new UnknowResponse();
        }
        return response;
    }

    @RequestMapping(value = "/addUserInfo", method = RequestMethod.POST)
    public CommonResponse addUserInfo(String userName,long phone,String bankCard,HttpSession httpSession){
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            UserInfo userInfo = new UserInfo();
            userInfo.setPhone(phone);
            userInfo.setUserName(userName);
            userInfo.setBankCard(bankCard);
            userInfo.setUserId(userId);
            response = dubboUserInfoService.updateUserInfo(userInfo);
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        }catch (Exception e){
            log.error("getUserInfo.error",e);
            response = new UnknowResponse();
        }
        return response;
    }

    /**
     * 获取用户地址
     * @param httpSession
     * @return
     */
    @RequestMapping(value = "/addressList", method = RequestMethod.GET)
    public CommonResponse getUserAddr(HttpSession httpSession){
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            List<UserAddr> list = dubboUserInfoService.getUserAddr(userId);
            response = new WebResponse<List<UserAddr>>(list);
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        }catch (Exception e){
            log.error("getUserAddr.error",e);
            response = new UnknowResponse();
        }
        return response;
    }
    @RequestMapping(value = "/delAddress", method = RequestMethod.GET)
    public CommonResponse delAddress(int addrId,HttpSession httpSession) {
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            UserAddr userAddr = new UserAddr();
            userAddr.setUserId(userId);
            userAddr.setId(addrId);
            response = dubboUserInfoService.delUserAddr(userAddr);
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        }catch (Exception e){
            log.error("getUserAddr.error",e);
            response = new UnknowResponse();
        }
        return response;
    }

    @RequestMapping(value = "/editAddress", method = RequestMethod.POST)
    public CommonResponse editAddress(UserAddr userAddr,Integer addrId,Integer provinceCode,Integer cityCode,Integer districtCode,HttpSession httpSession) {
        CommonResponse response = null;
        try {
            Long userId = (Long) httpSession.getAttribute(CommonValues.SESSION_UID);
            // 检查登录
            if (userId == null) {
                throw new LoginException();
            }
            userAddr.setUserId(userId);
            userAddr.setProvince(provinceCode);
            userAddr.setCity(cityCode);
            userAddr.setDistrict(districtCode);
            if(addrId == null || addrId.equals(0) ){
                userAddr.setId(addrId);
                response = dubboUserInfoService.editAddress(userAddr);
            }else {
                dubboUserInfoService.addAddress(userAddr);
            }
        } catch (LoginException e) {
            response = new LoginErrorResponse();
        }catch (Exception e){
            log.error("getUserAddr.error",e);
            response = new UnknowResponse();
        }
        return response;
    }
}
