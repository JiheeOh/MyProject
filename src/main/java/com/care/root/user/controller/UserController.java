package com.care.root.user.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.care.root.config.ChattingHandler;
import com.care.root.config.FileService;
import com.care.root.config.PagingVO;
import com.care.root.user.dto.UserDTO;
import com.care.root.user.service.UserService;
import com.care.root.user.session.UserSessionName;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("user")
public class UserController implements UserSessionName {

	@Autowired
	UserService user_service;

	/**
	 * Suho 2021-07-12 유저 로그인 
	 */

	@GetMapping("user_login")
	public String login() {

		return "user/user_login";

	}

	/**
	 * Suho 2021-07-12 유저 회원가입 
	 */
	@RequestMapping("user_signup_form")
	public String userSignupForm() {

		return "user/user_signup";

	}

	/**
	 * Suho 2021-07-12 회원 가입 처리 
	 */
	@PostMapping("user_signup")
	public String userSignup(MultipartHttpServletRequest mul, UserDTO dto) {

		int result = user_service.userSignup(mul, dto);
		if (result == 1) {
			return "redirect:user_login";
		}
		return "redirect:user_signup_form";

	}

	/**
	 * Suho 2021-07-12 유저 확인 
	 */
	@PostMapping("/user_check")
	public String userCheck(HttpServletRequest request, RedirectAttributes rs) {

		int result = user_service.userCheck(request);
		if (result == 1) {
			rs.addAttribute("user_id", request.getParameter("user_id"));
			rs.addAttribute("auto_login", request.getParameter("auto_login"));
			return "redirect:success_login";
		}
		return "redirect:user_login";

	}

	/**
	 * Suho 2021-07-12 로그인 성공 시 
	 */
	@RequestMapping("success_login")
	public String successLogin(@RequestParam("user_id") String user_id,
			@RequestParam(value = "auto_login", required = false) String auto_login, HttpServletResponse response,
			HttpSession session) {

		session.setAttribute(LOGIN, user_id);
		if (auto_login != null) {
			int limittiom = 60 * 60 * 24 * 90; // 90占쏙옙
			Cookie cookie = new Cookie("login_cookie", session.getId());
			cookie.setPath("/");
			cookie.setMaxAge(limittiom);
			response.addCookie(cookie);

			Calendar cal = Calendar.getInstance();
			cal.setTime(new java.util.Date());
			cal.add(Calendar.MONTH, 3);

			Date date = new Date(cal.getTimeInMillis());

			user_service.saveSession(session.getId(), date, user_id);

		}
		return "/index";
	}

	/**
	 * Suho 2021-07-12 로그아웃 
	 */
	@GetMapping("user_logout")
	public String userLogout(HttpSession session, HttpServletResponse response,
			@CookieValue(value = "login_cookie", required = false) Cookie login_cookie) {

		if (session.getAttribute(LOGIN) != null) {
			if (login_cookie != null) {
				login_cookie.setMaxAge(0);
				response.addCookie(login_cookie);
				user_service.saveSession("nan", new Date(System.currentTimeMillis()),
						(String) session.getAttribute(LOGIN));

				System.out.println("id = " + (String) session.getAttribute(LOGIN) + " ," + session.getId());
			}
			session.invalidate();
		}
		return "redirect:/index";
	}

	/**
	 * Suho 2021-07-13 유저 목록 
	 */
	@GetMapping("user_board")
	public String userBoard(PagingVO vo, Model model 
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		int total = user_service.countUserBoard();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", vo);
		model.addAttribute("user_list", user_service.selectUserBoard(vo));
		
		
		return "user/user_board";
		
	}

	/**
	 * Suho 2021-07-13 유저 개인 정보 
	 */
	@RequestMapping("user_info")
	public String userInfo(Model model, @RequestParam("user_id") String user_id) {

		user_service.userInfo(model, user_id);
		return "user/user_info";
	}

	/**
	 * Suho 2021-07-13 파일 다운로드 처리 
	 */
	@GetMapping("download")
	public void download(@RequestParam String user_profile, HttpServletResponse response) throws IOException {

		response.addHeader("Content-disposition", "attachment;imageFileName=" + user_profile);
		File file = new File(FileService.IMAGE_PROFILE_REPO + "/" + user_profile);
		FileInputStream in = new FileInputStream(file);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
	}

	/**
	 * Suho 2021-07-13 개인 정보 수정 
	 */
	@PostMapping("user_modify")
	public void modify(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request)
			throws IOException {

		String message = user_service.userModify(mul, request);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=utf-8");
		out.print(message);

	}

	/**
	 * Suho 2021-07-13 유저 탈퇴 
	 */
	@PostMapping(value = "user_delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String userDelte(@RequestParam("user_id") String user_id, @RequestParam("user_profile") String user_profile,
			HttpServletRequest request, HttpServletResponse response) throws IOException {

		System.out.println("user_id : " + user_id);

		int result = user_service.userDelete(user_id, user_profile, request);

		System.out.println("message : " + result);

		return String.valueOf(result);

	}

	/**
	 * Suho 2021-07-13 유저 아이디 확ㅇ니 
	 */
	@GetMapping(value = "user_id_check")
	@ResponseBody
	public int userIdCheck(@RequestParam("user_id") String user_id) throws IOException {

		int result = user_service.userIdCheck(user_id);

		return result;

	}

	// 관리자가 유저 삭제 
	@PostMapping(value = "admin_user_delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String adminUserDelte(@RequestParam(value = "tdArr[]") List<String> tdArr, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		int result = 0;
		boolean success_check = true;
		
		for (String user_id : tdArr) {
			result = user_service.adminUserDelete(user_id,request);
			System.out.println("result : " + result);
			
			if(result == 0) {
				success_check = false;
			}
			if(!success_check) {
				System.out.println("삭제하는 중 문제가 발생하였습니다. ");
			}
			  
		}
	   
	    return String.valueOf(result);
	 
	}
	
	// 채팅 기능 
	@GetMapping("/chat")
	public void chat(Model model, HttpSession session) {
		
		Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
		
		String user_id = (String) session.getAttribute(LOGIN);
		
		
		logger.info("====================");
		logger.info(", GET Chat / Username : " + user_id);
		
		model.addAttribute("user_id", user_id);
		
		
	}
}
