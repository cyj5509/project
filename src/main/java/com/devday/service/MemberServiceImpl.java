package com.devday.service;

import org.springframework.stereotype.Service;

import com.devday.domain.MemberVO;
import com.devday.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	
	// 회원가입 관련 메서드
	@Override
	public void join(MemberVO vo) {
		
		memberMapper.join(vo);
	}
	
	// 아이디 중복검사 관련 메서드
	@Override
	public String idCheck(String mem_id) {
		
		return memberMapper.idCheck(mem_id);
	}
	
	// 로그인 관련 메서드
	@Override
	public MemberVO login(String mem_id) {

		return memberMapper.login(mem_id);
	}
	
	// 접속일자 업데이트 관련 메서드
	@Override
	public void loginTimeUpdate(String mem_id) {

		memberMapper.loginTimeUpdate(mem_id);
	}
	
	// 아이디 찾기 관련 메서드
	@Override
	public String findIdByNE(String mem_name, String mem_email) {
	
		return memberMapper.findIdByNE(mem_name, mem_email);
		
	}

	// 비밀번호 찾기 관련 메서드
	@Override
	public int findPwByINE(String mem_id, String mem_name, String mem_email) {
		
		return memberMapper.findPwByINE(mem_id, mem_name, mem_email);
	}
	
	// 비밀번호 업데이트 관련 메서드
	@Override
	public void updatePw(String mem_id, String mem_pw) {
	
		memberMapper.updatePw(mem_id, mem_pw);
	}
	
	// 회원수정 관련 메서드
	@Override
	public void modify(MemberVO vo) {
		
		memberMapper.modify(vo);
	}

	// 회원탈퇴 관련 메서드
	@Override
	public void delete(String mem_id) {
		
		memberMapper.delete(mem_id);
	}
}
