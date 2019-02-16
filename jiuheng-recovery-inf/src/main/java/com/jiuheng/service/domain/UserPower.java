package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2019/2/11.
 */
@Data
public class UserPower implements Serializable{

    /**
     * 用户id
     */
    public int userId;
    /**
     * 账号
     */
    public String account;
    /**
     * 菜单id
     */
    public int menuId;
    /**
     * 菜单名称
     */
    public String menuName;
    /**
     * 创建时间
     */
    public String createTime;
    /**
     * 创建人
     */
    public String createUser;
}
