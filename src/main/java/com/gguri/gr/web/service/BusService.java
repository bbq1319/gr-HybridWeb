package com.gguri.gr.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gguri.gr.web.mapper.BusMapper;
import com.gguri.gr.web.vo.BusVO;

@SuppressWarnings({"unchecked", "rawtypes"})
@Service("busService")
public class BusService {

private static final Logger logger = LoggerFactory.getLogger(BusService.class);
	
	@Autowired
	BusMapper busMapper;
	
	public Map getBustable(BusVO busVO) {
		//List list = menuMapper.getMenu(menuVO);
		Map map = new HashMap();
		List<BusVO> list = busMapper.getBustable(busVO);
		List<BusVO> 
			terList = new ArrayList<BusVO>(),
			schList = new ArrayList<BusVO>();
		
		
		for(BusVO li : list) {
			if(li.getDestination().equals("T")) {
				terList.add(li);
			}
			else if(li.getDestination().equals("S")) {
				schList.add(li);
			}
		}
		
		map.put("terList", terList);
		map.put("schList", schList);
		
		logger.info("busList : ", map.get("busList"));
		
		return map;
	}
	
}
