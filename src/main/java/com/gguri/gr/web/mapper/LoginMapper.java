package com.gguri.gr.web.mapper;

import org.mybatis.spring.annotation.MapperScan;

import com.gguri.gr.web.vo.UserVO;

@SuppressWarnings("rawtypes")
@MapperScan
public interface LoginMapper {

	String checkIdDuplicate(UserVO userVO);
	
	int createUser(UserVO userVO);
	
	UserVO validUserCheck(String id);
	
}
