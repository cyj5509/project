package com.devday.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.devday.domain.ReviewVO;
import com.devday.domain.UserVO;
import com.devday.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // AJAX로만 활용(JSP 파일 미사용)
@RequiredArgsConstructor
@RequestMapping("/user/review/*") 
@Log4j
public class ReviewController {
	
	private final ReviewService reviewService;
	
	// consumes = "application/json": 클라이언트에서 보내온 정보를 JSON으로 받겠다는 설정
	// @RequestBody: JSON 데이터를 ReviewVO 객체로 변환해주는 기능
	// [참고] @ResponseBody: 반대의 의미를 가진 어노테이션
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> review_insert(@RequestBody ReviewVO vo, HttpSession session) throws Exception {
		
		log.info("리뷰: " + vo);
		
		String us_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();
		vo.setUs_id(us_id);
		
		ResponseEntity<String> entity = null;
		
		// DB 저장
		reviewService.review_insert(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	// 전통적인 형태의 주소 list?pro_num=10&page=1 -> REST API 개발형태 주소 list/10/1
	@GetMapping("/list/{pro_num}/{page}") // RESTful 개발방법론의 주소
	public ResponseEntity<Map<String, Object>> list(@PathVariable("pro_num") Integer pro_num, 
												   @PathVariable("page") Integer page) throws Exception {
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		
		return entity;
	}

}
