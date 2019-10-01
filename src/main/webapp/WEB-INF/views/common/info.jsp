<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Info</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<form action="/logout" method="POST"> 
			<input type="submit" value="로그아웃" /> 
			<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}">
		</form>
		 
		<br><br><br>
		
		아이디 : <%= id %> <br>
		이름 : <%= name %> <br>
		성별 : <%= sex %> <br>
		생일 : <%= birth %> <br>
		구분 : <%= type %> <br>
		전공 : <%= major %> <br>
		부전공 : <%= sub_major %> <br>
		학번 : <%= stu_no %> <br>
		
	</body>
	
	<script>
	</script>
</html>