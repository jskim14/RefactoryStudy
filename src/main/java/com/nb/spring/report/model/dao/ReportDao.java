package com.nb.spring.report.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.nb.spring.report.model.vo.Report;
import com.nb.spring.report.model.vo.ReportImage;

public interface ReportDao {
		
	List<Report> selectReportList(SqlSessionTemplate session, int cPage, int numPerPage);
	List<ReportImage> selectReportImages(SqlSessionTemplate session, String productNo);
	int reportCount(SqlSessionTemplate session);
	
	int insertReport(SqlSessionTemplate session, Report r);
	int insertReportImage(SqlSessionTemplate session, ReportImage ri);
	
	int insertReportResult(SqlSessionTemplate session, Map<String,String>param);
	
	int changeStatus(SqlSessionTemplate session, String productNo);
	
	Report reportCon(SqlSessionTemplate session, String productNo);

}
