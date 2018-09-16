package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/6/23.
 */
@Data
public class Menu implements Serializable{

    /**
     * 菜单id
     */
    private String id;
    /**
     * 父id
     */
    private String pId;
    /**
     * 菜单名称
     */
    private String name;
    /**
     *链接地址
     */
    private String lnkUrl;
    /**
     * 图标地址
     */
    private String icon;
}
