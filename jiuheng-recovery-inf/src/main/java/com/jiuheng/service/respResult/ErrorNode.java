package com.jiuheng.service.respResult;

import java.io.Serializable;

/**
 * @author danielmiao
 *
 */
public final class ErrorNode implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1794895351808269370L;

	/**
	 * 错误码
	 */
	private int code;

	/**
	 * 错误说明
	 */
	private String msg;

	/**
	 * @param code
	 * @param msg
	 */
	public ErrorNode(int code, String msg) {
		super();
		this.code = code;
		this.msg = msg;
	}

	/**
	 * @return
	 */
	public int getCode() {
		return code;
	}

	/**
	 * @return
	 */
	public String getMsg() {
		return msg;
	}

}
