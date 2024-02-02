	package com.devday.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

// import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devday.domain.CategoryVO;
import com.devday.domain.ProductVO;
import com.devday.dto.Criteria;
import com.devday.dto.PageDTO;
import com.devday.service.AdCategoryService;
import com.devday.service.AdProductService;
import com.devday.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/product/*")
@RequiredArgsConstructor
@Log4j
public class AdProductController {

	private final AdProductService adProductService;
	private final AdCategoryService adCategoryService;

	// 메인 및 썸네일 이미지 업로드 폴더 경로 주입 작업
	// servlet-context.xml의 beans 참조 -> <beans:bean id="uploadPath" class="java.lang.String">
	@Resource(name = "uploadPath")
	private String uploadPath;

	// CKEditor에서 사용되는 업로드 폴더 경로
	@Resource(name = "uploadProductCKPath")
	private String uploadProductCKPath;

	// 상품등록 폼
	@GetMapping("/insert")
	public void insert() {

		log.info("상품등록 폼");
	}

	// 1차 카테고리 테이터를 Model로 작업(설명용)
	// 반복적인 작업을 하나로 처리하기 위해 GlobalControllerAdvice 클래스를 생성하여 처리
	/*
	 @GetMapping("이름")
	 public void aaa(Model model) { 
	 model.addAttribute("cg_code", "1차 카테고리 정보");
	 }
	 */

	// 상품정보 저장 작업
	// 파일 업로드 기능
	// 1) 스프링에서 내장된 기본 라이브러리 -> servlet-context.xml에서 MultipartFile에 대한 bean 등록 작업
	// 2) 외부 라이브러리를 이용(pom.xml의 commons-fileupload) -> servlet-context.xml에서 MultipartFile에 대한 bean 등록 작업
	// 매개변수로 쓰인 MultipartFile uploadFile은 ProductVO에 직접 집어 넣어서 사용해도 됨
	// <input type = "file" class="form-control" name="uploadFile" id="uploadFile"
	// placeholder="작성자 입력..."/>
	@PostMapping("/insert")
	// public String insert(ProductVO vo, List<MultipartFile> uploadFile) { //
	// 파일이 여러 개일 때
	public String insert(ProductVO vo, MultipartFile uploadFile, RedirectAttributes rttr) { // 파일이 하나일 때

		log.info("상품정보: " + vo);

		// 1) 파일 업로드 작업(선수 작업: FileUtils 클래스 작업)
		String dateFolder = FileUtils.getDateFolder();
		String savedFileName = FileUtils.uploadFile(uploadPath, dateFolder, uploadFile);

		vo.setPd_image(savedFileName);
		vo.setPd_image_folder(dateFolder);

		log.info("상품정보: " + vo);

		// 2) 상품 정보 작업
		adProductService.insert(vo);

		return "redirect:/admin/product/adProductList"; // 상품 리스트 주소로 이동
	}

	// CkEditor 업로드 탭에서 파일 업로드 시 동작하는 매핑주소
	// imageUpload(HttpServletRequest request, HttpServletResponse response,
	// MultipartFile upload) 메서드
	/*
	1. HttpServletRequest 클래스: JSP의 Request 객체 클래스로, 클라이언트의 요청을 담고 있는 객체
	2. HttpServletResponse 클래스: JSP의 Response 객체 클래스로, 클라이언트로 보낼 서버 측의 응답 정보를 가지고 있는 객체
	3. MultipartFile 클래스: 업로드된 파일을 참조하는 객체(변수명과 CkEditor의 name을 일치)
	-> <input ~ type="file" name="upload" size="38">
	*/
	@PostMapping("/imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {

		// 전역변수로 사용하기 위해 try~catch 코드 사용 전에 선언
		OutputStream out = null;
		PrintWriter printWriter = null; // 클라이언트에게 서버의 응답 정보를 보낼 때 사용

		// JSP 파일의 아래 역할과 동일
		/*
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		*/
		// 클라이언트에게 보내는 응답 설정
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		try {

			// 1) 파일 업로드 작업
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 전송한 파일 이름
			byte[] bytes = upload.getBytes(); // 업로드한 파일을 byte 배열로 읽어들임

			// 'File.separator'는 운영 체제에 따라 적절한 파일 경로 구분자를 제공함
			String ckUploadPath = uploadProductCKPath + File.separator + fileName;

			log.info("CKEditor 파일 경로: " + ckUploadPath);

			out = new FileOutputStream(new File(ckUploadPath)); // 0KB 파일 생성
			out.write(bytes); // 출력 스트림 작업
			out.flush();

			// 2) 파일 업로드 작업 후 파일 정보를 CKEditor로 보내는 작업
			printWriter = response.getWriter();

			// 브라우저의 CKEditor에서 사용할 업로드한 파일 정보를 참조하는 경로 설정 작업하는 방법(두 가지)
			/*
			 1. 톰캣 Context Path에서 Add External Web Module... 작업을 해야 함(그렇지 않으면 프로젝트가 커짐) 
			 -> Path는 /ckupload(임의로 설정), Document base는 C:\\Dev\\upload\\ckeditor 설정 
			 2. Tomcat의 server.xml에서 <Context docBase="업로드경로" path="/매핑 주소" reloadable="true"/>
			 -> <Context docBase="C:\\Dev\\upload\\ckeditor" path="/ckupload" reloadable="true"/>
			 ※ 설정할 때는 '\' 하나만 사용, 코드상으로는 '\\' 두 개 사용 
			 */

			// CKEditor에서 업로드된 파일 경로를 보내줄 때 매핑 주소와 파일명이 포함
			String fileUrl = "/ckupload/product/" + fileName;
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"}
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1, \"url\":\"" + fileUrl + "\"}");
			printWriter.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			if (printWriter != null)
				printWriter.close();
		}
	}

	// 상품 리스트: 목록과 페이징
	// 메서드의 파라미터를 스프링에서 객체를 자동으로 생성해준다.
	// 테이블의 전체 데이터를 가져옴
	// Model 파라미터는 AJAX 호출 시 사용하지 않음(단순 JSP에서 데이터 값을 이용할 때)
	@GetMapping("/adProductList")
	public void adProductList(Criteria cri, Model model) throws Exception {

		cri.setAmount(4); // Criteria에서 this(1, 2);

		List<ProductVO> productList = adProductService.getListWithPaging(cri);

		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 스프링에서 처리하지 않으면 자바스크립트에서 처리할 수도 있다.
		productList.forEach(vo -> {
			vo.setPd_image_folder(vo.getPd_image_folder().replace("\\", "/"));
		});
		model.addAttribute("productList", productList);

		int totalCount = adProductService.getTotalCount(cri);
		
		// model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		PageDTO pageDTO = new PageDTO(cri, totalCount);
		model.addAttribute("pageMaker", pageDTO);
	}

	// 상품 리스트에서 보여줄 이미지. <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /admin/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {

		return FileUtils.getFile(uploadPath + dateFolderName, fileName);
	}

	// [방법 1] 체크상품 목록 수정(Ajax 요청) ─ DB 연동 여러 번
	@ResponseBody // Ajax 요청을 받을 것이기 때문 <-> @RestController에서는 사용하지 않음
	@PostMapping("/pd_checked_modify1") // pd_list.jsp에서 type이 post 방식(329행)
	// 일반적으로 Ajax에선 ResponseEntity 클래스 방식이 사용
	// -> 이유: 해당 클래스가 헤더 작업과 http 상태코드 작업을 지원하기 때문
	// 일반요청 시 배열 형태로 파라미터가 전송되어 오면 @RequestParam("pd_number_arr[]")에서 []를 제외
	// <-> Ajax 요청으로 들어오기 때문에 아래와 같이 []를 붙인 형태로 작성됨
	// public ResponseEntity<String> pd_checked_modify(클라이언트에 보낸 정보를 받는 매개변수)
	public ResponseEntity<String> pd_checked_modify1(@RequestParam("pd_number_arr[]") List<Integer> pd_number_arr,
													@RequestParam("pd_price_arr[]") List<Integer> pd_price_arr,
													@RequestParam("pd_buy_status_arr[]") List<String> pd_buy_status_arr) throws Exception {

		// 클라이언트에서 값이 넘어오는 것을 확인하고 Mapper 등의 서버 측 스프링 작업할 것
		log.info("상품코드: " + pd_number_arr);
		log.info("상품가격: " + pd_price_arr);
		log.info("판매여부: " + pd_buy_status_arr);

		ResponseEntity<String> entity = null; // 참조타입이라 null이 가능

		// 체크상품 수정 작업
		adProductService.pd_checked_modify1(pd_number_arr, pd_price_arr, pd_buy_status_arr);

		entity = new ResponseEntity<String>("success", HttpStatus.OK); // function (result)

		return entity;
	}

	// [방법 2] 체크상품 목록 수정(Ajax 요청) ─ DB 연동 한 번(for문 이용)
	@ResponseBody
	@PostMapping("/pd_checked_modify2")
	public ResponseEntity<String> pd_checked_modify2(@RequestParam("pd_number_arr[]") List<Integer> pd_number_arr,
													@RequestParam("pd_price_arr[]") List<Integer> pd_price_arr,
													@RequestParam("pd_buy_status_arr[]") List<String> pd_buy_status_arr) throws Exception {

		log.info("상품코드: " + pd_number_arr);
		log.info("상품가격: " + pd_price_arr);
		log.info("판매여부: " + pd_buy_status_arr);

		ResponseEntity<String> entity = null;

		// 체크상품 수정 작업
		adProductService.pd_checked_modify2(pd_number_arr, pd_price_arr, pd_buy_status_arr);

		entity = new ResponseEntity<String>("success", HttpStatus.OK); // function (result)

		return entity;
	}

	// 상품수정 폼 페이지
	@GetMapping({"/edit", "/get"})
	public void getAndEdit(@ModelAttribute("cri") Criteria cri, 
						   Integer pd_number, Model model) throws Exception {

		// 선택한 상품정보
		ProductVO pd_vo = adProductService.get(pd_number);
		
		log.info("작업 전 상품정보: " + pd_vo);
		
		// '\'(역슬래시)를 '/'(슬래시)로 변환하는 작업
		// 요청 타겟에서 유효하지 않은 문자가 발견되었습니다. 유효한 문자들은 RFC 7230과 RFC 3986에 정의되어 있습니다.
		pd_vo.setPd_image_folder(pd_vo.getPd_image_folder().replace("\\", "/")); // Escape Sequence 특수문자
		
		log.info("작업 후 상품정보: " + pd_vo);
		
		model.addAttribute("pd_vo", pd_vo); // 2차 카테고리 코드

		// 1차 전체 카테고리는 GlobalControllerAdvice 클래스 Model 참조

		// 상품 카테고리에서 2차 카테고리를 이용한 1차 카테고리 정보를 참조
		// productVO.getCg_code(): 상품 테이블에 있는 2차 카테고리 코드의 부모인 1차 카테고리 정보를 가져오는 작업
		// first_category 자체가 CategoryVO의 성격을 가짐
		CategoryVO firstCategory = adCategoryService.get(pd_vo.getCg_code()); // 변수 설정 이유
		model.addAttribute("first_category", firstCategory); // first_category: 하나

		// 1차 카테고리를 부모로 둔 2차 카테고리 정보 예) TOP(1)
		// 현재 상품의 1차 카테고리 코드: firstCategory.getCg_parent_code()
		model.addAttribute("second_categoryList", adCategoryService.getSecondCategoryList(firstCategory.getCg_parent_code())); // second_categoryList: 여러 개
	}
	
	// 상품 수정
	@PostMapping("/edit")
	public String edit(Criteria cri, ProductVO vo, MultipartFile uploadFile, RedirectAttributes rttr) throws Exception {
		
		// 상품 리스트에서 사용할 정보(검색, 페이징 정보)
		log.info("검색 및 페이징 정보: " + cri);
		// 상품 수정 내용
		log.info("상품 수정 내용: " + vo);
		
		vo.setPd_image_folder(vo.getPd_image_folder().replace("/", "\\")); // Escape Sequence 특수문자
		
		// 작업
		// 파일이 변경되었을 때 해야 할 작업: 1) 기존 이미지 파일 삭제 -> 2) 업로드 작업
		// [참고] 클라이언트 파일명을 DB에 저장하는 부분도 고려해야 한다.
		// 첨부파일 존재 여부 확인할 때 사용할 때 조건식: uploadFile.getSize() > 0
		if(!uploadFile.isEmpty()) {

			// 1) 기존 이미지 파일 삭제 작업
			FileUtils.deleteFile(uploadPath, vo.getPd_image_folder(), vo.getPd_image());

			// 2) 업로드 작업
			String dateFolder = FileUtils.getDateFolder();
			String savedFileName = FileUtils.uploadFile(uploadPath, dateFolder, uploadFile);

			// 3) DB에 저장할 새로운 날짜폴더명 및 이미지명 변경 작업
			vo.setPd_image(savedFileName);
			vo.setPd_image_folder(dateFolder);	
		}
		
		// DB 연동 작업
		adProductService.edit(vo);
		
		return "redirect:/admin/product/adProductList" + cri.getListLink();
	}
	
	@PostMapping("/delete")
	public String delete(Criteria cri, Integer pd_number) throws Exception {
		
		// DB 연동 작업
		adProductService.delete(pd_number);
		
		return "redirect:/admin/product/adProductList" + cri.getListLink();
	}
}
