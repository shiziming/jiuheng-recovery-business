package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2019/2/17.
 */
@Data
public class PasswordReq implements Serializable{

    /**
     * 密码
     */
    private String password;
    /**
     * 确认密码
     */
    private String resetPassword;
    /**
     * 用户id
     */
    private int userId;
    /**
     * 修改人id
     */
    private int updateUserId;
}
