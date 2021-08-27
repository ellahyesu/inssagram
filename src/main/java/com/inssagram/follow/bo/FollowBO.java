package com.inssagram.follow.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inssagram.follow.dao.FollowDAO;
import com.inssagram.follow.model.Follow;

@Service
public class FollowBO {
	
	@Autowired
	private FollowDAO followDAO;

	public int createFollow(String follower, String followee) {
		return followDAO.insertFollow(follower, followee);
	}
	
	// follower가 follow를 하는 목록(followee)
	public List<Follow> getFolloweeListByFollower(String follower) {
		return followDAO.selectFolloweeListByFollower(follower);
	}
	
	// follow를 당하는 목록
	public List<Follow> getFollowerListByFollowee(String followee) {
		return followDAO.selectFollowerListByFollowee(followee);
	}
	
	public void deleteFollow(String follower, String followee) {
		followDAO.deleteFollow(follower, followee);
	}
	
}
