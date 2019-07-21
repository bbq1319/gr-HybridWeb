package com.gguri.gr.web.mapper;

import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

import com.gguri.gr.web.vo.BusVO;

@SuppressWarnings("rawtypes")
@MapperScan
public interface BusMapper {
	
	Map getBustable(BusVO busVO);

}
