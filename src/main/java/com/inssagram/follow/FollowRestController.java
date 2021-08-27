package com.inssagram.follow;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.inssagram.follow.bo.FollowBO;
import com.inssagram.follow.model.Follow;

@RequestMapping("/follow")
@RestController
public class FollowRestController {

	@Autowired
	FollowBO followBO;
	
	/**
	 * follow 하기
	 * @param followee
	 * @param request
	 * @return
	 */
	@RequestMapping("/create")
	public Map<String, String> followCreate(
			@RequestParam("followee") String followee
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		// 팔로우를 하는 사람 - 나 자신
		String follower = (String) session.getAttribute("userLoginId"); 
		
		Map<String, String> result = new HashMap<>();
		
		// 세션 확인 - 로그인 여부
		if (userId == null) {
			result.put("result", "error");
			return result;
		}
		
		int row = 0;
		// 내가 이미 팔로우 한 대상인지 DB 확인
		List<Follow> followeeList = followBO.getFolloweeListByFollower(follower);
		
		for (Follow follow : followeeList) {
			// 내가 팔로우 한 대상이 0명 이 아닌 경우
			if (follow.getFollowee() != null) {
				if (follow.getFollowee().equals(followee) == false) {
					// DB insert
					row = followBO.createFollow(follower, followee);
					if (row > 0) {
						result.put("result", "success");
						return result;
					}
				} else 
					continue;
			}
		} 
		
		// 내가 팔로우 한 대상이 0명 인 경우
		// DB insert
		row = followBO.createFollow(follower, followee);
		
		// return result
		if (row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	} 
	
	/**
	 * 팔로우 취소하기
	 * @param followee
	 * @param request
	 * @return
	 */
	@RequestMapping("/delete")
	public Map<String, String> likeDelete(
			@RequestParam("followee") String followee
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		// 팔로우를 취소 하는 사람 - 나 자신
		String follower = (String) session.getAttribute("userLoginId"); 
		
		Map<String, String> result = new HashMap<>();
		
		// 세션 확인 - 로그인 여부
		if (userId == null) {
			result.put("result", "error");
			return result;
		}
		
		// DB delete
		followBO.deleteFollow(follower, followee);
		
		// return result
		result.put("result", "success");
		return result;
	}
	
}
