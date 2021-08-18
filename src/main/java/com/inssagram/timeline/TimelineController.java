package com.inssagram.timeline;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	@RequestMapping("/timeline_view")
	public String postListView(Model model) {
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}

}

