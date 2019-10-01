package com.gguri.gr.common.security;


import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.gguri.gr.web.vo.UserVO;

public class CustomUserDetailProvider extends DaoAuthenticationProvider {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomUserDetailProvider.class);

	@Autowired
	CustomUserDetailService userService;
	@Autowired 
	private BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		logger.info("CustomUserDetailProvider");
		logger.info("authenticate");
		
		String id = authentication.getName();
		String pw = (String) authentication.getCredentials();
		boolean passMatch = false;
		
		UserVO userVO = null;
		Collection<? extends GrantedAuthority> authorities = null;

		try {
			userVO = userService.loadUserByUsername(id);
			
			if(userVO == null)
				throw new BadCredentialsException("아이디가 일치하지 않습니다.");
			
			passMatch = passwordEncoder.matches(pw, userVO.getPassword());
			
			if(passMatch)
				authorities = userVO.getAuthorities();
			else 
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
		} catch(UsernameNotFoundException e) { 
			logger.info(e.toString()); 
			throw new UsernameNotFoundException(e.getMessage()); 
		} catch(BadCredentialsException e) { 
			logger.info(e.toString()); 
			throw new BadCredentialsException(e.getMessage()); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return new UsernamePasswordAuthenticationToken(userVO, pw, authorities);
	}
	
}
