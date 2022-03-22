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
		
		<div class="bus_wrap">
			<ul class="bus_nav">
				<li><span>학교 > 터미널</span></li>
				<li><span>터미널 > 학교</span></li>
			</ul>
			<ul class="bus_info">
				<li class="come"> 다가오는 버스</li>
				<li class="leave"> 신원사 경유</li>
			</ul>
			
			<table class="bus_table">
			</table>
			
			<p>신원사 경유 버스는<br>표 시간보다 15~20분 정도 여유롭게 나가는게 좋습니다.<br>특히 오전 10시 이전 버스 주의!</p>
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</body>
	<script>
		var date = new Date();
		var cur_hour;
		var cur_min;
		var cur_time;
		
		var to_ter = $(".bus_nav").children().eq(0);
		var to_sch = $(".bus_nav").children().eq(1);
		var to_ter_list; 
		var to_sch_list;
		
		var blist = "";
		var cnt = 1;
		var length = 4;
		
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
				
				getBusTime(to_ter, to_ter_list);
			},
			error : function(xhr, status, error) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("error : " + error);
			}
		});
		
		to_ter.click(function() {
			getBusTime(to_ter, to_ter_list);
		});
		to_sch.click(function() {
			getBusTime(to_sch, to_sch_list);
		});
		
		function getBusTime(nav, list) {
			var cur = true;
			var size = list.length;
			
			nav.parents().children().removeClass('active');
			nav.addClass('active');
			cnt = 1;
			blist = "";
			
			for(var i in list) {
				if(cnt == 1)
					blist += '<tr>';
				
				if(cur && cur_time < list[i].time_start) {
					blist += '<td class="bus_cur_time">';
					cur = false;
				} else {
					blist += '<td>';
				}
				if(list[i].via == 'Y'){
					blist += 	'<sup>●</sup>' + list[i].time_start;	
				} else {
					blist += 	list[i].time_start;
				}
				blist += '</td>';
				
				if(cnt == length) {
					blist += '</tr>';
					cnt = 1;
				}
				else 
					cnt++;
			}
			
			$(".bus_table").html(blist);
		}
		
		/*
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
		 */
	</script>
</html>