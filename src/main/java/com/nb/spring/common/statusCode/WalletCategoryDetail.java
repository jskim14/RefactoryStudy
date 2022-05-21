package com.nb.spring.common.statusCode;

public enum WalletType {
	PROFIT(0),
	FAILURE(1),
	CHARGE(2),
	BID(3),
	BUYNOW(4)
	;
	
	private final int value;
	
	WalletType(int value){ this.value = value;}
	
	public int getValue() {return value;}
}
