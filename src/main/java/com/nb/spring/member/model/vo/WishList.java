package com.nb.spring.member.model.vo;

import com.nb.spring.product.model.vo.Product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WishList {
	private Product productNo;
	private Member memberNo;
}
