<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inssagram</title>
<!-- bootstrap CDN link -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<!-- AJAX를 사용하기 위해 slim이 아닌 풀버전의 jquery로 교체 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/static/css/style.css" type="text/css">

<!-- font style -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;500;600;700&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Leckerli+One&display=swap" rel="stylesheet">
</head>
<body>
	<div id="wrap" class="container">
		<header></header>
		<nav class="navBar"></nav>
		<section>
			<div class="d-flex justify-content-center">
				<div class="col-4">
					<h1 class="logo text-center mt-3 mb-3">Inssagram</h1>
					<h6 class="text-center text-secondary font-weight-bold mt-3">친구들의 일상이 궁금하다면 가입하세요.</h6>
				
					<form id="signUpForm" method="post" action="/user/sign_up_for_ajax">
						<div class="d-flex mt-4">
							<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디">
							<button type="button" id="idCheckBtn" class="btn">✔️</button>
						</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">
							이미 사용중인 ID 입니다.
						</div>
						<div id="idCheckOk" class="small text-success d-none">
							사용가능한 ID 입니다.
						</div>
						<input type="password" id="password" name="password" class="mt-2 form-control" placeholder="비밀번호(8자이상 영문, 숫자, 특수문자 포함)">
						<input type="text" id="name" name="name" class="mt-2 form-control" placeholder="이름">
						<input type="text" id="email" name="email" class="mt-2 form-control" placeholder="이메일">
						
						<button type="submit" id="joinBtn" class="mt-3 btn btn-primary w-100">가입</button>
					</form>
					<div class="mt-2 text-center"><a href="/user/sign_in_view">계정이 있으신가요? 로그인</a></div>
				</div>
			</div>
		</section>
			
		<script>
			$(document).ready(function() {
				
				// 아이디 중복확인
				$('#idCheckBtn').on('click', function() {
					
					let loginId = $('#loginId').val().trim();
					// 중복 확인 여부는 DB를 조회해야 하므로 서버에 묻는다.
					// 화면을 이동시키지 않고 AJAX 통신으로 중복 여부 확인하고
					// 동적으로 문구 노출
					$.ajax({
						url : '/user/is_duplicated_id'
						, type : 'get'
						, data : {
							'loginId': loginId
						}
					    , success : function(data) {
							if (data.result) { // 중복인 경우
								$('#idCheckDuplicated').removeClass('d-none'); // 중복 경고 문구 노출
								$('#idCheckOk').addClass('d-none'); // 숨김
							} else { // 사용 가능한 경우
								$('#idCheckOk').removeClass('d-none'); // 사용 가능 문구 노출
								$('#idCheckDuplicated').addClass('d-none'); // 숨김
							}
						}, error : function(e) {
							alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
						}
					});
				});
				
				// 회원가입 버튼
				$('#signUpForm').submit(function(e) {
					e.preventDefault();
					
					let loginId = $('#loginId').val().trim();
					let password = $('#password').val();
					let name = $('#name').val().trim();
					let email = $('#email').val().trim();
					
					if (loginId == '') {
						alert("아이디를 입력해주세요.");
						return;
					}
					if ($('#idCheckOk').hasClass('d-none')) {
						alert("아이디 중복체크를 해주세요.");
						return;
					}
					if (password == '') {
						alert("비밀번호를 입력해주세요.");
						return;
					}
					//정규식 설정
				    let passwordRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
				    //정규식 결과 저장
				    let passwordRegExpResult = passwordRegExp.test(password);
				    if (!passwordRegExpResult) {
				    	alert("비밀번호 8자이상 영문, 숫자, 특수문자를 사용하세요.");
				    	return;
				    }
					
					if (name == '') {
						alert("이름을 입력하세요.");
						return;
					}
					if (email == '') {
						alert("이메일을 입력하세요.");
						return;
					}
					
					let emailRegExp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
					let emailRegExpResult = emailRegExp.test(email);
					if (!emailRegExpResult) {
						alert("이메일 형식이 올바르지 않습니다.");
						return;
					}
					
					let url = $(this).attr('action');
					let datas = $(this).serialize();
					// console.log(datas);
					$.post(url, datas).done(function(data) {
						if (data.result == 'success') {
							alert("회원 가입을 환영합니다! 로그인을 해주세요.");
							location.href = "/user/sign_in_view";
						} else {
							alert("가입에 실패했습니다. 다시 시도해주세요.");
						}
					});
				});
				
			});
		</script>
	</div>
</body>
</html>