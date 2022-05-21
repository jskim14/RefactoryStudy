package com.nb.spring.cs.model.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nb.spring.cs.model.vo.Notice;
import com.nb.spring.cs.model.vo.Qna;

@Repository
public class CustomerServiceDaoImpl implements CustomerServiceDao {

	@Override
	public List<Notice> selectNoticeList(SqlSessionTemplate session, int cPage, int numPerPage) {
		return session.selectList("cs.selectNoticeList", null, new RowBounds((cPage-1)*numPerPage, numPerPage));
	}
	
	@Override
	public int noticeCount(SqlSessionTemplate session) {
		return session.selectOne("cs.noticeCount");
	}

	@Override
	public List<Qna> selectQnaList(SqlSessionTemplate session, int cPage, int numPerPage) {
		return session.selectList("cs.selectQnaList", null, new RowBounds((cPage-1)*numPerPage, numPerPage));
	}
	@Override
	public int qnaCount(SqlSessionTemplate session) {
		return session.selectOne("cs.qnaCount");
	}
	
	@Override
	public int insertNotice(SqlSessionTemplate session, Map<String,String> param) {
		return session.insert("cs.insertNotice",param);
	}
	@Override
	public int insertQuestion(SqlSessionTemplate session, Map<String,String> param2) {
		return session.insert("cs.insertQuestion",param2);
	}

	@Override
	public int deleteNotice(SqlSessionTemplate session, int noticeNo) {
		return session.update("cs.deleteNotice",noticeNo);
	}

	@Override
	public Qna qnaContent(SqlSessionTemplate session, int qnaNo) {
		return session.selectOne("cs.qnaContent",qnaNo);
	}

	@Override
	public int insertAnswer(SqlSessionTemplate session, Map<String,String>param) {
		return session.update("cs.insertAnswer", param);
	}

	@Override
	public List<Qna> myQnaList(SqlSessionTemplate session, String memberNo) {
		return session.selectList("cs.myQna", memberNo);
	}
	
	
	
	
	
	

}
