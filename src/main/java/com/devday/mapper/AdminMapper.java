package com.devday.mapper;

import com.devday.domain.AdminVO;

public interface AdminMapper {

	AdminVO admin_ok(String adm_id);
	
	void loginTime(String adm_id);
		
}
