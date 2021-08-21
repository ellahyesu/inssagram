package com.inssagram.timeline;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.inssagram.timeline.bo.PostBO;

@RequestMapping("/timeline")
@RestController
public class TimelineRestController {

	@Autowired
	private PostBO postBO;
	
	@RequestMapping("/create")
	public Map<String, String> postCreate(
			@RequestParam("content") String content
			, @RequestParam(value="file", required=false) MultipartFile file
			, HttpServletRequest request) {

		HttpSession session = request.getSession();
		// DB insert를 위한 id
		int userId = (int) session.getAttribute("userId");
		// 파일 업로드 경로에 쓰일 loginId
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		String userName = (String) session.getAttribute("userName");
		// DB insert
		int row = postBO.createPost(userId, userLoginId, userName, content, file);

		// 결과 리턴
		Map<String, String> result = new HashMap<>();
		
		if (row > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
