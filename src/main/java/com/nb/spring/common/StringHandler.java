package com.nb.spring.common;

public class StringHandler {
	public static String removeComma(String commaStr) {

		String[] sArr = commaStr.split(",");
		String nonComma = String.join("", sArr);
		return nonComma;
	}
}
