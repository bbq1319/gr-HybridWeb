package com.gguri.gr.web.vo;

public class MenuVO {
	private String month;
	private String day;
	private String mealtime;
	private String all_menu;
	
	@Override
	public String toString() {
		return "MenuVO [month=" + month + ", day=" + day + ", mealtime=" + mealtime + ", all_menu=" + all_menu + "]";
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
	public String getAll_menu() {
		return all_menu;
	}
	public void setAll_menu(String all_menu) {
		this.all_menu = all_menu;
	}
	
	
}
