package com.devday.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devday.domain.CartVO;
import com.devday.domain.OrderBasicVO;
import com.devday.domain.PaymentVO;
import com.devday.domain.UserVO;
import com.devday.dto.CartDTOList;
import com.devday.kakaopay.ApproveResponse;
import com.devday.kakaopay.ReadyResponse;
import com.devday.service.CartService;
import com.devday.service.KakaoPayServiceImpl;
import com.devday.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user/order/*")
@Log4j
public class OrderController {

	private final CartService cartService;
	private final OrderService orderService;
	private final KakaoPayServiceImpl kakaoPayServiceImpl;
	
	// 주문 정보 페이지 이동
	@GetMapping("/order_info")
	public void order_info(HttpSession session, Model model) throws Exception {
		
		log.info("주문 정보 페이지 진입");
		
		// 주문 정보
		String us_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();

		
		// [참고] UserProductController의 @GetMapping("/pro_list")
		List<CartDTOList> order_info = cartService.cart_list(us_id);
		
		int od_price = 0;

		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 스프링에서 처리 안하면 자바스크립트에서 처리할 수도 있다.
		/*
		cart_list.forEach(vo -> {
			vo.setPd_image_folder(vo.getPd_image_folder().replace("\\", "/"));
			
			// 금액 = (판매가 - (판매가 * 할인율)) * 수량
			cart_total_price += (double) (vo.getPd_price() - (vo.getPd_price() * vo.getPd_discount() * 1/100)) * vo.getCt_amount();
		});
		*/
		
		// 위 코드는 컴파일 에러 발생해서 다음 코드로 대체함
		for (int i = 0; i < order_info.size(); i++) {
			CartDTOList vo = order_info.get(i);
			
			vo.setPd_image_folder(vo.getPd_image_folder().replace("\\", "/"));
			// vo.setPd_discount(vo.getPd_discount() * 1/100);
			
			od_price += (vo.getPd_price() * vo.getCt_amount());
		}
		
		model.addAttribute("order_info", order_info);
		model.addAttribute("od_price", od_price);
	}
	
	// 상품상세에서 주문하기
	@GetMapping("/order_ready")
	public String order_ready(CartVO vo, HttpSession session) throws Exception {

		String us_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();
		vo.setUs_id(us_id);

		cartService.cart_add(vo);

		return "redirect:/user/order/order_info"; // 주문정보 페이지
	}
	
	// 주문 정보 페이지에서 카카오페이 결제 선택을 진행한 경우: 주문 정보, 주문 상세 정보, 결제 정보가 한꺼번에 들어옴
	// 결제 선택 ─ 카카오 페이
	// 1) 결제 준비 요청
	@GetMapping(value = "/orderPay", produces = "application/json")
	public @ResponseBody ReadyResponse payReady(String paymethod, OrderBasicVO o_vo, /* OrderDetailVO od_vo, */ PaymentVO p_vo, 
											   int total_price, HttpSession session) throws Exception {
		/*
		   1) 주문정보 구성 
		   - 주문 테이블(OrderBasicVO): ord_status, payment_status 정보 존재하지 않음
		   - 주문 상세 테이블(OrderDetailVO): 장바구니 테이블에서 데이터를 참조하는 방법 이용
		   - 결제 테이블: 보류
		   2) 카카오페이 결제에 필요한 정보구성
		   - 스프링에서 처리할 수 있는 부분
		*/
		
		String us_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();;
		o_vo.setUs_id(us_id); // 아이디 값 할당(설정)
		

		// 시퀀스를 주문번호로 사용: 동일한 주문번호 값이 사용
		// int com.docmall.service.OrderService.getOrderSeq()
		Long od_number = (long) orderService.getOrderSeq();
		o_vo.setOd_number(od_number); // 주문번호 저장		
	
		// 1) 주문 테이블 저장 작업: ord_status, payment_status 데이터 준비할 것(우선은 누락시킴)
		// 2) 주문 상세 테이블 저장 작업
		
		p_vo.setOd_number(od_number);
		p_vo.setUs_id(us_id);
		p_vo.setPm_method("카카오페이");
		p_vo.setPm_total_price(total_price);
		
		o_vo.setOd_status("주문완료");
		o_vo.setPm_status("결제완료");
		
		log.info("결제방법: " + paymethod);
		log.info("주문정보: " + o_vo);
		log.info("결제정보: " + p_vo);		
		
		List<CartDTOList> cart_list = cartService.cart_list(us_id);
		String itemName = cart_list.get(0).getPd_name() + "외 " + String.valueOf(cart_list.size() - 1) + "건";
		
		orderService.order_insert(o_vo, p_vo); // 주문, 주문상세 정보 저장, 장바구니 삭제, 결제 정보 저장
		
		// 3) Kakao Pay 호출 -> 1) 결제 준비 요청
		ReadyResponse readyResponse = kakaoPayServiceImpl.payReady(o_vo.getOd_number(), us_id, itemName, cart_list.size(), total_price);
		
		log.info("결제 고유번호: " + readyResponse.getTid());
		log.info("결제 요청 URL: " + readyResponse.getNext_redirect_pc_url());
	
		// 카카오페이 결제 승인 요청 작업에 필요한 정보 준비
		session.setAttribute("tid", readyResponse.getTid());
		session.setAttribute("odr_code", o_vo.getOd_number());
		
		return readyResponse;
	}
	
	// 결제 승인 요청 작업 -> http://localhost:8080/user/order/order_complete
	@GetMapping("/orderApproval")
	public String orderApproval(@RequestParam("pg_token") String pg_token, HttpSession session) {
		
		// 2) Kakao Pay 결제 승인 요청 작업
		String tid = (String) session.getAttribute("tid");
		Long odr_code = (Long) session.getAttribute("odr_code");
		String user_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();;

		// ApproveResponse approveResponse = kakaoPayServiceImpl.payApprove(tid, odr_code, user_id, pg_token);
		kakaoPayServiceImpl.payApprove(tid, odr_code, user_id, pg_token);

		session.removeAttribute("tid");
		session.removeAttribute("odr_code");
		
		return "redirect:/user/order/order_complete";
	}
	
	// 결제 완료 페이지: 
	@GetMapping("/orderComplete")
	public void orderComplete() {
		
	}
	
	// 결제 취소 시: http://localhost:8080/user/order/orderCancel
	@GetMapping("/orderCancel")
	public void orderCancel() {
		
	}
	
	// 결제선택 ─ 무통장 입금
	@GetMapping("/nobank")
	public ResponseEntity<String> nobank(String paymethod, OrderBasicVO o_vo, /* OrderDetailVO od_vo,는 장바구니에서 참조  */ PaymentVO p_vo,
			   			int total_price, HttpSession session) throws Exception {
		
		ResponseEntity<String> entity = null;
		
		String user_id = ((UserVO) session.getAttribute("loginStatus")).getUs_id();
		o_vo.setUs_id(user_id); // 아이디 값 할당(설정)
		
		// 시퀀스를 주문번호로 사용: 동일한 주문번호 값이 사용
		// int com.docmall.service.OrderService.getOrderSeq()
		Long od_number = (long) orderService.getOrderSeq();
		o_vo.setOd_number(od_number); // 주문번호 저장		
		
		// 1) 주문 테이블 저장 작업: ord_status, payment_status 데이터 준비할 것(우선은 누락시킴)
		// 2) 주문 상세 테이블 저장 작업
		
		o_vo.setOd_status("주문완료");
		o_vo.setPm_status("결제완료");
		
		p_vo.setPm_method("무통장입금");
		p_vo.setOd_number(od_number);
		p_vo.setUs_id(user_id);
		p_vo.setPm_total_price(total_price);
		p_vo.setPm_no_bankbook_price(total_price);
		
		log.info("결제방법: " + paymethod);
		log.info("주문정보: " + o_vo);
		log.info("결제정보: " + p_vo);
		
		orderService.order_insert(o_vo, p_vo); // 주문, 주문상세 정보 저장, 장바구니 삭제, 결제 정보 저장
		
		entity = new ResponseEntity<>("success", HttpStatus.OK);
		
		return entity;
	}
}
