package com.jiuheng.web.controller;

import com.jiuheng.order.domain.Menu;
import com.jiuheng.order.dubbo.DubboMenuService;
import com.jiuheng.web.utils.SysUser;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/login")
public class LoginController {

	@Resource
	private DubboMenuService dubboMenuService;

	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public String login(HttpServletRequest request){
		String indexLoginId = request.getParameter("indexLoginId");
		String indexLoginPwd = request.getParameter("indexLoginPwd");

		if(StringUtils.isBlank(indexLoginId)) return "{\"flag\" : \"loginIdNull\"}";
		if(StringUtils.isBlank(indexLoginPwd)) return "{\"flag\" : \"loginPwdNull\"}";
		SysUser sysUser = new SysUser();
		sysUser.setUserId(123456);
		sysUser.setUserAccount(indexLoginId);
		sysUser.setUserName("石子明");
		if(indexLoginId.equals("admin") && indexLoginPwd.equals("123456")){
			request.getSession().setAttribute("user", sysUser);
			return "{\"flag\" : \"success\"}";
		}else{
			return "{\"flag\" : \"loginPwdError\"}";
		}

	}

	@RequestMapping(value="/getPositionRoleMenuTree")
	@ResponseBody
	public String getPositionRoleMenuTree(HttpServletRequest request){
		SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
		List<Menu> menus = dubboMenuService.queryMenu();
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

			/*object.put("id", 123);
			object.put("pId", 0);
			object.put("name", "商品管理");
			object.put("lnkUrl", "");
			object.put("icon", "/images/icons/kongtiao.png");
			array.add(object);
			object.put("id", 145);
			object.put("pId", 0);
			object.put("name", "用户管理");
			object.put("lnkUrl", "");
			object.put("icon", "/images/icons/kongtiao.png");
			array.add(object);
			object.put("id", 1234);
			object.put("pId", 123);
			object.put("name", "商品管理");
			object.put("lnkUrl", "http://bj.58.com/");
			object.put("icon", "/images/icons/kongtiao.png");
			array.add(object);
			object.put("id", 12342);
			object.put("pId", 145);
			object.put("name", "用户查询");
			object.put("lnkUrl", "http://bj.58.com/");
			object.put("icon", "");
			array.add(object);*/
		}
		return array.toString();
	}
	
}
