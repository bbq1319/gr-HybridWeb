package com.gguri.gr.web.service;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.gguri.gr.common.ServerCode;
import com.gguri.gr.web.mapper.MobileMapper;
import com.gguri.gr.web.vo.MobileVO;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service("mobileService")
public class MobileService {
	
	private static final Logger logger = LoggerFactory.getLogger(MobileService.class);
	
	@Autowired
	MobileMapper mobileMapper;
	@Autowired
	ServletContext context;
	
	public List<String> getTokens(MobileVO mobileVO) {
		List<String> list = new ArrayList<String>();
		list = mobileMapper.getTokens(mobileVO);
		
		return list;
	}
	
	public void sendFCM(String title, String body) {
		try {
			if(body != null && title != null) {
                // String path = request.getSession().getServletContext().getRealPath("/") + "resources/google/gr-gguri-firebase-adminsdk-vg8wc-4b28f97b49.json";
				String path = context.getRealPath("/") + "resources/google/gr-gguri-firebase-adminsdk-vg8wc-4b28f97b49.json";
                String MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
                String[] SCOPES = { MESSAGING_SCOPE };
                
                GoogleCredential googleCredential = GoogleCredential
                                    .fromStream(new FileInputStream(path))
                                    .createScoped(Arrays.asList(SCOPES));
                googleCredential.refreshToken();
                                    
                HttpHeaders headers = new HttpHeaders();
                headers.add("content-type" , MediaType.APPLICATION_JSON_VALUE);
                headers.add("Authorization", "Bearer " + googleCredential.getAccessToken());
                
                JSONObject notification = new JSONObject();
                notification.put("body", body);
                notification.put("title", title);
                
                JSONObject message = new JSONObject();
                message.put("condition", "'NoticeIOS191122' in topics");
//                message.put("condition", "'NoticeAnd' in topics");
//                message.put("condition", "'Notice' in topics");
                message.put("notification", notification);
                
                JSONObject jsonParams = new JSONObject();
                jsonParams.put("message", message);
                
                HttpEntity<JSONObject> httpEntity = new HttpEntity<JSONObject>(jsonParams, headers);
                RestTemplate rt = new RestTemplate();            
                
                ResponseEntity<String> res = rt.exchange("https://fcm.googleapis.com/v1/projects/gr-gguri/messages:send"
                        , HttpMethod.POST
                        , httpEntity
                        , String.class);
            
                if (res.getStatusCode() != HttpStatus.OK) {
                    logger.debug("FCM-Exception");
                    logger.debug(res.getStatusCode().toString());
                    logger.debug(res.getHeaders().toString());
                    logger.debug(res.getBody().toString());
                    
                } else {
                    logger.debug(res.getStatusCode().toString());
                    logger.debug(res.getHeaders().toString());
                    logger.debug(res.getBody().toLowerCase());
                    
                }
    		}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	public Map saveUserToken(MobileVO mobileVO) {
		Map resMap = new HashMap();
		
		try {
			int res = mobileMapper.saveUserToken(mobileVO);
			
			if(res > 0) {
				resMap.put("RESULT_CODE", ServerCode.RESULT_SUCCESS);
			} else {
				resMap.put("RESULT_CODE", ServerCode.RESULT_ERROR);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return resMap;
	}
	
}
