package com.gguri.gr.web.service;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gguri.gr.web.mapper.BusMapper;
import com.gguri.gr.web.vo.BusVO;

@SuppressWarnings( "rawtypes")
@Service("busService")
public class BusService {

private static final Logger logger = LoggerFactory.getLogger(BusService.class);
	
	@Autowired
	BusMapper busMapepr;
	
	public Map getBustable(BusVO busVO) {
		//List list = menuMapper.getMenu(menuVO);
		Map map = new HashMap();
		
		return map;
	}
	
}
