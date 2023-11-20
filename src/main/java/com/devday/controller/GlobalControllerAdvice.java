package com.devday.controller;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.devday.domain.CategoryVO;
import com.devday.service.AdCategoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/*
// @ControllerAdvice(basePackages = {"기본 패키지명"})
지정한 패키지(com.docmall.controller)에서 반복적으로 사용하는 Model 데이터 작업을
아래 클래스에서 한 번만 정의를 해서 사용할 때. 매번 요청이 발생될 때마다 클래스가 동작된다.
*/

@ControllerAdvice(basePackages = { "com.devday.controller" })
@Log4j
@RequiredArgsConstructor
public class GlobalControllerAdvice {

	private final AdCategoryService adCategoryService;

	@ModelAttribute // @ControllerAdvice에서는 메서드 상위 수준에 해당 작업 필요
	public void getFirstCategoryList(Model model) {

		log.info("1차 카테고리 리스트");
		
		List<CategoryVO> firstCategoryList = adCategoryService.getFirstCategoryList();
		model.addAttribute("firstCategoryList", firstCategoryList);
	}
}
