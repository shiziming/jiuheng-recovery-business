package com.jiuheng.service.dto.login;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/3.
 */
@Data
public class MemberInfo implements Serializable {

    /**
     * 用户id
     */
    private Long userId;
    /**
     * 昵称
     */
    private String name;
    /**
     * 手机号
     */
    private Long phone;
    /**
     * 密码
     */
    private String password;
}
