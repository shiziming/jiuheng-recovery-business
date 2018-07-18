package com.jiuheng.order.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/8.
 * 品类接收参数
 */
@Data
public class CategoryReq implements Serializable{

    /**
     * 品类id
     */
    private Integer id;
    /**
     * 父级id,root为-1
     */
    private Integer fid;
    /**
     * 分类名称
     */
    private String name;
    /**
     * 分类图标地址
     */
    private String categoryPic;
    /**
     * 排序值，同一级别下，由小到大排序展示
     */
    private int sort;
    /**
     * 分类状态， -1：删除   0：停用  1：启用
     */
    private byte status;
    /**
     * 分类节点从父节点到本节点的id路径，如 1,2,4
     */
    private String pathId;
    /**
     * 分类节点从父节点到本节点的name路径，如 3C >> 手机
     */
    private String pathName;
    /**
     * 记录创建时间
     */
    private String createTime;
    /**
     * 最近更新时间
     */
    private String updateTime;
    /**
     * 最近更新人名称
     */
    private String updator;
}
