package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.UserAddr;
import com.jiuheng.service.dto.UserInfo;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.respResult.CommonResponse;
import java.util.List;

/**
 * Created by shiziming on 2018/9/11.
 */
public interface DubboUserInfoService {

    MemberInfo getUserInfo(Long userId);

    CommonResponse updateUserInfo(UserInfo userInfo);

    List<UserAddr> getUserAddr(long userId);

    CommonResponse delUserAddr(UserAddr userAddr);

    CommonResponse editAddress(UserAddr userAddr);

    CommonResponse addAddress(UserAddr userAddr);
}
