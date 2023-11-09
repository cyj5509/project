package com.devday.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor // 기본 생성자를 구현해야 함
public class EmailDTO {

	private String senderName; // 발신자 이름
	private String senderMail; // 발신자 메일주소
	private String receiverMail; // 수신자 메일주소 즉, 회원메일 주소로 클라이언트 측에서 제공(join.jsp)
	private String subject; // 제목
	private String message; // 본문 내용

	// @AllArgsConstructor
	public EmailDTO() {

		this.senderName = "DocMall";
		this.senderMail = "DocMall";
		this.subject = "DocMall 회원가입 메일 인증코드입니다.";
		this.message = "메일 인증코드를 확인하시고 회원가입 시 인증코드 입력란에 입력바랍니다.";
	}
}
