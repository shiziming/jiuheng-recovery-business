package com.jiuheng.service.respResult;

import java.io.Serializable;

/**
 * @author danielmiao
 *
 */
public class CommonResponse implements Serializable{

	/**
	 * 返回码
	 */
	private int rpco;

	/**
	 * 错误信息
	 */
	private String msg;

	public CommonResponse() {
		super();
	}

	/**
	 * @param rpco
	 * @param msg
	 */
	public CommonResponse(int rpco, String msg) {
		super();
		this.rpco = rpco;
		this.msg = msg;
	}

	/**
	 * @return
	 */
	public int getRpco() {
		return rpco;
	}

	/**
	 * @param rpco
	 */
	public void setRpco(int rpco) {
		this.rpco = rpco;
	}

	/**
	 * @return
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * @param msg
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

}
