package com.nb.spring.common.statusCode;

public enum WalletCategoryDetail {
	SALES_PROFIT("0"),
	BID_FAILURE("1"),
	EMONEY_CHARGE("2"),
	BID_PRICE("3"),
	BUYNOW_PRICE("4")
	;
	
	private final String type;

	WalletCategoryDetail(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
}
