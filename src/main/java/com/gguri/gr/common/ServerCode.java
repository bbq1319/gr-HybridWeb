package com.gguri.gr.common;

public class ServerCode {
	public final static int RESULT_SUCCESS = 0;
	public final static int RESULT_ERROR = -1;
	public final static int RESULT_ALREADY = -2;
	public final static int RESULT_EMPTY = -3;
	public final static int RESULT_AUTH_ERROR = -4;
	public final static int RESULT_NOT_LOGIN = -100;
	public final static int RESULT_SERVER_ERROR = -500;
	
	public final static boolean IS_REAL = true;
	
	/**
	 * 멤버 별 권한 
	 * 
	 * ADMIN : 관리자
	 * COUNCIL : 학생
	 * REPRESENTATIVE : 과 대표
	 * MEMBER : 회원
	 * GUEST : 손님 
	 */
	public final static int ADMIN = 100;
	public final static int COUNCIL = 80;
	public final static int REPRESENTATIVE = 50;
	public final static int MEMBER = 10;
	public final static int GUEST = 1;
}
