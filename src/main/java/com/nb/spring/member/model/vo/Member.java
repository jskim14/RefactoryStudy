package com.nb.spring.member.model.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	private String memberNo;
	private String memberName;
	private String password;
	private String phone;
	private String email;
	private String nickName;
	private String address;
	private String deliveryAddress;
	private Date enrollDate;
	private String balance;
	private String rank;
	private List<Wallet> walletList;
//	private List<WishList> WishList;
}
