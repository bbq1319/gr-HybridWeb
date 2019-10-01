package com.gguri.gr.web.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gguri.gr.common.ServerCode;
import com.gguri.gr.web.mapper.NoticeMapper;
import com.gguri.gr.web.vo.NoticeVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@Service("noticeService")
public class NoticeService {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeService.class);
	
	@Autowired
	NoticeMapper noticeMapper;
	@Autowired
	MobileService mobileService;
	
	int cnt = 0;
	String isMain = "Y";
	NoticeVO vo = new NoticeVO();
	
	public Map getNotice(NoticeVO noticeVO) {
		Map map = new HashMap();
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		String aca = "academic";
		String non = "nonSubject";
		String job = "job";
		String gen = "general";
		
		vo = noticeVO;
		isMain = vo.getIsMain();
		
		if(isMain.equals("N")) {
			list = noticeMapper.getNotice(vo);
		} else {
//			list = noticeMapper.getNotice(vo);
			list = null;
		}
		
		map.put(aca, getDocParse("https://www.ggu.ac.kr/sub01080101", aca, list));
		map.put(non, getDocParse("https://www.ggu.ac.kr/sub01080107", non, list));
		map.put(job, getDocParse("https://www.ggu.ac.kr/sub01080103", job, list));
		map.put(gen, getDocParse("https://www.ggu.ac.kr/sub01080105", gen, list));
        
		return map;
	}
	
	public JSONArray getDocParse(String url, String notice_nm, List<NoticeVO> list) {
		Map map = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		String par_no, par_title, par_day, par_notice, par_url = "";
		String no = "";
		cnt = 0;
		
		if(list != null) {
			list = noticeMapper.getNotice(vo);
			
			for(NoticeVO li : list) {
				if(notice_nm.equals(li.getName())) {
					no = li.getNo();
				}
			}
		}
		
		try {
			Document doc = Jsoup.connect(url).get();
			Elements par_row = doc.select(".bbs").eq(0).select("tbody > tr");
            int par_notice_length = par_row.size();
            
            for(int i=0; i<par_notice_length; i++) {
            	par_no = par_row.get(i).select("td").eq(0).text();
            	par_title = par_row.get(i).select("td").eq(2).text();
            	par_day = par_row.get(i).select("td").eq(4).text();
            	
            	// ggu.ac.kr + par_url
            	par_url = par_row.get(i).select("td > a").attr("href");
            	par_notice = par_row.get(i).select(".notice").eq(0).text();
            	
            	if(par_notice.isEmpty()) {
                	if(cnt == 0 && !no.isEmpty() && !par_no.isEmpty() && Integer.parseInt(no) < Integer.parseInt(par_no)) {
                		vo.setNo(par_no);
                		vo.setName(notice_nm);
                		vo.setTitle(par_title);
                		
                		int res = noticeMapper.updateNotice(vo);
                		
                		if(res > 0) {
            				map.put("RESULT_CODE", ServerCode.RESULT_SUCCESS);
            				logger.info("result success!!");
            				
            				String title = "새로운 공지가 업데이트 되었습니다.";
            				mobileService.sendFCM(title, par_title);
            			} else {
            				map.put("RESULT_CODE", ServerCode.RESULT_ERROR);
            				logger.info("result error!!");
            			}

        				cnt ++;
                	}
                	
            		jsonObject = new JSONObject();
            		jsonObject.put("noticeNo", par_no);
            		jsonObject.put("noticeTitle", par_title);
            		jsonObject.put("noticeDay", par_day);
            		jsonObject.put("noticeURL", par_url);
            		jsonArray.add(jsonObject);
            		
            		map.put("arr_notice", jsonArray);
            		
            		if(jsonArray.size() >= 3)
            			break;
            	}
            }
            
            map.put("arr_" + notice_nm, jsonArray);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonArray;
	}

}
