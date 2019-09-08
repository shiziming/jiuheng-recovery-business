package com.jiuheng.service.dto.login;


import com.jiuheng.service.respResult.ErrorNode;

/**
 * Created by liuhaikuo on 2017/11/14.
 */
public class LoginError {
    public final static ErrorNode ACCOUNT_EMPTY = new ErrorNode(40001, "帐号不能为空或包含空格");
    public final static ErrorNode PWD_EMPTY = new ErrorNode(40002, "密码不能为空或包含空格");
    public final static ErrorNode LOGIN_ERROR = new ErrorNode(40003, "登录失败");
    public final static ErrorNode ACCOUNT_EXIST = new ErrorNode(40004, "该帐号已经注册");
    public final static ErrorNode PHONE_IS_NULL = new ErrorNode(40050, "手机号不能为空");
    public final static ErrorNode VAILD_CODE_ERROR = new ErrorNode(40051, "手机验证码错误");
    public final static ErrorNode MESSAGE_TOO_BUSY = new ErrorNode(20002, "send message too busy.");
    public final static ErrorNode HOUR_MESSAGE_TOO_BUSY = new ErrorNode(20003, "hour send message too busy.");
    public final static ErrorNode PHONE_HAS_EXIT = new ErrorNode(20004, "this phone has exit.");

    public final static ErrorNode CAN_NOT_LOGIN = new ErrorNode(40100, "客观慢点 奴家跟不上了.");

    public final static ErrorNode REQUEST_TOO_BUSY = new ErrorNode(40101, "请求太频繁.");
    public final static ErrorNode RISK_SAFE_LOW = new ErrorNode(40102, "风控分数过低 需要验证码.");
    public static final ErrorNode VERIFY_CODE_EMPTY = new ErrorNode(40105,"请输入正确验证码");
    public static final ErrorNode VERIFY_CODE_ERROR = new ErrorNode(40106,"验证码验证失败");

    public static final ErrorNode NOT_FIND_BIND_MOB_ERROR = new ErrorNode(30001,"验证码错误");







}
