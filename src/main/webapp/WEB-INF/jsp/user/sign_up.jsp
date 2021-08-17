<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="signUpForm" class="d-flex justify-content-center">
	<div class="col-3">
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
			<input type="password" id="password" name="password" class="mt-2 form-control" placeholder="비밀번호">
			<input type="text" id="name" name="name" class="mt-2 form-control" placeholder="이름">
			<input type="text" id="email" name="email" class="mt-2 form-control" placeholder="이메일">
			
			<button type="submit" id="joinBtn" class="mt-3 btn btn-primary w-100">가입</button>
		</form>
		<div class="mt-2 text-center"><a href="/user/sign_in_view">계정이 있으신가요? 로그인</a></div>
	</div>
</div>

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
			if (name == '') {
				alert("이름을 입력하세요.");
				return;
			}
			if (email == '') {
				alert("이메일을 입력하세요.");
				return;
			}
			
			let url = '/user/sign_up_for_ajax';
			let datas = {
					'loginId': loginId
					, 'password': password
					, 'name': name
					, 'email': email}
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