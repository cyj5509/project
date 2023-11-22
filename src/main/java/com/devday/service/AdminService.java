package com.devday.service;

import com.devday.domain.AdminVO;

public interface AdminService {

	AdminVO admin_ok(String ad_id);

	void loginTime(String ad_id);

}
