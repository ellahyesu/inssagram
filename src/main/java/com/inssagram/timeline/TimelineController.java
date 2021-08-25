package com.inssagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inssagram.timeline.bo.ContentBO;
import com.inssagram.timeline.model.Content;

@RequestMapping("/timeline")
@Controller
public class TimelineController {

	@Autowired
	private ContentBO contentBO;
	
	@RequestMapping("/timeline_view")
	public String timelineView(
			HttpServletRequest request
			, Model model) {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		List<Content> contentList = contentBO.getContentList();
		model.addAttribute("contentList", contentList);
		
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}

