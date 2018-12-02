package com.jiuheng.api.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieOperator {

    public static final String LOGIN_COOKIE_HEAD = "CSLCH";
    public static final String LOGIN_COOKIE_PATH = "/";
    public static final String LOGIN_OPENID = "opid";

    public final static Cookie getCookie(HttpServletRequest request) {
        Cookie ret = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(CookieOperator.LOGIN_COOKIE_HEAD)) {
                    ret = cookie;
                    break;
                }
            }
        }
        return ret;
    }


    public final static void updateCookie(HttpServletResponse response, Cookie cookie,
            String domain, String value, int timeOut) {
        if (cookie == null) {
            cookie = new Cookie(CookieOperator.LOGIN_COOKIE_HEAD, value);
        }
        cookie.setDomain(domain);
        cookie.setHttpOnly(true);
        cookie.setPath(CookieOperator.LOGIN_COOKIE_PATH);
        cookie.setValue(value);
        cookie.setMaxAge(timeOut);
        response.addCookie(cookie);
    }

    public final static Cookie writeCookie(HttpServletResponse response, Cookie cookie,
            String domain, String value, int timeOut) {
        if (cookie == null) {
            cookie = new Cookie(CookieOperator.LOGIN_COOKIE_HEAD, value);
        }
        cookie.setDomain(domain);
        cookie.setHttpOnly(true);
        cookie.setPath(CookieOperator.LOGIN_COOKIE_PATH);
        cookie.setValue(value);
        cookie.setMaxAge(timeOut);
        return cookie;
    }

    public final static Cookie getCookieByName(HttpServletRequest request, String name) {
        Cookie ret = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    ret = cookie;
                    break;
                }
            }
        }
        return ret;
    }
}
