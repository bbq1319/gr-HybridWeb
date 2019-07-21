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

import com.gguri.gr.web.service.BusService;
import com.gguri.gr.web.service.MenuService;
import com.gguri.gr.web.vo.BusVO;
import com.gguri.gr.web.vo.MenuVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@Controller
public class BusController {
	
	private static final Logger logger = LoggerFactory.getLogger(BusController.class);

	@Autowired
	BusService busService;
	
	@RequestMapping("/getBustable.json")
	@ResponseBody
	public Map getBustable(@RequestParam Map paramMap, BusVO busVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map = busService.getBustable(busVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
}
