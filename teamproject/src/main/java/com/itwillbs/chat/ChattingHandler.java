package com.itwillbs.chat;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;


public class ChattingHandler extends TextWebSocketHandler{
	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		UriComponents uriComponents = UriComponentsBuilder.fromUriString(session.getUri().toString()).build();
		logger.info("WebSocket URI: " + session.getUri());
		String encodedUserName = uriComponents.getQueryParams().getFirst("userName");
		if (encodedUserName != null) {
			String userName = URLDecoder.decode(encodedUserName, "UTF-8");
			session.getAttributes().put("userName", userName);
			String welcomeMessage = userName + "님이 입장하셨습니다.";
			session.sendMessage(new TextMessage(welcomeMessage));
		} else {
			logger.warn("사용자 ID가 제공되지 않았습니다.");
		}
		sessionList.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String userName = (String) session.getAttributes().get("userName");
		logger.info(userName + ": " + message);
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(userName + ":" + message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String userName = (String) session.getAttributes().get("userName");
		sessionList.remove(session);
		
		logger.info(userName + "님이 퇴장하셨습니다.");
	}
}