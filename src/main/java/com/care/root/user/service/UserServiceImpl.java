package com.care.root.user.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.config.FileService;
import com.care.root.config.FileServiceImpl;
import com.care.root.config.PagingVO;
import com.care.root.mybatis.user.UserMapper;
import com.care.root.user.dto.UserDTO;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired 
	UserMapper user_mapper;
	
	/**
	 * Suho 2021-07-12 암호화 처리방법
	 */
	BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	@Override
	public UserDTO getUserSessionId(String session_id) {

		return user_mapper.getUserSessionId(session_id);
		
	}

	@Override
	public int userSignup(MultipartHttpServletRequest mul, UserDTO dto) {
		
		String secure_pwd = encoder.encode(dto.getUser_pwd());
		
		dto.setSession_id("nan");
		dto.setLimit_time(new Date(System.currentTimeMillis()));
		dto.setUser_pwd(secure_pwd);
		
		MultipartFile file = mul.getFile("image_file_name");
		FileService file_service = new FileServiceImpl();
		
		if(file.getSize() != 0) {
			dto.setUser_profile(file_service.saveProfileImage(file));		
		}else {	
			dto.setUser_profile("nan");		
		}
		
		try {
			return user_mapper.userSignup(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public int userCheck(HttpServletRequest request) {
		
		UserDTO dto = user_mapper.userCheck(request.getParameter("user_id"));
		if(dto != null) {
			if(request.getParameter("user_pwd").equals(dto.getUser_pwd()) || 
					encoder.matches(request.getParameter("user_pwd"), dto.getUser_pwd())) {
				return 1;
			}
		}
		return 0;
	}

	@Override
	public void saveSession(String session_id, Date limit_date, String user_id) {
		Map<String, Object> dates =new HashMap<String, Object>();
		dates.put("session_id", session_id);
		dates.put("limit_date", limit_date);
		dates.put("user_id", user_id);
		
		user_mapper.saveSession(dates);
		
	}

	@Override
	public void userBoard(int page_number, Model model) {
		
		int page_letter = 10; //한페이지에 몇 개의 글을 보여줄지
		int user_count = user_mapper.selectUserCount(); // 글 총 개수 얻어오기
		
		int repeat = user_count / page_letter; // 총 페이지 수
		if(user_count % page_letter != 0) {
			repeat += 1;
		}
		
		// num = 1 * 3 
		int end_number = page_number * page_letter; 
		// num = 3 + 1 - 3
		int start_number = end_number + 1 - page_letter;
		
		System.out.println("allCount : " + user_count + " end : " + end_number + " start : " + start_number + " repeat : " + repeat );
		
		model.addAttribute("repeat", repeat);
		
		model.addAttribute("user_list", user_mapper.userBoard(start_number, end_number));
		
	}

	@Override
	public void userInfo(Model model, String user_id) {
		
		model.addAttribute("user_info", user_mapper.userInfo(user_id));
		
	}

	@Override
	public String userModify(MultipartHttpServletRequest mul, HttpServletRequest request) {

		UserDTO dto = new UserDTO();
		
		String secure_pwd = encoder.encode(mul.getParameter("user_pwd"));

		dto.setUser_id(mul.getParameter("user_id"));
		dto.setUser_pwd(secure_pwd);
		dto.setUser_email(mul.getParameter("user_email"));
		dto.setUser_address_number1(mul.getParameter("user_address_number1"));
		dto.setUser_address_number2(mul.getParameter("user_address_number2"));
		dto.setUser_address_number3(mul.getParameter("user_address_number3"));

		MultipartFile file = mul.getFile("user_profile");
		FileService file_service = new FileServiceImpl();
		if(file.getSize() != 0) {
			dto.setUser_profile(file_service.saveProfileImage(file));
			file_service.deleteProfileImage(mul.getParameter("origin_file_name"));
		}else {
			dto.setUser_profile(mul.getParameter("origin_file_name"));
		}

		int result = user_mapper.userModify(dto);
		String msg, url;
		String path = request.getContextPath();
		if(result == 1) {
			msg = "성공적으로 수정 되었습니다.";
			url = path + "/index";
		}else {
			msg = "수정 중 문제 발생";
			url = path + "/user/user_modify";
		}
		return file_service.getMessage(msg, url);
	}

	@Override
	public int userDelete(String user_id, String user_profile, HttpServletRequest request) {
		
		
		FileService file_service = new FileServiceImpl();
		if(!user_profile.equals("nan")) {
			file_service.deleteProfileImage(user_profile);
		}
		
		int result = user_mapper.userDelete(user_id);
		System.out.println("result : " + result);
		
		return result;
	}

	@Override
	public int userIdCheck(String user_id) {
		
		
		int result = user_mapper.userIdCheck(user_id);
		
		return result;
		
	}

	@Override
	public int adminUserDelete(String user_id, HttpServletRequest request) {
		
		int result = user_mapper.userDelete(user_id);
		System.out.println("result : " + result);
		
		return result;
	}

	
	
	@Override
	public int countUserBoard() {
		return user_mapper.countUserBoard();
	}
	
	@Override
	public List<UserDTO> selectUserBoard(PagingVO vo) {
			
		return user_mapper.selectUserBoard(vo);
		
	}

	
	
}
