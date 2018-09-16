
package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.login.LoginRequest;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.repository.UserMapper;
import com.jiuheng.service.respResult.CommonResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/8/26.
 */
@Service("dubboLoginService")
public class DubboLoginServiceImpl implements DubboLoginService {

    private Logger log = LoggerFactory.getLogger(DubboLoginService.class);

    @Autowired
    private UserMapper userMapper;

    public CommonResponse checkUserLogin(LoginRequest loginRequest){
        CommonResponse resp = null;
        try {
            MemberInfo memberInfo = userMapper.checkUserLogin(loginRequest);
            if(null == memberInfo){
                resp = new CommonResponse(4001,"account is null");
                return resp;
            }
            if(loginRequest.getPassword().equals(memberInfo.getPassword())){
                resp = new CommonResponse(4000,"password error");
                return resp;
            }
            resp = new CommonResponse(200,"");
            return resp;
        } catch (Exception e) {
            log.error("DubboLoginService.checkUserLogin",e);
            resp = new CommonResponse(500,"unknow error");
            return resp;
        }
    }
    public CommonResponse registerLogin(LoginRequest loginRequest){
        CommonResponse resp = null;
        try {
            userMapper.registerLogin(loginRequest);
            resp = new CommonResponse(200,"");
            return resp;
        } catch (Exception e) {
            log.error("DubboLoginService.registerLogin",e);
            resp = new CommonResponse(500,"unknow error");
            return resp;
        }
    }
}
