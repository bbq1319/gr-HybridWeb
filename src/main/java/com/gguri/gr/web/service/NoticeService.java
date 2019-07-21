package com.gguri.gr.web.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.gguri.gr.web.vo.NoticeVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@Service("noticeService")
public class NoticeService {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeService.class);
	
	public Map getNotice(NoticeVO noticeVO) {
		Map map = new HashMap();
		String aca = "academic";
		String non = "nonSubject";
		String job = "job";
		String gen = "general";
		
		map.put(aca, getDocParse("https://www.ggu.ac.kr/sub01080101", aca));
		map.put(non, getDocParse("https://www.ggu.ac.kr/sub01080107", non));
		map.put(job, getDocParse("https://www.ggu.ac.kr/sub01080103", job));
		map.put(gen, getDocParse("https://www.ggu.ac.kr/sub01080105", gen));
        
		return map;
	}
	
	public JSONArray getDocParse(String url, String notice_nm) {
		Map map = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		String par_no, par_title, par_day, par_notice, par_url = "";
		
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
