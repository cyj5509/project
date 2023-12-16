package com.devday.service;

import javax.servlet.http.HttpServletResponse;

import com.devday.domain.UserVO;
import com.devday.dto.FindInfoDTO;
import com.devday.dto.LoginDTO;

public interface UserService {

	void join(UserVO vo); // 회원가입 관련 메서드 
	String id_check(String us_id); // 아이디 중복검사 관련 메서드
	
	UserVO login(String us_id); // 일반적인 로그인 관련 메서드(SELECT 문)
	void lastLoginTime(String us_id); //  최근 접속 일자 관련 메서드(UPDATE 문)
	UserVO enhancedLogin(LoginDTO lo_dto, HttpServletResponse response); // 로그인 및 접속일자 포함한 추가 메서드
	
	void updateUserToken(UserVO vo); // 로그인 유지 관련 메서드(UPDATE 문)
	UserVO getUserByToken(String us_login_token); // 자동 로그인 처리 관련 메서드(SELECT 문)
	
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
