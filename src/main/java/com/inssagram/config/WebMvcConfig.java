package com.inssagram.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.inssagram.interceptor.PermissionInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Autowired
	private PermissionInterceptor permissonInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(permissonInterceptor)
		.addPathPatterns("/**") // ** 아래 디렉토리까지 확인
		.excludePathPatterns("/user/sign_out", "/static/**", "/error"); // 여기에 해당하는 URL은 인터셉터가 되지 않는다.
		;
	}
}