package com.care.root.user.intercepter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.care.root.user.dto.UserDTO;
import com.care.root.user.service.UserService;
import com.care.root.user.session.UserSessionName;


public class AutoLoginIntercepter extends HandlerInterceptorAdapter implements UserSessionName{

	@Autowired
	UserService user_service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("autoLoginIntercepter ");
		
		Cookie login_cookie = WebUtils.getCookie(request, "login_cookie");
		if(login_cookie != null) {
			UserDTO dto = user_service.getUserSessionId(login_cookie.getValue());
			
			if(dto != null) {
				request.getSession().setAttribute(LOGIN, dto.getUser_id());
			}
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterConcurrentHandlingStarted(request, response, handler);
	}
	
	
	
}
