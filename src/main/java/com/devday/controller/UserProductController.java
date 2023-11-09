package com.devday.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.UserProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user/product")
@Log4j
public class UserProductController {

	private final UserProductService userProductService;
	
	// 1. 일반적인 매핑 주소: /user/product/prd_list?cg_code=2차 카테고리 코드
	/*
	@GetMapping("/prd_list")
	public void prd_list(Criteria cri, @RequestParam("cg_code") Integer cg_code, Model model) throws Exception {
		
	}
	*/
	
	// 2. REST API 개발 형태의 매핑 주소: /user/product/prd_list/2차 카테고리 코드
	// 2차 카테고리를 선택했을 때 그걸 조건으로 데이터를 가져옴
	@GetMapping("/prd_list/{cg_code}")
	public void prd_list(Criteria cri, @PathVariable("cg_code") Integer cg_code, Model model) throws Exception {
		
		// AdProductController에서 Copy & Paste
		
		// 10 -> 2로 변경
		cri.setAmount(2); // Criteria에서 this(1, 2);

		List<ProductVO> prd_list = userProductService.prd_list(cg_code, cri);

		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		prd_list.forEach(vo -> {
			vo.setPrd_up_folder(vo.getPrd_up_folder().replace("\\", "/"));
		});
		model.addAttribute("prd_list", prd_list);

		int totalCount = userProductService.getTotalCount(cg_code);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
	}
}
