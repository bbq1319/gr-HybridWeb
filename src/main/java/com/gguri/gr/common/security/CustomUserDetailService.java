package com.gguri.gr.common.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.gguri.gr.web.mapper.LoginMapper;
import com.gguri.gr.web.vo.UserVO;

public class CustomUserDetailService implements UserDetailsService {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomUserDetailService.class);

	@Autowired
	LoginMapper loginMapper;
	
	@Override
	public UserVO loadUserByUsername(String id) throws UsernameNotFoundException {
		UserVO userInfo = null;
		try {
			logger.info("CustomUserDetailService");
			userInfo = loginMapper.validUserCheck(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userInfo;
	}
	
}
