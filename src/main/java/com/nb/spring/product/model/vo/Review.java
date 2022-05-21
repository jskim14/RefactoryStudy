package com.nb.spring.product.model.vo;

import java.sql.Date;

import com.nb.spring.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Review {
	private Member seller;
	private String reviewContent;
	private String reviewRate;
	private Date reviewDate;
}
