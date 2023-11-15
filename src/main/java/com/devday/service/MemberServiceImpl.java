package com.devday.service;

import org.springframework.stereotype.Service;

import com.devday.domain.MemberVO;
import com.devday.dto.FindInfoDTO;
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
	public String findId(FindInfoDTO findInfoDTO) {
	
		return memberMapper.findId(findInfoDTO);
		
	}

	// 비밀번호 찾기 관련 메서드
	@Override
	public int findPw(FindInfoDTO findInfoDTO) {
		
		return memberMapper.findPw(findInfoDTO);
	}
	
	// 비밀번호 재설정 관련 메서드
	@Override
	public void updatePw(FindInfoDTO findInfoDTO) {
	
		memberMapper.updatePw(findInfoDTO);
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
