package com.devday.service;

import com.devday.dto.EmailDTO;

public interface EmailService {
	
	// 메일 인증 관련 메서드
	void sendMail(EmailDTO emailDTO);
	
	// 임시 비밀번호 관련 메서드
	void sendTempPw(EmailDTO emailDTO);
}
