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
		System.out.println("포맷 지정 전 : " + nowDate); 
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//원하는 데이터 포맷 지정 
		String strNowDate = simpleDateFormat.format(nowDate); 
		//지정한 포맷으로 변환
		System.out.println("포맷 지정 후 : " + strNowDate); 
		
		return strNowDate;
		
	}
	

	
}
