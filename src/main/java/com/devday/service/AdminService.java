package com.devday.service;

import com.devday.domain.AdminVO;

public interface AdminService {

	AdminVO admin_ok(String adm_id);

	void loginTime(String adm_id);

}
