package com.jiuheng.web.domain;

import com.jiuheng.web.utils.SysUser;

public class CurrentSysUser {
	
	
	private static ThreadLocal<SysUser> sysUsers = new ThreadLocal<SysUser>();
	
	public static void setCurrentSysUser(SysUser sysUser){
		sysUsers.set(sysUser);
	}
	
	public static SysUser getCurrentSysUser(){
		return sysUsers.get();
	}
	
	public static void removeCurrentSysUser(){
		sysUsers.remove();
	}
	
	public static String getCurrentSysUserAccount(){
		return sysUsers.get().getUserAccount();
	}
}