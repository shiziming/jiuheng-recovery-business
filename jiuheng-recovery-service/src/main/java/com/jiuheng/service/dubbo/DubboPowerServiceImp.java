package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import com.jiuheng.service.repository.PowerMapper;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2019/2/8.
 */
@Service("dubboPowerService")
public class DubboPowerServiceImp implements DubboPowerService{

    private Logger log = LoggerFactory.getLogger(DubboPowerServiceImp.class);

    @Autowired
    private PowerMapper powerMapper;

    public Response<SearchResult> getPowers(int userId){
        try {
            List<UserPower> list = powerMapper.getPowers(userId);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        } catch (Exception e) {
            log.error("DubboPowerService.getPowers",e);
            return Response.fail(e.getMessage());
        }
    }
    public Response<SearchResult> getUserAccount(int page,int rows){
        try {
            PageHelper.startPage(page, rows);
            List<UserAccount> list = powerMapper.getUserAccount(page,rows);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        } catch (Exception e) {
            log.error("DubboPowerService.getUserAccount",e);
            return Response.fail(e.getMessage());
        }
    }

    public Response<UserAccount> getUserAccountByUserId(int userId){
        try {
            UserAccount userAccount = powerMapper.getUserAccountByUserId(userId);
            return Response.ok(userAccount);
        } catch (Exception e) {
            log.error("DubboPowerService.getUserAccountByUserId",e);
            return Response.fail(e.getMessage());
        }

    }

}
