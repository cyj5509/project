package com.devday.mapper;

import com.devday.domain.UserVO;
import com.devday.dto.FindInfoDTO;

public interface UserMapper {
	
	// 타입관련 ReviewMapper 참고해서 수정해볼 것
	
	void join(UserVO vo); // 회원가입 관련 메서드
	// int idCheck(String us_id); 또는 Integer idCheck(String us_id); 
	String idCheck(String us_id); // 아이디 중복검사 관련 메서드

	UserVO login(String us_id); // 로그인 관련 메서드
	void loginTimeUpdate(String us_id); // 접속일자 업데이트 관련 메서드
	
	UserVO findId(FindInfoDTO findInfoDTO); // 아이디 찾기 관련 메서드
	
	int findPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 관련 메서드
	boolean resetPw(FindInfoDTO findInfoDTO); // 비밀번호 업데이트 관련 메서드
	String isPwMatch(String us_id); // 현재 비밀번호 일치 여부 관련 메서드
	
	void modify(UserVO vo); // 회원수정 관련 메서드
	void delete(String us_id); // 회원탈퇴 관련 메서드
}
