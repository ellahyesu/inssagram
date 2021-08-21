package com.inssagram.timeline.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.inssagram.common.FileManagerService;
import com.inssagram.timeline.dao.PostDAO;
import com.inssagram.timeline.model.Post;

@Service
public class PostBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManaegerService;
	
	public int createPost(int userId, String userLoginId, String userName, String content, MultipartFile file) {

		// file을 가지고 image URL로 구성하고 DB에 insert
		String imageUrl = null;
		if (file != null) {
			try {
				imageUrl = fileManaegerService.saveFile(userLoginId, file);
			} catch (IOException e) {
				// e.printStackTrace();
				logger.error("[파일업로드] " + e.getMessage());
			}
			logger.info("##### 이미지 주소: " + imageUrl);
		}
		return postDAO.insertPost(userId, userName, content, imageUrl);
	}
	
	public List<Post> getPostListByUserId(int userId) {
		return postDAO.selectPostByUserId(userId);
	}
}
