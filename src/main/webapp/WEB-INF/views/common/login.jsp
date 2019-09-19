<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Home</title>
		<%@ include file="/WEB-INF/views/common/common.jsp"%>
	</head>
	
	<body onload="document.fm.id.focus();">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		
		<div class="wrap">
			<div class="login_title">
				LOGIN
			</div>
			
			<form id="fm" name="fm" action="/login" method = "POST">
				<table class="login">
		            <tbody>
		                <tr>
		                    <td><input type="text" name="id" value="" placeholder="아이디를 입력해 주세요" autocomplete="off"></td>
		                </tr>
		                <tr>
		                    <td><input type="password" name="pw" placeholder="비밀번호를 입력해 주세요"></td>
		                </tr>
		                <tr>
		                    <td colspan="2"><input class="round" name="submit" type="submit" value="로그인"></td>
		                </tr>
		                <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}">
		            </tbody>
		        </table>
			</form>
			
			<div class="login_sub">
				<a>아이디 찾기</a> | 
				<a>비밀번호 찾기</a> | 
				<a href="/register">회원가입</a>
			</div>
		</div>
	</body>
	
	<script>
		
		var url = window.location.host;
		var error = window.location.search;
		var param = {};
		
		error.replace(
	        new RegExp( "([^?=&]+)(=([^&]*))?", "g" ),
	        function( $0, $1, $2, $3 ){
	        	param[ $1 ] = $3;
	        }
	    );
		
		if(param["error"] == "true") {
			alert("아이디 또는 비밀번호 오류입니다");
			history.replaceState({}, null, location.pathname);
		}

		/*
		$("input[name=submit]").click(function() {
			console.log($("#fm").serialize());
			
			
			$.ajax({
				type : "POST",
				url : "/login/validUserCheck.json",
				beforeSend : function(xhr) {   
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				data : $("#fm").serialize(),
				datatype : "json",
				success : function(data) {
					console.log(data);
					alert("asd");
				},
				error : function(xhr, status, error) {
					console.log("xhr : " + xhr);
					console.log("status : " + status);
					console.log("error : " + error);
				}
			});
		});
		*/
	</script>
</html>