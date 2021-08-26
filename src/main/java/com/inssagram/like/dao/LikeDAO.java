package com.inssagram.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.inssagram.like.model.Like;

@Repository
public interface LikeDAO {

	public int insertLike(
			@Param("userId") int userId
			, @Param("postId") int postId);
	
	public int selectLikeCountByPostId(int postId); 
	
	public Like selectLikeByUserIdAndPostId(
			@Param("userId") int userId
			, @Param("postId") int postId);
	
	public void deleteLike(
			@Param("userId") int userId
			, @Param("postId") int postId);
	
}
