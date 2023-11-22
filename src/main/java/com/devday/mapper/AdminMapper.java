package com.devday.mapper;

import com.devday.domain.AdminVO;

public interface AdminMapper {

	AdminVO admin_ok(String ad_id);
	
	void loginTime(String ad_id);
		
}
