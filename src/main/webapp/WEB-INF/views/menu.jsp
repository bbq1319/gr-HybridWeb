<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<title>Menu</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<div class="wrap">
			<div class="menu_top">
				<div>오늘 뭐먹지?</div>
				<a href="https://www.ggu.ac.kr/sub0504">학교식당 사이트 바로가기 ></a>
			</div>
			
			<div class="menu_mid">
				<div id="today"></div>
				<div>
					<span id="breakfast">조식</span>
					<span id="lunch">중식</span>
					<span id="dinner">석식</span>
				</div>
				<div class="slide wb">
					<div class="prev"></div>
					<div class="cur_menu" id="cur_menu"></div>
					<div class="next"></div>
					
					<!-- <div id="breakfast">조식</div>
					<div id="lunch">중식</div>
					<div id="dinner">석식</div> -->
				</div>
			</div>
			
			<div class="menu_bot">
				<div>금주의 식단</div>
				
				<div class="slide">
					<div class="prev ml"><img src="/resources/img/prev.png"></div>
					<div class="week_day" id="week_day"></div>
					<div class="next mr"><img src="/resources/img/next.png"></div>
				</div>
				
				<table class="menu">
					<colgroup>
						<col width="33%" />
						<col width="34%" />
						<col width="33%" />
					</colgroup>
					<thead>
						<tr>
							<th>조식</th>
							<th>중식</th>
							<th>석식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="week_breakfast"></td>
							<td id="week_lunch"></td>
							<td id="week_dinner"></td>
						</tr>	
					</tbody>
				</table>
			</div>
		</div>
	</body>
	
	<script>
		var date = new Date();
		var cur_f_month;
		var cur_f_day;
		var cur_month = (date.getMonth() + 1) + "";
		var cur_day = date.getDate() + "";
		var cur_hour;
		var weeks = new Array('일', '월', '화', '수', '목', '금', '토');
		var week = date.getDay() + "";
		var today = weeks[week];
		
		var cnt = 0;
		var breakfast;
		var lunch;
		var dinner;
		var allMenuList
		var empty = "식단정보를 불러올 수 없습니다.";
		
		if(cur_month < 10) 
			cur_f_month = "0" + cur_month;
		else 
			cur_f_month = cur_month;
		
		if(cur_day < 10) 
			cur_f_day = "0" + cur_day;
		else 
			cur_f_day = cur_day;
		
		if(date.getHours() < 10)
			cur_hour = "0" + date.getHours();
		else
			cur_hour = date.getHours() + "";
		
		$("#today").html(cur_f_month + "." + cur_f_day + "(" + today +")");
		
		$.ajax({
			type : "POST",
			url : "/menu/getMenu.json",
			beforeSend : function(xhr) {   
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			data : {month: cur_month, day: cur_day, all_menu: "Y"},
			datatype : "json",
			success : function(data) {
				if(data.todayBreakfast == empty)
					breakfast = data.todayBreakfast;
				else
					breakfast = data.todayBreakfast.replace(/\s/g, ', ');
				if(data.todayLunch == empty)
					lunch = data.todayLunch;
				else
					lunch = data.todayLunch.replace(/\s/g, ', ');
				if(data.todayDinner == empty)
					dinner = data.todayDinner;
				else
					dinner = data.todayDinner.replace(/\s/g, ', ');

				if(cur_hour >= 20 || cur_hour < 10) {
					$("#breakfast").css("color", "#126DFF");
					$("#cur_menu").html(breakfast);
				}
				else if(cur_hour => 10 && cur_hour < 14) {
					$("#lunch").css("color", "#126DFF");
					$("#cur_menu").html(lunch);
				}
				else if(cur_hour => 14 && cur_hour < 20) {
					$("#dinner").css("color", "#126DFF");
					$("#cur_menu").html(dinner);
				}
				
				allMenuList = data.allMenuList;
				$("#week_day").html(allMenuList[0].today);
				$("#week_breakfast").html(allMenuList[0].breakfast.replace(/\s/g, '<br>'));
				$("#week_lunch").html(allMenuList[0].lunch.replace(/\s/g, '<br>'));
				$("#week_dinner").html(allMenuList[0].dinner.replace(/\s/g, '<br>'));
			},
			error : function(xhr, status, error) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("error : " + error);
			}
		});
		
		
		$("#breakfast").click(function() {
			$("#breakfast").css("color", "#126DFF");
			$("#lunch").css("color", "#767676");
			$("#dinner").css("color", "#767676");
			$("#cur_menu").html(breakfast);
		});
		$("#lunch").click(function() {
			$("#breakfast").css("color", "#767676");
			$("#lunch").css("color", "#126DFF");
			$("#dinner").css("color", "#767676");
			$("#cur_menu").html(lunch);
		});
		$("#dinner").click(function() {
			$("#breakfast").css("color", "#767676");
			$("#lunch").css("color", "#767676");
			$("#dinner").css("color", "#126DFF");
			$("#cur_menu").html(dinner);
		});
		
		
		$(".prev").click(function() {
			if(cnt > 0) {
				cnt--;
				$("#week_day").html(allMenuList[cnt].today);
				$("#week_breakfast").html(allMenuList[cnt].breakfast.replace(/\s/g, '<br>'));
				$("#week_lunch").html(allMenuList[cnt].lunch.replace(/\s/g, '<br>'));
				$("#week_dinner").html(allMenuList[cnt].dinner.replace(/\s/g, '<br>'));
			}
		});
		$(".next").click(function() {
			if(cnt < allMenuList.length-1) {
				cnt++;
				$("#week_day").html(allMenuList[cnt].today);
				$("#week_breakfast").html(allMenuList[cnt].breakfast.replace(/\s/g, '<br>'));
				$("#week_lunch").html(allMenuList[cnt].lunch.replace(/\s/g, '<br>'));
				$("#week_dinner").html(allMenuList[cnt].dinner.replace(/\s/g, '<br>'));
			}
		});
	</script>
</html>