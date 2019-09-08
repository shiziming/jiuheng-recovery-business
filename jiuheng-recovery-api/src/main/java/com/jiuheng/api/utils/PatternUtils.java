package com.jiuheng.api.utils;

import java.util.regex.Pattern;

public class PatternUtils {

	private static final Pattern mobilePattern = Pattern.compile(
//			"^(((1[3|8][0-9])|(14[5|7])|(15[^4,\\D])|(17[3|6|7|8]))\\d{8}|(170[0|5|9])\\d{7})$",
			"^1[3|4|5|6|7|8|9]\\d{9}$",
			Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE | Pattern.CANON_EQ);

	public static final boolean matchMobile(String mobile) {
		return mobilePattern.matcher(mobile).matches();
	}

	public static void main(String[] args) {
		System.out.println(matchMobile("11349238318"));
	}
}
