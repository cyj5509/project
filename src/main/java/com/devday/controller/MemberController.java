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
import com.devday.dto.FindInfoDTO;
import com.devday.dto.LoginDTO;
import com.devday.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member/*")
@Log4j
public class MemberController {

	private final MemberService memberService; // MemberService 인터페이스 implementsMemberServiceImpl 클래스
	
	// spring-security.xml의 <bean id="bCryptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder">
	// PasswordEncoder 인터페이스 implements BCryptPasswordEncoder 클래스
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

		// ResponseEntity<String> entity = new ResponseEntity<>(idUse, HttpStatus.OK);
		ResponseEntity<String> entity = null; 
		
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
	@GetMapping("/modifyInfo")
	public void modifyInfo(HttpSession session, Model model) throws Exception {
		
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
		session.setAttribute("loginStatus", vo);

		rttr.addFlashAttribute("msg", "modify"); // 리디렉션되는 메인 페이지(main.jsp)에서 사용

		return "redirect:/";
	}
		
	// 회원탈퇴 전 정보 확인 페이지 이동
	@GetMapping("/deleteInfo")
	public void deleteInfo() {

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
				url = "/member/deleteInfo"; // 회원인증 페이지 이동
				msg = "비밀번호가 일치하지 않습니다.";
				rttr.addFlashAttribute("msg", msg); 
			}
		} else {
			// 아이디가 존재하지 않거나 빈 칸으로 둔 경우
			url = "/member/deleteInfo"; // 회원인증 페이지 이동
			msg = "아이디를 다시 입력해주세요.";
			rttr.addFlashAttribute("msg", msg); 
		}

		return "redirect:" + url; // 메인 페이지 또는 회원인증 페이지(delConfirmInfo.jsp) 이동
	}
	
	// 아이디 및 비밀번호 찾기 페이지 이동
	@GetMapping("/findInfo")
	public void findInfo() {
		
		log.info("아이디 및 비밀번호 찾기 페이지 진입");
	}
	
	// 아이디 찾기 기능 구현
	@PostMapping("/findId")
	public ResponseEntity<MemberVO> findId(@RequestParam("mem_name") String mem_name, 
										  @RequestParam("mem_email") String mem_email) throws Exception {
	    
		ResponseEntity<MemberVO> entity = null;

	    FindInfoDTO findInfoDTO = FindInfoDTO.ofFindId(mem_name, mem_email); // 아이디 찾기용 정적 팩토리 메서드 호출
	    MemberVO memberVO = memberService.findId(findInfoDTO); 
	    
	    if (memberVO != null) {
	      entity = new ResponseEntity<>(memberVO, HttpStatus.OK);
	    }
	    
	    return entity;
	}
	
	// 비밀번호 찾기 기능 구현: 세션 관련 파라미터 필요
	@PostMapping("/findPw")
	public ResponseEntity<String> findPw(HttpSession session, 
										@RequestParam("mem_id") String mem_id, // 필수 파라미터(Default: true)
										@RequestParam(value = "mem_name", required = false) String mem_name, // 선택적 파라미터
	                                     @RequestParam(value = "mem_email", required = false) String mem_email // 선택적 파라미터
	                                     ) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		// 1단계 ─ 아이디 확인: 우선적 처리를 위해 2단계에서 처리될 이름과 이메일이 null인 경우 진행
		if (mem_name == null && mem_email == null) {
			// 아이디 존재 유무 확인
			if (memberService.idCheck(mem_id) != null) {
				log.info("존재하는 아이디: " + mem_id);
				session.setAttribute("mem_id", mem_id); // 세션에 아이디 저장
				entity = new ResponseEntity<>("yes", HttpStatus.OK);
			} else { 
				log.info("존재하지 않는 아이디: " + mem_id);
				entity = new ResponseEntity<>("no", HttpStatus.OK); // 
			}
		} else {
			// 2단계 ─ 이름과 이메일 확인
			// Object javax.servlet.http.HttpSession.getAttribute(String name)
			String idForPw = (String) session.getAttribute("mem_id"); // 다음 단계 진행을 위해 세션에 저장된 아이디를 변수에 할당
			// idForPw.equals(mem_id): 사용자가 웹 페이지에서 입력한 아이디와 서버의 세션에 저장된 아이디가 같은지 확인
			if (idForPw != null && idForPw.equals(mem_id)) {
				FindInfoDTO findInfoDTO = FindInfoDTO.ofFindPw(mem_id, mem_name, mem_email); // 비밀번호 찾기용 정적 팩토리 메서드 호출
				// memberService.processFindPw(findInfoDTO): 회원정보 조회 관련 메서드 호출
				// boolean com.devday.service.MemberService.processFindPw(FindInfoDTO findInfoDTO)
				boolean confirmInfo = memberService.processFindPw(findInfoDTO);

				if (confirmInfo) {
					entity = new ResponseEntity<>("yes", HttpStatus.OK); // HTTP 상태 코드(200): 임시 비밀번호 발송 성공
				} else {
					entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // HTTP 상태 코드(500): 임시 비밀번호 발송 실패
				}
			}
		}
		return entity;
	}


	// 비밀번호 재설정 기능 구현
	@PostMapping("/resetPw")
	public ResponseEntity<String> resetPw(@RequestParam("mem_id") String mem_id,
										 @RequestParam("mem_pw") String mem_pw,
										 @RequestParam(value = "currentPw", required = false) String currentPw) throws Exception {

		ResponseEntity<String> entity = null;

		log.info("암호화 전 비밀번호: " + mem_pw);

	    // 사용자의 현재 비밀번호 조회
		String storedPw = memberService.isPwMatch(mem_id);
		if (storedPw == null) {
		    // 현재 저장된 비밀번호가 없는 경우(사용자가 존재하지 않는 경우)
			entity = new ResponseEntity<>(HttpStatus.NOT_FOUND); // HTTP 상태 코드(404)
		} else if (!passwordEncoder.matches(currentPw, storedPw)) {
			// 클라이언트가 제공한 현재 비밀번호와 저장된 비밀번호가 일치하지 않음
			entity = new ResponseEntity<>("request", HttpStatus.OK);
		} else {
			// 위의 두 조건이 모두 아닌 경우 (비밀번호 재설정 가능)
			String encoPassword = passwordEncoder.encode(mem_pw);
			// log.info("암호화 후 비밀번호: " + encoPassword);

			FindInfoDTO findInfoDTO = FindInfoDTO.ofResetPw(mem_id, encoPassword);
			boolean isResetPw = memberService.resetPw(findInfoDTO); // DB에 암호화된 비밀번호 업데이트

			if (isResetPw) {
				entity = new ResponseEntity<>("success", HttpStatus.OK); // HTTP 상태 코드(200): 비밀번호 재발급 성공
			} else {
				entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // HTTP 상태 코드(500): 비밀번호 재발급 실패
			}
		}

	    return entity;
	}
		
	
//	// 위에서 이미 작성한 코드라 중복되는 부분이 있어 나머지 내용들은 View에서 처리할 예정
//	@PostMapping("/findPw")
//	public String findPw(MemberVO vo, RedirectAttributes rttr) throws Exception {
//		
//		// 비밀번호 찾기 전 사용자 존재 유무 확인
//		// int user_check = memberService.findPw(vo.getMem_id(), vo.getMem_name(), vo.getMem_email());
//		
//		String url = "";
//		String msg = "";
//		
//		 if (user_check > 0) {
//	         ResponseEntity<String> response = emailDTO.sendResetPw(vo.getMem_email());
//			  ResponseEntity<String> response = emailService.sendResetPw(memberVO, emailDTO);
//			 if (response.getStatusCode() == HttpStatus.OK) {
//	            msg = "임시 비밀번호가 이메일로 전송되었습니다.";
//	            url = "/member/login"; // 로그인 페이지 이동
//			} else {
//			    msg = "이메일 발송에 실패했습니다.";
//			    url = "/member/findPw"; // 비밀번호 찾기 페이지 이동
//			}
//		} 
//		else {
//				url = "/member/findPw"; // 비밀번호 찾기 페이지 이동
//				msg = "입력하신 정보와 일치하는 사용자가 없습니다.";
//		}
//		rttr.addFlashAttribute("msg", msg);
//		
//	    return "redirect:" + url; // 비밀번호 찾기(findPw.jsp) 또는 아이디 확인 페이지(confirmInfo.jsp) 이동
//	}

	
}
