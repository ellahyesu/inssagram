<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="mb-4">
<div class="d-flex justify-content-between mt-3">
	<h1><a href="/timeline/timeline_view" class="logo">Inssagram</a></h1>
	<div class="d-flex justify-content-center align-items-center col-8">
	<div class="d-flex col-8 input-group">
		<input type="text" id="searchWord" name="searchWord" class="form-control" placeholder="검색">
		<div class="input-group-append">
			<button type="button" id="searchWordBtn" class="btn"><i class="fas fa-search"></i></button>
		</div>
	</div>
	</div>
	<div class="d-flex">
		<%-- 로그인이 된 경우 --%>
		<c:if test="${not empty userName}">
			<div class="d-flex align-items-center"> 
				<%-- Modal --%>
				<div class="d-flex">
					<input type="file" id="profileEditfile" name="profileEditfile" class="d-none" accept=".jpg, .jpeg, .gif, .png">
					<c:set var="loop_flag" value="false" />
					<c:forEach var="content" items="${contentList}">
						<c:if test="${not loop_flag}">
							<c:if test="${userId eq content.user.id}">
								<c:if test="${not empty content.user.profileImageFile}">
									<a href="#" id="profileEditLink" class="btn" data-toggle="modal" data-target="#profileEditModal" data-user-id="${userId}">
										<img src="${content.user.profileImageFile}" class="profile-image">
									</a>
									<c:set var="loop_flag" value="true" />
								</c:if>
								<c:if test="${empty content.user.profileImageFile}">
									<a href="#" id="profileEditLink" class="empty-profile btn" data-toggle="modal" data-target="#profileEditModal" data-user-id="${userId}">
										<i id="userIcon" class="d-flex justify-content-center align-items-center fas fa-user profile-image"></i>
									</a>
									<c:set var="loop_flag" value="true" />
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
					<c:set var="loop_flag" value="false" />
				</div>
			</div>
			<div class="d-flex align-items-end mb-2">
				<small><a href="/user/sign_out" id="logout">로그아웃</a></small>
			</div>
		</c:if>
		
		<%-- 로그인이 안 된 경우 --%>
		<c:if test="${empty userName}">
			<div class="d-flex align-items-end mb-2">
				<small><a href="/user/sign_in_view">로그인</a></small>
			</div>
		</c:if>
	</div>
</div>

<!-- Modal -->
<div class="modal" id="profileEditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<h5 class="modal-title" id="exampleModalLabel">프로필 사진을 수정하시겠습니까?</h5>
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
         			<span aria-hidden="true">&times;</span>
        		</button>
      		</div>
      		<div class="modal-body">
      			<div class="d-flex justify-content-center mb-2">
      				<div id="previewProfileImg"></div>
      			</div>
      			<div class="d-flex justify-content-center mb-2">
   					<div id="profileFileName"></div>
   				</div>
      			<div class="d-flex justify-content-center">
      			<button type="button" id="profileEditBtn" class="btn btn-success mr-2">수정하기</button>
        		<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        		</div>
   			</div>
   			
    	</div>
  	</div>
</div>
</header>

<script>
	$(document).ready(function() {
		
		// 프로필 이미지 클릭 => 사용자가 파일 업로드를 할 수 있게 해줌.
		$('#profileEditLink').on('click', function(e) {
			
			e.preventDefault();
			$('#profileEditfile').click(); // input file 태그를 클릭한 것과 같은 동작.
			
			let id = $(this).data('user-id');
			$('#profileEditModal').data('user-id', id);
		});
		
		// 사용자가 파일 업로드를 했을 때 
		$('#profileEditfile').on('change', function(e) {
			
			let fileName = e.target.files[0].name;
			
			// 확장자 validation
			let ext = fileName.split('.');
			if ((ext.length < 2) || 
					(ext[ext.length - 1] != 'jpg'
						&& ext[ext.length - 1] != 'jpeg'
						&& ext[ext.length - 1] != 'gif'
						&& ext[ext.length - 1] != 'png')) {
				alert("이미지 파일만 업로드 가능합니다.");
				$(this).val(''); // input file에 업로드가 된 상태이므로 비워주어야 한다.
				return;
			}
			
			// 업로드 할 파일 사진 미리보여주기
			let file = this.files[0];
		    reader = new FileReader();
		   
		    reader.onload = function (event) {
		        let img = new Image();
		        img.src = event.target.result;
	          	img.width = 150;
	          	img.height = 150;
		        $('#previewProfileImg').empty();
		        $('#previewProfileImg').append(img);
		    };
		    reader.readAsDataURL(file);
			
			// 업로드 할 파일명 미리보여주기
			$('#profileFileName').text(fileName);
		});
		
		// 수정 하기 버튼 클릭 시 (DB Update)
		$('#profileEditBtn').on('click', function() {
			
			let id = $('#profileEditModal').data('user-id');
			//alert(id);
			
			let formData = new FormData(); // 파일업로드 할 때 formData로 보낸다.
			formData.append("id", id);
			formData.append("file", $('#profileEditfile')[0].files[0]);

			$.ajax({
				url: '/user/update_profile_image'
				, method: 'post'
				, data: formData
				// 필수 파라미터(파일 업로드시)
				, processData: false // 기본은 true, json 또는 쿼리스트링(key=value&key1=value1) => String 즉, file을 String이 아니라 객체로 보내야 되기 때문임!!
				, contentType: false
				, enctype: 'multipart/form-data'
				
				, success: function(data) {
					if (data.result == 'success') {
						alert("프로필 편집이 완료되었습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("프로필 편집에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		
		// 검색 버튼을 눌렀을 때
		$('#searchWordBtn').on('click', function() {
			
		});
	});
</script>