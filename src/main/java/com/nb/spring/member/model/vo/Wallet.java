package com.nb.spring.member.model.vo;

import java.sql.Date;

import com.nb.spring.product.model.vo.Product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Wallet {
	private Member memberNo;
	private String category;
	private String categoryDetail;
	private Date tradeDate;
	private String amount;
	private Product productNo;
}
