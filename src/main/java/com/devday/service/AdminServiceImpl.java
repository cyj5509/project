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
	public AdminVO admin_ok(String ad_id) {
		
		return adminMapper.admin_ok(ad_id);
	}

	@Override
	public void loginTime(String ad_id) {

		adminMapper.loginTime(ad_id);
	}
	
}
