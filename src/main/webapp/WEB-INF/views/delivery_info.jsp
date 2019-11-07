<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>DeliveryInfo</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<div class="del">
			<div class="restaurant_title">
			</div>
			
			<div class="restaurant_info">
				<table id="restaurant_table">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
 				</table>
			</div>
			
			<div class="restaurant_call">
			</div>
			
			<div class="restaurant_etc">
				<div>메뉴</div>
			</div>
			
			<div class="restaurant_menu">
			</div>
		</div>
	</body>
	
	<script>
		var dcode = getURLParams('dcode');
		var info_html = "";
		var menu_html = "";
		
		var menu;
		var del_info;
		var res_info;
		var menu_info;
	
		$.ajax({
			type : "POST",
			url : "/delivery/getMenuInfo.json",
			beforeSend : function(xhr) {   
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			data : {dcode: dcode},
			datatype : "json",
			success : function(data) {
				res_info = data.restaurantInfo[0];
				menu = data.menuInfo;
				
				if(res_info.min_price != null) {
					menu_info += '<tr><td>최소주문금액</td><td>' + comma(res_info.min_price) + '원</td></tr>';
				}
				if(res_info.ot != null && res_info.ct != null) {
					menu_info += '<tr><td>운영시간</td><td>' + res_info.ot + ' ~ ' + res_info.ct;
					if(res_info.hot != null && res_info.hct != null) {
						menu_info += '<br>' + res_info.hot + ' ~ ' + res_info.hct;
					}
					menu_info += '</td></tr>';
				}
				if(res_info.restday != null) {
					menu_info += '<tr><td>휴무일</td><td>' + res_info.restday + '</td></tr>';
				}
				
				$(".restaurant_title").html(res_info.name);
				$("#restaurant_table").append(menu_info);
				$(".restaurant_call").html('<a href="tel:' + res_info.phone + '"><img src="/resources/img/call.png"> 전화주문하기</a>');
				
				for(var i in menu) {
					menu_html += '<p>' + menu[i].menu + '<br>';
					menu_html += '· ' + comma(menu[i].price) + ' 원</p>';
				}
				
				res_info.etc != null ? 
						$(".restaurant_etc").append('<span>' + res_info.etc + '</span>') :
						$(".restaurant_etc").html('');
				$(".restaurant_etc").append('<span>' + res_info.etc == null ? res_info.etc : "" + '</span>');
				$(".restaurant_menu").html(menu_html);
				
				console.log(res_info);
			},
			error : function(xhr, status, error) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("error : " + error);
			}
		});
		
		function comma(num) {
			var len, point, str; 
		       
		    num = num + ""; 
		    point = num.length % 3 ;
		    len = num.length; 
		   
		    str = num.substring(0, point); 
		    while (point < len) { 
		        if (str != "") str += ","; 
		        str += num.substring(point, point + 3); 
		        point += 3; 
		    } 
		     
		    return str;
		}
	
	</script>
</html>