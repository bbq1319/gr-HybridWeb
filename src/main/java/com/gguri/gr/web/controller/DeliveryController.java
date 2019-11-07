package com.gguri.gr.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gguri.gr.web.service.DeliveryService;
import com.gguri.gr.web.vo.DeliveryVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@RequestMapping("/delivery")
@Controller
public class DeliveryController {

	private static final Logger logger = LoggerFactory.getLogger(DeliveryController.class);
	
	@Autowired
	DeliveryService deliveryService;
	
	@RequestMapping("/getMenu.json")
	@ResponseBody
	public Map getMenu(@RequestParam Map paramMap, DeliveryVO deliveryVO) {
		Map map = new HashMap();
		
		try {
			String isMain = (String) paramMap.get("isMain");
			deliveryVO.setIsMain(isMain);
			
			map = deliveryService.getMenu(deliveryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	@RequestMapping("/getMenuInfo.json")
	@ResponseBody
	public Map getMenuInfo(@RequestParam Map paramMap, DeliveryVO deliveryVO) {
		Map map = new HashMap();
		
		try {
			String dcode = (String) paramMap.get("dcode");
			deliveryVO.setDcode(dcode);
			
			map = deliveryService.getMenuInfo(deliveryVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
}
