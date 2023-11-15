package com.devday.service;

import com.devday.dto.EmailDTO;

public interface EmailService {
	
	// 메일 발송 관련 메서드: 회원가입과 아이디 및 비밀번호 찾기, 임시 비밀번호 발송 시 사용
	void sendMail(EmailDTO emailDTO);
}
