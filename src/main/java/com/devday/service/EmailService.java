package com.devday.service;

import org.springframework.http.ResponseEntity;

import com.devday.domain.MemberVO;
import com.devday.dto.EmailDTO;

public interface EmailService {
	
	// 메일 인증 관련 메서드
	void sendMail(EmailDTO emailDto);

	ResponseEntity<String> sendResetPw(MemberVO memberVO, String receiverMail);
}
