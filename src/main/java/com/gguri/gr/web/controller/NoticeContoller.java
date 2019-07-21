package com.gguri.gr.web.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gguri.gr.web.service.NoticeService;
import com.gguri.gr.web.vo.NoticeVO;

@SuppressWarnings({"rawtypes", "unchecked"})
@RequestMapping("/notice")
@Controller
public class NoticeContoller {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeContoller.class);

	@Autowired
	NoticeService noticeService;
	
	@RequestMapping("/getNotice.json")
	@ResponseBody
	public Map getMenu(@RequestParam Map paramMap, NoticeVO noticeVO) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			noticeVO.setPageNo(paramMap.get("page").toString());
			noticeVO.setIsMain(paramMap.get("isMain").toString());
			map = noticeService.getNotice(noticeVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
}
