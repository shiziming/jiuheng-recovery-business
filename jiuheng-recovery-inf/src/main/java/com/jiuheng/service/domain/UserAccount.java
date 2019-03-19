package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2019/1/24.
 */
@Data
public class UserAccount extends Base{

    /**
     * 用户id
     */
    private int userId;
    /**
     * 账号
     */
    private String account;
    /**
     * 密码
     */
    private String password;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 状态(0：启用，1：停用，-1：删除)
     */
    private int status;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 创建人
     */
    private int createUser;
    /**
     * 创建人名称
     */
    private String createUserName;
}
