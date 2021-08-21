<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex justify-content-center">
	<div>
		<div class="writing-box mb-4">
			<textarea class="m-3" cols="50" rows="3" name="content" placeholder="무슨 생각을 하고 계신가요?"></textarea>
			
			<div class="d-flex justify-content-between m-2">
				<div class="d-flex">
					<input type="file" id="file" name="file" class="d-none" accept=".jpg, .jpeg, .gif, .png">
					<button type="button" id="imageUploadBtn" class="btn"><i id="imageUploadIcon" class="fas fa-image"></i></button>
					<div id="fileName" class="d-flex align-items-center"></div>
				</div>
				<button type="button" id="writingUploadBtn" class="btn text-primary"><b>업로드</b></button>
			</div>
		</div>
		
		<c:forEach var="post" items="${postList}" varStatus="status">
			<div class="post-box mt-4">
				<div class="d-flex justify-content-between post-header m-2">
					<div class="d-flex">
						<div><img src="${userProfileImageFile}" class="profileImage mr-2"></div>
						<div class="d-flex align-items-center"><b>${userLoginId}</b></div>
					</div>
					<div>
						<button type="button" id="editBtn" class="btn"><i class="fas fa-edit"></i></button>
						<button type="button" id="deleteBtn" class="btn"><i class="far fa-trash-alt text-danger"></i></button>
					</div>
				</div>
				<div class="m-2">
					<c:if test="${!empty post.imagePath}">
						<img src="${post.imagePath}" class="post-image">
					</c:if>
				</div>
				<div class="d-flex post-function ml-2">
					<button type="button" id="likeBtn" class="btn"><i class="far fa-heart"></i></button>
					<div class="d-flex align-items-center">좋아요 100개</div>
				</div>
				<div class="d-flex">
					<div class="ml-3 mr-2"><b>${userLoginId}</b></div>
					<div>${post.content}</div>
				</div>
				<div class="ml-3 text-secondary"><a href="#"><small>댓글 모두 보기</small></a></div>
				<div class="d-flex post-comment m-2">
					<input type="text" class="form-control" placeholder="댓글 쓰기...">
					<button type="button" id="commentBtn" class="btn text-primary"><b>게시</b></button>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 파일 업로드 아이콘 클릭 => 사용자가 파일 업로드를 할 수 있게 해줌.
		$('#imageUploadBtn').on('click', function(e) {
			e.preventDefault();
			$('#file').click(); // input file 태그를 클릭한 것과 같은 동작.
		});
		
		// 사용자가 파일 업로드를 했을 때 
		$('#file').on('change', function(e) {
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
			$('#fileName').text(fileName);
		});
		
		// 업로드 버튼 => DB insert
		$('#writingUploadBtn').on('click', function() {
			let content = $('textarea[name=content]').val();
			if (content == '') {
				alert("내용을 입력해주세요.");
				return;
			}
			
			let formData = new FormData();
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			$.ajax({
				url: '/timeline/create'
				, method: 'post'
				, data: formData
				// 필수 파라미터(파일 업로드시)
				, processData: false // 기본은 true, json 또는 쿼리스트링(key=value&key1=value1) => String 즉, file을 String이 아니라 객체로 보내야 되기 때문임!!
				, contentType: false
				, enctype: 'multipart/form-data'
				
				, success: function(data) {
					if (data.result == 'success') {
						//alert("메모가 저장되었습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("메모 저장에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
	});


</script>