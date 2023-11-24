package com.devday.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	@GetMapping("/register")
	public void register(Model model) {
		
		log.info("called register...");
		BoardVO board = new BoardVO();
		
		// board.setBd_register_dateNow();
		
		model.addAttribute("board", board);
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute("board") BoardVO board) {
	
		log.info("게시판 입력 데이터: " + board); 		
		
		boardService.register(board);
				
		return "redirect:/user/board/list";  
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		// log.info("list: " + cri); 
	
		List<BoardVO> list = boardService.getListWithPaging(cri);
		model.addAttribute("list", list);
		
		int total = boardService.getTotalCount(cri);
		
		log.info("데이터 총 개수: " + total);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
		log.info("페이징 정보: " + pageDTO);
		
	
		// log.info("게시판 분류: " + boardService.listType(bd_type));
		
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bd_number") Long bd_number, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("게시물 번호: " + bd_number);
		log.info("페이징과 검색 정보: " + cri);
		
		BoardVO board = boardService.get(bd_number);
		model.addAttribute("board", board);
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		
		log.info("수정 데이터: " + board);
		log.info("Criteria: " + cri);
		
		boardService.modify(board);
		
		// 검색과 페이지 정보를 이동주소(/board/list)의 파라미터로 사용하기 위한 작업
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());	
		
		return "redirect:/user/board/list" + cri.getListLink();
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("bd_number") Long bd_number, Criteria cri, RedirectAttributes rttr) {
		
		log.info("삭제할 번호: " + bd_number);
		// log.info("Criteria: " + cri);
		
		boardService.delete(bd_number);
		
		// 검색과 페이지 정보를 이동주소(/board/list)의 파라미터로 사용하기 위한 작업
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());	
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/user/board/list";
	}
	
	
}
