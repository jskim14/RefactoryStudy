package com.nb.spring.cs.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.ui.Model;

import com.nb.spring.cs.model.vo.Notice;
import com.nb.spring.cs.model.vo.Qna;

public interface CustomerServiceDao {
	
	List<Notice> selectNoticeList(SqlSessionTemplate session, int cPage, int numPerPage);
	int noticeCount(SqlSessionTemplate session);
	List<Qna> selectQnaList(SqlSessionTemplate session, int cPage, int numPerPage);
	int qnaCount(SqlSessionTemplate session);
	
	int insertNotice(SqlSessionTemplate session, Map<String,String> param);
	int insertQuestion(SqlSessionTemplate session, Map<String,String> param2);
	
	int deleteNotice(SqlSessionTemplate session, int noticeNo);
	Qna qnaContent(SqlSessionTemplate session, int qnaNo);
	
	int insertAnswer(SqlSessionTemplate session, Map<String,String>param);
	
	List<Qna> myQnaList(SqlSessionTemplate session, String memberNo);
}
