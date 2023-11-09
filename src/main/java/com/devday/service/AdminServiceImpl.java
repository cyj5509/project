package com.devday.service;

import org.springframework.stereotype.Service;

import com.devday.domain.AdminVO;
import com.devday.mapper.AdminMapper;

import lombok.RequiredArgsConstructor;

// import lombok.RequiredArgsConstructor;

@Service // bean 생성 및 등록: adminServiceImpl
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
	
	private final AdminMapper adminMapper;

//	public AdminServiceImpl(AdminMapper adminMapper) {
//		this.adminMapper = adminMapper;
//	}
	
	@Override
	public AdminVO admin_ok(String adm_id) {
		
		return adminMapper.admin_ok(adm_id);
	}

	@Override
	public void loginTime(String adm_id) {

		adminMapper.loginTime(adm_id);
	}
	
}
