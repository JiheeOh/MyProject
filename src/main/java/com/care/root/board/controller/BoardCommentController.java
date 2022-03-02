package com.care.root.board.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.care.root.board.dto.BoardCommentDTO;
import com.care.root.board.service.BoardService;
import com.care.root.user.session.UserSessionName;

@RestController
@RequestMapping("/board")
public class BoardCommentController implements UserSessionName{

	@Autowired BoardService board_service;
	
	@PostMapping(value="comment_write", produces = "application/json; charset=utf-8")
	public void commentWrite(@RequestBody Map<String, Object> map, HttpSession session) {
	
		BoardCommentDTO dto = new BoardCommentDTO();
		dto.setComment_writer((String)session.getAttribute(LOGIN));
		dto.setComment_board_seq(Integer.parseInt((String)map.get("board_seq")));
		dto.setComment_content((String)map.get("comment_content"));
		dto.setComment_secret((String)map.get("comment_secret"));
		dto.setComment_secret_pwd((String)map.get("comment_secret_pwd"));
	
		
		board_service.commentWrite(dto);
	}
	
	@PostMapping(value="comment_update", produces = "application/json; charset=utf-8")
	public void commentModify(@RequestBody Map<String, Object> map, HttpSession session) {
	
		BoardCommentDTO dto = new BoardCommentDTO();
		dto.setComment_seq(Integer.parseInt((String) map.get("update_comment_seq")));
		dto.setComment_content((String)map.get("update_comment_content"));
		dto.setComment_secret((String)map.get("update_comment_secret"));
		dto.setComment_secret_pwd((String)map.get("update_comment_secret_pwd"));
	
		
		board_service.commentModify(dto);
	}
	
	
	@GetMapping(value="replyData/{board_seq}", produces = "application/json; charset=utf-8") 
	public List<BoardCommentDTO> replyData(@PathVariable int board_seq){
	
		return board_service.getCommentLiset(board_seq); 
	
	}
	
	@PostMapping(value="comment_delete", produces = "application/json; charset=utf-8")
	public String boardDelte(@RequestParam("comment_seq") int comment_seq, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		System.out.println("board_seq : " + comment_seq);
		
		int result = board_service.commentDelete(comment_seq,request); 
		
		System.out.println("message : " + result);
		
		return String.valueOf(result);
		 
	}
	 
	
}
