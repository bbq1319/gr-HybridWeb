package com.gguri.gr.web.service;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gguri.gr.web.mapper.DeliveryMapper;
import com.gguri.gr.web.vo.DeliveryVO;

@SuppressWarnings({"unchecked", "rawtypes"})
@Service("deliveryService")
public class DeliveryService {
	
private static final Logger logger = LoggerFactory.getLogger(DeliveryService.class);
	
	@Autowired
	DeliveryMapper deliverynMapper;
	
	public Map getMenu(DeliveryVO deliveryVO) {
		Map map = new HashMap();
		
		if(deliveryVO.getIsMain().equals("Y")) {
			map.put("menuID", deliverynMapper.getMenuID(deliveryVO));
		}
		map.put("menu", deliverynMapper.getMenu(deliveryVO));
		
		return map;
	}
	
	public Map getMenuInfo(DeliveryVO deliveryVO) {
		Map map = new HashMap();
		map.put("menuInfo", deliverynMapper.getMenuInfo(deliveryVO));
		map.put("restaurantInfo", deliverynMapper.getRestaurantInfo(deliveryVO));
		
		return map;
	}

}
