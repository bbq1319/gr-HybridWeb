package com.gguri.gr.web.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.gguri.gr.web.vo.MobileVO;

@SuppressWarnings("rawtypes")
@MapperScan
public interface MobileMapper {

	List<String> getTokens(MobileVO mobileVO); 
	int saveUserToken(MobileVO mobileVO);
	
}
