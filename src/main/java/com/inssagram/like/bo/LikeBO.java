package com.inssagram.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inssagram.like.dao.LikeDAO;
import com.inssagram.like.model.Like;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;

	public int createLike(int userId, int postId) {
		return likeDAO.insertLike(userId, postId);
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostId(postId);
	}
	
	public Like getLikeByUserIdAndPostId(int userId, int postId) {
		return likeDAO.selectLikeByUserIdAndPostId(userId, postId);
	}
	
	public void deleteLike(int userId, int postId) {
		likeDAO.deleteLike(userId, postId);
	}
	
	public void deleteLikeByPostId(int postId) {
		likeDAO.deleteLikeByPostId(postId);
	}
	
}
