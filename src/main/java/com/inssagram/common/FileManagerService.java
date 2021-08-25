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
	
	// 파일 삭제
	public void deleteFile(String imagePath) throws IOException {
		// imagePath => /images/coco12_1629441276231/PaintJS[EXPORT](5).png
		// /images/가 중복되기 때문에 공백으로 치환해준다.
		// C:\\Users\\ella\\6_spring_project\\memo\\memo_workspace\\Memo\\images/coco12_1629441276231/PaintJS[EXPORT](5).png
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		if (Files.exists(path)) {
			Files.delete(path); // 이미지 삭제
		}

		// 디렉토리 삭제
		path = path.getParent();
		if (Files.exists(path)) {
			Files.delete(path);
		}
	}
	
	
}
