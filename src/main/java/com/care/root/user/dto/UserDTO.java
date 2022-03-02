package com.care.root.user.dto;

import java.sql.Date;

public class UserDTO {

	private String user_id; 
    private String user_pwd;
    private String user_email;
    private String user_address_number1;
    private String user_address_number2;
    private String user_address_number3;
    private String user_profile;
    private String session_id;
	private Date limit_time;
    private String identity;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}	
	public String getUser_address_number1() {
		return user_address_number1;
	}
	public void setUser_address_number1(String user_address_number1) {
		this.user_address_number1 = user_address_number1;
	}
	public String getUser_address_number2() {
		return user_address_number2;
	}
	public void setUser_address_number2(String user_address_number2) {
		this.user_address_number2 = user_address_number2;
	}
	public String getUser_address_number3() {
		return user_address_number3;
	}
	public void setUser_address_number3(String user_address_number3) {
		this.user_address_number3 = user_address_number3;
	}
	public String getUser_profile() {
		return user_profile;
	}
	public void setUser_profile(String user_profile) {
		this.user_profile = user_profile;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getSession_id() {
		return session_id;
	}
	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}
	public Date getLimit_time() {
		return limit_time;
	}
	public void setLimit_time(Date limit_time) {
		this.limit_time = limit_time;
	}
	
	
}
