package com.inssagram.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
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
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) { 
		registry.addResourceHandler("/images/**") // http://localhost/images/coco12_1629441276231/PaintJS[EXPORT] (5).png 와 같이 접근 가능하게 매핑해준다.
		.addResourceLocations("file:///C:\\Users\\ella\\6_spring_project\\inssagram\\inssagram_workspace\\Inssagram\\images/"); // 실제 파일 저장 위치
	}
	
}