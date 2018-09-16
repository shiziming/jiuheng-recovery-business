package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.login.LoginRequest;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.respResult.CommonResponse;

/**
 * Created by shiziming on 2018/8/26.
 */
public interface DubboLoginService {


    CommonResponse checkUserLogin(LoginRequest loginRequest);

    CommonResponse registerLogin(LoginRequest loginRequest);

}
