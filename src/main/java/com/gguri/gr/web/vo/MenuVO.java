package com.gguri.gr.web.vo;

public class MenuVO {
	private String month;
	private String day;
	private String mealtime;
	
	@Override
	public String toString() {
		return "MenuVO [month=" + month + ", day=" + day + ", mealtime=" + mealtime + "]";
	}
	
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getMealtime() {
		return mealtime;
	}
	public void setMealtime(String mealtime) {
		this.mealtime = mealtime;
	}
	
}
