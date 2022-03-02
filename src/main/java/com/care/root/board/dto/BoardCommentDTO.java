package com.care.root.board.dto;

import java.util.Date;

public class BoardCommentDTO {

	private int comment_seq;
	private int comment_board_seq;
	private String comment_writer;
	private Date comment_write_time;
	private String comment_content;
	private int comment_like_count;
	private String comment_secret;
	private String comment_secret_pwd;
	
	public int getComment_seq() {
		return comment_seq;
	}
	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}
	public int getComment_board_seq() {
		return comment_board_seq;
	}
	public void setComment_board_seq(int comment_board_seq) {
		this.comment_board_seq = comment_board_seq;
	}
	public String getComment_writer() {
		return comment_writer;
	}
	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}
	public Date getComment_write_time() {
		return comment_write_time;
	}
	public void setComment_write_time(Date comment_write_time) {
		this.comment_write_time = comment_write_time;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public int getComment_like_count() {
		return comment_like_count;
	}
	public void setComment_like_count(int comment_like_count) {
		this.comment_like_count = comment_like_count;
	}
	public String getComment_secret() {
		return comment_secret;
	}
	public void setComment_secret(String comment_secret) {
		this.comment_secret = comment_secret;
	}
	public String getComment_secret_pwd() {
		return comment_secret_pwd;
	}
	public void setComment_secret_pwd(String comment_secret_pwd) {
		this.comment_secret_pwd = comment_secret_pwd;
	}
	
	
	
}
