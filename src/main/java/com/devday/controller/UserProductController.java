package com.devday.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.UserProductService;
import com.devday.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user/product")
@Log4j
public class UserProductController {

	private final UserProductService userProductService;
	
	// 메인 및 썸네일 이미지 업로드 폴더 경로 주입 작업
	// servlet-context.xml의 beans 참조 -> <beans:bean id="uploadPath" class="java.lang.String">
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 1. 일반적인 매핑 주소: /user/product/prd_list?cg_code=2차 카테고리 코드
	/*
	@GetMapping("/prd_list")
	public void prd_list(Criteria cri, @RequestParam("cg_code") Integer cg_code, Model model) throws Exception {
		
	}
	*/
	
	// 2. REST API 개발 형태의 매핑 주소: /user/product/prd_list/2차 카테고리 코드
	// 2차 카테고리를 선택했을 때 그걸 조건으로 데이터를 가져옴
	@GetMapping("/prd_list")
	public String prd_list(Criteria cri, @ModelAttribute("cg_code") Integer cg_code, String cg_name, Model model) throws Exception {
		
		// AdProductController에서 Copy & Paste
		
		// 10 -> 2 -> 8로 변경
		cri.setAmount(8); // Criteria에서 this(1, 2);

		List<ProductVO> prd_list = userProductService.prd_list(cg_code, cri);

		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 스프링에서 처리 안하면 자바스크립트에서 처리할 수도 있다.
		prd_list.forEach(vo -> {
			vo.setPd_img_folder(vo.getPd_img_folder().replace("\\", "/"));
		});
		model.addAttribute("prd_list", prd_list); // 상품 목록

		int totalCount = userProductService.getTotalCount(cg_code);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount)); // 페이징 정보
		
		return "/user/product/prd_list";
	}
	
	// 상품 리스트에서 보여줄 이미지. <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /user/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {

		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}
	
	// 상품 상세(상품 후기 작업 포함)
	// Integer cg_code, String cg_name: 액션폼에서 넘어오는 값으로 cg_name은 다시 활용
	@GetMapping("/prd_detail")
	public void prd_detail(Criteria cri, Integer cg_code, @ModelAttribute("cg_name") String cg_name, Integer prd_num, Model model) throws Exception {
	
		log.info("페이징 정보: " + cri);
		log.info("상품코드: " + prd_num);
		
		ProductVO productVO = userProductService.prd_detail(prd_num);
		// 클라이언트에서 이미지 출력작업: \(역슬래시)가 서버로 보낼 때 문제가 되어 /(슬래시)를 사용하고자 함 
		productVO.setPd_img_folder(productVO.getPd_img_folder().replace("\\", "/"));
		
		model.addAttribute("productVO", productVO); // 화면에 보여줘야 해서 모델 작업 필요

		// DB 연동작업
	}
}
