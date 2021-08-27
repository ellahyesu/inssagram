package com.inssagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inssagram.follow.bo.FollowBO;
import com.inssagram.follow.model.Follow;
import com.inssagram.timeline.bo.ContentBO;
import com.inssagram.timeline.model.Content;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

	@Autowired
	private ContentBO contentBO;
	
	@Autowired
	private FollowBO followBO;
	
	@RequestMapping("/timeline_view")
	public String timelineView(
			HttpServletRequest request
			, Model model) {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		// follow주체 - 나 자신
		String follower = (String) session.getAttribute("userLoginId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		List<Content> contentList = contentBO.getContentList(userId, follower);
		model.addAttribute("contentList", contentList);
		
		// 내가 follow하는 대상의 목록
		List<Follow> followeeList = followBO.getFolloweeListByFollower(follower);
		model.addAttribute("followeeList", followeeList);
		
		// 나를 follow하는 대상의 목록
		List<Follow> followerList = followBO.getFollowerListByFollowee(follower);
		model.addAttribute("followerList", followerList);
		
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
	
}

