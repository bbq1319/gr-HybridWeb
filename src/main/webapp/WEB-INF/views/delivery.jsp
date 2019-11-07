<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Delivery</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body>
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<div class="banner" id="banner">
			<img src="/resources/img/banner_del2.png">
		</div>
		
		<table class="delivery_list">
			<tbody id="list">
			</tbody>
		</table>
		
	</body>
	
	<script>
		var dcode;
		var menu;
		var tr;
		var tr_cnt = 1;
		var tr_length = 3;
	
		$.ajax({
			type : "POST",
			url : "/delivery/getMenu.json",
			beforeSend : function(xhr) {   
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			data : {isMain: 'Y'},
			datatype : "json",
			success : function(data) {
				menu = data.menu;
				
				for(var i in menu) {
					dcode = menu[i].dcode;
					
					if(tr_cnt == 1)
						tr += '<tr>';
					
					tr += '<td>';
					tr += '		<a href="/delivery_info?dcode=' + dcode + '">';
					tr += '			<img src="/resources/img/' + menu[i].did + '.png">'
					tr += 			menu[i].name;
					tr += '		</a>';
					tr += '</td>';
					
					
					if(tr_cnt == tr_length) {
						tr += '</tr>'
						tr_cnt = 1;
					}
					else 
						tr_cnt++;
				};
				
				$("#list").html(tr);
			},
			error : function(xhr, status, error) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("error : " + error);
			}
		});
		
		$("td").click(function() {
			console.log($(this));
		});
	</script>
</html>