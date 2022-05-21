package com.nb.spring.chat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessage {
    private String content;
    private String sender;
    private MessageType type;

    public enum MessageType {
        CHAT, LEAVE, JOIN
    }

}
