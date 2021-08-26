package com.inssagram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inssagram.comment.bo.CommentBO;
import com.inssagram.comment.model.Comment;
import com.inssagram.like.bo.LikeBO;
import com.inssagram.like.model.Like;
import com.inssagram.post.bo.PostBO;
import com.inssagram.post.model.Post;
import com.inssagram.timeline.model.Content;
import com.inssagram.user.bo.UserBO;
import com.inssagram.user.model.User;

@Service
public class ContentBO {

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public List<Content> getContentList(int userId) {
		
		List<Content> contentList = new ArrayList<>();
		
		// Post 목록
		List<Post> postList = postBO.getPostList();
		for (Post post : postList) {
			Content content = new Content();
			content.setPost(post);
			
			// User - 프로필사진
			String userName = post.getUserName();
			User user = userBO.getUserByUserName(userName);
			content.setUser(user);
			
			// Post 의 댓글 - Comment 목록
			int postId = post.getId();
			List<Comment> commentList = commentBO.getCommentListByPostId(postId);
			content.setCommentList(commentList);

			// 나의 좋아요 여부
			Like like = likeBO.getLikeByUserIdAndPostId(userId, postId);
			
			if (like != null) {
				if (userId == like.getUserId()) {
					content.setFilledLike(true);
				} else {
					content.setFilledLike(false);
				}
			}
			
			// 좋아요 개수
			int likeCount = likeBO.getLikeCountByPostId(postId);
			content.setLikeCount(likeCount);
			
			contentList.add(content);
		}
		return contentList;
	}
	
	
}
