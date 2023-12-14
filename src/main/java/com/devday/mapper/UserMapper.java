package com.devday.mapper;

import com.devday.domain.UserVO;
import com.devday.dto.FindInfoDTO;

public interface UserMapper {
	
	// [1] 회원가입 및 아이디 중복검사 관련 메서드
	void join(UserVO vo); // 회원가입(INSERT 문)
	// 아이디 중복검사의 경우, 반환 타입을 int 또는 Integer로 처리할 수도 있음
	String idCheck(String us_id); // 아이디 중복검사(SELECT 문)

	// [2] 로그인 및 최근 접속 일자 관련 메서드
	UserVO login(String us_id); // 일반적인 로그인(SELECT 문)
	void lastLoginTime(String us_id); // 최근 접속 일자(UPDATE 문)
	void updateUserToken(UserVO vo); // 로그인 유지(UPDATE 문)
	UserVO getUserByToken(String us_login_token); // 자동 로그인 처리(SELECT 문)
	
	// [3] 아이디 및 비밀번호 찾기, 비밀번호 재설정 관련 메서드
	UserVO findId(FindInfoDTO findInfoDTO); // 아이디 찾기
	int findPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기
	boolean resetPw(FindInfoDTO findInfoDTO); // 비밀번호 재설정
	String isPwMatch(String us_id); // 현재 비밀번호 일치 여부 관련 메서드
	
	void modify(UserVO vo); // 회원수정 관련 메서드(UPDATE 문)
	void delete(String us_id); // 회원탈퇴 관련 메서드(DELETE 문)
}
