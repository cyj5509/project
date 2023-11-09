package com.devday.mapper;

import org.apache.ibatis.annotations.Param;

import com.devday.domain.MemberVO;

public interface MemberMapper {
	
	String idCheck(String mem_id);
	
	// 회원가입
	void join(MemberVO vo);	

	MemberVO login(String mem_id);
	
	void modify(MemberVO vo);
	
	void delete(String mem_id);
	
	void loginTimeUpdate(String mem_id);
	
	String findIdByEmail(String mem_email);

	String findPwByIdAndEmail(
			@Param("mem_id") String mem_id,
			@Param("mem_email") String mem_email
	);
}
