package com.gguri.gr.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gguri.gr.web.service.NoticeService;
import com.gguri.gr.web.vo.NoticeVO;

@Component
public class Scheduler {

	private static final Logger logger = LoggerFactory.getLogger(Scheduler.class);
	
	@Autowired
	NoticeService noticeService;
	
	@Scheduled(cron="0 0 9,12,15,18 * * * ")
	public void RefreshNotice() {
		logger.info("RefreshNotice");
		NoticeVO noticeVO = new NoticeVO();
		noticeVO.setIsMain("N");
		
		noticeService.getNotice(noticeVO);
	}
	
}
