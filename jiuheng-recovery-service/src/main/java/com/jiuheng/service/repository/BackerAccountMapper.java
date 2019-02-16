package com.jiuheng.service.repository;

import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.respResult.CommonResponse;
import org.apache.ibatis.annotations.Param;

/**
 * Created by shiziming on 2019/1/27.
 */
public interface BackerAccountMapper {

    UserAccount login(@Param("userAccount")UserAccount userAccount);
}
