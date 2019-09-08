package com.jiuheng.api.login;

import static com.jiuheng.api.utils.RsaUtils.decryptBASE64;
import static com.jiuheng.api.utils.RsaUtils.decryptByPrivateKey;

import com.alibaba.fastjson.JSON;
import com.jiuheng.api.utils.CookieCode;
import com.jiuheng.api.utils.CookieOperator;
import com.jiuheng.api.utils.PatternUtils;
import com.jiuheng.api.utils.RandomUtils;
import com.jiuheng.api.utils.SsoUserCookieTools;
import com.jiuheng.service.dto.login.LoginError;
import com.jiuheng.service.dto.login.LoginRequest;
import com.jiuheng.service.dto.login.MemberInfo;
import com.jiuheng.service.dubbo.DubboLoginService;
import com.jiuheng.service.dubbo.DubboValidCodeService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.ErrorNode;
import com.jiuheng.service.respResult.WebResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by shiziming on 2018/8/26.
 */
@RestController
@RequestMapping("login")
@Slf4j
public class LoginController {

    @Autowired
    private DubboLoginService dubboLoginService;
    @Autowired
    private DubboValidCodeService dubboValidCodeService;
    @Value("${rsa.primity.key}")
    private String rsaKey;

    /**
     * 登录接口
     * @param loginRequest
     * @param httpSession
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/lg", method = RequestMethod.POST)
    public WebResponse<Long> login(@RequestBody LoginRequest loginRequest,
        HttpSession httpSession,HttpServletRequest request,HttpServletResponse response){
        WebResponse<Long> resp = null;
        String domain = request.getServerName();
        try {
            ErrorNode node = this.validParams(loginRequest);
            if(node!=null){
                return new WebResponse<Long>(node.getCode(),node.getMsg());
            }
            //decodeLoginRequest(loginRequest);
            log.info("decodeLoginRequest account: {} pwd: {}",loginRequest.getPhone(),loginRequest.getPassword());
            resp = dubboLoginService.checkUserLogin(loginRequest);
            if(200 == resp.getRpco()){
                CookieOperator.updateCookie(response,null, domain,
                    CookieCode.encode(resp.getBody(), SsoUserCookieTools.createRand(),System.currentTimeMillis()),
                    604800);
            }
            return resp;
        } catch (Exception e) {
            log.error("Unknow.login", e);
            resp = new WebResponse<Long>(LoginError.LOGIN_ERROR.getCode(),LoginError.LOGIN_ERROR.getMsg());
            return resp;
        }

    }

    /**
     * 注册
     * @param loginRequest
     * @return
     */
    @RequestMapping(value = "/checkRegister", method = RequestMethod.POST)
    public CommonResponse checkRegister(@RequestBody LoginRequest loginRequest){
        CommonResponse resp = null;
        ErrorNode node = null;
        node = this.validParams(loginRequest);
        if(node!=null){
            resp = new CommonResponse(node.getCode(),node.getMsg());
            return resp;
        }
        WebResponse<MemberInfo> webResponse = dubboLoginService.getUserLogin(loginRequest);
        if (webResponse.getBody() != null) {
            resp = new CommonResponse(LoginError.ACCOUNT_EXIST.getCode(),LoginError.ACCOUNT_EXIST.getMsg());
            return resp;
        }
        /*long phone = dubboValidCodeService.checkVaildCode(loginRequest.getValidrand(),loginRequest.getValidCode());
        if(phone<0L){
            resp = new CommonResponse(LoginError.VAILD_CODE_ERROR.getCode(),LoginError.VAILD_CODE_ERROR.getMsg());
            return resp;
        }*/
        loginRequest.setName(loginRequest.getPhone().toString());
        resp = dubboLoginService.registerLogin(loginRequest);
        return resp;
    }
    private ErrorNode validParams(LoginRequest loginRequest){
        ErrorNode node = null;
        if(loginRequest.getPhone()==null|| StringUtils.isBlank(loginRequest.getPhone())||loginRequest.getPhone().contains(" ")){
            node =  LoginError.ACCOUNT_EMPTY;
        }
        if(loginRequest.getPassword()==null||StringUtils.isBlank(loginRequest.getPassword())||loginRequest.getPassword().contains(" ")){
            node =  LoginError.PWD_EMPTY;
        }
        return  node;
    }

    private LoginRequest decodeLoginRequest(LoginRequest loginRequest)throws Exception{
        if(!StringUtils.isBlank(loginRequest.getPhone())){
            String decode = new String(decryptByPrivateKey(decryptBASE64(loginRequest.getPhone()), rsaKey));
            log.info("decode account {} ",decode);
            loginRequest.setPhone(decode);
        }
        if(!StringUtils.isBlank(loginRequest.getPassword())){
            String pwd = new String(decryptByPrivateKey(decryptBASE64(loginRequest.getPassword()), rsaKey));
            log.info("decode pwd {} ",pwd);
            loginRequest.setPassword(new String(decryptByPrivateKey(decryptBASE64(loginRequest.getPassword()), rsaKey)));
        }
        log.info("decode account {} ", JSON.toJSONString(loginRequest));
        return loginRequest;
    }

    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public CommonResponse resetPassword(@RequestBody LoginRequest loginRequest,
        HttpSession httpSession,HttpServletRequest request,HttpServletResponse response){
        CommonResponse commonResponse = null;
        ErrorNode node = this.validParams(loginRequest);
        if(null != node){
            commonResponse = new CommonResponse(node.getCode(),node.getMsg());
            return commonResponse;
        }
        commonResponse =  dubboLoginService.resetPassword(loginRequest);
        return commonResponse;
    }

    @RequestMapping(value = "/sendCode", method = RequestMethod.POST)
    public CommonResponse sendCode(@RequestBody LoginRequest loginRequest,
        HttpSession httpSession,HttpServletRequest request,HttpServletResponse response){
        CommonResponse commonResponse = null;
        String validRand = null;
        if (loginRequest.getPhone() == null) {
            commonResponse = new CommonResponse(LoginError.PHONE_IS_NULL.getCode(),LoginError.PHONE_IS_NULL.getMsg());
            return commonResponse;
        }
        if (!PatternUtils.matchMobile(loginRequest.getPhone())) {
            throw new IllegalArgumentException("mobile is not support.");
        }
        String code = RandomUtils.randomDigit(6);
        validRand = RandomUtils.randomUniqueToken();
        //TODO 调用发短信接口，同时保存code和validRand到redis中
        commonResponse =  new WebResponse<String>(validRand);
        return commonResponse;
    }

}
