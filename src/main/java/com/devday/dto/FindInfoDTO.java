package com.devday.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FindInfoDTO {

	private String mem_id; // 사용자 아이디: 비밀번호 찾기 시 사용
	private String mem_pw; // 사용자가 재설정할 평문 비밀번호
	private String mem_name; // 인증을 위한 회원 이름(공통 사항)
	private String mem_email; // 인증을 위한 회원 이메일(공통 사항)
	
	// 아이디 찾기용 정적 팩토리 메서드: 이름과 이메일 필요
	public static FindInfoDTO ofFindId(String mem_name, String mem_email) {
		FindInfoDTO dto = new FindInfoDTO();
		dto.setMem_name(mem_name);
		dto.setMem_email(mem_email);
		return dto;
	}
	
	// 비밀번호 찾기용 정적 팩토리 메서드: 아이디, 이름, 이메일 필요
	public static FindInfoDTO ofFindPw(String mem_id, String mem_name, String mem_email) {
		FindInfoDTO dto = new FindInfoDTO();
		dto.setMem_id(mem_id);
		dto.setMem_name(mem_name);
		dto.setMem_email(mem_email);
		return dto;
	}
	
	// 비밀번호 재설정용 정적 팩토리 메서드: 아이디, 비밀번호 필요
	public static FindInfoDTO ofResetPw(String mem_id, String mem_pw) {
		FindInfoDTO dto = new FindInfoDTO();
		dto.setMem_id(mem_id);
		dto.setMem_pw(mem_pw);
		return dto;
	}
}
