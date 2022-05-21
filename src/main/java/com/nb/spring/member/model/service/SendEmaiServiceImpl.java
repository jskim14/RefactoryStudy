package com.nb.spring.member.model.service;

import javax.mail.Message.RecipientType;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class SendEmaiServiceImpl implements SendEmailService{
	
	private final int TEMPPASSWORD_LENGTH = 8;
	private final int TEMPCODE_LENGTH = 6;
	private final String SENDER_ADDRESS = "yangdaeyeol9245@naver.com";
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public String mailSend(String userEmail) throws Exception{
		//SimpleMailMessage message = new SimpleMailMessage();
		
		MimeMessage message = mailSender.createMimeMessage();
		message.addRecipients(RecipientType.TO, userEmail);
		//message.setTo(userEmail);
		message.setFrom(SENDER_ADDRESS);
		message.setSubject("NBIF 회원가입 이메일 인증");
		
		String content="";
		content+= "<div style='margin:100px;'>";
		content+= "<h1> 안녕하세요 NBIF입니다. </h1>";
		content+= "<br>";
		content+= "<p>아래 코드를 회원가입 창으로 돌아가 입력해주세요<p>";
		content+= "<br>";
		content+= "<p>감사합니다!<p>";
		content+= "<br>";
		content+= "<div align='center' style='border:1px solid black; font-family:verdana';>";
		content+= "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
		content+= "<div style='font-size:130%'>";
	    content+= "CODE : <strong>";
	    String tempCode=getTempCode();
	    content+= tempCode+"</strong><div><br/> ";
	    content+= "</div>";
		
		
		
	    message.setText(content,"utf-8","html");		
	  
		mailSender.send(message);
		
		return tempCode;
	}
	
	private String getTempCode() {
		
		char[] charSet = new char[] {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		
		String str="";
		
		int idx =0;
		
		for(int i=0; i<TEMPCODE_LENGTH;i++) {
			idx = (int)(charSet.length * Math.random());
			str+=charSet[idx];
		}
		
		
		return str;
	}

	@Override
	public String mailSendNewPassword(String userEmail) throws Exception {
	//SimpleMailMessage message = new SimpleMailMessage();
		
		MimeMessage message = mailSender.createMimeMessage();
		message.addRecipients(RecipientType.TO, userEmail);
		//message.setTo(userEmail);
		message.setFrom(SENDER_ADDRESS);
		message.setSubject("NBIF 임시 비밀번호 발급");
		
		String content="";
		content+= "<div style='margin:100px;'>";
		content+= "<h1> 안녕하세요 NBIF입니다. </h1>";
		content+= "<br>";
		content+= "<p>임시비밀번호입니다. 빠른 시일 내에 변경해주세요.<p>";
		content+= "<br>";
		content+= "<p>감사합니다!<p>";
		content+= "<br>";
		content+= "<div align='center' style='border:1px solid black; font-family:verdana';>";
		content+= "<h3 style='color:blue;'>임시 비밀번호입니다.</h3>";
		content+= "<div style='font-size:130%'>";
	    content+= "CODE : <strong>";
	    String tempPw = getTempPassword();
	    content+= tempPw+"</strong><div><br/> ";
	    content+= "</div>";
		
		
		
	    message.setText(content,"utf-8","html");		
	  
		mailSender.send(message);
		
		return tempPw;
	}
	
	private String getTempPassword() {
		char[] charSet = new char[] {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
		
		String str="";
		
		int idx =0;
		
		for(int i=0; i<TEMPPASSWORD_LENGTH;i++) {
			idx = (int)(charSet.length * Math.random());
			str+=charSet[idx];
		}
		str+="!";
		
		
		return str;
	}
	
	
	
	
	
	
}














