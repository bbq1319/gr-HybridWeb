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
			<a href="/">금알</a>
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
	
	<hr color="gray" width="100%">
</header>



<script>
	
</script>