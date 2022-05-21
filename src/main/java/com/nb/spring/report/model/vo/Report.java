package com.nb.spring.report.model.vo;

import java.sql.Date;
import java.util.List;

import com.nb.spring.member.model.vo.Member;
import com.nb.spring.product.model.vo.Product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Report {
	private Product reportProduct;
	private Member reportMember;
	private String reportReason;
	private String reportResult;
	private Date reportDate;
	private List<ReportImage> reportImages;
	
}
