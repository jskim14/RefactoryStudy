package com.nb.spring.member.model.service;

public interface SendEmailService {
	public String mailSend(String userEmail) throws Exception;
	public String mailSendNewPassword(String userEmail) throws Exception;
	
}
