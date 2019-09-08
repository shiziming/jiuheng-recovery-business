package com.jiuheng.service.repository;

import com.jiuheng.service.dto.UserAddr;
import com.jiuheng.service.dto.UserInfo;
import com.jiuheng.service.dto.login.LoginRequest;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2018/9/9.
 */
public interface UserMapper {

    MemberInfo checkUserLogin(@Param("loginRequest") LoginRequest loginRequest);

    void registerLogin(@Param("loginRequest") LoginRequest loginRequest);

    MemberInfo getUserInfo(long userId);

    void updateUserInfo(UserInfo userInfo);

    void addUserInfo(UserInfo userInfo);

    List<UserAddr> getUserAddr(long userId);

    UserAddr getUserAddrByUserIdAndAddrId(Map map);

    void delUserAddr(@Param("userAddr") UserAddr userAddr);

    void editAddress(@Param("userAddr") UserAddr userAddr);

    void addAddress(@Param("userAddr") UserAddr userAddr);

    List<UserInfo> getUserList(@Param("userInfo") UserInfo userInfo, Integer page, Integer size);

    void resetPassword(@Param("loginRequest") LoginRequest loginRequest);

}
