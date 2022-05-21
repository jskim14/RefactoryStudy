package com.nb.spring.report.model.service;

import java.util.List;
import java.util.Map;

import com.nb.spring.report.model.vo.Report;
import com.nb.spring.report.model.vo.ReportImage;

public interface ReportService {
	
	List<Report> selectReportList(int cPage, int numPerPage);
	int reportCount();
	int insertReport(Report r);
	int insertReportResult(Map<String,String>param);
	int changeStatus(String productNo);
	Report reportCon(String productNo);
}
