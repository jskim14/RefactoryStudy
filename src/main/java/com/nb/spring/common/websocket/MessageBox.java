package com.nb.spring.common.websocket;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class MessageBox extends TextWebSocketHandler{
	private Map<String,WebSocketSession> clients = new HashMap<String,WebSocketSession>();
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(message);
		Iterator<String> keys = clients.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			WebSocketSession ss = clients.get(key);
			ss.sendMessage(message);
		}
	}
	
	public void actionMessage(String msg) throws Exception{
		Iterator<String> keys = clients.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			WebSocketSession ss = clients.get(key);
			ss.sendMessage(new TextMessage(msg));
		}
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		clients.put(session.getId(),session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		clients.remove(session.getId());
	}
	
	
}
