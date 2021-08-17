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
		<nav></nav>
		<section>
			<div class="d-flex justify-content-center">
				<div class="col-4">
					<h1 class="logo text-center mt-3 mb-3">Inssagram</h1>
					<form id="loginForm" method="post" action="/user/sign_in">
						<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디">
						<input type="password" id="password" name="password" class="mt-2 form-control" placeholder="비밀번호">
						
						<button type="submit" id="loginBtn" class="mt-3 btn btn-primary w-100">로그인</button>
					</form>
					<div class="mt-2 text-center"><a href="/user/sign_up_view">계정이 없으신가요? 회원가입</a></div>
				</div>
			</div>
		</section>
		
		<script>
			$(document).ready(function() {
				$('#loginForm').submit(function(e) {
					e.preventDefault();
					
					let loginId = $('#loginId').val().trim();
					let password = $('#password').val().trim();
					if (loginId == '') {
						alert("아이디를 입력해주세요.");
						return;
					}
					if (password == '') {
						alert("비밀번호를 입력해주세요.");
						return;
					}
					
					let url = $(this).attr('action');
					let datas = $(this).serialize();
					
					$.post(url, datas).done(function(data) {
						if (data.result == 'success') {
							location.href="/post/post_list_view";
						} else {
							alert("로그인에 실패했습니다. 다시 시도해주세요.");
						}
					});
				});
				
			});
		</script>
	</div>
</body>
</html>
		