package com.gguri.gr.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gguri.gr.web.service.MenuService;
import com.gguri.gr.web.vo.MenuVO;

@SuppressWarnings({ "rawtypes", "unchecked" })
@RequestMapping("/menu")
@Controller
public class MenuController {
	
	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@Autowired
	MenuService menuService;
	
	@RequestMapping("/getMenu.json")
	@ResponseBody
	public Map getMenu(@RequestParam Map paramMap, MenuVO menuVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			menuVO.setDay(paramMap.get("month").toString());
			menuVO.setDay(paramMap.get("day").toString());
			map = menuService.getMenu(menuVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}

}
