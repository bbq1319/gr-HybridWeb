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
		
		<div class="wrap">
			<div class="register_title">
				회원가입
			</div>
			<form id="fm" onsubmit="return false">
				<table class="register">
					<tbody>
						<!-- 인풋 텍스트 -->
						<tr>
							<td>아이디</td>
							<td>
								<div class="reg_id_div">
									<input class="reg_id" type="text" name="id" placeholder="영문, 숫자 포함 6~20자" autocomplete="off">
									<input class="reg_id_chk" type="submit" name="id_chk" value="중복확인">
								</div>
								<span id="chk_id"></span>
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td>
								<input type="password" name="pw" placeholder="영문, 숫자, 특수문자 포함 6~20자" autocomplete="off">
								<span id="chk_pw"></span>
							</td>
						</tr>
						<tr>
							<td>비밀번호확인</td>
							<td>
								<input type="password" name="pw_chk" placeholder="비밀번호 다시 입력">
								<span id="chk_pw_re"></span>
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>
								<input type="text" name="nm">
								<span id="chk_nm"></span>
							</td>
						</tr>
						<tr>
							<td>학번</td>
							<td>
								<input type="text" name="stu_no">
								<span id="chk_stu_no"></span>
							</td>
						</tr>
						<!-- 라디오 -->
						<tr>
							<td>성별</td>
							<td>
								<div>
									<input type="radio" name="sex" value="M" style="transform:scale(3); vertical-align:middle; margin-left:20px; margin-right:10px;">
									<label for="male" style="margin-right:50px;">남성</label>
									<input type="radio" name="sex" value="F" style="transform:scale(3); vertical-align:middle; margin-left:20px; margin-right:10px;">
									<label for="female">여성</label>
									<span id="chk_sex"></span>
								</div>
							</td>
						</tr>
						<!-- 셀렉터 -->
						<tr>
							<td>구분</td>
							<td>
								<select name="type">
									<option value="none">선택</option>
									<option value="S">학생</option>
									<option value="G">졸업생</option>
									<option value="P">교수</option>
									<option value="TS">교직원</option>
									<option value="SP">학부모</option>
								</select>
								<span id="chk_type"></span>
							</td>
						</tr>
						<tr>
							<td>주전공</td>
							<td>
								<select name="major">
									<option value="none">선택</option>
									<option value="B">불교학전공</option>
									<option value="AB">응용불교학전공</option>
									<option value="A">행정학전공</option>
									<option value="SW">사회복지학전공</option>
									<option value="IT">IT경영학전공</option>
									<option value="G">글로벌지역통상학전공</option>
								</select>
								<span id="chk_major"></span>
							</td>
						</tr>
						<tr>
							<td>부전공</td>
							<td>
								<select name="sub_major">
									<option value="none">선택</option>
									<option value="B">불교학전공</option>
									<option value="AB">응용불교학전공</option>
									<option value="A">행정학전공</option>
									<option value="SW">사회복지학전공</option>
									<option value="IT">IT경영학전공</option>
									<option value="G">글로벌지역통상학전공</option>
									<option value="N">해당없음</option>
								</select>
								<span id="chk_sub_major"></span>
							</td>
						</tr>
						<tr>
							<td>생년월일</td>
							<td>
								<div class="reg_birth">
									<input type="number" name="bir_year" id="bir_year" maxlength="4" placeholder="YYYY" oninput="numberMaxLength(this);" style="border:none">
									<div class="div">/</div>
									<input type="number" name="bir_mon" id="bir_mon" maxlength="2" placeholder="MM" oninput="numberMaxLength(this);" style="border:none">
									<div class="div">/</div>
									<input type="number" name="bir_day" id="bir_day" maxlength="2" placeholder="DD" oninput="numberMaxLength(this);" style="border:none">
								</div>
								<span id="chk_birth"></span>
							</td>
						</tr>
						<!-- 약관 동의 -->
						<tr>
							<td></td>
							<td>
								<input class="round" type="button" name="agree" value="✔︎ 아래 내용에 모두 동의합니다.">
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<button class="round" type="button" name="submit" onClick="validate()">가입완료</button>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
		</div>
	</body>
	
	<script>	
		//IOS 일때 처리
		var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
		 
		if (varUA.indexOf("iphone")>-1||varUA.indexOf("ipad")>-1||varUA.indexOf("ipod")>-1) {
			
		}
		
		/**
		 * 회원가입 검증 
		 * 2019.08.12
		 */
		 
		var id_confirm = false;
		
		function validate() {
			var date = new Date();
			var cur_year;
			var cur_month;
			var cur_day;
			
			cur_year = date.getFullYear() + "";
			if(date.getMonth() + 1 < 10)
				cur_month = "0" + (date.getMonth() + 1);
			else 
				cur_month = (date.getMonth() + 1) + "";
			if(date.getDate() < 10) 
				cur_day = "0" + date.getDate();
			else 
				cur_day = date.getDate() + "";
			
			
			var valid = true;
			
			var pw = $("input[name=pw]")[0].value;
			var pw_chk = $("input[name=pw_chk]")[0].value;
			var pw_regExp = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{6,20}$/;
			
			var nm = $("input[name=nm]")[0].value;
			var stu_no = $("input[name=stu_no]")[0].value;
			var sex = $("input[name=sex]:checked").val();
			
			var year = $("input[name=bir_year]")[0].value;
			var month = $("input[name=bir_mon]")[0].value;
			var day = $("input[name=bir_day]")[0].value;
			
			var type = $("select[name=type]").val();
			var major = $("select[name=major]").val();
			var sub_major = $("select[name=sub_major]").val();
				
			/* check id */
			if(id_confirm == false) {
				valid = false;
				$("#chk_id").html("중복확인을 해 주세요");
			} else {
				$("#chk_id").html("");
			}
			
			/* check pw */
			if(pw == null || pw.trim() == "") {
				valid = false;
				$("#chk_pw").html("비밀번호를 입력해 주세요");
			} else if(!pw_regExp.test(pw)) {
				valid = false;
				$("#chk_pw").html("비밀번호 양식을 확인해 주세요");
			} else {
				$("#chk_pw").html("");
			}
			
			if(pw != pw_chk) {
				valid = false;
				$("#chk_pw_re").html("비밀번호가 일치하지 않습니다. 다시 입력해 주세요");
			} else {
				$("#chk_pw_re").html("");
			}
			
			if(nm == null || nm.trim() == "") {
				valid = false;
				$("#chk_nm").html("이름을 입력해 주세요");
			} else {
				$("#chk_nm").html("");
			}
			
			if(stu_no == null || stu_no.trim() == "") {
				valid = false;
				$("#chk_stu_no").html("학번을 입력해 주세요");
			} else {
				$("#chk_stu_no").html("");
			}
			
			if(sex == null || sex.trim() == "") {
				valid = false;
				$("#chk_sex").html("성별을 선택해 주세요");
			} else {
				$("#chk_sex").html("");
			}
			
			if(type == "none" || type == null || type.trim() == "") {
				valid = false;
				$("#chk_type").html("구분을 선택해 주세요");
			} else {
				$("#chk_type").html("");
			}
			
			if(major == "none" || major == null || major.trim() == "") {
				valid = false;
				$("#chk_major").html("주전공을 선택해 주세요");
			} else {
				$("#chk_major").html("");
			}
			
			if(sub_major == "none" || sub_major == null || sub_major.trim() == "") {
				valid = false;
				$("#chk_sub_major").html("부전공을 선택해 주세요");
			} else {
				$("#chk_sub_major").html("");
			}
			
			/* 생년월일 */
			if((year == null || year.trim() == "") || (month == null || month.trim() == "") || (day == null || day.trim() == "")) {
				valid = false;
				$("#chk_birth").html("생년월일을 입력해 주세요");
			} else if((year < cur_year-100 || year > cur_year) || (month > 12 || month < 0) || (day > 31 || day < 0)) {
				valid = false;
				$("#chk_birth").html("생일을 확인해 주세요");
			} else {
				$("#chk_birth").html("");
			}

			
			
			if(valid) {
				var birth = year+"-"+month+"-"+day;
				var data = $("#fm").serialize() + "&birth=" + birth;
				
				$.ajax({
					type : "POST",
					url : "/login/createUser.json",
					beforeSend : function(xhr) {   
						/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		            },
					data : data,
					datatype : "json",
					success : function(data) {
						if(data.RESULT_CODE == ${result_success}) {
							alert("가입이 완료되었습니다");
							location.replace("/");
						} 
						else if(data.RESULT_CODE == ${result_error}) {
							
						}
						else if(data.RESULT_CODE == ${result_server_error}) {
							
						}
					},
					error : function(xhr, status, error) {
						console.log("xhr : " + xhr);
						console.log("status : " + status);
						console.log("error : " + error);
					}
				});
			} else {
				$('html').scrollTop(0);
			} 
		}
		
		
		// ID 중복확인
		$("input[name=id_chk]").click(function() {
			var id = $("input[name=id]")[0].value;
			var id_regExp = /^[a-zA-Z0-9]{6,20}$/;
			
			if(id == null || id.trim() == "") {
				alert("아이디를 입력해 주세요");
			}
			else if(!id_regExp.test(id)) {
				alert("아이디 양식을 확인해 주세요");
			}
			else {
				$.ajax({
					type : "POST",
					url : "/login/checkIdDuplicate.json",
					beforeSend : function(xhr) {   
						/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		            },
					data : {id : id},
					datatype : "json",
					success : function(data) {
						if(data == false) {
							alert("이미 존재하는 아이디입니다");
						}
						else {
							id_confirm = true;
							alert("사용가능한 아이디입니다");
							
							$("input[name=id]").attr("readOnly", true);
							$("input[name=id_chk]").attr("disabled", true);
						}
					},
					error : function(xhr, status, error) {
						console.log("xhr : " + xhr);
						console.log("status : " + status);
						console.log("error : " + error);
					}
				});
			}
		});
		
		/**
		 * input number 숫자 길이 제한하기
		 * 2019.08.24
		 *
		 * 출처 : https://sseung-fire.tistory.com/22
		 */
		function numberMaxLength(num) {
			if(num.value.length > num.maxLength) {
				num.value = num.value.slice(0, num.maxLength);
			}
		}
		
	</script>
</html>