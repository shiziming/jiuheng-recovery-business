package com.jiuheng.service.respResult;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

/**
 * @author danielmiao
 *
 */
@JsonInclude(Include.NON_NULL)
public class WebResponse<T> extends CommonResponse {

	/**
	 * 时间戳
	 */
	private long tsrp;

	private T body;

	public WebResponse() {
		super();
	}

	/**
	 * @param rpco
	 * @param msg
	 */
	public WebResponse(int rpco, String msg) {
		super(rpco, msg);
	}

	public WebResponse(T body) {
		super(200, null);
		this.tsrp = System.currentTimeMillis();
		this.body = body;
	}

	/**
	 * @return the tsrp
	 */
	public long getTsrp() {
		return tsrp;
	}

	/**
	 * @param tsrp
	 *            the tsrp to set
	 */
	public void setTsrp(long tsrp) {
		this.tsrp = tsrp;
	}

	/**
	 * @return the body
	 */
	public T getBody() {
		return body;
	}

	/**
	 * @param body
	 *            the body to set
	 */
	public void setBody(T body) {
		this.body = body;
	}

}
