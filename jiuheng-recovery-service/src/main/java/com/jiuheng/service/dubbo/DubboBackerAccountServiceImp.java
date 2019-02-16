package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.repository.BackerAccountMapper;
import com.jiuheng.service.respResult.CommonResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2019/1/27.
 */
@Service("dubboBackerAccountService")
public class DubboBackerAccountServiceImp implements DubboBackerAccountService{

    private Logger log = LoggerFactory.getLogger(DubboBackerAccountService.class);

    @Autowired
    private BackerAccountMapper backerAccountMapper;
    @Override
    public UserAccount login(UserAccount userAccount) {
        try {
            userAccount = backerAccountMapper.login(userAccount);
            return userAccount;
        } catch (Exception e) {
            log.error("DubboBackerAccountService.login.error",e);
            return null;
        }
    }
}
