package com.care.root.mybatis.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.care.root.board.dto.BoardCommentDTO;
import com.care.root.board.dto.BoardDTO;
import com.care.root.config.PagingVO;

public interface BoardMapper {

	public int selectBoardCount();
	public List<BoardDTO> selectAllBoardList(@Param("page_start_number") int start ,@Param("page_end_number") int end);
	public int boardWriteSave(BoardDTO dto);
	public BoardDTO boardDetailView(int board_seq);
	public void boardViewCount(int board_seq);
	public int boardModify(BoardDTO dto);
	public int boardDelete(int board_seq);
	public int commentDelete(int comment_seq);
	
	// 게시물 총 갯수
	public int boardCount();
	// 페이징 처리 게시글 조회
	public List<BoardDTO> boardSelect(PagingVO vo);
	
	public void commentWrite(BoardCommentDTO dto);
	public List<BoardCommentDTO> getCommentLiset(int board_seq); 
	public void commentModify(BoardCommentDTO dto);
	
}
