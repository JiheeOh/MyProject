package com.care.root.config;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileServiceImpl implements FileService {

	@Override
	public String saveProfileImage(MultipartFile file) {
		SimpleDateFormat simpl = new SimpleDateFormat("yyyyMMddHHmmss-");
		Calendar calendar = Calendar.getInstance();
		String sysFileName = simpl.format(calendar.getTime()) + file.getOriginalFilename();//20210710174720-test.png
		File saveFile = new File(IMAGE_PROFILE_REPO + "/" +sysFileName);
		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sysFileName;
	}

	@Override
	public void deleteProfileImage(String origin_file_name) {
		
		File deleteFile = new File(IMAGE_PROFILE_REPO+"/"+origin_file_name);
		deleteFile.delete();
		
	}
	
	@Override
	public String saveBoardImage(MultipartFile file) {
		SimpleDateFormat simpl = new SimpleDateFormat("yyyyMMddHHmmss-");
		Calendar calendar = Calendar.getInstance();
		String sysFileName = simpl.format(calendar.getTime()) + file.getOriginalFilename();//20210710174720-test.png
		File saveFile = new File(IMAGE_BOARD_REPO + "/" +sysFileName);
		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sysFileName;
	}

	@Override
	public void deleteBoardImage(String origin_file_name) {
		
		File deleteFile = new File(IMAGE_BOARD_REPO+"/"+origin_file_name);
		deleteFile.delete();
		
	}

	@Override
	public String getMessage(String msg, String url) {
		
		System.out.println("msg : " + msg + ", url : " + url);
		
		String message = null;
		
		message = "<script>alert('"+msg+"'); location.href='"+url+"'</script>";
	
		return message;
		
	}
	
}
