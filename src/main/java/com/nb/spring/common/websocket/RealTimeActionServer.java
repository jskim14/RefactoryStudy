package com.nb.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class RealTimeActionServer extends TextWebSocketHandler {

	private Map<String,WebSocketSession> clients = new HashMap<String,WebSocketSession>();
	private List<String> msgList = new ArrayList<String>();
	private String time = "{\"min\":1,\"sec\":11}";
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		if(message.getPayload().contains("nickName") || message.getPayload().contains("system")) {
			msgList.add(message.getPayload());
			System.out.println(message.getPayload());
		}else if(message.getPayload().contains("min")) {
			time = message.getPayload();
		}
		Iterator<String> keys = clients.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			WebSocketSession ss = clients.get(key);
			if(message.getPayload().contains("nickName")) {
				ss.sendMessage(new TextMessage("" + msgList));
				ss.sendMessage(new TextMessage("" + time));
			}
		}
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		clients.put(session.getId(),session);
		Iterator<String> keys = clients.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			WebSocketSession ss = clients.get(key);
			ss.sendMessage(new TextMessage("" + clients.size()));
			ss.sendMessage(new TextMessage("" + time));
			if(msgList.size()!=0) {
				ss.sendMessage(new TextMessage("" + msgList));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		clients.remove(session.getId());
		Iterator<String> keys = clients.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			WebSocketSession ss = clients.get(key);
			ss.sendMessage(new TextMessage("" + clients.size()));
			ss.sendMessage(new TextMessage("" + time));
		}
	}
	
}
