package com.nb.spring.cs.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.nb.spring.cs.model.vo.Notice;
import com.nb.spring.cs.model.vo.Qna;


public interface CustomerServiceService {
	
	
	List<Notice> selectNoticeList(int cPage, int numPerPage);
	int noticeCount();
	
	List<Qna> selectQnaList(int cPage, int numPerPage);
	int qnaCount();
	
	int insertNotice(Map<String,String> param);
	int insertQuestion(Map<String,String> param2);
	
	int deleteNotice(int noticeNo);
	Qna qnaContent(int qnaNo);
	
	int insertAnswer(Map<String,String>param);
	
	List<Qna> myQnaList(String memberNo);

}
