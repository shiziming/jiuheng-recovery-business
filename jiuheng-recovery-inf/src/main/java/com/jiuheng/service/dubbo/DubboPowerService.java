package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.Menu;
import com.jiuheng.service.domain.PasswordReq;
import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import java.util.List;
import java.util.Map;

/**
 * Created by shiziming on 2019/2/8.
 */
public interface DubboPowerService {


    Response<SearchResult> getPowers(int userId);

    Response<SearchResult> getUserAccount(int page,int rows,String account,Integer status);

    Response<UserAccount> getUserAccountByUserId(int userId);

    Response<Boolean> updatePassword(PasswordReq passwordReq);

    Response<Boolean> editUserStatus(UserAccount account);

    Response<List<Menu>> queryModel();

    Response<List<Menu>> queryFunctionByFatherId(String modelid);

    Response<List<Menu>> queryAllMenu();

    Response<Boolean> delPower(int userId,String menuId, int type);

    Response<Boolean> addPower(int userId,String modelid,String fatherFunctionId,int createUserId);

    Response<Boolean> addAccount(String account,String password,String name,Integer createUser);

}