package com.care.root.user.service;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.config.PagingVO;
import com.care.root.user.dto.UserDTO;

public interface UserService {

	public UserDTO getUserSessionId(String sessionId);
	public int userSignup(MultipartHttpServletRequest mul, UserDTO dto);
	public int userCheck(HttpServletRequest request);
	public void saveSession(String session_id, Date limit_date, String user_id);
	public void userBoard(int page_number, Model model);
	public void userInfo(Model model, String user_id);
	public String userModify(MultipartHttpServletRequest mul, HttpServletRequest request);
	//public String userDelete(MultipartHttpServletRequest mul, HttpServletRequest request);
	public int userDelete(String user_id, String user_profile, HttpServletRequest request);
	public int userIdCheck(String user_id); 
	public int adminUserDelete(String user_id, HttpServletRequest request);

	
	// 게시물 총 갯수
	public int countUserBoard();
	// 페이징 처리 게시글 조회
	public List<UserDTO> selectUserBoard(PagingVO vo);

	
}
