package com.devday.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devday.domain.OrderBasicVO;
import com.devday.domain.OrderDetailInfoVO;
import com.devday.domain.OrderDetailProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.AdOrderService;
import com.devday.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/order/*")
@Log4j
public class AdOrderController {

	private final AdOrderService adOrderService;

	// 메인 및 썸네일 이미지 업로드 폴더 경로 주입 작업
	// servlet-context.xml의 beans 참조 -> <beans:bean id="uploadPath"
	// class="java.lang.String">
	@Resource(name = "uploadPath")
	private String uploadPath;

	// 주문 리스트: 목록과 페이징
	// 테이블의 전체 데이터를 가져옴
	@GetMapping("/order_list")
	public void order_list(Criteria cri, Model model) throws Exception {

		// 10 -> 2로 변경
		cri.setAmount(2); // Criteria에서 this(1, 2);

		List<OrderBasicVO> order_list = adOrderService.order_list(cri);
		model.addAttribute("order_list", order_list);

		int totalCount = adOrderService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
	}

	// 주문상세 방법1: 주문상세 정보가 클라이언트에서 JSON 형태로 변환되어 보내진다(pom.xml에 jackson-databind 라이브러리가 백그라운드 작동).
	// ReviewContorll에서 Copy & Paste
	// 전통적인 형태의 주소 list?pro_num=10&page=1 -> REST API 개발형태 주소 list/10/1
	// ResponseEntity<String>는 AJAX 요청 시 SELECT 외 나머지, AJAX 요청 시 SELECT면 해당하는 리턴 타입 필요
	@GetMapping("/order_detail_info1/{od_number}") // RESTful 개발방법론의 주소
	public ResponseEntity<List<OrderDetailInfoVO>> order_detail_list1(@PathVariable("od_number") Long od_number) throws Exception {

		// 클래스명은 주문 상세 테이블과 상품 테이블을 조인한 결과만 담는 클래스

		ResponseEntity<List<OrderDetailInfoVO>> entity = null;
		
		List<OrderDetailInfoVO> orderDetailList = adOrderService.orderDetailInfo1(od_number);

		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 브라우저에서 상품 이미지 출력 시 역슬래시 사용이 문제가 된다. 그래서 슬래시로 변환해서 클라이언트로 보냄
		orderDetailList.forEach(vo -> {
			vo.setPd_image_folder(vo.getPd_image_folder().replace("\\", "/"));
		});

		entity = new ResponseEntity<List<OrderDetailInfoVO>>(orderDetailList, HttpStatus.OK);

		return entity;
	}
	
	// 주문상세 내역에서 개별 상품 삭제(Model 필요 없음, Criteria 추가 로직 없음)
	@GetMapping("/order_product_delete")
	public String order_product_delete(Criteria cri, Long od_number, Integer pd_number) throws Exception {
		
		// 주문상세 개별 삭제
		adOrderService.order_product_delete(od_number, pd_number);
		
		return "redirect:/admin/order/order_list" + cri.getListLink();
	}

	// 주문상세 방법2
	@GetMapping("/order_detail_info2/{od_number}") // RESTful 개발방법론의 주소
	public String order_detail_list2(@PathVariable("od_number") Long od_number, Model model) throws Exception {

		List<OrderDetailProductVO> orderProductList = adOrderService.orderDetailInfo2(od_number);
		
		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 브라우저에서 상품 이미지 출력 시 역슬래시 사용이 문제가 된다. 그래서 슬래시로 변환해서 클라이언트로 보냄
		/*
		orderProductList.forEach(vo -> {
			vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
		});
		*/
		// 클래스 자체가 필드로 되어 있어 계층적으로 상위 단계를 표시해줘야 함
		orderProductList.forEach(vo -> {
			vo.getProductVO().setPd_image_folder(vo.getProductVO().getPd_image_folder().replace("\\", "/"));
		});
		
		model.addAttribute("orderProductList", orderProductList);
		
		return "/admin/order/order_detail_product";
	}
	
	// 상품 리스트에서 보여줄 이미지. <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /admin/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {

		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}

}
