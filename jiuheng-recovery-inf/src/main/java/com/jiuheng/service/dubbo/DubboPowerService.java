package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;

/**
 * Created by shiziming on 2019/2/8.
 */
public interface DubboPowerService {


    Response<SearchResult> getPowers(int userId);

    Response<SearchResult> getUserAccount(int page,int rows);

    Response<UserAccount> getUserAccountByUserId(int userId);

}