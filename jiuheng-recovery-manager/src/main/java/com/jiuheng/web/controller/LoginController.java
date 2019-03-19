package com.jiuheng.web.controller;

import com.jiuheng.service.domain.Menu;
import com.jiuheng.service.domain.UserAccount;
import com.jiuheng.service.dubbo.DubboBackerAccountService;
import com.jiuheng.service.dubbo.DubboMenuService;
import com.jiuheng.service.respResult.CommonResponse;
import com.jiuheng.web.utils.SysUser;
import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/login")
public class LoginController {

	@Resource
	private DubboMenuService dubboMenuService;
	@Resource
	private DubboBackerAccountService dubboBackerAccountService;

	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public String login(HttpServletRequest request){
		String indexLoginId = request.getParameter("indexLoginId");
		String indexLoginPwd = request.getParameter("indexLoginPwd");

		if(StringUtils.isBlank(indexLoginId)) return "{\"flag\" : \"loginIdNull\"}";
		if(StringUtils.isBlank(indexLoginPwd)) return "{\"flag\" : \"loginPwdNull\"}";
		UserAccount userAccount = new UserAccount();
		userAccount.setAccount(indexLoginId);
		userAccount.setPassword(indexLoginPwd);
		userAccount = dubboBackerAccountService.login(userAccount);
		if(null == userAccount){
			return "{\"flag\" : \"loginPwdError\"}";
		}
		SysUser sysUser = new SysUser();
		sysUser.setUserId(userAccount.getUserId());
		sysUser.setUserAccount(userAccount.getAccount());
		sysUser.setUserName(userAccount.getUserName());
		if(indexLoginId.equals(userAccount.getAccount()) && indexLoginPwd.equals(userAccount.getPassword())){
			request.getSession().setAttribute("user", sysUser);
			return "{\"flag\" : \"success\"}";
		}else{
			return "{\"flag\" : \"loginPwdError\"}";
		}

	}
	/**
	 * 跳转用户登录页面
	 *
	 */
	@RequestMapping(value="/toLogin")
	public void toLogin(HttpSession session,HttpServletResponse response){
		session.removeAttribute("user");
		try {
			response.sendRedirect("/jiuheng-recovery-manager/login");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/getPositionRoleMenuTree")
	@ResponseBody
	public String getPositionRoleMenuTree(HttpServletRequest request){
		SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
		List<Menu> menus = dubboMenuService.queryMenu(sysUser.getUserId());
		/*Role role=sysUser.getRole();
		List<Menu> menus=role.getMenuList();*/
		JSONArray array = new JSONArray();
		for(Menu menu:menus){
			JSONObject object = new JSONObject();
			object.put("id", menu.getId());
			object.put("pId", menu.getPId());
			object.put("name", menu.getName());
			object.put("lnkUrl", menu.getLnkUrl());
			object.put("icon", menu.getIcon());
			array.add(object);
		}
		return array.toString();
	}
	
}
