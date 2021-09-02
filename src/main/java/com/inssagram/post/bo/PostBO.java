package com.inssagram.post.bo;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.inssagram.comment.dao.CommentDAO;
import com.inssagram.common.FileManagerService;
import com.inssagram.like.dao.LikeDAO;
import com.inssagram.post.dao.PostDAO;
import com.inssagram.post.model.Post;

@Service
public class PostBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final int POST_MAX_SIZE = 3;
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private LikeDAO likeDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public int createPost(int userId, String userLoginId, String userName, String content, MultipartFile file) {

		String imagePath = generateimagePathByFile(userLoginId, file);
		return postDAO.insertPost(userId, userName, content, imagePath);
	}
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
	
	public List<Post> getPostListByUserId(int userId) {
		return postDAO.selectPostListByUserId(userId);
	}
	
	public Post getPostByPostIdAndUserId(int id, int userId) {
		return postDAO.selectPostByPostIdAndUserId(id, userId);
	}

	// 페이징
	public List<Post> getPostListByLimit(Integer prevId, Integer nextId) {
		
		String direction = null;
		Integer standardId = null;
		
		if (prevId != null) {
			direction = "prev";
			standardId = prevId;
			
			List<Post> postList = postDAO.selectPostListByLimit(direction, standardId, POST_MAX_SIZE);
			// 정렬을 뒤집어야 함.
			Collections.reverse(postList);
			return postList;
		} else if (nextId != null) {
			direction = "next";
			standardId = nextId;
		}
		
		return postDAO.selectPostListByLimit(direction, standardId, POST_MAX_SIZE);
	}
	
	// 가장 오른쪽 페이지인가?
	public boolean isLastPage(int nextId) {
		// 게시글 번호 10 9 8 | 7 6 5 | 4 3 2 | 1 
		// 1
		return nextId == postDAO.selectPostIdBySort("ASC"); // postId == nextId
	}

	// 가장 왼쪽 페이지인가?
	public boolean isFirstPage(int prevId) {
		// 10
		return prevId == postDAO.selectPostIdBySort("DESC");
	}
		
	public int updatePost(int id, int userId, String userLoginId, String content, MultipartFile file) {
		String imagePath = generateimagePathByFile(userLoginId, file);
		logger.info("### 수정된 이미지 주소: " + imagePath);
		
		if (imagePath != null) {
			Post post = postDAO.selectPostByPostIdAndUserId(id, userId);
			String oldImagePath = post.getImagePath();
			try {
				fileManagerService.deleteFile(oldImagePath);
			} catch (IOException e) {
				logger.error("[파일삭제] 삭제 중 에러: " + id + " " + oldImagePath);
			}
		}
		return postDAO.updatePost(id, userId, content, imagePath);
	}
	
	public int deletePost(int id, int userId) {

		// 글에 종속된 모든 것 삭제되어야 함! (글, file, 댓글, 좋아요)
		
		// file 및 디렉토리 삭제
		Post post = postDAO.selectPostByPostIdAndUserId(id, userId);
		String oriImagePath = post.getImagePath();
		
		if (oriImagePath != null) {
			try {
				fileManagerService.deleteFile(oriImagePath);
			} catch (IOException e) {
				logger.error("[파일삭제] 삭제 중 에러: " + id + " " + oriImagePath);
			}
		}
		
		// 댓글 삭제
		commentDAO.deleteCommentByPostId(id);
		
		// 좋아요 삭제
		likeDAO.deleteLikeByPostId(id);
		
		return postDAO.deletePost(id);
	}
	
	private String generateimagePathByFile(String userLoginId, MultipartFile file) {
		// file을 가지고 image URL로 구성하고 DB에 넣는다.
		String imagePath = null;
		if (file != null) {
			try {
				// 컴퓨터(서버)에 파일 업로드 후 웹으로 접근할 수 있는 image URL을 얻어낸다.
				imagePath = fileManagerService.saveFile(userLoginId, file);
			} catch (IOException e) {
				logger.error("[파일 업로드] " + e.getMessage());
			}
		}
		return imagePath;
	}
	
}
