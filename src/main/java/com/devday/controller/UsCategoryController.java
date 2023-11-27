package com.devday.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.devday.domain.CategoryVO;
import com.devday.service.UsCategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

// Bean의 생성 및 등록을 위한 설정 작업
// 1. @Controller 또는 @RestController: UserCategoryController Bean 생성
// 2. servlet-context.xml의 <context:component-scan base-package="com.docmall.controller" />

// @RestController: Only Ajax 사용. JSP 파일 불필요(해당 파일에서 사용하기 위한 데이터 작업)
// <-> @Controller: 혼합 사용 및 JSP 파일 필요
@RestController 

@RequiredArgsConstructor
@RequestMapping("/category")
@Log4j
public class UsCategoryController {

	private final UsCategoryService usCategoryService;

	// 2차 카테고리 정보를 불러오는 작업(AdCategoryController에서 Copy & Paste)
	@ResponseBody
	@GetMapping("/secondCategory/{cg_parent_code}") // secondCategory(1차 카테고리 선택)
	public ResponseEntity<List<CategoryVO>> secondCategory(@PathVariable("cg_parent_code") Integer cg_parent_code) throws Exception {  // DB 작업을 위해 ~ throws Exception
		
		// log.info("1차 카테고리 코드: " + cg_parent_code);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		entity = new ResponseEntity<List<CategoryVO>>(usCategoryService.getSecondCategoryList(cg_parent_code), HttpStatus.OK);
	
		// List<CategoryVO> list = adCategoryService.getSecondCategoryList(cg_parent_code) 
		// list 객체를 JSON으로 변환하는 라이브러리로 Jackson Databind 필요(pom.xml 참고) 
		
		return entity;
	}	
}
