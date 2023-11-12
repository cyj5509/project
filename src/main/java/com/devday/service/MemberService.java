package com.devday.service;

import com.devday.domain.MemberVO;

public interface MemberService {

	void join(MemberVO vo); // 회원가입 관련 메서드

	String idCheck(String mem_id); // 아이디 중복검사 관련 메서드
	
	MemberVO login(String mem_id); // 로그인 관련 메서드
	
	void modify(MemberVO vo);
	
	void delete(String mem_id);
	
	void loginTimeUpdate(String mem_id);
	
	String findIdByEmail(String mem_email);
	
	String findPwByIdAndEmail(String mem_id, String mem_email);
}
