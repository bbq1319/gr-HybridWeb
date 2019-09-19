package com.gguri.gr.web.service;

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
import org.springframework.stereotype.Service;

import com.gguri.gr.web.vo.MenuVO;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service("menuService")
public class MenuService {

	private static final Logger logger = LoggerFactory.getLogger(MenuService.class);
	
	public Map getMenu(MenuVO menuVO) {
		//List list = menuMapper.getMenu(menuVO);
		Map map = new HashMap();
		String month = menuVO.getMonth();
		String day = menuVO.getDay();
		String all_menu = menuVO.getAll_menu();
		String f_month = month;
		String f_day = day;
		String breakfast = "";
		String lunch = "";
		String dinner = "";
		String today = "";
		String empty = "식단정보를 불러올 수 없습니다.";
		JSONArray jsonMenuArr = new JSONArray();
		JSONObject jsonMenuObj = new JSONObject();
		
		if(Integer.parseInt(month) < 10)
			f_month = "0" + month;
		if(Integer.parseInt(day) < 10)
			f_day = "0" + day;
		
		try {
			Document doc = Jsoup.connect("https://www.ggu.ac.kr/sub0504/").get();
			
			Elements par_row = doc.select(".table-wrap").eq(2).select("table > tbody > tr");
            Elements par_day = doc.select(".table-wrap").eq(2).select("table > tbody > tr > th");
            
            int par_day_length = par_day.size() - 1;
            
            for(int i=0; i<par_day_length; i++) {
            	today = par_day.get(i).text();
            	
            	if(all_menu.equals("Y")) {
            		jsonMenuObj = new JSONObject();
            		jsonMenuObj.put("today", today);
            		jsonMenuObj.put("breakfast", par_row.get(i).select("td").eq(0).text());
            		jsonMenuObj.put("lunch", par_row.get(i).select("td").eq(1).text());
            		jsonMenuObj.put("dinner", par_row.get(i).select("td").eq(2).text());
            		
            		jsonMenuArr.add(jsonMenuObj);
            	}
            	
            	if(today.contains(month) && today.contains(day)) {
            		breakfast = par_row.get(i).select("td").eq(0).text();
            		lunch = par_row.get(i).select("td").eq(1).text();
            		dinner = par_row.get(i).select("td").eq(2).text();
            		
            		map.put("todayBreakfast", breakfast);
            		map.put("todayLunch", lunch);
            		map.put("todayDinner", dinner);
            	}
            	else if(today.contains(f_month) && today.contains(f_day)) {
            		breakfast = par_row.get(i).select("td").eq(0).text();
            		lunch = par_row.get(i).select("td").eq(1).text();
            		dinner = par_row.get(i).select("td").eq(2).text();

            		map.put("todayBreakfast", breakfast);
            		map.put("todayLunch", lunch);
            		map.put("todayDinner", dinner);
            	}
            }
            
            if(breakfast.isEmpty())
            	map.put("todayBreakfast", empty);
            if(lunch.isEmpty())
            	map.put("todayLunch", empty);
            if(dinner.isEmpty())
            	map.put("todayDinner", empty);
            
            if(all_menu.equals("Y")) {
            	map.put("allMenuList", jsonMenuArr);
            }
            
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
}
