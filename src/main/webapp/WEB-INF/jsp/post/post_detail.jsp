<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<div class="d-flex justify-content-center">
	<div>
		<div class="post-box mt-4">
			<textarea class="m-3" cols="50" rows="5" name="content">${post.content}</textarea>
			
			<div class="m-2">
				<c:if test="${!empty post.imagePath}">
					<img src="${post.imagePath}" class="post-edit-image">
				</c:if>
			</div>
			
			<div class="d-flex justify-content-between m-2">
				<div class="d-flex">
					<input type="file" id="file" name="file" class="d-none" accept=".jpg, .jpeg, .gif, .png">
					<button type="button" id="imageUploadBtn" class="btn"><i id="imageUploadIcon" class="fas fa-image"></i></button>
					<div id="fileName" class="d-flex align-items-center"></div>
				</div>
				<button type="button" id="writingUploadBtn" class="btn text-primary" data-post-id="${post.id}"><b>업로드</b></button>
			</div>
			
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		// 파일 업로드 아이콘 클릭 => 사용자가 파일 업로드를 할 수 있게 해줌.
		$('#imageUploadBtn').on('click', function(e) {
			e.preventDefault();
			$('#file').click(); // input file 태그를 클릭한 것과 같은 동작.
		});
		
		// 사용자가 파일 업로드를 했을 때 파일명 보여주기
		$('#file').on('change', function(e) {
			let fileName = e.target.files[0].name;
			$('#fileName').text(fileName);
		});
		
		// 업로드(수정)버튼 클릭 시
		$('#writingUploadBtn').on('click', function() {
			
			let content = $('textarea[name=content]').val();
			if (content == '') {
				alert("내용을 입력해주세요.");
				return;
			}
			
			let file = $('#file').val();
			if (file != '') {
				let ext = file.split('.').pop().toLowerCase();
				if ($.inArray(ext, ['jpg', 'jpeg', 'gif', 'png']) == -1) {
					alert("jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.");
					$('input[name=image]').val('');
					return;
				}
			}
			
			let formData = new FormData();
			formData.append("id", $(this).data('post-id'));
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// $('input[name=image]')[0]  => 첫번째 input file 태그를 의미
			// .files[0]                  => 업로드 된 파일 중 첫번째를 의미
			
			$.ajax({
				url: '/post/update'
				, type: 'post'
				, data: formData
				, processData: false
				, contentType: false
				, encType: 'multipart/form-data'

			 	, success: function(data) {
	              	if (data.result == 'success') {
	              		alert("수정 되었습니다.");
	                  	location.reload();
	               	}
	            }, error: function(e) {
	               	alert("수정에 실패했습니다. 관리자에게 문의해주세요.");
	            }
			});
			
		});
	});
</script>