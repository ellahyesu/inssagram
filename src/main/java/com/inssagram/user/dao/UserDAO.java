package com.inssagram.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.inssagram.user.model.User;

@Repository
public interface UserDAO {

	public User selectUserByLoginId(String loginId);
	
	public void insertUser(
			@Param("loginId") String loginId
			, @Param("password") String password 
			, @Param("name") String name 
			, @Param("email") String email);
	
}
