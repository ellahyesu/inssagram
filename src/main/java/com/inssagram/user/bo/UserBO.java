package com.inssagram.user.bo;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.inssagram.common.FileManagerService;
import com.inssagram.user.dao.UserDAO;
import com.inssagram.user.model.User;

@Service
public class UserBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public void addUser(String loginId, String password, String name, String email) {
		userDAO.insertUser(loginId, password, name, email);
	}
	
	public User getUserByLoginId(String loginId) {
		return userDAO.selectUserByLoginId(loginId);
	}
	
	public User getUserByLoginIdAndPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIdAndPassword(loginId, password);
	}
	
	public User getUserByUserName(String name) {
		return userDAO.selectUserByUserName(name);
	}
	
	public int updateUserByProfileImageFile(
			int id
			, String userLoginId
			, MultipartFile file) {

		String profileImageFile = generateimagePathByFile(userLoginId, file);
		return userDAO.updateUserByProfileImageFile(id, profileImageFile);
	}
	
	private String generateimagePathByFile(String userLoginId, MultipartFile file) {
		// file을 가지고 image URL로 구성하고 DB에 넣는다.
		String profileImageFile = null;
		if (file != null) {
			try {
				// 컴퓨터(서버)에 파일 업로드 후 웹으로 접근할 수 있는 image URL을 얻어낸다.
				profileImageFile = fileManagerService.saveFile(userLoginId, file);
			} catch (IOException e) {
				logger.error("[파일 업로드] " + e.getMessage());
			}
		}
		return profileImageFile;
	}
	
}
