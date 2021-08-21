package com.inssagram.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public final static String FILE_UPLOAD_PATH = "C:\\Users\\ella\\6_spring_project\\inssagram\\inssagram_workspace\\Inssagram\\images/";
	
	public String saveFile(String userLoginId, MultipartFile file) throws IOException {
		
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (!directory.mkdir()) {
			logger.error("[파일업로드] 디렉토리 생성 실패 " + userLoginId + ", " + filePath);
			return null;
		}
		
		byte[] bytes = file.getBytes();
		Path path = Paths.get(filePath + file.getOriginalFilename());
		Files.write(path, bytes);
		
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	
}
