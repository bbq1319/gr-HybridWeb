<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header>
	<div>
		<div class="head_more">
			<a href="/more">
				<img src="/resources/img/menu.png">
			</a>
		</div>
		<div class="app_name">
			<a href="/"><img alt="title" src="/resources/img/title.png"></a>
		</div>
		<%-- 
		<div class="head_login">
			<a href="/login">
				<img src="/resources/img/login.png">
			</a>
			<sec:authorize access="isAnonymous()">
				<a href="/login">
					<img src="/resources/img/login.png">
				</a>
			</sec:authorize>
			
			<sec:authorize access="isAuthenticated()">
				<a href="/info">
					<img src="/resources/img/login.png">
				</a>
			</sec:authorize>
		</div>
		 --%>
	</div>
	
	<ul class="nav">
		<li><a href="/"><span>홈</span></a></li>
		<li><a href="/delivery"><span>꾸르맛집</span></a></li>
		<li><a href="/menu"><span>식단표</span></a></li>
		<li><a href="/bus"><span>덕성버스</span></a></li>
	</ul>
</header>



<script>
	$(function() {
		setHighlightGnb();
	});
	
	function setHighlightGnb() {
		var href;
		var anchor;
		
		var nav = $(".nav").children();
		var length = nav.length;
		var location = window.location.pathname;
		
		for(var i=0; i<length; i++) {
			anchor = nav.eq(i).children();
			href = anchor.attr('href')
			
			if(location == href || (href.length > 1 && location.includes(href))) {
				anchor.children().addClass('ul hl');
				break;
			}
		}
	}
</script>