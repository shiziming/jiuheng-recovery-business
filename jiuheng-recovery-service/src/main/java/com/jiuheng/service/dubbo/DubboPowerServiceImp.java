package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.Menu;
import com.jiuheng.service.domain.PasswordReq;
import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.domain.UserPower;
import com.jiuheng.service.repository.MenuMapper;
import com.jiuheng.service.repository.PowerMapper;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

/**
 * Created by shiziming on 2019/2/8.
 */
@Service("dubboPowerService")
public class DubboPowerServiceImp implements DubboPowerService{

    private Logger log = LoggerFactory.getLogger(DubboPowerServiceImp.class);

    @Autowired
    private PowerMapper powerMapper;
    @Autowired
    private MenuMapper menuMapper;
    @Override
    public Response<SearchResult> getPowers(int userId){
        try {
            List<UserPower> list = powerMapper.getPowers(userId);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        } catch (Exception e) {
            log.error("DubboPowerService.getPowers",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<SearchResult> getUserAccount(int page,int rows,String account,Integer status){
        try {
            PageHelper.startPage(page, rows);
            List<UserAccount> list = powerMapper.getUserAccount(account,status);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        } catch (Exception e) {
            log.error("DubboPowerService.getUserAccount",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<UserAccount> getUserAccountByUserId(int userId){
        try {
            UserAccount userAccount = powerMapper.getUserAccountByUserId(userId);
            return Response.ok(userAccount);
        } catch (Exception e) {
            log.error("DubboPowerService.getUserAccountByUserId",e);
            return Response.fail(e.getMessage());
        }

    }
    @Override
    public Response<Boolean> updatePassword(PasswordReq passwordReq){
        try {
            powerMapper.updatePassword(passwordReq);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboPowerService.updatePassword",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<Boolean> editUserStatus(UserAccount account){
        try {
            powerMapper.editUserStatus(account);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboPowerService.editUserStatus",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<List<Menu>> queryModel(){
        try {
            List<Menu> menus = menuMapper.queryModel();
            return Response.ok(menus);
        } catch (Exception e) {
            log.error("DubboPowerService.queryModel",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<List<Menu>> queryAllMenu(){
        try {
            List<Menu> menus = menuMapper.queryAllMenu();
            return Response.ok(menus);
        } catch (Exception e) {
            log.error("DubboPowerService.queryAllMenu",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<List<Menu>> queryFunctionByFatherId(String modelid){
        try {
            List<Menu> menus = menuMapper.queryFunctionByFatherId(modelid);
            return Response.ok(menus);
        } catch (Exception e) {
            log.error("DubboPowerService.queryModel",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    public Response<Boolean> delPower(int userId,String menuId, int type){
        try {
            Map map = new HashMap<>();
            map.put("userId",userId);
            map.put("menuId",menuId);
            if(type == 1){
                powerMapper.delFatherPower(map);
            }else{
                powerMapper.delPower(map);
            }
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboPowerService.delPower",e);
            return Response.fail(e.getMessage());
        }
    }
    @Override
    @Transactional
    public Response<Boolean> addPower(int userId,String modelid,String fatherFunctionId,int createUserId){
        try {
            Map map = new HashMap();
            map.put("userId",userId);
            map.put("id",fatherFunctionId);
            UserPower userPower = powerMapper.queryPowerById(map);
            if(userPower != null){
                return Response.fail("当前用户已存在该权限，请重新添加！");
            }
            Map newMap = new HashMap();

            newMap.put("userId",userId);
            newMap.put("id",modelid);
            UserPower newUserPower = powerMapper.queryPowerById(newMap);
            if(newUserPower != null){
                Map addMap = new HashMap();
                addMap.put("userId",userId);
                addMap.put("id",fatherFunctionId);
                addMap.put("createUserId",createUserId);
                powerMapper.addPower(addMap);
            }else{
                Map addMapmo = new HashMap();
                addMapmo.put("userId",userId);
                addMapmo.put("id",modelid);
                addMapmo.put("createUserId",createUserId);
                    powerMapper.addPower(addMapmo);
                Map addMap = new HashMap();
                addMap.put("userId",userId);
                addMap.put("id",fatherFunctionId);
                addMap.put("createUserId",createUserId);
                powerMapper.addPower(addMap);
            }
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            log.error("DubboPowerService.addPower",e);
            return Response.fail(e.getMessage());
        }
    }

    public Response<Boolean> addAccount(String account,String password,String name,Integer createUser){
        try {
            UserAccount userAccount = powerMapper.queryUserByAccount(account);
            if(userAccount != null){
                return Response.fail("当前账号已存在！");
            }
            Map map = new HashMap();
            map.put("account",account);
            map.put("password",password);
            map.put("name",name);
            map.put("createUser",createUser);
            powerMapper.addAccount(map);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboPowerService.addAccount", e);
            return Response.fail(e.getMessage());
        }
    }

}
