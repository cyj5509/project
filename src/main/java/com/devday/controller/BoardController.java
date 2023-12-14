package com.devday.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devday.domain.BoardVO;
import com.devday.dto.BoardDTO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user/board/*")	
@RequiredArgsConstructor
@Log4j 	
public class BoardController {
	
	private final BoardService boardService;
	private final PasswordEncoder passwordEncoder; // 비회원 관련 암호화 처리를 위함(security 폴더 내 spring-security.xml) 
	
	// 게시물 등록 페이지 이동(게시물 등록 폼)
	@GetMapping(value = {"/register", "/register/{bd_type}"})
	public String register(@PathVariable(value = "bd_type", required = false) String bd_type, Model model) {
		
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
	public String register(@ModelAttribute("bd_vo") BoardVO bd_vo, HttpSession session) {
	
		log.info("게시물 등록 데이터: " + bd_vo);
		log.info("구분: " + bd_vo.getBd_type());		
		
	    // 로그인 체크 - 비회원 처리 로직
	    if (session.getAttribute("userStatus") == null) {
	    		bd_vo.setUs_id(""); // 비회원인 경우 us_id를 빈 문자열로 설정
			// 비회원 비밀번호 처리: 비밀번호가 제공된 경우 암호화 
			if (bd_vo.getBd_guest_pw() != null && !bd_vo.getBd_guest_pw().isEmpty()) {
		    		String guest_pw = bd_vo.getBd_guest_pw(); 
		    		bd_vo.setBd_guest_pw(passwordEncoder.encode(guest_pw)); // 암호화된 비밀번호로 설정
		    }
        }
		boardService.register(bd_vo); // 게시물 등록 관련 메서드 호출
		
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
		
		List<BoardVO> list = boardService.getListWithPaging(cri, bd_type);
		log.info("게시판 구분: " + bd_type); 
		log.info("타입별 목록: " + list); 
		
		model.addAttribute("list", list);
		
		int total = boardService.getTotalCount(cri, bd_type);
		
		model.addAttribute("bd_type", bd_type);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
		// log.info("데이터 총 개수: " + total);
		// log.info("페이징 정보: " + pageDTO);
		// log.info("게시판 분류: " + boardService.getListType(bd_type));
		
		return "/user/board/list"; // JSP 페이지 경로
	}
	
	// 게시물 조회 페이지 이동(게시물 조회 폼)
	@GetMapping(value = "/get/{bd_type}")
	public String getModify(@PathVariable(value = "bd_type", required = false) String bd_type,
						    @RequestParam("bd_number") Long bd_number, 
							@ModelAttribute("cri") Criteria cri, Model model) {

		log.info("게시물 조회 페이지 진입");
		log.info("조회한 게시물 번호: " + bd_number);
		log.info("조회한 페이징 및 검색 정보: " + cri);

		BoardVO bd_vo = boardService.get(bd_number);
		model.addAttribute("bd_vo", bd_vo);

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

		BoardVO bd_vo = boardService.get(bd_number);
		model.addAttribute("bd_vo", bd_vo);

		return "/user/board/modify";
	}
	
	// 게시물 수정 기능 구현
	@PostMapping("/modify")
	public String modify(BoardVO bd_vo, Criteria cri, HttpSession session, RedirectAttributes rttr) {
		
		log.info("게시물 수정 데이터: " + bd_vo);
		log.info("게시물 수정 권한 유무: " + session.getAttribute("isAuthorized"));
		
		// 수정 권한 확인
	    if (session.getAttribute("isAuthorized") == null || !(Boolean) session.getAttribute("isAuthorized")) {
	        rttr.addFlashAttribute("msg", "게시물을 수정할 권한이 없습니다.");
	        return "redirect:/user/board/get/" + bd_vo.getBd_type() + "?bd_number=" + bd_vo.getBd_number();
	    }

		boardService.modify(bd_vo); // 게시물 수정 관련 메서드 호출
		session.removeAttribute("isAuthorized"); // isAuthorized라는 특정 세션 속성 삭제
		
		// 페이징과 검색 정보를 쿼리 스트링으로 사용하기 위한 작업을 cri.getListLink()으로 대체함
		/*
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());	
		*/
		rttr.addFlashAttribute("msg", bd_vo.getBd_number() + "번 게시물이 정상적으로 수정되었습니다.");
		
		return "redirect:/user/board/list" + "/" + bd_vo.getBd_type() + cri.getListLink();
	}
	
	// 게시물 삭제 기능 구현(관련 페이지 불필요)
	@GetMapping(value = "/delete/{bd_type}")
	public String delete(@PathVariable(value = "bd_type", required = false) String bd_type, 
						BoardVO bd_vo, Criteria cri, HttpSession session, RedirectAttributes rttr) {

		log.info("게시물 삭제 데이터: " + bd_vo);
		log.info("게시물 삭제 권한 유무: " + session.getAttribute("isAuthorized"));
		
		// 삭제 권한 확인
	    if (session.getAttribute("isAuthorized") == null || !(Boolean) session.getAttribute("isAuthorized")) {
	        rttr.addFlashAttribute("msg", "게시물을 삭제할 권한이 없습니다.");
	        return "redirect:/user/board/get/" + bd_type + "?bd_number=" + bd_vo.getBd_number();
	    }
		
	    boardService.delete(bd_vo.getBd_number());
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
	public String checkPw(Long bd_number, String bd_guest_pw, String action, HttpSession session, RedirectAttributes rttr) {
	    BoardVO boardVO = boardService.get(bd_number);
	    if (boardVO != null && passwordEncoder.matches(bd_guest_pw, boardVO.getBd_guest_pw())) {
	        // 비밀번호 확인 성공, 세션에 권한 설정
	        session.setAttribute("isAuthorized", true);

	        String bd_type = boardVO.getBd_type() != null ? boardVO.getBd_type() : "total";

	        // 액션에 따라 다른 리다이렉션 처리
	        if ("modify".equals(action)) {
	            return "redirect:/user/board/modify/" + bd_type + "?bd_number=" + bd_number;
	        } else if ("delete".equals(action)) {
	            return "redirect:/user/board/delete/" + bd_type + "?bd_number=" + bd_number;
	        }
	    } else {
	        rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
	        return "redirect:/user/board/get/" + (boardVO != null ? boardVO.getBd_type() : "total") + "?bd_number=" + bd_number;
	    }
	    return "redirect:/user/board/list/" + (boardVO != null ? boardVO.getBd_type() : "total");
	}
	
}
