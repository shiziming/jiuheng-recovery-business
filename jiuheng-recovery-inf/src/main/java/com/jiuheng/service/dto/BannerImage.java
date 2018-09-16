package com.jiuheng.service.dto;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/9/10.
 */
@Data
public class BannerImage implements Serializable{

    /**
     * id
     */
    private int id;
    /**
     *链接地址
     */
    private String linkUrl;
    /**
     * 图片地址
     */
    private String imageUrl;
    /**
     * 排序
     */
    private int sort;
    /**
     * 图片状态（0失效，1生效）
     */
    private int status;
    /**
     * 创建人
     */
    private String createUser;
}
