<%@ page language="java" contentType="text/HTML;charset=UTF-8" 
	pageEncoding="UTF-8"%>

<footer>
	<div class="division"></div>

	<div class="footer">
		<div>금강대 알리미</div>
		<div><a href="https://open.kakao.com/o/ghfG4bMb">문의 / 질문하러가기</a></div>
		<div><a href="/agreement">개인정보 처리방침</a></div>
		<br>
		<div id="test"><span></span>Galert. ALL RIGHTS RESERVED.</div>
	</div>
</footer>



<script>
	$("#test").click(function() {
		console.log("testEcho call");
		
		$.ajax({
			type : "POST",
			url : "/mobile/sendFCM.json",
			beforeSend : function(xhr) {   
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
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
	});
</script>

