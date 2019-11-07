<%@page import="com.gguri.gr.common.CommonUtil"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="com.gguri.gr.common.ServerCode"%>
<%@page import="com.gguri.gr.web.vo.UserVO"%>
<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth!=null ? auth.getPrincipal() : null;
	
	String 
		id = "",
		name = "",
		sex = "",
		birth = "",
		//email = "",
		type = "",
		major = "",
		sub_major = "",
		stu_no = "";
	
	if(principal != null && principal instanceof UserVO) {
		id = ((UserVO)principal).getId();
		name = ((UserVO)principal).getNm();
		sex = ((UserVO)principal).getSex().equals("M") ? "남" : "여";
		birth = ((UserVO)principal).getBirth();
		type = ((UserVO)principal).getType();
		major = ((UserVO)principal).getMajor();
		sub_major = ((UserVO)principal).getSub_major();
		stu_no = ((UserVO)principal).getStu_no();
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta charset="UTF-8">

<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>

<%
	String contextPath = request.getContextPath();
%>
<c:set var="contextPath" value="<%=contextPath %>"></c:set>

<!-- 로그인한 사용자 ID -->
<c:set var="user_info" value="${sessionScope.loginInfo}" />
<c:set var="user_id" value="${sessionScope.loginInfo.id}" />
<c:set var="user_nm" value="${sessionScope.loginInfo.nm}" />
<c:set var="user_stu_no" value="${sessionScope.loginInfo.stu_no}" />
<c:set var="user_sex" value="${sessionScope.loginInfo.sex}" />
<c:set var="user_type" value="${sessionScope.loginInfo.type}" />
<c:set var="user_major" value="${sessionScope.loginInfo.major}" />
<c:set var="user_sub_major" value="${sessionScope.loginInfo.sub_major}" />
<c:set var="user_birth" value="${sessionScope.loginInfo.birth}" />

<!-- 공통 에러코드 -->
<c:set var="result_success" value="${ServerCode.RESULT_SUCCESS }" />
<c:set var="result_error" value="${ServerCode.RESULT_ERROR }" />
<c:set var="result_already" value="${ServerCode.RESULT_ALREADY }" />
<c:set var="result_empty" value="${ServerCode.RESULT_EMPTY }" />
<c:set var="result_auth_error" value="${ServerCode.RESULT_AUTH_ERROR }" />
<c:set var="result_not_login" value="${ServerCode.RESULT_NOT_LOGIN }" />
<c:set var="result_server_error" value="${ServerCode.RESULT_SERVER_ERROR }" />
<c:set var="is_real" value="${ServerCode.IS_REAL }" />

<!-- JS -->
<script type="text/javascript" src="/resources/js/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="/resources/css/style.css?ver=test_65">
<link rel="stylesheet" href="/resources/css/sweetalert2.css?ver=test_3">

<!-- ICON -->
<!-- <link rel="shortcut icon" href="/img/favicon.png">
<link rel="icon" href="/img/favicon.png"> -->

<!-- FONT -->
<!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans"> -->

<script>
	/** @param txt<br/>
	 *  @param len : 생략시 기본값 20<br/>
	 *  @param lastTxt : 생략시 기본값 "..."<br/>
	 *  @returns 결과값
	 * <br/>
	 * <br/>
	 * 특정 글자수가 넘어가면 넘어가는 글자는 자르고 마지막에 대체문자 처리<br/>
	 *  ex) 가나다라마바사 -> textLengthOverCut('가나다라마바사', '5', '...') : 가나다라마...<br/>
	 *
	 * 출처: https://cofs.tistory.com/19 [CofS]
	 */
	function textLengthOverCut(txt, len, lastTxt) {
	    if (len == "" || len == null) { // 기본값
	        len = 20;
	    }
	    if (lastTxt == "" || lastTxt == null) { // 기본값
	        lastTxt = "...";
	    }
	    if (txt.length > len) {
	        txt = txt.substr(0, len) + lastTxt;
	    }
	    return txt;
	}

	function getDate() {
		var date = new Date();
		var cur_year;
		var cur_month;
		var cur_day;
		
		cur_year = date.getFullYear() + "";
		if(date.getMonth() + 1 < 10)
			cur_month = "0" + (date.getMonth() + 1);
		else 
			cur_month = (date.getMonth() + 1) + "";
		if(date.getDate() < 10) 
			cur_day = "0" + date.getDate();
		else 
			cur_day = date.getDate() + "";
		
		return cur_year + cur_month + cur_day;
	}
	
	function getTime() {
		var date = new Date();
		var cur_hour;
		var cur_min;
		var cur_seconds;
		
		if(date.getHours() < 10)
			cur_hour = "0" + date.getHours();
		else
			cur_hour = date.getHours() + "";
		if(date.getMinutes() < 10)
			cur_min = "0" + date.getMinutes();
		else
			cur_min = date.getMinutes() + "";
		if(date.getSeconds() < 10)
			cur_seconds = "0" + date.getSeconds();
		else
			cur_seconds = date.getSeconds() + "";
		
		return cur_hour + cur_min + cur_seconds;
	}
	
	/** 
	 * URL 파라미터 가져오기
	 * 2019.10.03
	 *  
	 * param : 파라미터 key값 
	 *
	 * 출처: https://gocoder.tistory.com/576 [고코더 IT Express]
	 */
	function getURLParams(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
</script>