package com.devday.service;

import com.devday.dto.EmailDTO;

public interface EmailService {

	void sendMail(EmailDTO dto, String message);
	
}
