package com.devday.controller;

import java.util.UUID;

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
import com.devday.dto.EmailDTO;
import com.devday.dto.LoginDTO;
import com.devday.service.EmailService;
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
	private final EmailService emailService;
	
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

		memberService.join(vo); // 회원가입 관련 메서드 호출
		
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
				// void javax.servlet.http.HttpSession.setAttribute(String name, Object value)
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

	// 마이 페이지로의 이동 ─ 회원정보 조회 기능 담당
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
		
		log.info("마이 페이지 진입");
		
		// 로그인 상태 확인: session.getAttribute(name)
	    if (session.getAttribute("loginStatus") == null) {
	        // 로그인 상태가 아닌 경우 로그인 페이지로 이동(login.jsp)
	        return "redirect:/member/login";
	    }
	   
	    // Object javax.servlet.http.HttpSession.getAttribute(String name): MemberVO로의 형변환(casting) 필요
	    String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		MemberVO vo = memberService.login(mem_id); // memberService.login(mem_id): 로그인 관련 메서드 호출
		model.addAttribute("vo", vo);
		
	    // 로그인 상태 -> 마이 페이지로 이동(myPage.jsp)
	    return "member/myPage";
	}
	
	// 회원수정 페이지 이동(회원수정 폼)
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) throws Exception {
		
		log.info("회원수정 페이지 진입");

		// Object javax.servlet.http.HttpSession.getAttribute(String name): MemberVO로의 형변환(casting) 필요
	    String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		MemberVO vo = memberService.login(mem_id); // memberService.login(mem_id): 로그인 관련 메서드 호출
		model.addAttribute("vo", vo);
	}

	// 회원수정 기능 구현
	@PostMapping("/modify")
	public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {

		// Object javax.servlet.http.HttpSession.getAttribute(String name): MemberVO로의 형변환(casting) 필요
		MemberVO db_vo = (MemberVO) session.getAttribute("loginStatus");
		String mem_id = db_vo.getMem_id();
		
		// 로그인된 사용자의 ID를 'vo' 객체에 설정
		vo.setMem_id(mem_id); // String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		log.info("수정 전 회원정보: " + db_vo); // db_vo: 세션에 현재 로그인된 사용자의 정보
		
		memberService.modify(vo); // 회원수정 관련 메서드 호출
		log.info("수정 후 회원정보: " + vo); // vo: 클라이언트 단에서 사용자가 입력한 수정 데이터

		// 세션 정보를 최신 상태로 업데이트(수정된 정보를 활용할 경우)
		// db_vo.setMem_email(vo.getMem_email());
		session.setAttribute("loginStatus", db_vo);

		rttr.addFlashAttribute("msg", "modify"); // 리디렉션되는 메인 페이지(main.jsp)에서 사용

		return "redirect:/";
	}
		
	// 회원탈퇴 전 정보 확인 페이지 이동
	@GetMapping("/delConfirmInfo")
	public void delConfirmInfo() {

		log.info("회원탈퇴 전 정보 확인");
	}

	// 회원탈퇴 기능 구현
	@PostMapping("/delete")
	public String delete(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("회원탈퇴 요청");
		
		// memberService.login(dto.getMem_id()): 로그인 관련 메서드 호출
		// DB에서 LoginDTO에 제공된 아이디로 사용자 정보 조회(암호화된 비밀번호 포함)
		MemberVO db_vo = memberService.login(dto.getMem_id());

		String url = "";
		String msg = "";
		
		if (db_vo != null) {
				// passwordEncoder.matches(rawPassword, encodedPassword)
				// dto.getMem_pw()는 로그인 폼에 입력한 평문 비밀번호, db_vo.getMem_pw()는 DB에 저장된 암호화된 비밀번호
			if (passwordEncoder.matches(dto.getMem_pw(), db_vo.getMem_pw())) {
				memberService.delete(dto.getMem_id()); // 회원탈퇴 관련 메서드 호출
				url = "/"; // 메인 페이지 이동
				session.invalidate(); // 세션 무효화
				rttr.addFlashAttribute("msg", "delete");
			} else {
				url = "/member/delConfirmInfo"; // 회원인증 페이지 이동
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); 
			}
		} else {
			// 아이디가 존재하지 않거나 빈 칸으로 둔 경우
			url = "/member/delConfirmInfo"; // 회원인증 페이지 이동
			msg = "아이디를 다시 입력해주세요.";
			rttr.addFlashAttribute("msg", msg); 
		}

		return "redirect:" + url; // 메인 페이지 또는 회원인증 페이지(delConfirmInfo.jsp) 이동
	}
	
	// 아이디 및 비밀번호 찾기 페이지 이동
	@GetMapping({"/findId", "/confirmInfo", "/findPw"})
	public void findIdAndPw() {
		
		log.info("아이디 찾기 페이지 진입");
		
		log.info("아이디 확인 페이지 진입(비밀번호 찾기 전)");
		log.info("비밀번호 찾기 페이지 진입");
	}
	
	// 아이디 찾기 기능 구현
	@PostMapping("/findId")
	public void findId(MemberVO vo, Model model) throws Exception {

	    String mem_id = memberService.findIdByNE(vo.getMem_name(), vo.getMem_email());
	    model.addAttribute("mem_id", mem_id);
	}
	
	// 비밀번호 찾기 전 아이디 확인
	// @GetMapping("/idCheck")와 유사하지만 일부 생략 등 다소 다르게 작성함
	@PostMapping("/confirmInfo")
	// @RequestParam("mem_id") String mem_id: confirmInfo.jsp의 name="mem_id" & data: { mem_id: }
	public ResponseEntity<String> confirmInfo(@RequestParam("mem_id") String mem_id, HttpSession session) throws Exception {
		
		log.info("비밀번호 찾기 전 아이디 확인: " + mem_id);
			
		String idUse = memberService.idCheck(mem_id) != null ? "yes" : "no";
		log.info("아이디 존재 유무: " + idUse);
		
		if("yes".equals(idUse)) {
			session.setAttribute("mem_id", mem_id); // 세션에 아이디 저장	
		}
		
		ResponseEntity<String> entity = new ResponseEntity<>(idUse, HttpStatus.OK);
		
		return entity; // AJAX에서 idUse는 response로 사용(서버 -> 클라이언트)
	}

	
	// 비밀번호 찾기 기능 구현
	@PostMapping("/findPw")
	public String findPw(MemberVO vo, EmailDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		// 세션에서 아이디 가져오기
		// Object javax.servlet.http.HttpSession.getAttribute(String name)
		String mem_id = (String) session.getAttribute("mem_id");
		vo.setMem_id(mem_id); // 세션에서 가져온 아이디를 'vo' 객체에 설정
		
		// 비밀번호 찾기 전 사용자 존재 유무 확인
		int user_check = memberService.findPwByINE(vo.getMem_id(), vo.getMem_name(), vo.getMem_email());
		
		String url = "";
		String msg = "";
		
		if (user_check > 0) {
			// 임시 비밀번호 생성 및 암호화
			// String tempPassword = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
			// UUID.randomUUID().toString().replaceAll("-", ""): 랜덤 UUID를 문자열로 반환하며, 중간에 들어가는 "-"를 제거
			// uuid.substring(beginIndex, endIndex): 마지막 Index 제외(0부터 시작)
			String uuid = UUID.randomUUID().toString().replaceAll("-", ""); 
			String tempPassword = uuid.substring(0, 10); 
			String encoPassword = passwordEncoder.encode(tempPassword); // 암호화된 비밀번호
			
			// DB에 암호화된 비밀번호 업데이트
			memberService.updatePw(vo.getMem_id(), encoPassword);
			
			// 발신자 이름, 발신자 메일, 수신자 메일, 메일 제목, 메일 내용 순으로 생성자 인자 전달
			String subject = "임시 비밀번호 발급";
			String content = "임시 비밀번호는 아래와 같습니다.";
			
			dto = new EmailDTO (
				dto.getSenderName(), // EmailDTO
				dto.getSenderMail(), // EmailDTO
			    vo.getMem_email(), // MemberVO
			    subject, content // EmailDTO
			);
			
			log.info("이메일 서비스 정보: " + dto);
			
			// emailService.sendMail(dto, message): 
			emailService.sendMail(dto, tempPassword);
				url = "/member/login"; // 로그인 페이지 이동
				msg = "임시 비밀번호가 이메일로 전송되었습니다.";
		} else {
				url = "/member/findPw"; // 비밀번호 찾기 페이지 이동
				msg = "입력하신 정보와 일치하는 사용자가 없습니다.";
		}
		rttr.addFlashAttribute("msg", msg);
		
	    return "redirect:" + url; // 비밀번호 찾기(findPw.jsp) 또는 아이디 확인 페이지(confirmInfo.jsp) 이동
	}
}
