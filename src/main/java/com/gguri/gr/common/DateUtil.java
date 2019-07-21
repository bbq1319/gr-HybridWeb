package com.gguri.gr.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateUtil {

	private static final Logger logger = LoggerFactory.getLogger(DateUtil.class);
	
	public String getDate(String format) {
		Calendar calendar = Calendar.getInstance();
		Date date = calendar.getTime();
		String dateFormat = (new SimpleDateFormat(format)).format(date);
		
		return dateFormat;
	}
	
}
