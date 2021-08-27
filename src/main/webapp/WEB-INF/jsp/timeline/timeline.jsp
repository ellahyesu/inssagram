<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex justify-content-around">
	
	<div class="empty-box"></div>
	
	<div class="mr-3">
		<%-- 글 쓰기 영역 - 로그인 된 상태에서만 보임 --%>
		<div class="post-box mb-4">
			<textarea class="m-3" cols="50" rows="3" name="content" placeholder="무슨 생각을 하고 계신가요?"></textarea>
			<%-- 이미지 업로드를 위한 아이콘과 버튼 --%>
			<div class="d-flex justify-content-between m-2">
				<div class="d-flex">
					<input type="file" id="file" name="file" class="d-none" accept=".jpg, .jpeg, .gif, .png">
					<button type="button" id="imageUploadBtn" class="btn"><i id="imageUploadIcon" class="fas fa-image"></i></button>
					<div id="fileName" class="d-flex align-items-center"></div>
				</div>
				<button type="button" id="writingUploadBtn" class="btn text-primary"><b>업로드</b></button>
			</div>
		</div>
		<%-- 글 목록 영역 - 로그인 된 상태에서만 보임 --%>
		<c:forEach var="content" items="${contentList}">
			<div class="post-box mt-4">
				<div class="d-flex justify-content-between post-header m-2">
					<div class="d-flex">
					
						<c:if test="${not empty content.user.profileImageFile}">
							<div><img src="${content.user.profileImageFile}" class="profile-image mr-2"></div>
						</c:if>
						<c:if test="${empty content.user.profileImageFile}">
							<div>
								<i id="userIcon" class="d-flex justify-content-center align-items-center fas fa-user profile-image mr-2"></i>
							</div>
						</c:if>
								
						<div class="d-flex align-items-center"><b>${content.post.userName}</b></div>
						
						<%-- 글쓴이가 본인이 아니면 팔로우 버튼 노출 --%>
						<c:if test="${userName ne content.user.name}">
							<%-- TODO: 이미 팔로우를 한 사람이면 팔로우 취소 버튼 노출 --%>
							
							<c:if test="${content.followed eq true}">
								<a href="#" class="follow-cancel-btn ml-2 d-flex align-items-center text-danger" data-followee="${content.user.loginId}">
									<b>· 팔로우 취소</b>
								</a>
							</c:if>
							<c:if test="${content.followed eq false}">
								<a href="#" class="follow-btn ml-2 d-flex align-items-center text-primary" data-followee="${content.user.loginId}">
									<b>· 팔로우</b>
								</a>
							</c:if>
						</c:if>
					</div>
					
					<%-- 본인이면 글 수정, 글삭제 버튼 노출 --%>
					<c:if test="${userName eq content.user.name}">
					<div>
						<a href="/post/post_detail_view?id=${content.post.id}">
							<button type="button" id="editBtn" class="btn"><i class="fas fa-edit"></i>
							</button>
						</a>
						<%-- Modal --%>
						<button type="button" class="btn delete-icon" data-toggle="modal" data-target="#deleteModal" data-post-id="${content.post.id}">
							<i class="far fa-trash-alt"></i>
						</button>
					</div>
					</c:if>
				</div>
				<div class="m-2">
					<c:if test="${!empty content.post.imagePath}">
						<img src="${content.post.imagePath}" class="post-image">
					</c:if>
				</div>
				<div class="d-flex post-function ml-2">
				
					<%-- 본인 좋아요 여부에 따른 꽉찬하트 | 빈하트 --%>
					<c:choose>
						<c:when test="${content.filledLike eq true}">
							<button type="button" class="post-mylike-btn btn" data-post-id="${content.post.id}"><i class="fas fa-heart"></i></button>
						</c:when>
						<c:otherwise>
							<button type="button" class="post-like-btn btn" data-post-id="${content.post.id}"><i class="far fa-heart"></i></button>
						</c:otherwise>
					</c:choose>
		
					<div class="d-flex align-items-center">좋아요 ${content.likeCount}개</div>
				</div>
				
				<%-- 글(Post) --%>
				<div class="ml-3 mr-2">${content.post.content}</div>
				
				<%-- 댓글(Comment) 목록 --%>
				<%-- "댓글" - 댓글이 있는 경우에만 댓글 영역 노출 --%>
				<c:if test="${not empty content.commentList}">
						
					<%-- 댓글 모두 보기 | 숨기기 토글 버튼 구현 --%>
					<a href="#" class="show-comment-link ml-3 text-secondary" data-post-id="${content.post.id}">댓글 모두 숨기기</a>
					
					<div>
						<c:forEach var="comment" items="${content.commentList}">
							<div class="d-flex ml-3">
								<div class="mr-2 d-flex align-items-center"><b>${comment.userName}</b></div>
								<div class="d-flex align-items-center">${comment.content}</div>
								<%-- 댓글쓴이가 본인이면 삭제버튼 노출 --%>
								<c:if test="${userName eq comment.userName}">
									<button type="button" class="btn comment-del-btn" data-comment-id="${comment.id}"><i class="fas fa-backspace"></i></button>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</c:if>
				
				<div class="d-flex post-comment m-2">
					<input type="text" id="commentContent${content.post.id}" name="content" class="form-control" placeholder="댓글 쓰기...">
					<button type="button" class="comment-btn btn text-primary" data-post-id="${content.post.id}"><b>게시</b></button>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<%-- 나의 팔로우 목록 --%>
	<div class="follow-box">
		<div class="d-flex justify-content-between">
			<%-- 팔로워 --%>
			<div id="followerBox" class="w-100">
				<button type="button" id="followerShowBtn" class="btn w-100 mt-2 text-center text-primary"><b>팔로워</b></button>
				<div id="followerList">
					<c:forEach var="follower" items="${followerList}">
						<div class="text-center">
							<b>${follower.follower}</b>
						</div>	
					</c:forEach>
				</div>
			</div>
			<%-- 팔로잉 --%>
			<div id="followeeBox" class="w-100">
				<button type="button" id="followeeShowBtn" class="btn w-100 mt-2 text-center text-primary"><b>팔로잉</b></button>
				<div id="followeeList">
					<c:forEach var="followee" items="${followeeList}">
						<div class="text-center">
							<b>${followee.followee}</b>
						</div>	
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 더보기 버튼(3개씩 더 보이게) -->
<div id="moreArea" class="mt-3 d-flex justify-content-center">
	<button type="button" id="moreBtn" class="btn"><i class="fas fa-chevron-circle-down more-btn"></i></button>
</div>

<!-- Modal -->
<div class="modal" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">정말 삭제 하실건가요...? 😢</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body d-flex justify-content-center">
        <button type="button" id="deleteBtn" class="btn btn-danger mr-2">삭제하기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
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
		
		// 글 생성 (업로드 버튼 => DB insert)
		$('#writingUploadBtn').on('click', function() {
			
			let content = $('textarea[name=content]').val();
			if (content == '') {
				alert("내용을 입력해주세요.");
				return;
			}
			
			let formData = new FormData(); // 파일업로드 할 때 formData로 보낸다.
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			$.ajax({
				url: '/post/create'
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
		
		// 삭제하기 아이콘 클릭 시 - 모달에게 postId값을 넘겨준다.
		$('.delete-icon').on('click', function() {
			
			let id = $(this).data('post-id');
			// alert(id);
			$('#deleteModal').data('post-id', id);
		});
		
		// 글 삭제 (모달의 삭제하기 버튼 클릭 시)
		$('#deleteBtn').on('click', function() {
			
			let id = $('#deleteModal').data('post-id');
			// alert(id);
			$.ajax({
				url: '/post/delete'
				, method: 'post'
				, data: {
					"id" : id
				}, success: function(data) {
					if (data.result == 'success') {
						alert("삭제 되었습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("삭제에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 댓글 생성 (쓰기 버튼 클릭 시) 
		$('.comment-btn').on('click', function() {
		
			let postId = $(this).data('post-id');
			let commentContent = $('#commentContent' + postId).val();
			
			$.ajax({
				url: '/comment/create'
				, method: 'post'
				, data: {
					"postId": postId
					, "content": commentContent
				} 
				, success: function(data) {
					if (data.result == 'success') {
						alert("댓글이 등록 되었습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("댓글 등록에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 댓글 모두 보기 | 숨기기 토글 버튼
		$('.show-comment-link').on('click', function(e) {
			e.preventDefault();

			//let postId = $(this).data('post-id');
			//alert(postId);
			let brother = $(e.target).next();
			
			if ($(brother).hasClass("d-none")) {
				$(brother).removeClass("d-none");
				$(this).text('댓글 모두 숨기기');
			} else {
				$(brother).addClass("d-none");
				$(this).text('댓글 모두 보기');
			}
		});
		
		// 댓글 삭제
		$('.comment-del-btn').on('click', function() {
			
			let commentId = $(this).data('comment-id');

			$.ajax({
				url: '/comment/delete'
				, method: 'post'
				, data: {
					"id" : commentId
				}, success: function(data) {
					if (data.result == 'success') {
						alert("댓글이 삭제 되었습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("댓글 삭제에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 좋아요 누르기
		$('.post-like-btn').on('click', function() {
			
			let postId = $(this).data('post-id');
			$.ajax({
				url: '/like/' + postId
				, method: 'post'
				, data: {
					"postId" : postId
				}, success: function(data) {
					if (data.result == 'success') {
						alert("좋아요!");
						location.reload();
					}
				}, error: function(e) {
					alert("좋아요에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 좋아요 취소하기
		$('.post-mylike-btn').on('click', function() {
			
			$.ajax({
				url: '/like/delete'
				, method: 'post'
				, data: {
					"postId" : $(this).data('post-id')
				}, success: function(data) {
					if (data.result == 'success') {
						alert("좋아요를 취소 하였습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("좋아요 취소에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// follow 하기
		$('.follow-btn').on('click', function(e) {
			e.preventDefault();
			
			let followee = $(this).data('followee');
			// alert(followee);
			$.ajax({
				url: '/follow/create'
				, method: 'post'
				, data: {
					"followee" : followee
				}, success: function(data) {
					// alert(data);
					if (data.result == 'success') {
						alert("follow!");
						location.reload();
					}
				}, error: function(e) {
					alert("follow에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// follow 취소하기
		$('.follow-cancel-btn').on('click', function(e) {
			e.preventDefault();
			
			let followee = $(this).data('followee');
			// alert(followee);
			$.ajax({
				url: '/follow/delete'
				, method: 'post'
				, data: {
					"followee" : followee
				}, success: function(data) {
					if (data.result == 'success') {
						alert("follow를 취소 하였습니다.");
						location.reload();
					}
				}, error: function(e) {
					alert("follow 취소에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 더보기 버튼
		
	});
</script>