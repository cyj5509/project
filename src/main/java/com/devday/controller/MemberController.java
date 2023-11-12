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
@RequiredArgsConstructor
@RequestMapping("/member/*")
@Log4j
public class MemberController {

	// interface MemberService -> class MemberServiceImpl implements MemberService
	private final MemberService memberService;
	// interface PasswordEncoder -> class BCryptPasswordEncoder implements PasswordEncoder
	private final PasswordEncoder passwordEncoder;
	
	// 회원가입 페이지 이동(회원가입 폼)
	@GetMapping("/join")
	public void join() {

		log.info("회원가입 페이지 진입"); 
	}

	// 회원가입 기능 구현
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception { 
		
		log.info("회원 정보: " + vo); // MemberVO의 @ToString 메서드 호출
		log.info("암호화 전 비밀번호: " + vo.getMem_pw());
		
		// 비밀번호 암호화 처리
		vo.setMem_pw(passwordEncoder.encode(vo.getMem_pw())); // passwordEncoder.encode(rawPassword)
		log.info("암호화 후 비밀번호: " + vo.getMem_pw());

		memberService.join(vo); // 회원가입 관련  메서드 호출
		
		// 회원가입 후 환영인사
		String msg = "환영합니다! " + vo.getMem_id() + " 님, 회원가입이 완료되었습니다.";
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:/member/login"; // 로그인 페이지로 이동
	}

	// 아이디 중복검사 기능 구현
	@GetMapping("/idCheck")
	// class HttpEntity<T> -> class ResponseEntity<T> extends HttpEntity<T>
	// @RequestParam("mem_id") String mem_id: join.jsp의 name="mem_id" & data: { mem_id: }
	public ResponseEntity<String> idCheck(@RequestParam("mem_id") String mem_id) throws Exception {

		log.info("ID 중복검사: " + mem_id);
		
		
		// memberService.idCheck(mem_id): 아이디 중복검사 관련 메서드 호출
		// idCheck(mem_id) != null ? "no" : "yes" -> 아이디가 이미 존재하면 no, 존재하지 않으면 yes 
		String idUse = memberService.idCheck(mem_id) != null ? "no" : "yes";
		/*
		// 조건문을 사용할 경우(기존 방식)
	
		String idUse = "";
		if (memberService.idCheck(mem_id) != null) {
			idUse = "no"; 
		} else { 
			idUse = "yes";
		}
		*/
		log.info("ID 사용가능: " + idUse);

		// ResponseEntity<String> entity = new ResponseEntity<>(idUse, HttpStatus.OK);

		ResponseEntity<String> entity = null; 
		// new ResponseEntity<>(body, [headers], status): 해당 클래스의 인스턴스 생성 및 생성자 호출(초기화)
		entity = new ResponseEntity<>(idUse, HttpStatus.OK); // HTTP 상태 코드(200)
		
		return entity; // AJAX에서 idUse는 result로 사용(서버 -> 클라이언트)
	}

	// 로그인 페이지 이동(로그인 폼)
	@GetMapping("/login")
	public void login() {

		log.info("로그인 페이지 진입");
	}

	// 로그인 기능 구현
	@PostMapping("/login")
	public String login(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("로그인 정보: " + dto); // LoginDTO의 @ToString 메서드 호출

		// memberService.login(dto.getMem_id()): 로그인 관련 메서드 호출
		// DB에서 LoginDTO에 제공된 아이디로 사용자 정보 조회(암호화된 비밀번호 포함)
		MemberVO db_vo = memberService.login(dto.getMem_id());

		String url = "";
		String msg = "";
		
		if (db_vo != null) {
			// passwordEncoder.matches(rawPassword, encodedPassword)
			// dto.getMem_pw()는 로그인 폼에 입력한 평문 비밀번호, db_vo.getMem_pw()는 DB에 저장된 암호화된 비밀번호
			if (passwordEncoder.matches(dto.getMem_pw(), db_vo.getMem_pw())) {
				// 사용자와 관리자의 로그인 상태, 즉 db_vo를 "loginStatus"라는 이름으로 저장
			    session.setAttribute("loginStatus", db_vo); // session.setAttribute(name, value)
			    if (db_vo.getAdm_check() == 1) {
			        session.setAttribute("isAdmin", true); // 세션에 관리자 상태 설정(adm_check = 1)
			        log.info("관리자로 접속했습니다.");
			    } else {
			        session.setAttribute("isAdmin", false); // 세션에 사용자 상태 설정(adm_check = 0)
			        log.info("사용자로 접속했습니다.");
			    }
			    memberService.loginTimeUpdate(dto.getMem_id()); // 접속일자 업데이트 관련 메서드 호출
			    url = "/"; // 메인 페이지 이동
			} else {
				url = "/member/login"; // 로그인 페이지 이동
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); 
			}
		} else {
			// 아이디가 존재하지 않거나 빈 칸으로 둔 경우
			url = "/member/login"; // 로그인 페이지 이동
			msg = "아이디를 다시 입력해주세요.";
			rttr.addFlashAttribute("msg", msg);
		}

		return "redirect:" + url; // 메인 페이지 또는 로그인 페이지(login.jsp) 이동
	}

	// 로그아웃 기능 구현(페이지 불필요)
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		log.info("로그아웃 요청");
		session.invalidate(); // 사용자 세션 무효화

		return "redirect:/member/login"; // 로그아웃 시 다시 로그인 페이지 이동
	}

	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
		
		log.info("마이 페이지 진입");
		
		// 로그인 상태 확인: session.getAttribute(name)
	    if (session.getAttribute("loginStatus") == null) {
	        // 사용자가 로그인 상태가 아니라면 로그인 페이지로 이동(login.jsp)
	        return "redirect:/member/login";
	    }
	   
	    //???
	    String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		MemberVO db_vo = memberService.login(mem_id);
		model.addAttribute("memberVO", db_vo);
		
	    // 로그인 상태 -> 마이 페이지로 이동(myPager.jsp)
	    return "member/myPage";
	}
	
	// 회원수정 페이지 이동(회원수정 폼)
		@GetMapping("/modify")
		public void modify(HttpSession session, Model model) throws Exception {
			
			log.info("회원수정 페이지 진입");

			String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
			MemberVO db_vo = memberService.login(mem_id);
			model.addAttribute("memberVO", db_vo);
		}

		@PostMapping("/modify")
		public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {

			log.info("수정할 회원정보: " + vo);

			MemberVO db_vo = (MemberVO) session.getAttribute("loginStatus");
			String mem_id = db_vo.getMem_id();
			
			vo.setMem_id(mem_id);
			memberService.modify(vo);
			
			db_vo.setMem_email(vo.getMem_email());
			session.setAttribute("loginStatus", db_vo);

			rttr.addFlashAttribute("msg", "success");

			return "redirect:/";
		}
		
	// 회원탈퇴 전 확인 페이지 이동
	@GetMapping("/confirmInfo")
	public void confirmInfo() {

		log.info("회원탈퇴 전 정보 확인");
	}

	// 회원탈퇴 기능 구현
	@PostMapping("/delete")
	public String delete(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("회원탈퇴 요청");
		
		// 로그인한 사용자의 ID로 DB에서 비밀번호 조회	
		MemberVO db_vo = memberService.login(dto.getMem_id());

		String url = "";
		String msg = "";

		if (db_vo != null) {
			if (passwordEncoder.matches(dto.getMem_pw(), db_vo.getMem_pw())) {
				memberService.delete(dto.getMem_id()); // 회원탈퇴 관련 메서드 호출
				session.invalidate(); // 세션 무효화
				url = "/"; 
				msg = "회원탈퇴가 정상적으로 처리되었습니다.";
				rttr.addFlashAttribute("msg", msg);
			} else {
				url = "/member/confirmInfo"; 
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); 
			}
		} else {
			url = "/member/confirmInfo";
			msg = "아이디를 다시 입력해주세요.";
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
