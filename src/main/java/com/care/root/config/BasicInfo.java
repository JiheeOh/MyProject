package com.care.root.config;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BasicInfo {

	public static String currentTime() {
		
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
				
		Date time = new Date();
				
		String current_time = format.format(time);
		 
		return current_time;
				
	}
	
	
	public static long longTime(){
	
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date = new Date();
		
		String current_time = format.format(date);
		
		try {
			date = format.parse(current_time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		long long_current_tiem = date.getTime();
		
		return long_current_tiem;
				
	}
	
	public static String currentTime(String args) { 
		
		Date nowDate = new Date(); 
		System.out.println("���� ���� �� : " + nowDate); 
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//���ϴ� ������ ���� ���� 
		String strNowDate = simpleDateFormat.format(nowDate); 
		//������ �������� ��ȯ
		System.out.println("���� ���� �� : " + strNowDate); 
		
		return strNowDate;
		
	}
	

	
}
