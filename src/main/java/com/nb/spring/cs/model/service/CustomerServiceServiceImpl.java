package com.nb.spring.cs.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.nb.spring.cs.model.dao.CustomerServiceDao;
import com.nb.spring.cs.model.vo.Notice;
import com.nb.spring.cs.model.vo.Qna;

@Service
public class CustomerServiceServiceImpl implements CustomerServiceService {
	@Autowired
	private CustomerServiceDao dao;
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Notice> selectNoticeList(int cPage, int numPerPage) {
		return dao.selectNoticeList(session, cPage, numPerPage);
	}
	
	@Override
	public int noticeCount() {
		return dao.noticeCount(session);
	}

	@Override
	public List<Qna> selectQnaList(int cPage, int numPerPage) {
		return dao.selectQnaList(session, cPage, numPerPage);
	}
	@Override
	public int qnaCount() {
		return dao.qnaCount(session);
	}

	@Override
	public int insertNotice(Map<String,String> param) {
		return dao.insertNotice(session, param);
	}
	
	@Override
	public int insertQuestion(Map<String,String> param2) {
		return dao.insertQuestion(session, param2);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return dao.deleteNotice(session, noticeNo);
	}

	@Override
	public Qna qnaContent(int qnaNo) {
		return dao.qnaContent(session, qnaNo);
	}

	@Override
	public int insertAnswer(Map<String,String>param) {
		return dao.insertAnswer(session, param);
	}

	@Override
	public List<Qna> myQnaList(String memberNo) {
		return dao.myQnaList(session, memberNo);
	}
	
	
	
	
	
	
	
}
