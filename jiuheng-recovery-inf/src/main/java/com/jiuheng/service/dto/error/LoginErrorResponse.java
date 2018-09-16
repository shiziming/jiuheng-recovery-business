package com.jiuheng.service.dto.error;


import com.jiuheng.service.respResult.CommonResponse;

public class LoginErrorResponse extends CommonResponse {

	public LoginErrorResponse() {
		super(401, "用户未登录");
	}

}
