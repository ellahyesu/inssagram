package com.inssagram.timeline.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.inssagram.timeline.model.Post;

@Repository
public interface PostDAO {

	public int insertPost(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public List<Post> selectPostByUserId(int userId);
}
