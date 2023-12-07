package com.devday.mapper;

import com.devday.domain.UserVO;
import com.devday.dto.FindInfoDTO;

public interface UserMapper {
	
	void join(UserVO vo); // 회원가입 관련 메서드(INSERT 문)
	
	// int idCheck(String us_id); 또는 Integer idCheck(String us_id);
	String idCheck(String us_id); // 아이디 중복검사 관련 메서드(SELECT 문)

	UserVO login(String us_id); // 일반적인 로그인 관련 메서드(SELECT 문)
	void lastLoginTime(String us_id); // 최근 접속 일자 관련 메서드(UPDATE 문)
	
	void updateUserToken(UserVO vo); // 로그인 유지 관련 메서드(UPDATE 문)
	UserVO getUserByToken(String us_login_token); // 자동 로그인 처리 관련 메서드(SELECT 문)
	
	UserVO findId(FindInfoDTO findInfoDTO); // 아이디 찾기 관련 메서드
	
	int findPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 관련 메서드
	boolean resetPw(FindInfoDTO findInfoDTO); // 비밀번호 업데이트 관련 메서드
	String isPwMatch(String us_id); // 현재 비밀번호 일치 여부 관련 메서드
	
	void modify(UserVO vo); // 회원수정 관련 메서드(UPDATE 문)
	void delete(String us_id); // 회원탈퇴 관련 메서드(DELETE 문)
}
