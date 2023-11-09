package com.devday.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devday.domain.MemberVO;
import com.devday.dto.LoginDTO;
import com.devday.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@RequiredArgsConstructor
@Log4j
public class MemberController {

	private final MemberService memberService;
	private final PasswordEncoder passwordEncoder; 

	// 회원가입 페이지 이동
	@GetMapping("/join")
	public void join() {

		log.info("회원가입 페이지 진입"); 
	}

	// 회원가입
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception { 
		
		log.info("회원정보: " + vo);
		
		log.info("암호화 전 비밀번호: " + vo.getMem_pw());
		vo.setMem_pw(passwordEncoder.encode(vo.getMem_pw()));
		log.info("암호화 후 비밀번호: " + vo.getMem_pw());

		// 회원가입 서비스 실행
		memberService.join(vo);
		
		String msg = "환영합니다. " + vo.getMem_id() + "님 회원가입이 완료되었습니다.";
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:/member/login";
	}

	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(String mem_id) throws Exception {

		log.info("아이디: " + mem_id);
		
		ResponseEntity<String> entity = null;
		
		String idUse = "";
		if (memberService.idCheck(mem_id) != null) {
			idUse = "no";
		} else {
			idUse = "yes";
		}
		
		entity = new ResponseEntity<String>(idUse, HttpStatus.OK);
		return entity;
	}



	// 로그인 페이지 이동
	@GetMapping("/login")
	public void login() {

		log.info("로그인 페이지 진입");
	}


	@PostMapping("/login")
	public String login(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("로그인 정보: " + dto);

		MemberVO db_vo = memberService.login(dto.getMem_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			if (passwordEncoder.matches(dto.getMem_pw(), db_vo.getMem_pw())) {
				url = "/";
				session.setAttribute("loginStatus", db_vo);				
				memberService.loginTimeUpdate(dto.getMem_id());
			} else {
				url = "/member/login"; 
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg);
			}
		} else {
			url = "/member/login"; 
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); 
		}

		return "redirect:" + url;
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		log.info("로그아웃 요청");
		session.invalidate();

		return "redirect:/";
	}

	@GetMapping("/confirmPw")
	public void confirmPw() {

		log.info("회원수정 전 비밀번호 확인");
	}

	@PostMapping("/confirmPw")
	public String confirmPw(LoginDTO dto, RedirectAttributes rttr) throws Exception {
		
		log.info("회원수정 전 인증 재확인: " + dto);

		MemberVO db_vo = memberService.login(dto.getMem_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			if (passwordEncoder.matches(dto.getMem_pw(), db_vo.getMem_pw())) {
				url = "/member/myPage"; 
			} else {
				url = "/member/confirmPw";
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); 
			}
		} else {
			url = "/member/confirmPw";
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); 
		}

		return "redirect:" + url;
	}

	// 수정하기
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) throws Exception {
		
		log.info("회원수정 페이지 요청");

		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		MemberVO db_vo = memberService.login(mem_id);

		model.addAttribute("memberVO", db_vo);
	}

	@PostMapping("/modify")
	public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("회원정보 수정: " + vo);

		MemberVO db_vo = (MemberVO) session.getAttribute("loginStatus");
		String mem_id = db_vo.getMem_id();
		
		vo.setMem_id(mem_id);
		memberService.modify(vo);
		
		db_vo.setMem_email(vo.getMem_email());
		session.setAttribute("loginStatus", db_vo);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/";
	}

	// 마이페이지
	@GetMapping("/myPage")
	public void myPage(HttpSession session, Model model) throws Exception {
		
		log.info("마이페이지로의 이동 요청");
		
//		// 로그인 상태 확인
//	    if (session.getAttribute("loginStatus") != null) {
//	        // 로그인 상태라면 마이페이지로 리다이렉트
//	        return "redirect:/member/myPage";
//	    } else {
//	        // 로그인 상태가 아니라면 로그인 페이지로 리다이렉트
//	        return "redirect:/member/login";
//	    }
	}

	// 회원탈퇴 폼
	@GetMapping("/delConfirmPw")
	public void delConfirmPw() {

		log.info("회원탈퇴 전 비밀번호 확인");
	}

	// 회원탈퇴
	@PostMapping("/delete")
	public String delete(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("회원탈퇴 요청");
		
		MemberVO db_vo = memberService.login(dto.getMem_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			if (passwordEncoder.matches(dto.getMem_pw(), db_vo.getMem_pw())) {
				url = "/"; 
				session.invalidate();
				memberService.delete(dto.getMem_id());
			} else {
				url = "/member/delConfirmPw"; 
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); 
			}
		} else {
			url = "/member/delConfirmPw";
			msg = "아이디가 일치하지 않습니다.";
			rttr.addFlashAttribute("msg", msg); 
		}

		return "redirect:" + url;
	}

	// 하단 내용들은 관련 파일들 찾아서 새롭게 구성해야 함
//	// 아이디 찾기 폼
//	@GetMapping("/findId")
//	public void findId() {
//		
//		log.info("아이디 찾기 페이지 요청");
//	}
//	
//	// 비밀번호 찾기 폼
//	@GetMapping("/findPw")
//	public void findPw() {
//		
//		log.info("비밀번호 찾기 페이지 요청");
//	}
//	
//	// 아이디 찾기
//	@PostMapping("/findId")
//	public String findId(@RequestParam("mem_email") String mem_email, Model model, RedirectAttributes rttr) {
//
//	    String mem_id = memberService.findIdByEmail(mem_email);
//	    model.addAttribute("mem_id", mem_id);
//	    
//	    return "redirect:/member/login/findId";
//	}
//
//	// 비밀번호 찾기
//	@PostMapping("/findPw")
//	public String findPw(@RequestParam("mem_id") String mem_id, @RequestParam("mem_email") String mem_email, Model model, RedirectAttributes rttr) {
//		
//		log.info("비밀번호 찾기 페이지로 이동");
//	    String mem_pw = memberService.findPwByIdAndEmail(mem_id, mem_email);
//	    model.addAttribute("mem_pw", mem_pw);
//	    
//	    return "redirect:/member/login/findPw";
//	}
	
	
}
