package com.inssagram.comment.bo;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inssagram.comment.dao.CommentDAO;
import com.inssagram.comment.model.Comment;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;
	
	public int createComment(int postId, int userId, String userName, String content) {
		return commentDAO.insertComment(postId, userId, userName, content);
	}
	
	public List<Comment> getCommentList() {
		return commentDAO.selectCommentList();
	}
	
	public List<Comment> getCommentListByPostId(int postId) {
		return commentDAO.selectCommentListByPostId(postId);
	}
	
	public void deleteCommentById(int id) {
		commentDAO.deleteCommentById(id);
	}
	
	public void deleteCommentByPostId(@Param("postId") int postId) {
		commentDAO.deleteCommentByPostId(postId);
	}
	
}
