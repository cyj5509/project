package com.devday.service;

import java.util.UUID;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.devday.domain.MemberVO;
import com.devday.dto.EmailDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class EmailServiceImpl implements EmailService {

	// email-config.xml의 <bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
	// interface MailSender -> interface JavaMailSender extends MailSender -> class JavaMailSenderImpl implements JavaMailSender
	private final JavaMailSender mailSender; // private final MailSender mailSender: 기능상 제한될 가능성 있음
	
	// spring-security.xml의 <bean id="bCryptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder">
	// interface PasswordEncoder -> class BCryptPasswordEncoder implements PasswordEncoder
	private final PasswordEncoder passwordEncoder;
	
	private final MemberService memberService; // interface MemberService -> class MemberServiceImpl implements MemberService

	// 메일 발송 관련 메서드
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
	
	@Override
	public ResponseEntity<String> sendResetPw(MemberVO memberVO, String receiverMail) {

		ResponseEntity<String> entity = null;
				
		// 임시 비밀번호 생성 및 암호화
		// String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // 랜덤 UUID를 문자열로 반환하며, 중간에 들어가는 "-"를 제거
		// String tempPassword = uuid.substring(0, 10); // uuid.substring(beginIndex, endIndex): 마지막 Index 제외(0부터 시작)
		String tempPassword = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
		String encoPassword = passwordEncoder.encode(tempPassword); // 암호화된 비밀번호

		// DB에 암호화된 비밀번호 업데이트
		memberService.updatePw(memberVO.getMem_id(), encoPassword);
		
	    try {
	        // EmailDTO 생성 및 발송
	        EmailDTO emailDTO = EmailDTO.ofResetPw(receiverMail, tempPassword); // ofResetPw 정적 팩토리 메서드 호출 
	        
	        log.info("발송할 이메일 정보: " + emailDTO); // ofResetPw의 receiverMail 및 tempPassword 값 포함한 정보 출력
	        
	        
	        entity = new ResponseEntity<>("success", HttpStatus.OK); // HTTP 상태 코드(200)
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // HTTP 상태 코드(500)
	    }
		return entity;
	}

}
