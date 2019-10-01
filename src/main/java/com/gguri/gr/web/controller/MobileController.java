package com.gguri.gr.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gguri.gr.web.service.MobileService;
import com.gguri.gr.web.vo.MobileVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@RequestMapping("/mobile")
@Controller
public class MobileController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeContoller.class);
	
	@Autowired
	MobileService mobileService;
	
	@RequestMapping("/saveUserToken.json")
	@ResponseBody
	public Map saveUserToken(@RequestParam Map paramMap, HttpServletRequest request, HttpServletResponse response, MobileVO mobileVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			System.out.println(paramMap.get("token"));
			System.out.println(paramMap.get("androidID"));
			
			String token = "";
			String androidID = "";
			
			if(paramMap.get("key") != null && paramMap.get("androidID") != null) {
				token = (String) paramMap.get("token");
				androidID = (String) paramMap.get("androidID");
				mobileVO.setToken(token);
				mobileVO.setAndroidID(androidID);
			}
			
			map = mobileService.saveUserToken(mobileVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	@RequestMapping("/sendFCM.json")
	@ResponseBody
    public void sendFCM(@RequestParam Map paramMap, HttpServletRequest request, MobileVO mobileVO) throws Exception {
        try { 
        	logger.info("sendFCM Call");
        	
        	String title = "URL CALL";
        	String body = "Just Call";

        	mobileService.sendFCM(title, body);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }

}
