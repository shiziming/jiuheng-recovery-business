package com.jiuheng.service.dto;

import java.io.Serializable;

/**
 * @author miaowenlong
 *
 */
public class UserLoginInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -610260638336036910L;

	private static final long SIMPLE_MAX_TIME_OUT = (long) (7*86400* 1000);

	/**
	 * 用户编号
	 */
	private long memberId;

	/**
	 * 随机数
	 */
	private long rand;

	/**
	 * 用户UA
	 */
	private String userAgent;

	/**
	 * 最后登录时间
	 */
	private long lastAccess;
	
	

	public UserLoginInfo() {
		super();
	}

	public UserLoginInfo(long memberId, long rand, long lastAccess) {
		super();
		this.memberId = memberId;
		this.rand = rand;
		this.lastAccess = lastAccess;
	}

	public UserLoginInfo(long memberId, long rand, String userAgent,
			long lastAccess) {
		super();
		this.memberId = memberId;
		this.rand = rand;
		this.userAgent = userAgent;
		this.lastAccess = lastAccess;
	}

	/**
	 * @return the memberId
	 */
	public long getMemberId() {
		return memberId;
	}

	/**
	 * @param memberId
	 *            the memberId to set
	 */
	public void setMemberId(long memberId) {
		this.memberId = memberId;
	}

	/**
	 * @return the rand
	 */
	public long getRand() {
		return rand;
	}

	/**
	 * @param rand
	 *            the rand to set
	 */
	public void setRand(long rand) {
		this.rand = rand;
	}

	/**
	 * @return the userAgent
	 */
	public String getUserAgent() {
		return userAgent;
	}

	/**
	 * @param userAgent
	 *            the userAgent to set
	 */
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	/**
	 * @return the lastAccess
	 */
	public long getLastAccess() {
		return lastAccess;
	}

	/**
	 * @param lastAccess
	 *            the lastAccess to set
	 */
	public void setLastAccess(long lastAccess) {
		this.lastAccess = lastAccess;
	}

}
