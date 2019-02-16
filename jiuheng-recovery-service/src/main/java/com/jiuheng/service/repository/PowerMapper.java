package com.jiuheng.service.repository;

import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import java.util.List;

/**
 * Created by shiziming on 2019/2/8.
 */
public interface PowerMapper {

    List<UserPower> getPowers(int userId);

    List<UserAccount> getUserAccount(int page,int rows);

    UserAccount getUserAccountByUserId(int userId);
}
