package com.jiuheng.api.utils;

import java.util.HashMap;

/**
 * @author miaowenlong
 *
 */
public enum CookieStatus {

	/**
	 * 校验成功
	 */
	PASS(1),
	/**
	 * 本地超时，建议检查登录服务
	 */
	LOACL_TIME_OUT(0x11),
	/**
	 * 远程检查错误，应用自己判断是否执行
	 */
	REMOTE_SERVICE_ERROR(0x12),
	/**
	 * 解密失败
	 */
	DECODE_FAILD(0x40),
	/**
	 * 效验失败
	 */
	FAILD(0x50),
	/**
	 * 全局超时
	 */
	GLOBE_TIME_OUT(0x51),
	/**
	 * 强制退出,其他位置登录
	 */
	FOUSE_LOGOUT(0x52),
	/**
	 * 账户冻结
	 */
	FREEZE(0x80);

	private int value;

	private final static HashMap<Integer, CookieStatus> map = new HashMap<>();

	static {
		for (CookieStatus status : CookieStatus.values()) {
			CookieStatus.map.put(status.value, status);
		}
	}

	/**
	 * @param value
	 */
	private CookieStatus(int value) {
		this.value = value;
	}

	/**
	 * @return the value
	 */
	public int getValue() {
		return value;
	}

	/**
	 * 解析登录状态
	 * 
	 * @param value
	 * @return CookieStatus
	 * @throws IllegalArgumentException
	 *             - 如果该枚举类型没有带有指定的常量
	 */
	public final static CookieStatus parser(Integer value) {
		CookieStatus status = CookieStatus.map.get(value);
		if (status == null) {
			throw new IllegalArgumentException(String.format(
					"parser CookieStatus error,value=[%d]", value));
		}
		return status;
	}

	/**
	 * 验证是否登录成功
	 * 
	 * @param status
	 * @return boolean true可登录，false为禁止登录
	 */
	public final static boolean isVaild(CookieStatus status) {
		return status.value < CookieStatus.DECODE_FAILD.value;
	}
}
