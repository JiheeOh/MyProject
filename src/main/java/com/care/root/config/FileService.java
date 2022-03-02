package com.care.root.config;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {

	public static final String IMAGE_PROFILE_REPO = "C:\\Users\\weft4\\Desktop\\web_project\\image_repo\\profile_image";
	public static final String IMAGE_BOARD_REPO = "C:\\Users\\weft4\\Desktop\\web_project\\image_repo\\board_image";
	public String saveProfileImage(MultipartFile file);
	public void deleteProfileImage(String originFileName);
	public String saveBoardImage(MultipartFile file);
	public void deleteBoardImage(String originFileName);
	public String getMessage(String msg, String url);
	
}
