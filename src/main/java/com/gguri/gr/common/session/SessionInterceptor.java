package com.gguri.gr.common.session;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.debug("-------- SessionInterceptor preHandle ----------");
    	String reqURI = request.getRequestURI();
    	logger.debug("-------- SessionInterceptor getRequestURI() ===> " + reqURI);
		
    	if (SessionUtil.isLogin()) {
    		SessionUtil.setSessionTimeOut();
    		return true;
    	} else {
    		response.sendRedirect("/main.jsp");
    		return false;
    	}
	}
	
}