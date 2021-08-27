package com.inssagram.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.inssagram.comment.bo.CommentBO;

@RequestMapping("/comment")
@RestController
public class CommentRestController {

	@Autowired
	private CommentBO commentBO;
	
	/**
	 * 댓글 쓰기
	 * @param postId
	 * @param content
	 * @param request
	 * @return
	 */
	@RequestMapping("/create")
	public Map<String, String> commentCreate(
			@RequestParam("postId") int postId
			, @RequestParam("content") String content
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");
		
		Map<String, String> result = new HashMap<>();

		// 세션 확인 - 로그인 여부
		if (userId == null || userName == null) {
			result.put("result", "error");
			return result;
		}
		
		// DB insert
		int row = commentBO.createComment(postId, userId, userName, content);
		
		// return result
		if (row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	/**
	 * 댓글 삭제
	 * @param id
	 * @return
	 */
	@RequestMapping("/delete")
	public Map<String, String> commentDelete(
			@RequestParam("id") int id) {
		
		// DB delete
		commentBO.deleteCommentById(id);
		
		// return result
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
	
}
