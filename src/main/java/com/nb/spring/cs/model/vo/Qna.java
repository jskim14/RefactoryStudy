package com.nb.spring.cs.model.vo;

import java.sql.Date;

import com.nb.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Qna {
	private int qnaNo;
	private String qnaTitle;
	private String qnaContent;
	private Member writer;
	private String qnaAnswer;
	private Date questionDate;
	private Date answerDate;
}
