package com.devday.service;

import org.springframework.stereotype.Service;

import com.devday.domain.MemberVO;
import com.devday.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	
	@Override
	public String idCheck(String mem_id) {
		
		return memberMapper.idCheck(mem_id);
	}
	
	// 회원가입
	@Override
	public void join(MemberVO vo) {
		
		memberMapper.join(vo);
	}
	

	@Override
	public MemberVO login(String mem_id) {

		return memberMapper.login(mem_id);
	}

	@Override
	public void modify(MemberVO vo) {
		
		memberMapper.modify(vo);
	}

	@Override
	public void delete(String mem_id) {
		
		memberMapper.delete(mem_id);
	}
	
	@Override
	public void loginTimeUpdate(String mem_id) {

		memberMapper.loginTimeUpdate(mem_id);
	}

	@Override
	public String findIdByEmail(String mem_email) {
	
		return memberMapper.findIdByEmail(mem_email);
		
	}

	@Override
	public String findPwByIdAndEmail(String mem_id, String mem_email) {
		
		return memberMapper.findPwByIdAndEmail(mem_id, mem_email);
	}


}
