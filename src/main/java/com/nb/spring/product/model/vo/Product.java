package com.nb.spring.product.model.vo;

import java.sql.Date;
import java.util.List;

import com.nb.spring.member.model.vo.Member;
import com.nb.spring.member.model.vo.Wallet;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Product {
	private String productNo;
	private String productCategory;
	private String productName;
	private Member seller;
	private String nowBidPrice;
	private Member highestBidder;
	private String minBidPrice;
	private String productContent;
	private Date productEnrollDate;
	private String productStatus;
	private String bidUnit;
	private Date startDate;
	private Date endDate;
	private String finalPrice;
	private String buyNowPrice;
	private String extendYn;
	private String permissionYn;
	private String readCount;
	private String bannerImageName;
	private String rejectReason;
	private List<ProductImage> images;
	
}
