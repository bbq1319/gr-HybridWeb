package com.gguri.gr.common;

import java.lang.reflect.Field;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommonUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);
	
	/**
	 * VO 객체에 선언된 변수 모두 가져오기
	 * 2019.09.05
	 * 설명 : 출력하고자 하는 VO를 매개변수로 넣어주면 VO 안의 내용들 출력
	 * 출처 : http://blog.naver.com/PostView.nhn?blogId=simpolor&logNo=221096716490&parentCategoryNo=&categoryNo=166&viewDate=&isShowPopularPosts=true&from=search
	 */
	
	public static void getVO(Object obj) {
		try { 
			for(Field field : obj.getClass().getDeclaredFields()) {
				field.setAccessible(true);
				Object value = field.get(obj);
				logger.info("FIELD : " + field.getName() + " / VALUE : " + value);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void getRequest(HttpServletRequest request) {
		Enumeration params = request.getParameterNames();
    	while(params.hasMoreElements()) {
    		String name = (String)params.nextElement();
    		System.out.println("KEY : " + name + " / VALUE : " + request.getParameter(name));
    	}
	}

}
