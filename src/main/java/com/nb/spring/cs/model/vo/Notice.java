package com.nb.spring.cs.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.nb.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Notice {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
//	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date noticeWriteDate;
	private Member memberNo;
}
