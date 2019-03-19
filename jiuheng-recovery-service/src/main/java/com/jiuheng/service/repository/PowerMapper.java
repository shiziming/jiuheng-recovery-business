package com.jiuheng.service.repository;

import com.jiuheng.service.domain.PasswordReq;
import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2019/2/8.
 */
public interface PowerMapper {

    List<UserPower> getPowers(int userId);

    List<UserAccount> getUserAccount(@Param("account")String account,@Param("status")Integer status);

    UserAccount queryUserByAccount(String account);

    void addAccount(Map map);

    UserAccount getUserAccountByUserId(int userId);

    void updatePassword(@Param("passwordReq")PasswordReq passwordReq);

    void editUserStatus(@Param("account")UserAccount account);

    void delFatherPower(Map map);

    void delPower(Map map);

    UserPower queryPowerById(Map map);

    void addPower(Map addMap);
}
