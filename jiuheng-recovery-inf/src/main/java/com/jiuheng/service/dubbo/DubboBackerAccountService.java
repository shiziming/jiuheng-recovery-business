package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.respResult.CommonResponse;

/**
 * Created by shiziming on 2019/1/24.
 */
public interface DubboBackerAccountService {

    UserAccount login(UserAccount userAccount);
}
