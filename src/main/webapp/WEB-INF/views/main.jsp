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
		
		<!-- 로딩 바 -->
		<div id="loading">
			<img id="loading-image" src="/resources/img/packman.gif" alt="Loading..." />
		</div>
		
		<div class="wrap">
			<div class="middle">
				<div class="cotainer">
					<!-- 배너 -->
					<div id="banner">
						<img src="/resources/img/banner1.png">
						<img src="/resources/img/banner2.png">
						<img src="/resources/img/banner3.png">
					</div>
				
					<!-- 공지사항 -->
					<div class="row">
						<a href="https://www.ggu.ac.kr/sub01080101">
							<div class="detail">→</div>
							<div class="title">공지사항</div>
						</a>
						<div>
							<div class="sub" id="notice_title"></div>
							<div class="slide">
								<div class="prev"><img src="/resources/img/prev.png"></div>
								<table class="notice">
									<colgroup>
										<col width="75%" />
										<col width="25%" />
									</colgroup>
									<tbody id="notice_body">
										<tr>
											<td></td>
											<td></td>
										</tr>	
										<tr>
											<td></td>
											<td></td>
										</tr>	
										<tr>
											<td></td>
											<td></td>
										</tr>	
									</tbody>
								</table>
								<div class="next"><img src="/resources/img/next.png"></div>
							</div>
							<div class="notice_day" id="notice_day"></div>
							<div id="notice_title"></div>
						</div>
					</div>
					
					<div class="division"></div>
					
					<!-- 오늘의 식단 -->
					<div class="row">
						<a href="https://www.ggu.ac.kr/sub01080101">
							<div class="detail">→</div>
							<div class="title">오늘의 학식</div>
						</a>
						<div id="today" class="sub"></div>
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
									<td id="breakfast">조식</td>
									<td id="lunch">중식</td>
									<td id="dinner">석식</td>
								</tr>	
							</tbody>
						</table>
					</div>
					
					<div class="division"></div>
					
					<!-- 버스시간표 -->
					<div class="row">
						<div class="detail">→</div>
						<div class="title">
							현재 탈 수 있는 버스는?
						</div>
						
						<div></div>
						
						터미널 > 학교 15:30
						<br>
						학교 > 터미널 15:00
						<br>
					</div>
				</div>
			</div>
			<div class="footer">
				<div class="desc">
				</div>
				<div class="info">
				
				</div>
			</div>
		</div>
	</body>
	
	<script>
		$(document).ready(function() {
			getBanner();
			getNotice();
			getMenu();
			getBusTime();
		});
		
		function hideLoadingBar() {
			$('#loading').hide();  
		}
		
		// 슬라이드 배너
		function getBanner() {
			var banner = $("#banner");

			banner.find('img').hide();
			banner.find('img').first().show();
			banner.find('img').css('width', '100%');
			setInterval(function() {
				banner.append(banner.find('img').eq(0));
				banner.find('img').last().hide();
				banner.find('img').first().show();
			}, 2000);
		}
		
		
		// 공지사항
		function getNotice() {
			$.ajax({
				type : "POST",
				url : "/notice/getNotice.json",
				data : {page: 1, isMain: 'Y'},
				datatype : "json",
				success : function(data) {
					console.log(data);
					var num = 0;
					var arr = Object.keys(data);
					var length = Object.keys(data).length;

					var length = data.academic.length;
					var content = data.academic;;
					
					getNoriceDetail(0, data);
					
					// 이전 클릭 시
					$(".prev").click(function() {
						if (num > 0) {
							num--;
							getNoriceDetail(num, data);
						}
					});
					
					// 다음 클릭 시
					$(".next").click(function() {
						if (num < 3) {
							num++;
							getNoriceDetail(num, data);
						}
					});
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			});
		}
		
		function getNoriceDetail(num, data) {
			var notice_title;
			var aca = "학사공지";
			var non = "비교과 프로그램 운영공지";
			var job = "취업공지";
			var gen = "일반공지";
			
			if (num == 0) {
				content = data.academic;
				notice_title = aca;
			}
			else if (num == 1) {
				content = data.nonSubject;
				notice_title = non;
			}
			else if (num == 2) {
				content = data.job;
				notice_title = job;
			}
			else if (num == 3) {
				content = data.general;
				notice_title = gen;
			}
			
			$("#notice_title").html(notice_title);
			
			var notice_html = $("#notice_body").find('tr');
			var length = content.length;
			var href;
			
			for(var i=0; i<length; i++) {
				href = 'https://www.ggu.ac.kr' + content[i].noticeURL;
				notice_html.eq(i).find('td').eq(0).html("<a href=" + href + ">" + textLengthOverCut(content[i].noticeTitle) + "</a>");
				notice_html.eq(i).find('td').eq(1).html(content[i].noticeDay);	
				hideLoadingBar();
			}
		}
	
		
		// 메뉴
		function getMenu() {
			var date = new Date();
			var cur_f_month;
			var cur_f_day;
			var cur_month = (date.getMonth() + 1) + "";
			var cur_day = date.getDate() + "";
			
			if(cur_month < 10) 
				cur_f_month = "0" + cur_month;
			else 
				cur_f_month = cur_month;
			if(cur_f_day < 10) 
				cur_f_day = "0" + cur_day;
			else 
				cur_f_day = cur_day;
			
			$("#today").html(cur_f_month + "." + cur_day);
			
			$.ajax({
				type : "POST",
				url : "/menu/getMenu.json",
				data : {month: cur_month, day: cur_day},
				datatype : "json",
				success : function(data) {
					$("#breakfast").html(data.todayBreakfast.replace(/\s/g, '<br>'));
					$("#lunch").html(data.todayLunch.replace(/\s/g, '<br>'));
					$("#dinner").html(data.todayDinner.replace(/\s/g, '<br>'));
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			});
		}
		
		function getBusTime() {
			
		}
	</script>
</html>