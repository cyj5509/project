package com.devday.mapper;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.MemberVO;

public interface MemberMapper {
	
	void join(MemberVO vo); // 회원가입 관련 메서드
	// int idCheck(String mem_id); 또는 Integer idCheck(String mem_id); 
	String idCheck(String mem_id); // 아이디 중복검사 관련 메서드

	MemberVO login(String mem_id); // 로그인 관련 메서드
	void loginTimeUpdate(String mem_id); // 접속일자 업데이트 관련 메서드
	String findIdByNE(
			@Param("mem_name") String mem_name, 
			@Param("mem_email") String mem_email
	); // 아이디 찾기 관련 메서드
	int findPwByINE(
			@Param("mem_id") String mem_id,
			@Param("mem_name") String mem_name,
			@Param("mem_email") String mem_email
	); // 비밀번호 찾기 관련 메서드
	void updatePw(String mem_id, String mem_pw); // 비밀번호 업데이트 관련 메서드
	
	void modify(MemberVO vo); // 회원수정 관련 메서드
	void delete(String mem_id); // 회원탈퇴 관련 메서드
}
