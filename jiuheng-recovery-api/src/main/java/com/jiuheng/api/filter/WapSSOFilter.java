package com.jiuheng.api.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jiuheng.api.domain.CommonValues;
import com.jiuheng.api.utils.CookieCode;
import com.jiuheng.api.utils.CookieOperator;
import com.jiuheng.service.dto.UserLoginInfo;
import com.jiuheng.service.dto.error.LoginErrorResponse;
import java.io.IOException;
import java.util.TreeSet;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class WapSSOFilter implements Filter {

    private final static Logger logger = LoggerFactory.getLogger(WapSSOFilter.class);

    private final static ObjectMapper mapper = new ObjectMapper();

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        logger.info("filter in {}", request.getRequestURL().toString());
        String domain = request.getServerName();
        long intime = System.currentTimeMillis();
        HttpSession session = request.getSession();
        Long rand = null;
        Long userId = null;
        UserLoginInfo info = null;
        if (session != null) {
            logger.info("rand {} userId {}",
                    session.getAttribute(CommonValues.SESSION_RAND),
                    session.getAttribute(CommonValues.SESSION_UID));
            rand = (Long) session.getAttribute(CommonValues.SESSION_RAND);
            userId = (Long) session.getAttribute(CommonValues.SESSION_UID);
        }
        logger.info("userid: {} rand: {}", userId, rand);
        Cookie clshCookie = CookieOperator.getCookieByName(request,"CSLCH");
        if(null == clshCookie || null == clshCookie.getValue()){
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            response.getWriter().write(mapper.writeValueAsString(new LoginErrorResponse()));
        }else{
            info = CookieCode.decode(clshCookie.getValue());
            session.setAttribute(CommonValues.SESSION_UID, info.getMemberId());
            session.setAttribute(CommonValues.SESSION_RAND, info.getRand());
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
