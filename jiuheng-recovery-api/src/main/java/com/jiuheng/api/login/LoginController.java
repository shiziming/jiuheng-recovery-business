package com.jiuheng.api.login;

import static com.jiuheng.api.utils.RsaUtils.decryptBASE64;
import static com.jiuheng.api.utils.RsaUtils.decryptByPrivateKey;

import com.alibaba.fastjson.JSON;
import com.jiuheng.service.dto.login.LoginError;
import com.jiuheng.service.dto.login.LoginRequest;
import com.jiuheng.service.dubbo.DubboLoginService;
import com.jiuheng.service.dubbo.DubboValidCodeService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.service.respResult.ErrorNode;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

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
    public CommonResponse login(@RequestBody LoginRequest loginRequest,
        HttpSession httpSession,HttpServletRequest request,HttpServletResponse response){
        CommonResponse resp = null;
        try {
            ErrorNode node = this.validParams(loginRequest);
            if(node!=null){
                return new CommonResponse(node.getCode(),node.getMsg());
            }
            decodeLoginRequest(loginRequest);
            logger.info("decodeLoginRequest account: {} pwd: {}",loginRequest.getPhone(),loginRequest.getPassword());
            resp = dubboLoginService.checkUserLogin(loginRequest);
            return resp;
        } catch (Exception e) {
            logger.error("Unknow.login", e);
            resp = new CommonResponse(LoginError.LOGIN_ERROR.getCode(),LoginError.LOGIN_ERROR.getMsg());
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
        if(loginRequest.getPhone()==null|| StringUtils.isBlank(loginRequest.getPhone())||loginRequest.getPhone().contains(" ")){
            node =  LoginError.ACCOUNT_EMPTY;
        }
        if(node!=null){
            resp = new CommonResponse(node.getCode(),node.getMsg());
            return resp;
        }
        long phone = dubboValidCodeService.checkVaildCode(loginRequest.getValidrand(),loginRequest.getValidCode())
        if(phone<0L){
            resp = new CommonResponse(LoginError.VAILD_CODE_ERROR.getCode(),LoginError.VAILD_CODE_ERROR.getMsg());
            return resp;
        }
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
            logger.info("decode account {} ",decode);
            loginRequest.setPhone(decode);
        }
        if(!StringUtils.isBlank(loginRequest.getPassword())){
            String pwd = new String(decryptByPrivateKey(decryptBASE64(loginRequest.getPassword()), rsaKey));
            logger.info("decode pwd {} ",pwd);
            loginRequest.setPassword(new String(decryptByPrivateKey(decryptBASE64(loginRequest.getPassword()), rsaKey)));
        }
        logger.info("decode account {} ", JSON.toJSONString(loginRequest));
        return loginRequest;
    }
}
