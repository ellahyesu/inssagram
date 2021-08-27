package com.inssagram.timeline.model;

import java.util.List;

import com.inssagram.comment.model.Comment;
import com.inssagram.post.model.Post;
import com.inssagram.user.model.User;

public class Content { // Content 1개를 구성하고 있는 것들(글, 댓글목록, 좋아요)
	
	// User - 작성자 1명
	private User user;

	// post 1개
	private Post post; 
	
	// post - 댓글 N개
	private List<Comment> commentList;
	
	// Like - 좋아요 N개
	private int likeCount;
	
	private boolean filledLike; // userId(나) - post 좋아요
	
	private boolean followed; // userLoginId(나) - 다른 user follow 여부 

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

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean isFilledLike() {
		return filledLike;
	}

	public void setFilledLike(boolean filledLike) {
		this.filledLike = filledLike;
	}

	public boolean isFollowed() {
		return followed;
	}

	public void setFollowed(boolean followed) {
		this.followed = followed;
	}
	
}
