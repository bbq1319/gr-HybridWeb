package com.gguri.gr.web.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gguri.gr.web.service.LoginService;
import com.gguri.gr.web.vo.LoginVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@RequestMapping("/login")
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping("/checkIdDuplicate.json")
	@ResponseBody
	public boolean checkIdDuplicate(@RequestParam Map paramMap, LoginVO loginVO) {
		boolean validate = false;
		
		try {
			loginVO.setId(paramMap.get("id").toString());
			validate = loginService.checkIdDuplicate(loginVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return validate;
	}
	
	@RequestMapping("/createUser.json")
	@ResponseBody
	public Map createUser(@ModelAttribute LoginVO loginVO) {
		Map map = new HashMap();
		
		try {
			map = loginService.createUser(loginVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
}
