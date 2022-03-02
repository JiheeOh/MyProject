package com.care.root.board.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.board.dto.BoardCommentDTO;
import com.care.root.board.dto.BoardDTO;
import com.care.root.config.BasicInfo;
import com.care.root.config.FileService;
import com.care.root.config.FileServiceImpl;
import com.care.root.config.PagingVO;
import com.care.root.mybatis.board.BoardMapper;
import com.care.root.user.session.UserSessionName;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper board_mapper;
	
	
	Date sql_date;
	
	@Override
	public void selectBoardList(Model model, int page_number) {
		

		System.out.println("data :");
		
		int page_letter = 3; //한페이지에 몇 개의 글을 보여줄지
		int board_all_count = board_mapper.selectBoardCount(); // 글 총 개수 얻어오기
		
		int repeat = board_all_count / page_letter; // 총 페이지 수
		if(board_all_count % page_letter != 0) {
			repeat += 1;
		}
		
		// num = 1 * 3 
		int end_number = page_number * page_letter; 
		// num = 3 + 1 - 3
		int start_number = end_number + 1 - page_letter;
		
		System.out.println("allCount : " + board_all_count + " end : " + end_number + " start : " + start_number + " repeat : " + repeat );
		
		model.addAttribute("repeat", repeat);
		
		model.addAttribute("board_list", board_mapper.selectAllBoardList(start_number, end_number));
		

	}

	@Override
	public String boardWriteSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		BoardDTO dto = new BoardDTO();
		dto.setBoard_title(mul.getParameter("board_title"));
		dto.setBoard_category(mul.getParameter("board_category"));
		dto.setBoard_content(mul.getParameter("board_content"));
		
		
		if(mul.getParameter("board_secret") == null || mul.getParameter("board_secret").equals("null")) {
			dto.setBoard_secret("nan");
			dto.setBoard_secret_pwd("nan");
		}else {
			dto.setBoard_secret(mul.getParameter("board_secret"));
			dto.setBoard_secret_pwd(mul.getParameter("board_secret_pwd"));
		}
		
		HttpSession session = request.getSession();
		dto.setBoard_writer((String) session.getAttribute(UserSessionName.LOGIN));
		
		MultipartFile file = mul.getFile("board_file_url");
		FileService file_service = new FileServiceImpl();
		if(file.getSize() != 0) {
			
			dto.setBoard_file_url(file_service.saveBoardImage(file));
			
		}else {
			
			
			dto.setBoard_file_url("nan");
			
		}
		
		int result = board_mapper.boardWriteSave(dto);
		String msg, url;
		String path = request.getContextPath();
		if(result == 1) {
			msg = "게시글이 등록 되었습니다.";
			url = path + "/board/board_list";
		}else {
			msg = "게시글 등록 중 문제 발생";
			url = path + "/board/modify_form";
		}
		
		
		return file_service.getMessage(msg, url);
		
	}

	@Override
	public void boardDetailView(int board_seq, Model model) {
		
		model.addAttribute("board_data", board_mapper.boardDetailView(board_seq) );
		board_mapper.boardViewCount(board_seq);
		
	}

	@Override
	public String boardModify(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		BoardDTO dto = new BoardDTO();
		dto.setBoard_seq(Integer.parseInt(mul.getParameter("board_seq")));
		dto.setBoard_title(mul.getParameter("board_title"));
		dto.setBoard_category(mul.getParameter("board_category"));
		dto.setBoard_content(mul.getParameter("board_content"));
		
		Date now = new Date();
		
		dto.setBoard_write_time(now);
		
		Date time = new Date();
		time.setTime(BasicInfo.longTime());
		
		try {
			dto.setBoard_write_time(time);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		if(mul.getParameter("board_secret") == null || mul.getParameter("board_secret").equals("null")) {
			
			dto.setBoard_secret("nan");
			dto.setBoard_secret_pwd("nan");
			
		}else {
			
			dto.setBoard_secret(mul.getParameter("board_secret"));
			dto.setBoard_secret_pwd(mul.getParameter("board_secret_pwd"));
			
		}
		
		HttpSession session = request.getSession();
		dto.setBoard_writer((String) session.getAttribute(UserSessionName.LOGIN));
		
		MultipartFile file = mul.getFile("board_file_url");
		FileService file_service = new FileServiceImpl();
		if(file.getSize() != 0) {
			
			dto.setBoard_file_url(file_service.saveBoardImage(file));
			file_service.deleteBoardImage(mul.getParameter("origin_file_name"));
			
		}else {
			
			dto.setBoard_file_url("nan");
			
		}
		
		int result = board_mapper.boardModify(dto);
		String msg, url;
		String path = request.getContextPath();
		if(result == 1) {
			msg = "게시글이 수정 완료 되었습니다.";
			url = path + "/board/board_list";
		}else {
			msg = "게시글 수정 중 문제 발생";
			url = path + "/board/board_modify_form";
		}
		
		return file_service.getMessage(msg, url);
	}

	@Override
	public int boardDelete(int board_seq, String board_file_url, HttpServletRequest request) {
		
		FileService file_service = new FileServiceImpl();
		if(!board_file_url.equals("nan")) {
			file_service.deleteProfileImage(board_file_url);
		}
		
		int result = board_mapper.boardDelete(board_seq);
		System.out.println("result : " + result);
		
		return result;
		
	}

	@Override
	public int boardCount() {
		
		return board_mapper.boardCount();
		
	}

	@Override
	public List<BoardDTO> boardSelect(PagingVO vo) {
		
		return board_mapper.boardSelect(vo);
		
	}

	@Override
	public void commentWrite(BoardCommentDTO dto) {
		
		board_mapper.commentWrite(dto);
		
	}

	@Override
	public List<BoardCommentDTO> getCommentLiset(int board_seq) {
		
		return board_mapper.getCommentLiset(board_seq);
	}

	@Override
	public int commentDelete(int comment_seq, HttpServletRequest request) {
		
		int result = board_mapper.commentDelete(comment_seq);
		System.out.println("result : " + result);
		
		return result;
		
	}

	@Override
	public void commentModify(BoardCommentDTO dto) {
		
		board_mapper.commentModify(dto);
		
	}

}
