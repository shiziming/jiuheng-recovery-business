package com.jiuheng.service.respResult;

import java.io.Serializable;

/**
 * 默认0表示成功
 *
 * @author guanzhisong
 * @date 2018年7月2日
 * @param <T>
 */
public class CommonResult<T> implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -8131642446151012999L;

    private int code;

    private String msg;

    private T data;

    public CommonResult(T data) {
        this(0, null, data);
    }

    public CommonResult(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public CommonResult(int code, String msg, T data) {
        super();
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    /**
     * @return the code
     */
    public int getCode() {
        return code;
    }

    /**
     * @return the msg
     */
    public String getMsg() {
        return msg;
    }

    /**
     * @return the data
     */
    public T getData() {
        return data;
    }

}
