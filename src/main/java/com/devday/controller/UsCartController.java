package com.devday.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devday.domain.CartVO;
import com.devday.domain.UserVO;
import com.devday.dto.CartDTOList;
import com.devday.service.UsCartService;
import com.devday.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user/cart/*")
@Log4j
public class UsCartController {

	private final UsCartService cartService;

	// 메인 및 썸네일 이미지 업로드 폴더 경로 주입 작업
	// servlet-context.xml의 beans 참조 -> <beans:bean id="uploadPath"
	// class="java.lang.String">
	@Resource(name = "uploadPath")
	private String uploadPath;

	// [Oracle] 오라클 MERGE INTO 사용법 & 노하우 정리: https://gent.tistory.com/406 \

	@PostMapping("/cart_add")
	// @ResponseBody // 기능상 중복되긴 하지만, 명시적 전달을 위함(작성한다고 해서 문제가 되지 않는 어노테이션)
	public ResponseEntity<String> cart_add(CartVO vo, HttpSession session) throws Exception {

		ResponseEntity<String> entity = null;

		// 서버 ─ 로그인한 사용자의 아이디 정보 추가 작업
		// 클라이언트 ─ AJAX 방식으로 상품코드, 상품수량 2개 정보만 전송 -> data: {pro_num:
		// $(this).data("pro_num"), cart_amount: 1}
		// Object javax.servlet.http.HttpSession.getAttribute(String name)
		String us_id = ((UserVO) session.getAttribute("userStatus")).getUs_id();
		vo.setUs_id(us_id);

		cartService.cart_add(vo);

		entity = new ResponseEntity<String>("success", HttpStatus.OK);

		return entity;
	}

	// 장바구니 목록
	@GetMapping("/cart_list")
	public void cart_list(HttpSession session, Model model) throws Exception {

		String us_id = ((UserVO) session.getAttribute("userStatus")).getUs_id();

		
		// [참고] UserProductController의 @GetMapping("/pro_list")
		List<CartDTOList> cart_list = cartService.cart_list(us_id);
		
		int cart_total_price = 0;

		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 스프링에서 처리 안하면 자바스크립트에서 처리할 수도 있다.
		/*
		cart_list.forEach(vo -> {
			vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
			
			// 금액 = (판매가 - (판매가 * 할인율)) * 수량
			cart_total_price += (double) (vo.getPro_price() - (vo.getPro_price() * vo.getPro_discount() * 1/100)) * vo.getCart_amount();
		});
		*/
		
		// 위 코드는 컴파일 에러 발생해서 다음 코드로 대체함
		for (int i = 0; i < cart_list.size(); i++) {
			CartDTOList vo = cart_list.get(i);
			
			vo.setPd_image_folder(vo.getPd_image_folder().replace("\\", "/"));
			// vo.setPro_discount(vo.getPro_discount() * 1/100);
			
			cart_total_price +=  (vo.getPd_price() * vo.getCt_amount());
		}
		
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("cart_total_price", cart_total_price);

	}

	// 장바구니 이미지
	// 상품 리스트에서 보여줄 이미지. <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /user/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {

		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}
	
	// 장바구니 수량 변경
	@PostMapping("/cart_amount_change")
	public ResponseEntity<String> cart_amount_change(Long ct_code, int ct_amount) throws Exception {
		ResponseEntity<String> entity = null;
		
		cartService.cart_amount_change(ct_code, ct_amount);

		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	// 장바구니 목록에서 개별 삭제(AJAX용)
	@PostMapping("/cart_list_del")
	public ResponseEntity<String> cart_list_del1(Long ct_code) throws Exception {
		ResponseEntity<String> entity = null;
				
		cartService.cart_list_del(ct_code);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	// 장바구니 목록에서 개별 삭제(Non-AJAX용)
	@GetMapping("/cart_list_del")
	public String cart_list_del2(Long ct_code) throws Exception {
	
		cartService.cart_list_del(ct_code);
		
		return "redirect:/user/cart/cart_list";
	}
	
	//장바구니 선택삭제
	@PostMapping("/cart_sel_delete")
	public ResponseEntity<String> cart_sel_delete(@RequestParam("cart_code_arr[]") List<Long> ct_code_arr) {
		
		ResponseEntity<String> entity = null;
		
		//방법1. 하나씩 반복적으로 삭제.
		/*
		for(int i=0; i<cart_code_arr.size(); i++) {
			cartService.cart_delete(cart_code_arr.get(i));
		}
		*/
		
		//방법2. mybatis foreach : https://java119.tistory.com/85
		cartService.cart_sel_delete(ct_code_arr);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	// 장바구니 비우기는 사용자 아이디 가지고 날림
}
