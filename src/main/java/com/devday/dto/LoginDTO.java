package com.devday.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 비밀번호 암호화 처리를 위해 별도로 분리한 클래스

@Getter
@Setter
//@ToString
public class LoginDTO {

	private String us_id;
	private String us_pw; // 사용자가 입력한 평문 비밀번호(비암호화)
	
	//@ToString
	/*
	@Override
	public String toString() {
		return "LoginDTO [us_id=" + us_id + ", us_pw=" + us_pw + "]";
	}
	*/
}
