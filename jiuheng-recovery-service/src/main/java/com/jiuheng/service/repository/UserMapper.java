package com.jiuheng.service.repository;

import com.jiuheng.service.dto.UserAddr;
import com.jiuheng.service.dto.UserInfo;
import com.jiuheng.service.dto.login.LoginRequest;
import com.jiuheng.service.dto.login.MemberInfo;
import java.util.List;

/**
 * Created by shiziming on 2018/9/9.
 */
public interface UserMapper {

    MemberInfo checkUserLogin(LoginRequest loginRequest);

    void registerLogin(LoginRequest loginRequest);

    MemberInfo getUserInfo(long userId);

    void updateUserInfo(UserInfo userInfo);

    List<UserAddr> getUserAddr(long userId);

    void delUserAddr(UserAddr userAddr);

    void editAddress(UserAddr userAddr);

    void addAddress(UserAddr userAddr);
}
