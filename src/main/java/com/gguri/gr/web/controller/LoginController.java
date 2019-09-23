package com.gguri.gr.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gguri.gr.web.service.LoginService;
import com.gguri.gr.web.vo.UserVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@RequestMapping("/login")
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping("/checkIdDuplicate.json")
	@ResponseBody
	public boolean checkIdDuplicate(@RequestParam Map paramMap, UserVO userVO) {
		boolean validate = false;
		
		try {
			userVO.setId(paramMap.get("id").toString());
			validate = loginService.checkIdDuplicate(userVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return validate;
	}
	
	@RequestMapping("/createUser.json")
	@ResponseBody
	public Map createUser(@ModelAttribute UserVO userVO) {
		Map map = new HashMap();
		
		try {
			map = loginService.createUser(userVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
}
