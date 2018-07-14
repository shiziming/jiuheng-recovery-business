package com.jiuheng.web.intercept;

import com.jiuheng.web.domain.CurrentSysUser;
import com.jiuheng.web.utils.SysUser;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


public class LoginInterceptor implements HandlerInterceptor{
	
	private static final Logger log = LoggerFactory.getLogger(LoginInterceptor.class);

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();
		Object user = request.getSession().getAttribute("user");
        if (user == null) {
        	if(path.startsWith("/login")){
        		return true;
        	}else  if (path.startsWith("/index")) {
                response.sendRedirect("login");
                return true;
            }
            response.setStatus(401);
            return false;
        } 
        CurrentSysUser.setCurrentSysUser((SysUser)user);
		return true;
	}

	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		if(ex != null){
			response.setStatus(500);
			log.error("system.error",ex);
		}
		CurrentSysUser.removeCurrentSysUser();
	}

}
