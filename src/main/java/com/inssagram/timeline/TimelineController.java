package com.inssagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inssagram.timeline.bo.PostBO;
import com.inssagram.timeline.model.Post;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

	@Autowired
	private PostBO postBO;
	
	@RequestMapping("/timeline_view")
	public String postListView(
			HttpServletRequest request
			, Model model) {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		List<Post> postList = postBO.getPostListByUserId(userId);
		model.addAttribute("postList", postList);
		
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}

