package com.inssagram.timeline.model;

import java.util.List;

import com.inssagram.comment.model.Comment;
import com.inssagram.like.model.Like;
import com.inssagram.post.model.Post;
import com.inssagram.user.model.User;

public class Content { // Content 1개를 구성하고 있는 것들(글, 댓글목록, 좋아요)
	
	// User - 작성자 1명
	private User user;

	// post 1개
	private Post post; 
	
	// post - 댓글 N개
	private List<Comment> commentList;
	
	// post - 좋아요 N개
	private List<Like> likeList;
	
	// 좋아요 개수
	private int likeCount;
	
	private boolean isFilledLike; // userId(나) - post 좋아요

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

	public List<Like> getLikeList() {
		return likeList;
	}

	public void setLikeList(List<Like> likeList) {
		this.likeList = likeList;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean isFilledLike() {
		return isFilledLike;
	}

	public void setFilledLike(boolean isFilledLike) {
		this.isFilledLike = isFilledLike;
	}
	
}
