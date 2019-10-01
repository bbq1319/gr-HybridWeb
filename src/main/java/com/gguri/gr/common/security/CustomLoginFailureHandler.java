package com.gguri.gr.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			org.springframework.security.core.AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String errorMsg = "";
		
		if(exception instanceof BadCredentialsException) {
			errorMsg = "비밀번호가 일치하지 않습니다.";
		} else if(exception instanceof InternalAuthenticationServiceException) {
			errorMsg = "아이디가 일치하지 않습니다.";
		} else if(exception instanceof LockedException) {
			errorMsg = "인증 거부 : 잠긴 계정입니다.";
		} else if(exception instanceof DisabledException) {
			errorMsg = "인증 거부 : 비활성화 계정입니다.";
		} else if(exception instanceof AccountExpiredException) {
			errorMsg = "인증 거부 : 계정 유효 기간 만료입니다.";
		} else if(exception instanceof CredentialsExpiredException) {
			errorMsg = "인증 거부 : 비밀번호 유효 기간 만료입니다.";
		}
		
		request.setAttribute("errorMsg", errorMsg);
		request.getRequestDispatcher("/login").forward(request, response);
		// response.sendRedirect("/login?error=true");
	}
	
}
