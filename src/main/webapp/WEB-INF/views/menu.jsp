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
			<div class="menu_date">
				<div id="prev"> ＜ </div>
				<div id="date"></div>
				<div id="next"> ＞ </div>
			</div>
			
			<div id="header" class="vp menu_header">
				<div id="breakfast">조식</div>
				<div id="lunch">중식</div>
				<div id="dinner">석식</div>
			</div>
			
			<div id="body" class="menu_body">
			</div>
			
			<div class="menu_footer">
				<a href="https://www.ggu.ac.kr/sub0504">
					<span>금주 식단</span> 보러가기 ＞
				</a>
			</div>
		</div>
	</body>
	
	<script>
	
	//  class="radius"
	//  class="us"
		var date = new Date();
		var cur_f_month;
		var cur_f_day;
		var cur_month = (date.getMonth() + 1) + "";
		var cur_day = date.getDate() + "";
		var cur_hour;
		var weeks = new Array('일', '월', '화', '수', '목', '금', '토');
		var week = date.getDay() + "";
		var today = weeks[week];
		
		
		var cur_cnt = 0;
		var event;
		var todayBreakfast;
		var todayLunch;
		var todayDinner;
		var allMenuList;
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
		
		$("#date").html(cur_f_month + "." + cur_f_day + "(" + today +")");
		
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
				allMenuList = data.allMenuList;
				
				for(var i in allMenuList) {
					if(data.today == allMenuList[i].today) {
						cur_cnt = i;
						todayBreakfast = allMenuList[i].breakfast.replace(/\s/g, '<br>');
						todayLunch = allMenuList[i].lunch.replace(/\s/g, '<br>');
						todayDinner = allMenuList[i].dinner.replace(/\s/g, '<br>');
						break;
					}
				}
				
				highlightMenu($("#breakfast"));
				$("#date").html(data.today);
				$("#body").html(todayBreakfast);
			},
			error : function(xhr, status, error) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("error : " + error);
			}
		});
		
		$("#header").on('click', 'div', function() {
			event = $(this);
			highlightMenu(event);
			
			if(event[0].innerHTML == "조식") {
				$("#body").html(todayBreakfast);
			}
			else if(event[0].innerHTML == "중식") {
				$("#body").html(todayLunch);
			}
			else if(event[0].innerHTML == "석식") {
				$("#body").html(todayDinner);
			}
		});

		$("#prev").click(function() {
			if(cur_cnt > 0) {
				cur_cnt--;
				todayBreakfast = allMenuList[cur_cnt].breakfast.replace(/\s/g, '<br>');
				todayLunch = allMenuList[cur_cnt].lunch.replace(/\s/g, '<br>');
				todayDinner = allMenuList[cur_cnt].dinner.replace(/\s/g, '<br>');
				
				highlightMenu($("#breakfast"));
				$("#date").html(allMenuList[cur_cnt].today);
				$("#body").html(todayBreakfast);
			}
		});
		$("#next").click(function() {
			if(cur_cnt < allMenuList.length-1) {
				cur_cnt++;
				todayBreakfast = allMenuList[cur_cnt].breakfast.replace(/\s/g, '<br>');
				todayLunch = allMenuList[cur_cnt].lunch.replace(/\s/g, '<br>');
				todayDinner = allMenuList[cur_cnt].dinner.replace(/\s/g, '<br>');
				
				highlightMenu($("#breakfast"));
				$("#date").html(allMenuList[cur_cnt].today);
				$("#body").html(todayBreakfast);
			}
		});
		
		function highlightMenu(pos) {
			$("#header").children().removeClass('radius');
			$("#header").children().addClass('us');
			pos.removeClass('us');
			pos.addClass('radius');
		}
	</script>
</html>