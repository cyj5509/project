package com.devday.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.devday.domain.AdminVO;
import com.devday.domain.UserVO;
import com.devday.dto.FindInfoDTO;
import com.devday.dto.LoginDTO;
import com.devday.service.AdminService;
import com.devday.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member/*")
@Log4j
public class UserController {

	private final UserService userService; 
	private final PasswordEncoder passwordEncoder; // [참고] security 폴더의 spring-security.xml
	private final AdminService adminService;
	
	// 회원가입 페이지 이동 ─ 회원가입 폼
	@GetMapping("/join")
	public void join() {
		
		log.info("회원가입 페이지 진입"); 
	}

	// 회원가입 기능 구현
	@PostMapping("/join")
	public String join(UserVO us_vo, RedirectAttributes rttr) throws Exception { 
		
		log.info("암호화 처리 전 회원정보: " + us_vo);
		log.info("암호화 처리 전 비밀번호: " + us_vo.getUs_pw());
		
		us_vo.setUs_pw(passwordEncoder.encode(us_vo.getUs_pw())); // 비밀번호 암호화 처리
		userService.join(us_vo); // 회원가입 관련 메서드 호출
		
		log.info("암호화 처리 후 회원정보: " + us_vo);
		log.info("암호화 처리 후 비밀번호: " + us_vo.getUs_pw());
		
		// 회원가입 후 환영인사
		String msg = "환영합니다! " + us_vo.getUs_id() + "님, 회원가입이 완료되었습니다.";
		rttr.addFlashAttribute("msg", msg); // 리디렉션되는 페이지에서 일회성으로 사용
		
		return "redirect:/member/login"; // 로그인 페이지로 이동
	}

	// ID 중복 검사 기능 구현(관련 페이지 불필요)
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestParam("us_id") String us_id) throws Exception {

		ResponseEntity<String> entity = null; 
		
		log.info("입력된 아이디: " + us_id);
		
		// userService.id_check(us_id): 아이디 중복검사 관련 메서드 호출
		// 아이디가 이미 존재하면 no, 존재하지 않으면 yes를 반환
		String idUse = userService.id_check(us_id) != null ? "no" : "yes";
		log.info("아이디 사용 가능: " + idUse);
		
		entity = new ResponseEntity<>(idUse, HttpStatus.OK); // HTTP 상태 코드 200
		
		return entity; // AJAX 요청 시 idUse는 success 콜백 함수에서 result로 사용
	}

	// 로그인 페이지 이동 ─ 로그인 폼
	@GetMapping("/login")
	public void login(HttpServletRequest request, Model model) {

		log.info("로그인 페이지 진입");
		
		// 쿠키에서 remember_id 값을 확인하는 로직
		Cookie[] cookies = request.getCookies();
		String remember_id = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("remember_id".equals(cookie.getName())) {
					remember_id = cookie.getValue();
					break;
				}
			}
		}
	    model.addAttribute("remember_id", remember_id);
	}

	// 로그인 기능 구현
	@PostMapping("/login")
	public String login(LoginDTO lo_dto, HttpSession session, 
						HttpServletResponse response, RedirectAttributes rttr, Model model) throws Exception {

		log.info("컨트롤러 ─ 로그인 정보: " + lo_dto); // 로그인 페이지에서 로그인 버튼 클릭 시 동작
		
		UserVO us_vo = userService.enhancedLogin(lo_dto, response);

		String url = "";
		String msg = "";

		if (us_vo != null) {
			// 세션에 us_vo를 "userStatus"라는 이름으로 저장
			session.setAttribute("userStatus", us_vo);
	        
			// 관리자인 경우 ad_check = 1, 사용자인 경우 ad_check = 0
			if (us_vo.getAd_check() == 1) {
				// 로그인 시 관리자 페이지 표시 O
				AdminVO ad_vo = adminService.admin_ok(us_vo.getUs_id());
				session.setAttribute("adminStatus", ad_vo);
				log.info("관리자로 접속했습니다."); 
			} else {
				// 로그인 시 관리자 페이지 표시 X
				log.info("사용자로 접속했습니다."); 
			}
			
			// 로그인 후 이동할 URL 설정
			if (session.getAttribute("targetUrl") != null) {
				// 로그인이 필요한 주소 요청 시 "targetUrl"라는 이름을 가져와 url에 할당
				url = (String) session.getAttribute("targetUrl"); // [참고] UserInterceptor의 getTargetUrl
			} else {
				// 로그인을 필요로 하는 것이 아닌 단순 로그인 시 메인 페이지 이동
				url = "/"; 
			}
		} else {
			// 로그인 실패: 아이디 부존재, 비밀번호 불일치, 입력란을 빈 칸으로 둔 경우
			url = "/member/login"; // 로그인 실패로 다시 로그인 페이지 이동
			msg = "아이디 또는 비밀번호가 일치하지 않습니다. 다시 입력해 주세요.";
			rttr.addFlashAttribute("msg", msg);
		}
		
		return "redirect:" + url; // 로그인 또는 메인 페이지 및 해당 페이지 이동
	}

	// 로그아웃 기능 구현(관련 페이지 불필요)
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		log.info("로그아웃 요청");
		
		session.invalidate(); // 세션 무효화(사용자 및 관리자 전체)
		
		// 로그인 상태 유지 관련 쿠키 삭제(아이디 저장 관련 쿠키는 삭제하지 않음)
		Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("loginToken".equals(cookie.getName())) {
	                cookie.setValue(null);
	                cookie.setMaxAge(0); // 쿠키 삭제
	                cookie.setPath("/"); // 쿠키 경로 설정
	                response.addCookie(cookie);
	            }
	        }
	    }
		
		return "redirect:/member/login"; // 로그아웃 시 다시 로그인 페이지 이동
	}

	// 마이 페이지로의 이동 ─ 마이 페이지 폼(회원정보 조회 기능 담당)
	@GetMapping("/my_page")
	public void myPage(HttpSession session, Model model) {
		
		log.info("마이 페이지 진입");
		
		// [참고] 인터셉터 기능으로 인해 불필요해진 부분
		// 인터셉터를 사용하지 않을 경우 아래와 같은 코드를 중복 작성
		/* 
		// 로그인 상태 확인
	    if (session.getAttribute("userStatus") == null) {
	        return "redirect:/member/login"; // 비로그인 상태의 경우 로그인 페이지로 이동(login.jsp)
	    }
	    (기존 코드...)
	    return "member/my_page"; // 로그인 상태 -> 마이 페이지로 이동(my_page.jsp)
	    */
	   
	    String us_id = ((UserVO) session.getAttribute("userStatus")).getUs_id();
		UserVO us_vo = userService.login(us_id); // userService.login(us_id): 로그인 관련 메서드 호출
		model.addAttribute("us_vo", us_vo);
	}
	
	// 회원수정 페이지 이동(회원수정 폼)
	@GetMapping("/info/modify")
	public void modify(HttpSession session, Model model) throws Exception {
		
		log.info("회원수정 페이지 진입");
		
	    String us_id = ((UserVO) session.getAttribute("userStatus")).getUs_id();
		UserVO vo = userService.login(us_id); // userService.login(us_id): 로그인 관련 메서드 호출
		model.addAttribute("vo", vo);
	}

	// 회원수정 기능 구현
	@PostMapping("/modify_info")
	public String modifyInfo(UserVO us_vo, HttpSession session, RedirectAttributes rttr) throws Exception {

		UserVO db_vo = (UserVO) session.getAttribute("userStatus");
		String us_id = db_vo.getUs_id();
		
		// 로그인된 사용자의 ID를 'vo' 객체에 설정
		us_vo.setUs_id(us_id); // String us_id = ((MemberVO) session.getAttribute("userStatus")).getUs_id();
		
		log.info("수정 전 회원정보: " + db_vo); // db_vo: 세션에 현재 로그인된 사용자의 정보
		
		userService.modify(us_vo); // 회원수정 관련 메서드 호출
		log.info("수정 후 회원정보: " + us_vo); // vo: 클라이언트 단에서 사용자가 입력한 수정 데이터

		// 세션 정보를 최신 상태로 업데이트(수정된 정보를 활용할 경우)
		// db_vo.setUs_email(vo.getUs_email());
		session.setAttribute("userStatus", us_vo);

		rttr.addFlashAttribute("msg", "modify"); // 리디렉션되는 메인 페이지(main.jsp)에서 사용

		return "redirect:/";
	}
		
	// 회원탈퇴 전 정보 확인 페이지 이동
	@GetMapping("/info/delete")
	public void delete() {

		log.info("회원탈퇴 전 정보 확인");
	}

	// 회원탈퇴 기능 구현
	@PostMapping("/delete_info")
	public String deleteInfo(LoginDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {

		log.info("회원탈퇴 요청");
		
		// userService.login(dto.getUs_id()): 로그인 관련 메서드 호출
		// DB에서 LoginDTO에 제공된 아이디로 사용자 정보 조회(암호화된 비밀번호 포함)
		UserVO db_vo = userService.login(dto.getUs_id());

		String url = "";
		String msg = "";
		
		if (db_vo != null) {
				// passwordEncoder.matches(rawPassword, encodedPassword)
				// dto.getUs_pw()는 로그인 폼에 입력한 평문 비밀번호, db_vo.getUs_pw()는 DB에 저장된 암호화된 비밀번호
			if (passwordEncoder.matches(dto.getUs_pw(), db_vo.getUs_pw())) {
				userService.delete(dto.getUs_id()); // 회원탈퇴 관련 메서드 호출
				url = "/"; // 메인 페이지 이동
				session.invalidate(); //  전체 세션 무효화
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
	@GetMapping("/info/find")
	public void findInfo() {
		
		log.info("아이디 및 비밀번호 찾기 페이지 진입");
	}
	
	// 아이디 찾기 기능 구현
	// 가입일을 전달하는 건 @ModelAttribute로 전달하는 방법을 생각해보자.
	@PostMapping("/find_id")
	public ResponseEntity<UserVO> findId(@RequestParam("us_name") String us_name, 
										@RequestParam("us_email") String us_email) throws Exception {
	    
		ResponseEntity<UserVO> entity = null;

	    FindInfoDTO findInfoDTO = FindInfoDTO.ofFindId(us_name, us_email); // 아이디 찾기용 정적 팩토리 메서드 호출
	    UserVO us_vo = userService.findId(findInfoDTO); 
	    
	    if (us_vo != null) {
	      entity = new ResponseEntity<>(us_vo, HttpStatus.OK); // HTTP 상태 코드 200
	    }
	    
	    return entity;
	}
	
	// 비밀번호 찾기 기능 구현: 세션 관련 파라미터 필요
	@PostMapping("/find_pw")
	public ResponseEntity<String> findPw(HttpSession session, 
										@RequestParam("us_id") String us_id, // 필수 파라미터(Default: true)
										@RequestParam(value = "us_name", required = false) String us_name, // 선택적 파라미터
	                                    @RequestParam(value = "us_email", required = false) String us_email // 선택적 파라미터
	                                    ) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		// 1단계 ─ 아이디 확인: 우선적 처리를 위해 2단계에서 처리될 이름과 이메일이 null인 경우 진행
		if (us_name == null && us_email == null) {
			// 아이디 존재 유무 확인
			if (userService.id_check(us_id) != null) {
				log.info("존재하는 아이디: " + us_id);
				session.setAttribute("us_id", us_id); // 세션에 아이디 저장
				entity = new ResponseEntity<>("yes", HttpStatus.OK); // HTTP 상태 코드 200 
			} else { 
				log.info("존재하지 않는 아이디: " + us_id);
				entity = new ResponseEntity<>("no", HttpStatus.OK); // HTTP 상태 코드 200  
			}
		} else {
			// 2단계 ─ 이름과 이메일 확인
			// Object javax.servlet.http.HttpSession.getAttribute(String name)
			String idForPw = (String) session.getAttribute("us_id"); // 다음 단계 진행을 위해 세션에 저장된 아이디를 변수에 할당
			// idForPw.equals(us_id): 사용자가 웹 페이지에서 입력한 아이디와 서버의 세션에 저장된 아이디가 같은지 확인
			if (idForPw != null && idForPw.equals(us_id)) {
				FindInfoDTO findInfoDTO = FindInfoDTO.ofFindPw(us_id, us_name, us_email); // 비밀번호 찾기용 정적 팩토리 메서드 호출
				// userService.processFindPw(findInfoDTO): 회원정보 조회 관련 메서드 호출
				// boolean com.devday.service.MemberService.processFindPw(FindInfoDTO findInfoDTO)
				boolean confirmInfo = userService.processFindPw(findInfoDTO);

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
	@PostMapping("/reset_pw")
	public ResponseEntity<String> resetPw(@RequestParam("us_id") String us_id,
										 @RequestParam("us_pw") String us_pw,
										 @RequestParam(value = "currentPw", required = false) String currentPw) throws Exception {

		ResponseEntity<String> entity = null;
		log.info("암호화 전 비밀번호: " + us_pw);

	    // 사용자의 현재 비밀번호 조회
		String storedPw = userService.isPwMatch(us_id);
		
		if (storedPw == null) {
			// 현재 저장된 비밀번호가 없는 경우(사용자가 존재하지 않는 경우)
			entity = new ResponseEntity<>(HttpStatus.NOT_FOUND); // HTTP 상태 코드 404
		} else if (currentPw != null && !currentPw.isEmpty() && !passwordEncoder.matches(currentPw, storedPw)) {
			// 현재 비밀번호가 제공되었으나 저장된 비밀번호가 일치하지 않는 경우(단순 재설정 시도)
			entity = new ResponseEntity<>("request", HttpStatus.OK);
		} else {
			// 현재 비밀번호가 제공되지 않았거나 제공된 비밀번호가 저장된 비밀번호와 일치하는 경우
			// 1) 비밀번호 찾기를 통한 재설정(현재 비밀번호 미제공)
			// 2) 사용자가 현재 비밀번호를 알고 있고 이를 변경하려는 경우(현재 비밀번호 제공)
			String encoPassword = passwordEncoder.encode(us_pw);
			// log.info("암호화 후 비밀번호: " + encoPassword);
			FindInfoDTO findInfoDTO = FindInfoDTO.ofResetPw(us_id, encoPassword);
			
			boolean isResetPw = userService.resetPw(findInfoDTO); // DB에 암호화된 비밀번호 업데이트
			if (isResetPw) {
				entity = new ResponseEntity<>("success", HttpStatus.OK); // HTTP 상태 코드 200: 비밀번호 재발급 성공
			} else {
				entity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); // HTTP 상태 코드 500: 비밀번호 재발급 실패
			}
		}

	    return entity;
	}
	
}
