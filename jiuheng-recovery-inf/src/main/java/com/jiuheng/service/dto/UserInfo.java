package com.jiuheng.service.dto;

import com.jiuheng.service.dto.login.MemberInfo;
import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/3.
 */
@Data
public class UserInfo extends MemberInfo {

   /**
     * 银行卡号
     */
    private String bankCard;
    /**
     * 银行卡
     */
    private String bank;
    /**
     * 用户姓名
     */
    private String userName;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 创建开始时间
     */
    private String createStartTime;
    /**
     * 创建结束时间
     */
    private String createEndTime;
}
