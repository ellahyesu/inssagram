package com.inssagram.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.inssagram.post.model.Post;

@Repository
public interface PostDAO {

	public int insertPost(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public List<Post> selectPostList();

	public List<Post> selectPostListByUserId(int userId);
	
	public Post selectPostByPostIdAndUserId(
			@Param("id") int id
			, @Param("userId") int userId);
	
	public int updatePost(
			@Param("id") int id
			, @Param("userId") int userId
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public int deletePost(int id);
	
}
