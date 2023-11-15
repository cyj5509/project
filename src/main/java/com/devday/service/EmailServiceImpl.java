package com.devday.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.devday.dto.EmailDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class EmailServiceImpl implements EmailService {

	// MailSender 인터페이스 extends JavaMailSender 인터페이스
	private final JavaMailSender mailSender; 
	
	// 메일 발송 관련 메서드: 회원가입과 아이디 및 비밀번호 찾기, 임시 비밀번호 발송 시 사용
	@Override
	public void sendMail(EmailDTO emailDTO) {
		// 메일 구성정보를 담당하는 객체(받는 사람, 보내는 사람, 받는 사람의 메일 주소, 본문 내용 등)
		MimeMessage mimeMessage = mailSender.createMimeMessage();

		try {
			// 수신인의 메일 주소
			mimeMessage.addRecipient(RecipientType.TO, new InternetAddress(emailDTO.getReceiverMail()));
			// 발신인의 메일 주소와 발신인명
			mimeMessage.addFrom(new InternetAddress[] { new InternetAddress(emailDTO.getSenderMail(), emailDTO.getSenderName()) });
			// 메일 제목
			mimeMessage.setSubject(emailDTO.getSubject(), "utf-8");
			// 메일 내용
			mimeMessage.setText(emailDTO.getContent(), "utf-8");
			
			mailSender.send(mimeMessage);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
