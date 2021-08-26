package com.inssagram.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.inssagram.like.bo.LikeBO;

@RequestMapping("/like")
@RestController
public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;
	
	/**
	 * 좋아요 달기
	 * @param postId
	 * @param request
	 * @return
	 */
	@RequestMapping("/create")
	public Map<String, String> likeCreate(
			@RequestParam("postId") int postId
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		Map<String, String> result = new HashMap<>();
		
		// 세션 확인 - 로그인 여부
		if (userId == null) {
			result.put("result", "error");
			return result;
		}
		
		// DB insert
		int row = likeBO.createLike(userId, postId);
		
		// return result
		if (row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	@RequestMapping("/delete")
	public Map<String, String> likeDelete(
			@RequestParam("postId") int postId
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		Map<String, String> result = new HashMap<>();
		
		// 세션 확인 - 로그인 여부
		if (userId == null) {
			result.put("result", "error");
			return result;
		}
		
		// DB
		likeBO.deleteLike(userId, postId);
		
		// return result
		result.put("result", "success");
		return result;
	}
	
	
}
