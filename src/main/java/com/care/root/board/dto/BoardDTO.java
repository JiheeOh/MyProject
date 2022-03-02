package com.care.root.board.dto;

import java.util.Date;


public class BoardDTO {
    
    private int board_seq;
	private String board_category;
	private String board_writer;
	private String board_title;
	private Date board_write_time;
	private int board_view_count;
	private String board_file_url;
	private String board_content;
	private int board_like_count;
	private String board_secret;
	private String board_secret_pwd;
	
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public Date getBoard_write_time() {
		return board_write_time;
	}
	public void setBoard_write_time(Date board_write_time) {
		this.board_write_time = board_write_time;
	}
	public int getBoard_view_count() {
		return board_view_count;
	}
	public void setBoard_view_count(int board_view_count) {
		this.board_view_count = board_view_count;
	}
	public String getBoard_file_url() {
		return board_file_url;
	}
	public void setBoard_file_url(String board_file_url) {
		this.board_file_url = board_file_url;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public int getBoard_like_count() {
		return board_like_count;
	}
	public void setBoard_like_count(int board_like_cunt) {
		this.board_like_count = board_like_cunt;
	}
	public String getBoard_secret() {
		return board_secret;
	}
	public void setBoard_secret(String board_secret) {
		this.board_secret = board_secret;
	}
	public String getBoard_secret_pwd() {
		return board_secret_pwd;
	}
	public void setBoard_secret_pwd(String board_secret_pwd) {
		this.board_secret_pwd = board_secret_pwd;
	}
	
	
	
	
	
}
