<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Home</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		GR
		<br>
		공지사항
		<br>
		공지제목
		<br>
		공지내용
		<br>
		오늘의 학식
		<br>
		2.2(토)
		<br>
		조식 중식 석식
		<br>
		... ... ...
		<br>
		... ... ...
		<br>
		...
		<br>
		현재 탈 수 있는 버스는?
		<br>
		
		터미널 > 학교 15:30
		<br>
		학교 > 터미널 15:00
		<br>
	</body>
	
	<script>
		$(document).ready(function() {
			getNotice();
			getMenu();
			getBusTime();
		});
		
		function getNotice() {

		}
	
		function getMenu() {
			var today = getDate();
			
			$.ajax({
				type : "POST",
				url : "/menu/getMenu.json",
				data : {date: today},
				datatype : "json",
				success : function(data) {
					console.log(data);
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			})
		}
		
		function getBusTime() {
			
		}
	</script>
</html>