package com.nb.spring.common;

public enum DealType {
	INPUT(0),
	OUTPUT(1);
	
	private final int value;
	
	DealType(int value){ this.value = value;}
	
	public int getValue() {return value;}
}
