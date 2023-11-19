package com.devday.service;

import com.devday.domain.MemberVO;
import com.devday.dto.FindInfoDTO;

public interface MemberService {

	void join(MemberVO vo); // 회원가입 관련 메서드 
	String idCheck(String mem_id); // 아이디 중복검사 관련 메서드
	
	MemberVO login(String mem_id); // 로그인 관련 메서드
	void loginTimeUpdate(String mem_id); // 접속일자 업데이트 관련 메서드
	
	MemberVO findId(FindInfoDTO findInfoDTO); // 아이디 찾기 관련 메서드
    boolean isUserForId(String mem_name, String mem_email); // 아이디 찾기를 위한 사용자 존재 여부 확인
	
//	int findPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 관련 메서드
	boolean resetPw(FindInfoDTO findInfoDTO); // 비밀번호 업데이트 관련 메서드
	boolean processFindPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 및 업데이트 관련 메서드
	boolean isUserForPw(String mem_id, String mem_name, String mem_email); // 비밀번호 찾기를 위한 사용자 존재 여부 확인
	
	void modify(MemberVO vo); // 회원수정 관련 메서드
	void delete(String mem_id); // 회원탈퇴 관련 메서드
}
