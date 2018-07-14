package com.jiuheng.web.domain;

/**
 * 基础树节点数据类
 * @author Zhu.Xuecai
 * @date 2015年7月11日下午2:00:00
 * @Copyright(c) gome inc Gome Co.,LTD
 */
public class BaseTreeNode extends BaseEntity {
	private static final long serialVersionUID = 1L;
	/**
     * 父内码
     */
	private int parentId;

	/**
     * 父代码
     */
	private String parentCode;
	/**
     * 层级数
     */
	private short level;
	/**
     * 层级数
     */
	private boolean isLeaf;
	
	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public short getLevel() {
		return level;
	}

	public void setLevel(short level) {
		this.level = level;
	}

	public boolean isLeaf() {
		return isLeaf;
	}

	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}	
}
