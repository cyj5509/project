package com.devday.mapper;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.MemberVO;

public interface MemberMapper {
	
	void join(MemberVO vo); // 회원가입 관련 메서드

	String idCheck(String mem_id); // 아이디 중복검사 관련 메서드

	MemberVO login(String mem_id); // 로그인 관련 메서드
	
	void loginTimeUpdate(String mem_id);

	void modify(MemberVO vo);
	
	void delete(String mem_id);
	
	String findIdByEmail(String mem_email);

	String findPwByIdAndEmail(
			@Param("mem_id") String mem_id,
			@Param("mem_email") String mem_email
	);
}
