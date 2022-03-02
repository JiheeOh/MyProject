package com.care.root.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@RequestMapping("chatting")
public class ChattingHandler extends TextWebSocketHandler{
	
	//세션 리스트
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    private static Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
    
    //클라이언트가 연결 되었을 때 실행
    @Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("#ChattingHandler,afterConnectionEstablished");

		sessionList.add(session);
        logger.info(session.getId()+"님이 입장하셨습니다. "); 
		
	}

  //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("#ChattingHandler,handleTextMessage");
		System.out.println("message :  "+ message );
		
		//모든 유저에게 메세지 출력
        for(WebSocketSession sess : sessionList){
            sess.sendMessage(new TextMessage(message.getPayload()));
            
        	}
		

	}


	//클라이언트 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("#ChattingHandler,afterConnectionClosed");
		sessionList.remove(session);
		
	    logger.info(session.getId()+"님이 퇴장하셨습니다. ");
	    
	   
		
	}
   


    
    
}
