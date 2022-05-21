package com.nb.spring.common.statusCode;

public enum WalletCategoryType {
	DEPOSIT("0"),
	PAY("1")
	;
	
	private final String status;

	WalletCategoryType(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}
}
