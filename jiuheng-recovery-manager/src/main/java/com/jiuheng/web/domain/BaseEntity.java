package com.jiuheng.web.domain;

import java.io.Serializable;

/**
 * 基础实体类
 * @author Zhu.Xuecai
 * @date 2015年7月11日下午2:00:00
 * @Copyright(c) gome inc Gome Co.,LTD
 */
public class BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	/**
     * 内码
     */
	private int id;
	/**
     * 代码
     */
	private String code;
	/**
     * 名称
     */
	private String name;
	 /**
     * 状态
     */
	private short status;
	 /**
     * 最后维护时间
     */
	private java.util.Date lastUpdateTime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public java.util.Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(java.util.Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	
}
