package com.inssagram.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.inssagram.common.EncryptUtils;
import com.inssagram.user.bo.UserBO;
import com.inssagram.user.model.User;

@RequestMapping("/user")
@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		Map<String, Boolean> result = new HashMap<>();
		User user = userBO.getUserByLoginId(loginId);
		if (user == null) {
			result.put("result", false);
		} else {
			result.put("result", true);
		}
		
		return result;
	}
	
	@PostMapping("/sign_up_for_ajax")
	public Map<String, String> signUpForAjax(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, @RequestParam("name") String name
			, @RequestParam("email") String email) {
		
		// 암호화(해싱)
		String encryptPassword = EncryptUtils.md5(password);
		
		// insert DB
		userBO.addUser(loginId, encryptPassword, name, email);
		
		// 결과값 리턴
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, String> signIn(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request) {
		
		// password를 md5로 해싱
		String encryptPassword = EncryptUtils.md5(password);
		
		// DB
		User user = userBO.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		// result
		Map<String, String> result = new HashMap<>();
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userId", user.getId());
			session.setAttribute("userProfileImageFile", user.getProfileImageFile());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
}
