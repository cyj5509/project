package com.devday.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.devday.domain.ReviewVO;
import com.devday.domain.UserVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
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
	
	// 상품후기 수정
	@PutMapping(value = "/modify", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> review_modify(@RequestBody ReviewVO vo, HttpSession session) throws Exception {

		log.info("리뷰 수정: " + vo);

		String us_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();
		vo.setUs_id(us_id);

		ResponseEntity<String> entity = null;

		// DB 저장
		reviewService.review_modify(vo);

		entity = new ResponseEntity<String>("success", HttpStatus.OK);

		return entity;
	}
	
	// 전통적인 형태의 주소 list?pro_num=10&page=1 -> REST API 개발형태 주소 list/10/1
	// ResponseEntity<String>는 AJAX 요청 시 SELECT 외 나머지, AJAX 요청 시 SELECT면 해당하는 리턴 타입 필요
	@GetMapping("/list/{pd_number}/{page}") // RESTful 개발방법론의 주소
	public ResponseEntity<Map<String, Object>> list(@PathVariable("pd_number") Integer pd_number, 
												   @PathVariable("page") Integer page) throws Exception {
		
		// 리턴 타입에 따른 구분 ─ SELECT 문
		// ResponseEntity<Map<String, Object>>: 1) 상품 후기 목록 데이터 ─ List<ReviewVO>, 2)페이징 데이터 ─ PageDTO 실제 작업 
		// ResponseEntity<List<ReviewVO>>: 상품 후기 목록 데이터 ─ List<ReviewVO>
		// ResponseEntity<PageDTO>: 페이징 데이터
		
		// 리턴 타입에 따른 구분 ─ INSERT, DELETE, UPDATE 문
		// ResponseEntity<String>
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 1) 상품 후기 목록 데이터: Handelbars 이용
		Criteria cri = new Criteria(); // 파라미터가 아닌 수동 작업
		cri.setAmount(2); // 기본값이 10이라서 2개씩 조회
		cri.setPageNum(page);
		
		// DB 연동
		// List<ReviewVO> com.devday.service.ReviewService.list(Integer pro_num, Criteria cri)
		List<ReviewVO> list = reviewService.list(pd_number, cri);
		
		// 2) 페이징 데이터: 순수 자바스크립트 문법
		
		// DB 연동
		// int com.devday.service.ReviewService.listCount(Integer pro_num)
		int listCount = reviewService.listCount(pd_number);
		PageDTO pageMaker = new PageDTO(cri, listCount);
		
		// map.put(key, value)
		map.put("list", list); // 상품 후기 목록 데이터 ─ List<ReviewVO>
		map.put("pageMaker", pageMaker); //  페이징 데이터 ─ PageDTO
		
		// Jackson-Databind 라이브러리에 의하여 map -> JSON으로 변환되어 AJAX 호출한 쪽으로 리턴값이 보내진다.
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
	// 상품후기 삭제
	// 웹 요청 방식인 GET(SELECT 문), POST(SELECT 제외) 외에 PUT/PETCH(UPDATE 문), DELETE(DELETE 문)
	// REST API 개발방법론 CRUD(Create, Read, Update, Delete)에 의함
	@DeleteMapping("/delete/{rv_number}")
	public ResponseEntity<String> delete(@PathVariable("rv_number") Long rv_number) throws Exception {

		ResponseEntity<String> entity = null;

		// DB 연동
		reviewService.delete(rv_number);
		entity = new ResponseEntity<String>("success", HttpStatus.OK); // HTTP 상태 코드 200

		return entity;
	}
}
