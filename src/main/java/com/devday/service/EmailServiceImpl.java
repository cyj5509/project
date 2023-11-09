package com.devday.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.devday.dto.EmailDTO;

import lombok.RequiredArgsConstructor;

// 현재는 mapper 인터페이스를 참조하지 않음
@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

	// 주입 작업: email-config.xml 파일의 bean으로 주입
	// <bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
	private final JavaMailSender mailSender;

	@Override
	public void sendMail(EmailDTO dto, String message) {
		// 메일 구성정보를 담당하는 객체(받는 사람, 보내는 사람, 받는 사람의 메일 주소, 본문 내용 등)
		MimeMessage mimeMessage = mailSender.createMimeMessage();

		try {
			// 받는 사람의 메일 주소
			mimeMessage.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiverMail()));
			// 보내는 사람(메일, 이름)
			mimeMessage.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName()) });
			// 메일 제목
			mimeMessage.setSubject(dto.getSubject(), "utf-8");
			// 본문 내용
			mimeMessage.setText(message, "utf-8");
			
			mailSender.send(mimeMessage);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
