package com.devday.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.devday.dto.EmailDTO;
import com.devday.dto.FindInfoDTO;
import com.devday.service.EmailService;
import com.devday.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // 컨트롤러 클래스가 Ajax 용도로만 사용할 때 적용하는 어노테이션 ↔ @Controller
@RequiredArgsConstructor
@RequestMapping("/email/*")
@Log4j
public class EmailController {

	private final EmailService emailService; // EmailService 인터페이스 implements EmailServiceImpl 클래스
	private final UserService userService; // MemberService 인터페이스 implements MemberServiceImpl 클래스

	// 메일을 통한 회원 인증 기능 구현 ─ 회원가입, 아이디 및 비밀번호 찾기
	@GetMapping("/authCode")
	public ResponseEntity<String> sendAuthCode(@RequestParam(value = "us_id", required = false) String us_id,
											  @RequestParam(value = "us_name", required = false) String us_name, 
											  @RequestParam("receiverMail") String receiverMail, HttpSession httpSession) {
		
		log.info("수신자 이름: " + us_name);
		log.info("수신할 메일 주소: " + receiverMail);

		ResponseEntity<String> res_entity = null;
		boolean isExistingUser = false; // 사용자가 존재하지 않는다고 가정

		// 회원가입 요청: 이메일만 필요(아이디, 이름 불필요)
		if (us_id == null && us_name == null) {
			isExistingUser = true; // 별도의 사용자 존재 검사는 필요 없음
		}
		// 아이디 찾기 요청: 이름, 이메일 필요(아이디 불필요)
		else if (us_id == null && us_name != null) {
			isExistingUser = userService.isUserForId(us_name, receiverMail); // 존재하면 true, 존재하지 않으면 false 반환
		}
		// 비밀번호 찾기 요청: 아이디, 이름, 이메일 모두 필요
		else if (us_id != null && us_name != null) {
			isExistingUser = userService.isUserForPw(us_id, us_name, receiverMail); // 존재하면 true, 존재하지 않으면 false 반환
		}

		// 해당 이름과 일치하는 사용자가 존재하지 않는 경우(회원가입 제외)
		if (!isExistingUser && us_name != null) {
			res_entity = new ResponseEntity<>("request", HttpStatus.OK);
		}

		// 인증번호 생성 및 이메일 발송
		String authCode = "";
		for (int i = 0; i < 6; i++) {
			authCode += String.valueOf((int) (Math.random() * 10));
		}
		
		log.info("인증번호: " + authCode);

		// 세션에 인증번호 저장
		httpSession.setAttribute("authCode", authCode);

		try {
			EmailDTO emailDTO = EmailDTO.ofAuthCode(receiverMail, authCode); // ofAuthCode: 회원 인증 관련 정적 팩토리 메서드 호출
			
			log.info("발송할 이메일 정보: " + emailDTO); // ofAuthCode의 receiverMail 및 authCode 값 포함한 정보 출력
			
			emailService.sendMail(emailDTO); // 메일 발송 관련 메서드 호출
			res_entity = new ResponseEntity<>("success", HttpStatus.OK); // HTTP 상태 코드(200)
		} catch (Exception e) {
			e.printStackTrace();
			res_entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // HTTP 상태 코드(500)
		}
		return res_entity;
	}

	// 인증번호 확인 기능 구현: 세션 형태로 저장한 정보를 이용
	@GetMapping("/confirmAuthCode")
	public ResponseEntity<String> confirmAuthCode(String authCode, HttpSession session) {

		ResponseEntity<String> entity = null;

		// 세션 작업: 이를 위해 해당 메소드의 매개변수에 HttpSession session을 명시함
		if (session.getAttribute("authCode") != null) {
			// 인증 일치
			if (authCode.equals(session.getAttribute("authCode"))) {
				entity = new ResponseEntity<>("success", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<>("fail", HttpStatus.OK);
			}
		} else {
			entity = new ResponseEntity<>("request", HttpStatus.OK); // 세션 소멸 시(Default: 30분)
		}
		return entity;
	}
	
	// 임시 비밀번호 생성 관련 로직은 MemberService에서부터 진행
}
