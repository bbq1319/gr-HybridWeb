package com.gguri.gr;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gguri.gr.web.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = {RequestMethod.POST, RequestMethod.GET})
	public String home(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		return "main";
	}
	
	@RequestMapping(value = "/menu", method = RequestMethod.GET)
	public String menu(Locale locale, Model model) {
		return "/menu";
	}

	@RequestMapping(value = "/bus", method = RequestMethod.GET)
	public String bus(Locale locale, Model model) {
		return "/bus";
	}
	
	@RequestMapping(value = "/more", method = RequestMethod.GET)
	public String more(Locale locale, Model model) {
		return "/common/more";
	}
	
	@RequestMapping(value = "/login", method = {RequestMethod.POST, RequestMethod.GET})
	public String login(Locale locale, Model model, @AuthenticationPrincipal UserVO userVO, HttpServletRequest request, HttpServletResponse response) {
		String url = "";
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Object principal = auth.getPrincipal();
		
		if(principal != null && principal instanceof UserVO && !((UserVO)principal).getId().isEmpty()) {
			url = "/common/info";
		} else {
			url = "/common/login";
		}
		
		return url;
	}
	
	@RequestMapping(value = "/logout", method = {RequestMethod.POST, RequestMethod.GET})
	public String logout(Locale locale, Model model, @AuthenticationPrincipal UserVO userVO, HttpServletRequest request, HttpServletResponse response) {
		return "/login/logout";
	}
	
	@RequestMapping(value = "/info", method = {RequestMethod.POST, RequestMethod.GET})
	public String info(Locale locale, Model model) {
		return "/common/info";
	}
	
	@RequestMapping(value = "/register", method = {RequestMethod.POST, RequestMethod.GET})
	public String register(Locale locale, Model model) {
		return "/login/register";
	}
	
}
