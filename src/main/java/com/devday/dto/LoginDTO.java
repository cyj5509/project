package com.devday.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginDTO {

	// 로그인 정보
	private String mem_id; // 사용자 아이디
	private String mem_pw; // 사용자가 입력한 평문 비밀번호
	
	//@ToString
	/*
	@Override
	public String toString() {
		return "LoginDTO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + "]";
	}
	*/
}
