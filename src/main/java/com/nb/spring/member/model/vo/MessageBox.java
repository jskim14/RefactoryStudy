package com.nb.spring.member.model.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessageBox {
	private int msgNo;
	private String msgContent;
	private Date msgsendDate;
	private Member sender;
	private Member receiver;
	private String msgCheckYN;
}
