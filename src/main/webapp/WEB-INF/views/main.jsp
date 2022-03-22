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

		<!-- Banner -->
		<div class="banner" id="banner">
			<img src="/resources/img/banner_del.png">
			<!-- 
			<img src="/resources/img/banner1.png">
			<img src="/resources/img/banner2.png">
			<img src="/resources/img/banner3.png"> 
			-->
		</div>
		
		<div>
			<table class="main_category">
				<colgroup>
					<col width="25%">
					<col width="25%">
					<col width="25%">
					<col width="25%">
				</colgroup>
				<tr class="gnb">
					<td><a href="https://lms.ggu.ac.kr"><img src="/resources/img/main_lms.png">LMS</a></td>
					<td><a href="https://www.ggu.ac.kr/sub050501"><img src="/resources/img/main_bus.png">버스예약</a></td>
					<td><a href="http://certmis.ggu.ac.kr"><img src="/resources/img/main_certmis.png">종합정보시스템</a></td>
					<td><a href="https://dorm.ggu.ac.kr/"><img src="/resources/img/main_outdoor.png">외박신청</a></td>
				</tr>			
			</table>
		</div>
		
		<hr class="division">
		
		<div class="mt">
			<a href="https://www.ggu.ac.kr/sub01080101">
				<div class="main_header ms">
					<div>공지사항</div>
					<div>더보기 > </div>
				</div>
			</a>
				
			<div class="mnt ms">
				<div>학사</div>
				<div>비교과</div>
				<div>취업</div>
				<div>일반</div>
			</div>

			<div id="mnc" class="mnc">
				<img src="/resources/img/loading.gif" alt="Loading..." align="center"/>
			</div>
		</div>
		
		<hr class="division">
		
		<div class="mt">
			<a href="/menu">
				<div class="main_header ms">
					<div>오늘의 학식 <span id="today" class="us"></span></div>
					<div>더보기 > </div>
				</div>
			</a>
			
			<hr class="mt">
			
			<div class="ms">
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
				
				<div id="body" class="mmc">
				</div>
			</div>
		</div>
		
		<hr class="division">
		
		<div class="mt">
			<a href="/bus">
				<div class="main_header ms">
					<div>덕성버스</div>
					<div>더보기 > </div>
				</div>
			</a>
			
			<hr class="mt">
			
			<div class="ms">
				<div class="mbh">
					<div>출발</div>
					<div id="busChange" class="radius"><img src="/resources/img/change.png"/></div>
					<div>도착</div>
				</div>
				
				<div id="mbc" class="mt mbc">
				</div>
				
				<div id="mbt" class="mbt us_radius">
				</div>
			</div>
		</div>
		
		<!-- 로딩 바 -->
		<div id="loading">
			<img id="loading-image" src="/resources/img/loading.gif" alt="Loading..." />
		</div>
		
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</body>
	
	<script>
		$(document).ready(function() {
			// getBanner();
			getNotice();
			getMenu();
			getBusTime();
			hideLoadingBar();
			
			// 배달 이동
			$("#banner").click(function() {
				location.href = "/delivery";
			});
			
			// 모바일 통신
			window.Android.sendNotice();
			window.webkit.messageHandlers.callbackHandler.postMessage("MessageBody");
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
			var data;
			var event;
			
			$.ajax({
				type : "POST",
				url : "/notice/getNotice.json",
				beforeSend : function(xhr) {   
					/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
				data : {page: 1, isMain: 'Y'},
				datatype : "json",
				success : function(obj) {
					data = obj;
					
					getNoticeDetail(0, data);
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			});
			
			$(".mnt").on('click', 'div', function() {
				event = $(this);
				getNoticeDetail(event.index(), data);
			});
		}
		
		function getNoticeDetail(num, data) {
			var mnc;
			var mnc_html = "";
			var mnt = $(".mnt").children();
			mnt.addClass('us');
			mnt.removeClass('ul');
			mnt.eq(num).removeClass('us');
			mnt.eq(num).addClass('ul');
			
			switch(num) {
				case 0:
					mnc = data.academic;
					break;
				case 1:
					mnc = data.nonSubject;
					break;
				case 2:
					mnc = data.job;
					break;
				case 3:
					mnc = data.general;
					break;
			}
			
			for(var i in mnc) {
				mnc_html += ''
					+ '<hr>'
					+ '<a href="https://www.ggu.ac.kr' + mnc[i].noticeURL + '">'
					+ 	'<div class="ms">' + textLengthOverCut(mnc[i].noticeTitle) + '</div>'
					+ '</a>'
			}
			mnc_html += '<hr>';
			
			$(".mnc").html(mnc_html);
		}
	
		
		// 메뉴
		function getMenu() {
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
					allMenuList = data.allMenuList;
					today = data.today;
					
					for(var i in allMenuList) {
						if(data.today == allMenuList[i].today) {
							cur_cnt = i;
							todayBreakfast = allMenuList[i].breakfast.replace(/\s/g, '<br>');
							todayLunch = allMenuList[i].lunch.replace(/\s/g, '<br>');
							todayDinner = allMenuList[i].dinner.replace(/\s/g, '<br>');
							break;
						}
						
						if(i == allMenuList.length-1) {
							cur_cnt = i;
							today = allMenuList[cur_cnt].today;
							todayBreakfast = allMenuList[i].breakfast.replace(/\s/g, '<br>');
							todayLunch = allMenuList[i].lunch.replace(/\s/g, '<br>');
							todayDinner = allMenuList[i].dinner.replace(/\s/g, '<br>');
						}
					}
					
					highlightMenu($("#breakfast"));
					$("#date").html(today);
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
		}
		
		function getBusTime() {
			var cur_time = getBusTime();
			var ter_list;
			var sch_list;
			var change = 0;
			var mbc_html = "";
			
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
					mbc_html += 
						'<div>터미널</div>' +
						'<div> > </div>' +
						'<div>학교</div>';
					$("#mbc").html(mbc_html);
					
					sch_list = data.schList;
					ter_list = data.terList;
					
					getCureBustTime(ter_list);
					
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			});
			
			$("#busChange").on('click', function() {
				mbc_html = "";
				
				if(change == 1) {
					mbc_html += 
						'<div>터미널</div>' +
						'<div> > </div>' +
						'<div>학교</div>';
					
					change = 0;
					getCureBustTime(ter_list);
				} else {
					mbc_html +=
						'<div>학교</div>' +
						'<div> > </div>' +
						'<div>터미널</div>';
					
					change = 1;
					getCureBustTime(sch_list);
				}
				
				$("#mbc").html(mbc_html);
			});
			
			function getBusTime() {
				var cur_time = getTime();
				cur_time = cur_time.substring(0, 4);
				cur_time = cur_time.substring(0, 2) + ":" + cur_time.substring(2, 4);
				
				return cur_time;
			}
			
			function getCureBustTime(data){
				var cur_time = getBusTime();
				var cur_bus_time = 1;
				
				for (var i=0; i<data.length; i++) {
					if(data[i].time_start > cur_time) {
						cur_bus_time = data[i].time_start;
						
						if(data[i].via == "Y") {
							cur_bus_time = '<sup>●</sup>' + cur_bus_time;  
						}
						break;
					}
				}
				
				if(cur_bus_time == 1){
					cur_bus_time = data[data.length-1].time_start;
					
					if(data[data.length-1].via == "Y") {
						cur_bus_time = '<sup>●</sup>' + cur_bus_time;  
					}
				}
				
				$("#mbt").html(cur_bus_time);
			}
		}
		
		
		
		function callNative() {
			try {
				webkit.messageHandlers.callbackHandler.postMessage("MessageBody");
			} catch (err) {
				alert(err);
			}
		}
		
		function redHeader() {
			alert("readHeader() Call");
		}
		
		// function sendNotice (token, androidID) {
		function sendNotice(token, androidID) {
			console.log("testEcho call");
			console.log(androidID);
			
			$.ajax({
				type : "POST",
				url : "/mobile/saveUserToken.json",
				beforeSend : function(xhr) {   
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
	            data : {
	            	androidID : androidID,
	            	token : token
	            },
				datatype : "json",
				success : function(data) {
					console.log(data);
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			});
		}
	</script>
</html>