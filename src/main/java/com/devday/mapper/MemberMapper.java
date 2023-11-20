package com.devday.mapper;

import com.devday.domain.MemberVO;
import com.devday.dto.FindInfoDTO;

public interface MemberMapper {
	
	void join(MemberVO vo); // 회원가입 관련 메서드
	// int idCheck(String mem_id); 또는 Integer idCheck(String mem_id); 
	String idCheck(String mem_id); // 아이디 중복검사 관련 메서드

	MemberVO login(String mem_id); // 로그인 관련 메서드
	void loginTimeUpdate(String mem_id); // 접속일자 업데이트 관련 메서드
	
	MemberVO findId(FindInfoDTO findInfoDTO); // 아이디 찾기 관련 메서드
	
	int findPw(FindInfoDTO findInfoDTO); // 비밀번호 찾기 관련 메서드
	boolean resetPw(FindInfoDTO findInfoDTO); // 비밀번호 업데이트 관련 메서드
	String isPwMatch(String mem_id); // 현재 비밀번호 일치 여부 관련 메서드
	
	void modify(MemberVO vo); // 회원수정 관련 메서드
	void delete(String mem_id); // 회원탈퇴 관련 메서드
}
