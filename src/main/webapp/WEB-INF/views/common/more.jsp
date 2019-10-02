<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>More</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<div>
			<div id="banner">
				<img src="/resources/img/banner1.png">
				<img src="/resources/img/banner2.png">
				<img src="/resources/img/banner3.png">
			</div>
		</div>
		
		<div class="division"></div>
		
		<table class="more_category">
			<caption>
				카테고리		
			</caption>
			
			<colgroup>
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
			</colgroup>

			<tbody>
				<tr>
					<td><img src="/resources/img/schoolbus.png">교내버스</td>
					<td><img src="/resources/img/duksung.png">덕성여객</td>
					<td><img src="/resources/img/overnight.png">외박신청</td>
					<td><img src="/resources/img/lms.png">LMS</td>
				</tr>   
				<tr>
					<td><img src="/resources/img/delivery.png">꾸르맛집</td>
					<td><img src="/resources/img/anoytalk.png">익명수다</td>
					<td><img src="/resources/img/freetalk.png">자유수다</td>
					<td><img src="/resources/img/_menu.png">식단표</td>
				</tr>
			</tbody>
		</table>
		
		<div class="division"></div>
		
		<table class="more_notice">
			<caption>
				공지사항		
			</caption>
			
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>

			<tbody>
				<tr>
					<td><a href="https://www.ggu.ac.kr/sub01080101"><div>학사공지</div><div> > </div></a></td>
					<td><a href="https://www.ggu.ac.kr/sub01080107"><div>비교과공지</div><div> > </div></a></td>
				</tr>   
				<tr>
					<td><a href="https://www.ggu.ac.kr/sub01080103"><div>취업공지</div><div> > </div></a></td>
					<td><a href="https://www.ggu.ac.kr/sub01080105"><div>일반공지</div><div> > </div></a></td>
				</tr>
			</tbody>
		</table>
		
	</body>
	
	<script>
		$(document).ready(function() {
			getBanner();
		});
	
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
	</script>
</html>