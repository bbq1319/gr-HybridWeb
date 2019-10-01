package com.gguri.gr.web.mapper;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.gguri.gr.web.vo.NoticeVO;

@SuppressWarnings("rawtypes")
@MapperScan
public interface NoticeMapper {

	List<NoticeVO> getNotice(NoticeVO busVO);
	int updateNotice(NoticeVO noticeVO);
	
}
