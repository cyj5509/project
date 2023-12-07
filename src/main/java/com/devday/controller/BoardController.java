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
	private final PasswordEncoder passwordEncoder; // [참고] security 폴더의 spring-security.xml
	
	@GetMapping("/register/{bd_type}")
	public String register(@PathVariable("bd_type") String bd_type, Model model) {
		
		log.info("called register...");
		
		BoardVO boardVO = new BoardVO();
		boardVO.setBd_type(bd_type);
		boardVO.setBd_register_date(new Date());
		
		model.addAttribute("boardVO", boardVO);
		
		return "/user/board/register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute("boardVO") BoardVO boardVO,
						  @RequestParam(value="bd_guest_pw", required = false) String bd_guest_pw, HttpSession session) {
	
		log.info("게시판 입력 데이터: " + boardVO);
		log.info("게시판 종류: " + boardVO.getBd_type());		
		
	    // 비회원 게시글 작성 시 비밀번호 암호화 처리
	    if (bd_guest_pw != null && !bd_guest_pw.isEmpty()) {
	    		String guest_pw = passwordEncoder.encode(bd_guest_pw); // 암호화된 비밀번호 ─ 서버용(DB 저장)
	        boardVO.setBd_guest_pw(guest_pw); // 암호화된 비밀번호로 필드값 설정
	    }
		
	    // 로그인 체크
	    if (session.getAttribute("userStatus") == null) {
	        // 비회원 처리: 회원 아이디가 비어 있으면 'guest'로 설정
	        if (boardVO.getUs_id() == null || boardVO.getUs_id().isEmpty()) {
	            boardVO.setUs_id("guest");
	        }
	    }
		
		boardService.register(boardVO);
		
		return "redirect:/user/board/list" + "/" + boardVO.getBd_type();  
	}
	
	@GetMapping(value = {"/list", "/list/{bd_type}"})
	public String list(@PathVariable(value = "bd_type", required = false) String bd_type, Criteria cri, Model model) {
		
		// bd_type이 null이거나 빈 문자열인 경우, 전체 게시판("total")로 설정
		if (bd_type == null || bd_type == "") {
			bd_type = "total";
		}
		
		// log.info("list: " + cri); 
		BoardVO boardVO = new BoardVO();
		boardVO.setBd_type(bd_type);
		
		List<BoardVO> list = boardService.getListWithPaging(cri, bd_type);
		log.info("게시판 타입: " + bd_type); 
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
	
	
	@GetMapping("/get/{bd_type}") 
	public String get(@PathVariable("bd_type") String bd_type, 
					  @RequestParam("bd_number") Long bd_number, 
				      @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("게시물 번호: " + bd_number);
		log.info("페이징과 검색 정보: " + cri);
		
		BoardVO boardVO = boardService.get(bd_number);
		
		model.addAttribute("boardVO", boardVO);
		
		return "/user/board/get"; // JSP 페이지 경로
	}
	
	@GetMapping("/modify/{bd_type}") 
	public String modify(@PathVariable("bd_type") String bd_type, 
						@RequestParam("bd_number") Long bd_number, 
						@ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("게시물 번호: " + bd_number);
		log.info("페이징과 검색 정보: " + cri);
		
		BoardVO boardVO = boardService.get(bd_number);
		
		model.addAttribute("boardVO", boardVO);
		
		return "/user/board/modify"; // JSP 페이지 경로
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO boardVO, Criteria cri, RedirectAttributes rttr,
						@RequestParam(value="bd_guest_pw", required=false) String bd_guest_pw) {
		
		log.info("수정 데이터: " + boardVO);
		log.info("Criteria: " + cri);
		
		// DTO로 처리할 방법 강구해볼 것
		BoardVO existingBoard = boardService.get(boardVO.getBd_number());
		if (existingBoard != null) {
			// 비회원이 작성한 게시글인 경우 비밀번호 확인
			if ("guest".equals(existingBoard.getUs_id())) {
				if (bd_guest_pw == null || !passwordEncoder.matches(bd_guest_pw, existingBoard.getBd_guest_pw())) {
					rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
					return "redirect:/user/board/modify/" + existingBoard.getBd_type();
				}
			}
			boardService.modify(boardVO);

			// 검색과 페이지 정보를 이동주소(/board/list)의 파라미터로 사용하기 위한 작업
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
		}
		return "redirect:/user/board/list" + "/" + boardVO.getBd_type() + cri.getListLink();
	}
	
	@GetMapping("/delete/{bd_type}")
	public String delete(@PathVariable("bd_type") String bd_type, @RequestParam("bd_number") Long bd_number,
					    @RequestParam(value = "bd_guest_pw", required = false) String bd_guest_pw,
					    Criteria cri, RedirectAttributes rttr) {

		log.info("삭제할 게시판: " + bd_type);
		log.info("삭제할 번호: " + bd_number);
		// log.info("Criteria: " + cri);

		BoardVO existingBoard = boardService.get(bd_number);
		if (existingBoard != null) {
			// 비회원이 작성한 게시글인 경우 비밀번호 확인
			if ("guest".equals(existingBoard.getUs_id())) {
				if (bd_guest_pw == null || !passwordEncoder.matches(bd_guest_pw, existingBoard.getBd_guest_pw())) {
					rttr.addFlashAttribute("message", "Invalid password");
					return "redirect:/user/board/list/" + bd_type + "?pageNum=" + cri.getPageNum() + "&amount="
							+ cri.getAmount() + "&type=" + cri.getType() + "&keyword=" + cri.getKeyword();
				}
			}

			boardService.delete(bd_number);

			// 검색과 페이지 정보를 이동주소(/board/list)의 파라미터로 사용하기 위한 작업
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

			BoardVO boardVO = new BoardVO();
			boardVO.setBd_type(bd_type);
		}
		return "redirect:/user/board/list" + "/" + bd_type;
	}
	
}
