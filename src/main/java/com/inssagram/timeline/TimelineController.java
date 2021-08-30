package com.inssagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.inssagram.follow.bo.FollowBO;
import com.inssagram.follow.model.Follow;
import com.inssagram.post.bo.PostBO;
import com.inssagram.post.model.Post;
import com.inssagram.timeline.bo.ContentBO;
import com.inssagram.timeline.model.Content;
import com.inssagram.user.bo.UserBO;
import com.inssagram.user.model.User;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

	@Autowired
	private ContentBO contentBO;

	@Autowired
	private PostBO postBO;
	
	@Autowired
	private FollowBO followBO;
	
	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/timeline_view")
	public String timelineView(
			@RequestParam(value="prevId", required=false) Integer prevIdParam
			, @RequestParam(value="nextId", required=false) Integer nextIdParam
			, HttpServletRequest request
			, Model model) {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		// follow주체 - 나 자신
		String follower = (String) session.getAttribute("userLoginId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}

		// Post 목록
		List<Post> postList = postBO.getPostListByLimit(prevIdParam, nextIdParam);
		int prevId = 0;
		int nextId = 0;
		if (postList.isEmpty() == false) {
			prevId = postList.get(0).getId();
			nextId = postList.get(postList.size() - 1).getId();
			
			if (postBO.isLastPage(nextId)) {
				nextId = 0;
			}
			if (postBO.isFirstPage(prevId)) {
				prevId = 0;
			}
		}
		model.addAttribute("prevId", prevId); // 리스트 중 가장 앞 쪽(제일 큰) id
		model.addAttribute("nextId", nextId); // 리스트 중 가장 뒷 쪽(제일 작은) id
		
		List<Content> contentList = contentBO.getContentList(userId, follower, postList);
		model.addAttribute("contentList", contentList);
		
		// 내가 follow하는 대상의 목록
		List<Follow> followeeList = followBO.getFolloweeListByFollower(follower);
		model.addAttribute("followeeList", followeeList);
		
		// 나를 follow하는 대상의 목록
		List<Follow> followerList = followBO.getFollowerListByFollowee(follower);
		model.addAttribute("followerList", followerList);
		
		// header 프로필 사진을 띄우기 위해 user 넘겨줌 
		User user = userBO.getUserByLoginId(follower);
		model.addAttribute("user", user);
		
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
	
}

