package com.devday.service;

import com.devday.domain.UserVO;
import com.devday.dto.FindInfoDTO;

public interface UserService {

	void join(UserVO vo); // 회원가입 관련 메서드 
	String idCheck(String us_id); // 아이디 중복검사 관련 메서드
	
	UserVO login(String us_id); // 로그인 관련 메서드
	void lastLoginTime(String us_id); // 접속일자 업데이트 관련 메서드
	
	UserVO findId(FindInfoDTO findInfoDTO); // 아이디 찾기 관련 메서드
    boolean isUserForId(String us_name, String us_email); // 아이디 찾기를 위한 사용자 존재 여부 확인
	
//	int findPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 관련 메서드
	boolean resetPw(FindInfoDTO findInfoDTO); // 비밀번호 업데이트 관련 메서드
	boolean processFindPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 및 업데이트 관련 메서드
	boolean isUserForPw(String us_id, String us_name, String us_email); // 비밀번호 찾기를 위한 사용자 존재 여부 확인
	String isPwMatch(String us_id); // 현재 비밀번호 일치 여부 관련 메서드
	
	void modify(UserVO vo); // 회원수정 관련 메서드
	void delete(String us_id); // 회원탈퇴 관련 메서드
}
