package com.nb.spring.common.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
	private final RealTimeActionServer webSocketHandler;
	private final MessageBox mb;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
	    
        registry.addHandler(webSocketHandler, "ws/chat").setAllowedOrigins("*");
        registry.addHandler(mb, "ws/messagebox").setAllowedOrigins("*");
    }
}
