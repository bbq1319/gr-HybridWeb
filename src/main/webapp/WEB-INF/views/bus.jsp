<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Bus</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<div class="wrap">
			<div class="bus_top">
				<div>쉽게 확인하고<br>버스 놓치지 말자!</div> 
				<a href="https://www.ggu.ac.kr/sub050501">학교버스 시간표 바로가기 ></a>
			</div>
		</div>
		
		<div class="bus_mid">
			덕성여객 시간표
		</div>
		
		<div class="bus_bot">
			<div class="bus_type">
				<div>학교 > 터미널</div>
				<div>터미널 > 학교</div>		
			</div>
			
			<div class="bus_timetable">
			</div>
		</div>
	</body>
	
	<script>
		var date = new Date();
		var cur_hour;
		var cur_min;
		var cur_time;
		
		var bus_time = "";
		var bus_list = "";
		var cur_bus_time = "";
		var to_ter = $(".bus_type").children().eq(0);
		var to_sch = $(".bus_type").children().eq(1);
		var to_ter_list; 
		var to_sch_list; 
		
		if(date.getHours() < 10)
			cur_hour = "0" + date.getHours();
		else
			cur_hour = date.getHours() + "";
		if(date.getMinutes() < 10)
			cur_min = "0" + date.getMinutes();
		else
			cur_min = date.getMinutes() + "";
		
		cur_time = cur_hour + ":" + cur_min; 
		
		$.ajax({
			type : "POST",
			url : "/bus/getBustable.json",
			beforeSend : function(xhr) {   
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			data : {curTime: cur_time},
			datatype : "json",
			success : function(data) {
				to_ter_list = data.schList;
				to_sch_list = data.terList;
				
				getBusTime(to_ter_list, to_ter, to_sch);
			},
			error : function(xhr, status, error) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("error : " + error);
			}
		});
		
		to_ter.click(function() {
			getBusTime(to_ter_list, to_ter, to_sch);
		});
		to_sch.click(function() {
			getBusTime(to_sch_list, to_sch, to_ter);
		});
		
		function getBusTime(list, pos, re_pos) {
			var reg = "";
			bus_list = "";
			cur_bus_time = "";
			
			for(var i=0; i<list.length; i++) {
				bus_time = list[i].time_start;
				bus_list += (bus_time + "<br>");
				if(cur_time > bus_time) {
					cur_bus_time = bus_time;
				}
			}
			
			if(cur_bus_time == "" || cur_bus_time == null) {
				cur_bus_time = list[0].time_start;
			}
			
			console.log(cur_bus_time);

			bus_list = bus_list.replace(cur_bus_time, '<span class="bus_time_select">' + cur_bus_time + '</span>');
			pos.addClass("bus_select");	
			re_pos.removeClass("bus_select");
						
			$(".bus_timetable").html(bus_list);
		}
		
	</script>
</html>