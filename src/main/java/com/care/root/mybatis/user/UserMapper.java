package com.care.root.mybatis.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.care.root.config.PagingVO;
import com.care.root.user.dto.UserDTO;

public interface UserMapper {

	public int userSignup(UserDTO dto);
	public UserDTO userCheck(String user_id);
	public UserDTO getUserSessionId(String session_id);
	public void saveSession(Map<String, Object> dates);
	public ArrayList<UserDTO> userBoard(@Param("page_start_number") int start ,@Param("page_end_number") int end);
	public UserDTO userInfo(String user_id);
	public int userModify(UserDTO dto);
	public int userDelete(String user_id);
	public int userIdCheck(String user_id);
	public int selectUserCount();
	
	
	// �Խù� �� ����
	public int countUserBoard();
	// ����¡ ó�� �Խñ� ��ȸ
	public List<UserDTO> selectUserBoard(PagingVO vo);
	
}
