package com.nb.spring.common.statusCode;

public enum ProductType {
	ON_SALE("0"),
	DEPOSIT("1"),
	SHIPPING("2"),
	ARRIVAL("3"),
	DONE("4"),
	REPORT("5"),
	FAILURE("6")
	;
	 private final String status;

	ProductType(String status) {
		this.status = status;
	}
	public String getStatus() {
		return status;
	}
}
