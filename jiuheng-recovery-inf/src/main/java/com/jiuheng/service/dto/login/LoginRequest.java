package com.jiuheng.service.dto.login;

import lombok.Data;

/**
 * Created by shiziming on 2017/11/9.
 */
@Data
public class LoginRequest {

    /**
     * 用户id
     */
    private long id;
    /**
     * 账号
     */
    private String phone;

    /**
     * 密码
     */
    private String password;

    /**
     *唯一序列码
     */
    private String validrand;

    /**
     *验证码
     */
    private String validCode;
}
