package com.nb.spring.common.statusCode;

public enum DealType {
	DEPOSIT("0"),
	PAY("1")
	;
	
	private final String status;

	DealType(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}
}
