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
	private String subject; // 메일 제목
	private String content; // 메일 내용(본문)

	// @AllArgsConstructor
	public EmailDTO() {

		this.senderName = "DevDay";
		this.senderMail = "www.devday.com";
		this.subject = "DevDay 회원가입을 위한 메일 인증코드입니다.";
		this.content = "하단의 인증코드를 알맞게 인증코드 입력란에 입력바랍니다.";
	}
}
