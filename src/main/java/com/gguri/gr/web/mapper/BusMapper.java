package com.gguri.gr.web.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.gguri.gr.web.vo.BusVO;

@SuppressWarnings("rawtypes")
@MapperScan
public interface BusMapper {
	
	List<BusVO> getBustable(BusVO busVO);

}
