package com.gguri.gr.web.service;


import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.gguri.gr.common.ServerCode;
import com.gguri.gr.web.mapper.LoginMapper;
import com.gguri.gr.web.vo.UserVO;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service("loginService")
public class LoginService {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	@Autowired
	LoginMapper loginMapper;
	@Autowired
	BCryptPasswordEncoder passEncoder;
	
	public boolean checkIdDuplicate(UserVO userVO) {
		boolean validate = false;
		
		try {
			String id = loginMapper.checkIdDuplicate(userVO);
			
			if(id == null) {
				validate = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return validate;
	}
	
	public Map createUser(UserVO userVO) {
		Map resMap = new HashMap();
		
		String userPass = userVO.getPw();
		String pw = passEncoder.encode(userPass);
		userVO.setPw(pw);
		
		
		try {
			int res = loginMapper.createUser(userVO);
			if(res > 0) {
				resMap.put("RESULT_CODE", ServerCode.RESULT_SUCCESS);
			} else {
				resMap.put("RESULT_CODE", ServerCode.RESULT_ERROR);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resMap.put("RESULT_CODE", ServerCode.RESULT_SERVER_ERROR);
		}
		
		return resMap;
	}

}
