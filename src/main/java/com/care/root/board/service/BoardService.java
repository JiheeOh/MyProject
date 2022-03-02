package com.care.root.board.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.board.dto.BoardCommentDTO;
import com.care.root.board.dto.BoardDTO;
import com.care.root.config.PagingVO;

public interface BoardService {

	public void selectBoardList(Model model, int page_number);
	public String boardWriteSave(MultipartHttpServletRequest mul,HttpServletRequest request);
	public void boardDetailView(int board_seq, Model model);
	public String boardModify(MultipartHttpServletRequest mul, HttpServletRequest request);
	public int boardDelete(int board_seq, String board_file_url, HttpServletRequest request); 
	public int commentDelete(int comment_seq, HttpServletRequest request); 
	
	// 게시물 총 갯수
	public int boardCount();
	// 페이징 처리 게시글 조회
	public List<BoardDTO> boardSelect(PagingVO vo);
	
	public void commentWrite(BoardCommentDTO dto);
	public List<BoardCommentDTO> getCommentLiset(int board_seq);
	public void commentModify(BoardCommentDTO dto);
	
}
