package com.devday.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 비밀번호 암호화 처리를 위해 별도로 분리한 클래스

@Getter
@Setter
@ToString
public class LoginDTO {

	private String us_id;
	private String us_pw; // 사용자가 입력한 평문 비밀번호(비암호화)
	private boolean isRememberId; // 아이디 저장 기능을 위함
	private boolean isRememberLogin; // 로그인 상태 유지 기능을 위함
}
