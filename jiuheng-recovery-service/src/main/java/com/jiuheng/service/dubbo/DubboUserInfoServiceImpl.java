package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.RecoveryOrderResp;
import com.jiuheng.service.dto.UserAddr;
import com.jiuheng.service.dto.UserInfo;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.repository.UserMapper;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/9/11.
 */
@Service("dubboUserInfoService")
public class DubboUserInfoServiceImpl implements DubboUserInfoService{

    private Logger log = LoggerFactory.getLogger(DubboUserInfoService.class);

    @Autowired
    private UserMapper userMapper;
   public MemberInfo getUserInfo(Long userId){
       try {
           MemberInfo memberInfo = userMapper.getUserInfo(userId);
           return memberInfo;
       } catch (Exception e) {
           log.error("DubboUserInfoService.getUserInfo",e);
           return null;
       }

   }
   public CommonResponse updateUserInfo(UserInfo userInfo){
       CommonResponse response = null;
       try {
           MemberInfo info = userMapper.getUserInfo(userInfo.getUserId());
           if(null == info){
               userMapper.addUserInfo(userInfo);
           }else {
               userMapper.updateUserInfo(userInfo);
           }
           response = new CommonResponse(200,"");
           return response;
       } catch (Exception e) {
           log.error("DubboUserInfoService.updateUserInfo",e);
           response = new CommonResponse(5001,"账户信息修改失败");
           return response;
       }
   }

    public List<UserAddr> getUserAddr(long userId){
        List<UserAddr> list = null;
        try {
            list = userMapper.getUserAddr(userId);
            return list;
        } catch (Exception e) {
            log.error("DubboUserInfoService.getUserAddr",e);
            return list;
        }
    }
    public CommonResponse delUserAddr(UserAddr userAddr){
        CommonResponse resp = null;
        try {
            userMapper.delUserAddr(userAddr);
            resp = new CommonResponse(200,"");
        } catch (Exception e) {
            log.error("DubboUserInfoService.delUserAddr",e);
            resp = new CommonResponse(5002,"地址删除失败");
        }
        return resp;
    }

    public CommonResponse editAddress(UserAddr userAddr){
        CommonResponse resp = null;
        try {
            userMapper.editAddress(userAddr);
            resp = new CommonResponse(200,"");
        } catch (Exception e) {
            log.error("DubboUserInfoService.editAddress",e);
            resp = new CommonResponse(5002,"地址修改失败");
        }
        return resp;
    }

    public CommonResponse addAddress(UserAddr userAddr){
        CommonResponse resp = null;
        try {
            userMapper.addAddress(userAddr);
            resp = new CommonResponse(200,"");
        } catch (Exception e) {
            log.error("DubboUserInfoService.addAddress",e);
            resp = new CommonResponse(5002,"新增修改失败");
        }
        return resp;
    }

    public Response<SearchResult> getUserList(UserInfo userInfo, Integer page, Integer size){
        try{
            PageHelper.startPage(page, size);
            List<UserInfo> list= userMapper.getUserList(userInfo,page,size);
            return Response.ok(EasyUiDataGridUtil.convertToResult(list));
        }catch (Exception e){
            log.error("DubboUserInfoService.getUserList",e);
            return Response.fail(e.getMessage());
        }
    }


}
