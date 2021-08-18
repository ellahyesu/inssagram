<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div>
		<div class="writing-box mb-4">
			<textarea class="m-3" cols="50" rows="3" placeholder="무슨 생각을 하고 계신가요?"></textarea>
			<div class="d-flex justify-content-between m-2">
				<button type="button" id="imageUploadBtn" class="btn"><i class="fas fa-image"></i></button>
				<button type="button" id="uploadBtn" class="btn text-primary"><b>업로드</b></button>
			</div>
		</div>
		
		<div class="post-box">
			<div class="d-flex post-header m-2">
				<div><img src="${userProfileImageFile}" class="profileImage mr-2"></div>
				<div class="d-flex align-items-center"><b>${userName}</b></div>
			</div>
			<div class="m-2">
				<img src="https://cdn.pixabay.com/photo/2021/07/03/19/56/paris-6384758_960_720.jpg" class="post-image">
			</div>
			<div class="d-flex post-function ml-2">
				<button type="button" id="likeBtn" class="btn"><i class="far fa-heart"></i></button>
				<button type="button" id="commentViewBtn" class="btn"><i class="far fa-comment"></i></button>
			</div>
			<div class="d-flex post-comment m-2">
				<input type="text" class="form-control" placeholder="댓글 쓰기...">
				<button type="button" id="commentBtn" class="btn text-primary"><b>게시</b></button>
			</div>
		</div>
	</div>
</div>