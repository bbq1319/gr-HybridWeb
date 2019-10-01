package com.gguri.gr.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.gguri.gr.common.CommonUtil;

// 출처: https://cofs.tistory.com/87 [CofS]
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, 
        Authentication authentication) throws ServletException, IOException {
		logger.info("onAuthenticationSuccess");
		
		CommonUtil.getVO(authentication.getDetails());
		request.setAttribute("loginInfo", authentication.getPrincipal());
		
		response.sendRedirect("/");
    }

}
