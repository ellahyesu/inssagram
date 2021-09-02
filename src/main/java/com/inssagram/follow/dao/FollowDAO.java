package com.inssagram.follow.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.inssagram.follow.model.Follow;

@Repository
public interface FollowDAO {

	public int insertFollow(
			@Param("follower") String follower
			, @Param("followee") String followee);
	
	// follow하는 목록
	public List<Follow> selectFolloweeListByFollower(@Param("follower") String follower);

	// follow를 당하는 목록
	public List<Follow> selectFollowerListByFollowee(@Param("followee") String followee);
	
	public void deleteFollow(
			@Param("follower") String follower
			, @Param("followee") String followee);
	
}
