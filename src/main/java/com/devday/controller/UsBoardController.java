package com.devday.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devday.domain.BoardVO;
import com.devday.domain.CommentVO;
import com.devday.domain.UserVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.UsBoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user/board/*")	
@RequiredArgsConstructor
@Log4j 	
public class UsBoardController {
	
	private final UsBoardService usBoardService;
	
	// 비회원 관련 암호화 처리(security 폴더 내 spring-security.xml)
	private final PasswordEncoder passwordEncoder;  
	
	// CKEditor에서 사용되는 업로드 폴더 경로
	@Resource(name = "uploadBoardCKPath")
	private String uploadBoardCKPath;
	
	// 게시물 등록 페이지 이동(게시물 등록 폼)
	@GetMapping(value = {"/register", "/register/{bd_type}"})
	public String register(@PathVariable(value = "bd_type", required = false) String bd_type, 
						  Model model) {
		
		log.info("게시물 등록 페이지 진입");
		
		// 게시물 구분이 null이거나 빈 문자열인 경우, 전체 게시판으로 설정
		if (bd_type == null || bd_type == "") {
			bd_type = "total";
		}
		
		BoardVO bd_vo = new BoardVO();
		bd_vo.setBd_type(bd_type);
		bd_vo.setBd_register_date(new Date());
		
		model.addAttribute("bd_vo", bd_vo);
		
		return "/user/board/register";
	}
	
	// 게시물 등록 기능 구현
	@PostMapping("/register")
	public String register(@ModelAttribute("bd_vo") BoardVO bd_vo, HttpSession session, RedirectAttributes rttr) {
	
		log.info("게시물 등록 데이터: " + bd_vo);
		log.info("구분: " + bd_vo.getBd_type());		
		
		// 로그인 체크 - 비회원 처리 로직
		if (session.getAttribute("userStatus") == null) {
			bd_vo.setUs_id(null); // 비회원인 경우 us_id를 빈 문자열로 설정

			// 비회원 닉네임 처리: 닉네임이 제공되지 않은 경우 기본값 설정
			if (bd_vo.getBd_guest_nickname() == null || bd_vo.getBd_guest_nickname().trim().isEmpty()) {
				bd_vo.setBd_guest_nickname("guest"); // 기본값으로 'guest' 설정
			}
			// 비회원 비밀번호 처리: 비밀번호가 제공된 경우 암호화
			if (bd_vo.getBd_guest_pw() != null && !bd_vo.getBd_guest_pw().isEmpty()) {
				String guest_pw = bd_vo.getBd_guest_pw();
				bd_vo.setBd_guest_pw(passwordEncoder.encode(guest_pw)); // 암호화된 비밀번호로 설정
			}
		}
		usBoardService.register(bd_vo); // 게시물 등록 관련 메서드 호출

		rttr.addFlashAttribute("msg", "게시물이 정상적으로 등록되었습니다.");
		return "redirect:/user/board/list" + "/" + bd_vo.getBd_type();  
	}
	
	// 게시물 목록 페이지 이동(게시물 목록 폼)
	@GetMapping(value = {"/list", "/list/{bd_type}"})
	public String list(@PathVariable(value = "bd_type", required = false) String bd_type, Criteria cri, Model model) {
		
		log.info("게시물 목록 페이지 진입");
		
		// 게시물 구분이 null이거나 빈 문자열인 경우, 전체 게시판으로 설정
		if (bd_type == null || bd_type == "") {
			bd_type = "total";
		}
		
		// log.info("list: " + cri); 
		BoardVO boardVO = new BoardVO();
		boardVO.setBd_type(bd_type);
		
		List<BoardVO> list = usBoardService.getListWithPaging(cri, bd_type);
		int total = usBoardService.getTotalCount(cri, bd_type);
		PageDTO pageDTO = new PageDTO(cri, total);
		
		log.info("게시판 구분: " + bd_type); 
		log.info("타입별 목록: " + list); 
		
		model.addAttribute("list", list);		
		model.addAttribute("bd_type", bd_type);
		
		model.addAttribute("pageMaker", pageDTO);
		
		// log.info("데이터 총 개수: " + total);
		// log.info("페이징 정보: " + pageDTO);
		// log.info("게시판 분류: " + usBoardService.getListType(bd_type));
		
		return "/user/board/list"; // JSP 페이지 경로
	}
	
	// 게시물 조회 페이지 이동(게시물 조회 폼)
	@GetMapping(value = {"/get", "/get/{bd_type}"})
	public String get(@PathVariable(value = "bd_type", required = false) String bd_type,
			          @RequestParam("bd_number") Long bd_number, Model model,
			          @ModelAttribute("cri") Criteria cri) {

		log.info("게시물 조회 페이지 진입");
		log.info("조회한 게시물 번호: " + bd_number);
		log.info("조회한 페이징 및 검색 정보: " + cri);

		BoardVO bd_vo = usBoardService.get(bd_number, true); // 게시물 조회 관련 메서드 호출(조회 증가 처리 포함)
		model.addAttribute("bd_vo", bd_vo);
		
	    CommentVO cm_vo = new CommentVO();
	    model.addAttribute("cm_vo", cm_vo);

		return "/user/board/get";
	}
	
	// 게시물 수정 페이지 이동(게시물 수정 폼)
	@GetMapping(value = "/modify/{bd_type}")
	public String modify(@PathVariable(value = "bd_type", required = false) String bd_type,
						@RequestParam("bd_number") Long bd_number, 
						@ModelAttribute("cri") Criteria cri, Model model) {

		log.info("게시물 수정 페이지 진입");
		log.info("수정할 게시물 번호: " + bd_number);
		log.info("수정할 페이징 및 검색 정보: " + cri);

		BoardVO bd_vo = usBoardService.get(bd_number, false);
		model.addAttribute("bd_vo", bd_vo);

		return "/user/board/modify";
	}
	
	// 게시물 수정 기능 구현
	@PostMapping("/modify")
	public String modify(BoardVO bd_vo, Criteria cri, HttpSession session, RedirectAttributes rttr) {
		
		log.info("게시물 수정 데이터: " + bd_vo);
		log.info("게시물 수정 권한 유무: " + session.getAttribute("isAuthorized"));
		
		BoardVO db_vo = usBoardService.get(bd_vo.getBd_number(), false); // 수정하려는 게시물 정보 불러오기
		UserVO us_vo = (UserVO) session.getAttribute("userStatus"); // 현재 로그인한 사용자 정보 확인
		
		// 권한 부여 유무 확인: true 일 때만 true로 설정되고 false 또는 null인 경우는 false로 설정
		Boolean isAuthorized = Boolean.TRUE.equals(session.getAttribute("isAuthorized"));
		
		// 로그인 상태에서의 권한 없음 처리
		if (us_vo != null) {
			if (!us_vo.getUs_id().equals(db_vo.getUs_id()) && !isAuthorized) {
				// 회원이 다른 회원의 게시물 또는 비회원 게시물을 수정하려는 경우
				rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물을 수정할 권한이 없습니다.");
				return "redirect:/user/board/get/" + bd_vo.getBd_type() + cri.getListLink() + "&bd_number="
						+ bd_vo.getBd_number();
			}
		} 
		// 로그인하지 않은 상태에서의 권한 없음 처리
		else if (!isAuthorized) {
			// 비회원이 회원의 게시물 또는 비밀번호 검증을 통해 인증받지 못한 상태의 게시물을 수정하려는 경우 
			log.info("isAuthorized 상태: " + session.getAttribute("isAuthorized")); // isAuthorized 상태: null
			rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물을 수정할 권한이 없습니다.");
			return "redirect:/user/board/get/" + bd_vo.getBd_type() + cri.getListLink() + "&bd_number="
					+ bd_vo.getBd_number();
		}
		
		// 권한이 있는 경우 게시물 수정 처리
		usBoardService.modify(bd_vo); // 게시물 수정 관련 메서드 호출
		session.removeAttribute("isAuthorized"); // isAuthorized라는 특정 세션 속성 삭제
		
		// 페이징과 검색 정보를 쿼리 스트링으로 사용하기 위한 작업(cri.getListLink()으로 대체)
		/*
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());	
		*/
		rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물이 정상적으로 수정되었습니다.");
		
		return "redirect:/user/board/list/" + bd_vo.getBd_type() + cri.getListLink();
	}
	
	// 게시물 삭제 기능 구현(관련 페이지 불필요)
	@GetMapping(value = "/delete/{bd_type}")
	public String delete(@PathVariable(value = "bd_type", required = false) String bd_type, 
						BoardVO bd_vo, Criteria cri, HttpSession session, RedirectAttributes rttr) {

		log.info("게시물 삭제 데이터: " + bd_vo);
		log.info("게시물 삭제 권한 유무: " + session.getAttribute("isAuthorized"));
		
		BoardVO db_vo = usBoardService.get(bd_vo.getBd_number(), false); // 삭제하려는 게시물 정보 불러오기
		UserVO us_vo = (UserVO) session.getAttribute("userStatus"); // 현재 로그인한 사용자 정보 확인
		
		// 권한 부여 유무 확인: true 일 때만 true로 설정되고 false 또는 null인 경우는 false로 설정
		Boolean isAuthorized = Boolean.TRUE.equals(session.getAttribute("isAuthorized")); 
	
		// 로그인한 상태에서의 권한 없음 처리
		if (us_vo != null) {
			if (!us_vo.getUs_id().equals(db_vo.getUs_id()) && !isAuthorized) {
				// 다른 회원의 게시물 또는 비회원 게시물을 삭제하려는 경우
				rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물을 삭제할 권한이 없습니다.");
				return "redirect:/user/board/get/" + bd_vo.getBd_type() + cri.getListLink() + "&bd_number="
						+ bd_vo.getBd_number();
			}
		} 
		// 로그인하지 않은 상태에서의 권한 없음 처리
		else if (!isAuthorized) {
			// 비회원이 회원의 게시물 또는 비밀번호 검증을 통해 인증받지 못한 상태의 게시물을 삭제하려는 경우
			rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물을 삭제할 권한이 없습니다.");
			return "redirect:/user/board/get/" + bd_vo.getBd_type() + cri.getListLink() + "&bd_number="
					+ bd_vo.getBd_number();
		}
		
		// 권한이 있는 경우 게시물 삭제 처리
	    usBoardService.delete(bd_vo.getBd_number()); // 게시물 삭제 관련 메서드 호출
	    session.removeAttribute("isAuthorized"); // isAuthorized라는 특정 세션 속성 삭제
		
	    // 페이징과 검색 정보를 쿼리 스트링으로 사용하기 위한 작업을 cri.getListLink()으로 대체함
 		/*
 		rttr.addAttribute("pageNum", cri.getPageNum());
 		rttr.addAttribute("amount", cri.getAmount());
 		rttr.addAttribute("type", cri.getType());	
 		rttr.addAttribute("keyword", cri.getKeyword());	
 		*/
	    rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물이 정상적으로 삭제되었습니다.");
		return "redirect:/user/board/list/" + bd_type + cri.getListLink();
	}
	
	@PostMapping("/checkPw")
	public String checkPw(Long bd_number, String bd_guest_pw, String action, Criteria cri, HttpSession session, RedirectAttributes rttr) {
		
	    BoardVO db_vo = usBoardService.get(bd_number, false);
	    if (db_vo != null && passwordEncoder.matches(bd_guest_pw, db_vo.getBd_guest_pw())) {
	        // 비밀번호 확인 성공, 세션에 권한 설정
	        session.setAttribute("isAuthorized", true);

	        String bd_type = db_vo.getBd_type() != null ? db_vo.getBd_type() : "total";

	        // 액션에 따라 다른 리다이렉션 처리
	        if ("modify".equals(action)) {
	            return "redirect:/user/board/modify/" + bd_type + cri.getListLink() + "&bd_number=" + bd_number;
	        } else if ("delete".equals(action)) {
	            return "redirect:/user/board/delete/" + bd_type +  cri.getListLink() + "&bd_number=" + bd_number;
	        }
	    } else {
	        rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 시도해 주세요.");
	        return "redirect:/user/board/get/" + (db_vo != null ? db_vo.getBd_type() : "total") + cri.getListLink() + "&bd_number=" + bd_number;
	    }
	    return "redirect:/user/board/list/" + (db_vo != null ? db_vo.getBd_type() : "total");
	}
	
	@PostMapping("/imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {

		// 클라이언트에게 보내는 응답 설정
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		try {
			// 1) 파일 업로드 작업
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 전송한 파일 이름
			// String uniqueFileName = UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(fileName);
			// 파일 이름에 현재 시간을 밀리초 단위로 추가 (예: myfile_1234567890.jpg)
	        String uniqueFileName = FilenameUtils.getBaseName(fileName) + "_" +
	                                System.currentTimeMillis() + "." +
	                                FilenameUtils.getExtension(fileName);
			String ckUploadPath = uploadBoardCKPath + File.separator + uniqueFileName;

			log.info("CKEditor 파일 경로: " + ckUploadPath);

			// try-with-resources를 사용하여 자동 리소스 관리
	        try (OutputStream outputStream = new FileOutputStream(new File(ckUploadPath))) { // 0KB 파일 생성
	            byte[] bytes = upload.getBytes(); // 업로드한 파일을 byte 배열로 읽어들임
	            outputStream.write(bytes); // 출력 스트림 작업
	            outputStream.flush();
	        }

	        try (PrintWriter printWriter = response.getWriter()) {
	            String fileUrl = "/ckupload/board/" + uniqueFileName;
	            printWriter.println("{\"filename\":\"" + uniqueFileName + "\", \"uploaded\":1, \"url\":\"" + fileUrl + "\"}");
	            printWriter.flush();
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
