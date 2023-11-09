package com.devday.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.devday.dto.EmailDTO;
import com.devday.service.EmailService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/email/*")
@RequiredArgsConstructor
@Log4j
public class EmailController {

	private final EmailService emailService;

	// 메일 인증코드 요청주소
	@GetMapping("/authCode")
	public ResponseEntity<String> authSend(EmailDTO dto, HttpSession session) {

		log.info("이메일 정보: " + dto);
		ResponseEntity<String> entity = null;

		String authCode = "";
		for (int i = 0; i < 6; i++) {
			authCode += String.valueOf((int) (Math.random() * 10));
		}
		log.info("인증번호: " + authCode);

		// 사용자에게 메일로 발급해준 인증코드를 입력 시 비교 목적으로 세션 형태로 미리 저장해둔다.
		session.setAttribute("authCode", authCode);

		try {
			emailService.sendMail(dto, authCode); // 메일 보내기
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}

	// 인증코드 확인: 세션 형태로 저장한 정보를 이용
	@GetMapping("/confirmAuthcode")
	// public ResponseEntity<String> confirmAuthcode(입력한 인증코드 매개변수) {
	public ResponseEntity<String> confirmAuthcode(String authCode, HttpSession session) {

		ResponseEntity<String> entity = null;

		// 세션 작업: 이를 위해 해당 메소드의 매개변수에 HttpSession session을 명시함
		if (session.getAttribute("authCode") != null) {
			// 인증 일치
			if (authCode.equals(session.getAttribute("authCode"))) {
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} else {
			// 세션이 소멸되었을 때(기본 30분)
			entity = new ResponseEntity<String>("request", HttpStatus.OK);
		}
		return entity;
	}
}
