package com.gguri.gr.common.session;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.gguri.gr.common.CommonUtil;
import com.gguri.gr.web.vo.UserVO;

public class SessionUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(SessionUtil.class);
	
	public static HttpSession session() {
	    ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    return attr.getRequest().getSession(true); // true == allow create
	}
	
	public static void setSessionTimeOut(){
		session().setMaxInactiveInterval(86400); //24시간
	}
	
	public static void setSessionInfo(UserVO userVO){
		session().setAttribute("loginInfo", userVO); 
		logger.debug("Set Session Attribute loginInfo");
	}
	
	public static boolean isLogin(){
		if (session().getAttribute("loginInfo") == null ){
			logger.info("failed!!");
			return false;
		}else{
			CommonUtil.getVO(session().getAttribute("loginInfo"));
			logger.info("success!!");
			return true;
		}
	}

}
