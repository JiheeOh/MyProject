package com.care.root.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.board.dto.BoardDTO;
import com.care.root.board.service.BoardService;
import com.care.root.config.FileService;
import com.care.root.config.PagingVO;

@Controller
@RequestMapping("board")
public class BoardController {

	@Autowired
	BoardService board_service;
	
	@RequestMapping("board_list")
	public String selectBoardList(PagingVO vo, Model model 
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		int total = board_service.boardCount();
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
		model.addAttribute("board_list", board_service.boardSelect(vo));
		
		
		return "board/board_list";
	}
	
	@RequestMapping("board_write_form")
	public String boardWriteForm() {
		
		return "board/board_write_form";
	}
	
	@PostMapping("board_write_save")
	public void boardWriteSave(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		String message = board_service.boardWriteSave(mul, request);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
		
	}
	
	@GetMapping("board_detail_view")
	public String boardDetailView(@RequestParam("board_seq") int board_seq, Model model) {
		
		board_service.boardDetailView(board_seq, model);
		
		return "board/board_dtail_view";
	}
	
	@GetMapping("board_modify_form")
	public String modify_form(@RequestParam int board_seq, Model model) {
		board_service.boardDetailView(board_seq, model);
		return "board/board_modify_form";
	}
	
	@PostMapping("board_modify")
	public void modify(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		String message = board_service.boardModify(mul, request);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=utf-8");
		out.print(message);
		
	}
	
	
	@GetMapping("download")
	public void download(@RequestParam String board_profile, HttpServletResponse response) throws IOException {
		
		response.addHeader("Content-disposition", "attachment;board_profile="+ board_profile);
		File file = new File(FileService.IMAGE_BOARD_REPO+"/"+ board_profile);
		FileInputStream in = new FileInputStream(file);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
		
	}
	
	@PostMapping(value="board_delete", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String boardDelte(@RequestParam("board_seq") int board_seq, @RequestParam("board_file_url") String board_file_url , HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		System.out.println("board_seq : " + board_seq);
		
		int result = board_service.boardDelete(board_seq,board_file_url,request); 
		
		System.out.println("message : " + result);
		
		return String.valueOf(result);
		 
	}
	
}
