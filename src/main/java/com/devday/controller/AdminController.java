package com.devday.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devday.domain.AdminVO;
import com.devday.service.AdminService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

// AdminController adminController = new AdminController();
@Controller // 클라이언트의 요청을 담당하는 기능 -> bean으로 생성 및 등록: adminController
@RequestMapping("/admin/*")
@RequiredArgsConstructor
@Log4j
public class AdminController {

	private final AdminService adminService;
	private final PasswordEncoder passwordEncoder; 
	
	// 관리자 로그인 폼 페이지
	@GetMapping("/intro")
	public String adm_login() {
		log.info("관리자 로그인 페이지");
		
		return "/admin/adm_login";
	}
	
	// 관리자 로그인 인증
	@PostMapping("/admin_ok")
	public String admin_ok(AdminVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		log.info("관리자 로그인: " + vo);

		AdminVO db_vo = adminService.admin_ok(vo.getAdm_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			// 아이디가 일치하는 경우 실행
			// 사용자가 입력한 비밀번호(평문 텍스트)와 DB에서 가져온 암호화된 비밀번호 일치 여부 검사
			// passwordEncoder.matches(rawPassword, encodedPassword)
			if (passwordEncoder.matches(vo.getAdm_pw(), db_vo.getAdm_pw())) {
				url = "/admin/adm_menu"; // 관리자 메뉴 페이지 주소
				// 로그인 성공 결과로 서버 측의 메모리를 사용하는 세션 형태 작업
				session.setAttribute("adminStatus", db_vo); // logiStatus와 이름이 중복돼선 안 된다
				
				// 최근 접속(로그인) 시간 업데이트
				adminService.loginTime(vo.getAdm_id());	
				
			} else {
				url = "/admin/intro"; // 로그인 폼 주소
				msg = "failPW"; // "비밀번호가 일치하지 않습니다."
				rttr.addFlashAttribute("msg", msg); // 로그인 폼인 login.jsp 파일에서 사용 목적
			}
		} else {
			// 아이디가 일치하지 않는 경우
			url = "/admin/intro"; // 로그인 폼 주소
			msg = "failID"; // "아이디가 일치하지 않습니다."
			rttr.addFlashAttribute("msg", msg); // 로그인 폼인 login.jsp 파일에서 사용 목적
		}

		return "redirect:" + url;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/admin/intro"; // 로그인 페이지 주소로 이동
	}
	
	// 관리자 메뉴 페이지
	@GetMapping("/adm_menu")
	public void adm_menu() {
		
	}
}
