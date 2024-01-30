package com.devday.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devday.domain.CategoryVO;
import com.devday.service.AdCategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//@RestController(@Controller + @ResponseBody): 모든 매핑 주소가 Ajax 호출로 사용되는 경우
@Controller // Ajax 호출 또는 일반 호출을 함께 사용하는 경우 
@Log4j
@RequiredArgsConstructor
@RequestMapping("/admin/category/*")
public class AdCategoryController {

	private final AdCategoryService adCategoryService; // GlobalControllerAdvice에서 작업함
	
	// 1차 카테고리 선택에 따른 2차 카테고리 정보를 클라이언트에 제공
	// 일반 주소: /admin/category/secondCategory?cg_parent_code=1
	// RestFUll 개발론 주소는 /admin/category/secondCategory/1.json
	// 주소의 일부분을 값으로 사용하고자 할 경우 중괄호({})를 사용한다. 
	@ResponseBody
	@GetMapping("/secondCategory/{cg_parent_code}") // secondCategory(1차 카테고리 선택)
	public ResponseEntity<List<CategoryVO>> secondCategory(@PathVariable("cg_parent_code") Integer cg_parent_code) throws Exception {  // DB 작업을 위해 ~ throws Exception
		
		// log.info("1차 카테고리 코드: " + cg_parent_code);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		entity = new ResponseEntity<List<CategoryVO>>(adCategoryService.getSecondCategoryList(cg_parent_code), HttpStatus.OK);
	
		// List<CategoryVO> list = adCategoryService.getSecondCategoryList(cg_parent_code); 
		// list 객체를 JSON으로 변환하는 라이브러리로 Jackson Databind 필요(pom.xml 참고) 
		
		return entity; // 
	}
}
