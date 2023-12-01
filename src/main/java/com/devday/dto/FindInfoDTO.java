package com.devday.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FindInfoDTO {

	private String us_id; // 사용자 아이디: 비밀번호 찾기 시 사용
	private String us_pw; // 사용자가 재설정할 평문 비밀번호
	private String us_name; // 인증을 위한 회원 이름(공통 사항)
	private String us_email; // 인증을 위한 회원 이메일(공통 사항)
    private Date us_join_date; // 가입 일자 필드 추가... 수정 필요할 듯?
	
	// 아이디 찾기용 정적 팩토리 메서드: 이름과 이메일 필요
	public static FindInfoDTO ofFindId(String us_name, String us_email) {
		FindInfoDTO dto = new FindInfoDTO();
		dto.setUs_name(us_name);
		dto.setUs_email(us_email);
		return dto;
	}
	
	// 비밀번호 찾기용 정적 팩토리 메서드: 아이디, 이름, 이메일 필요
	public static FindInfoDTO ofFindPw(String us_id, String us_name, String us_email) {
		FindInfoDTO dto = new FindInfoDTO();
		dto.setUs_id(us_id);
		dto.setUs_name(us_name);
		dto.setUs_email(us_email);
		return dto;
	}
	
	// 비밀번호 재설정용 정적 팩토리 메서드: 아이디, 비밀번호 필요
	public static FindInfoDTO ofResetPw(String us_id, String us_pw) {
		FindInfoDTO dto = new FindInfoDTO();
		dto.setUs_id(us_id);
		dto.setUs_pw(us_pw);
		return dto;
	}
}
