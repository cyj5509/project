<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<!doctype html>
			<html lang="en">

			<head>
				<meta charset="utf-8">
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
				<meta name="description" content="">
				<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
				<meta name="generator" content="Hugo 0.101.0">
				<title>Pricing example · Bootstrap v4.6</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>
					<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
					<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
					<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
					<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
					<script>
						$(function () {
							$("#tabs_pro_detail").tabs();
						});
					</script>

					<style>
						.bd-placeholder-img {
							font-size: 1.125rem;
							text-anchor: middle;
							-webkit-user-select: none;
							-moz-user-select: none;
							-ms-user-select: none;
							user-select: none;
						}

						@media (min-width : 768px) {
							.bd-placeholder-img-lg {
								font-size: 3.5rem;
							}
						}
					</style>
			</head>

			<body>
				<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>

						<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
							<p>2차 카테고리: ${cg_name}</p>
						</div>

						<div class="container">
							<div class="card-deck mb-3 text-center row">
								<div class="col-md-6"> <!-- 상품 이미지 -->
									<img class="btn_prd_img" data-prd_num="${productVO.prd_num}" width="100%" height="200"
										src="/user/product/imageDisplay?dateFolderName=${productVO.prd_up_folder}&fileName=${productVO.prd_img}"
										alt="">
								</div>

								<div class="col-md-6">
									<div class="row text-left">
										<div class="col"> <!-- 상품명 -->
											상품명: ${productVO.prd_name}
										</div>
									</div>
									<div class="row text-left">
										<div class="col"> <!-- 상품가격 -->
											가격: <span id="unit_price">${productVO.prd_price}</span>
										</div>
									</div>
									<div class="row text-left">
										<div class="col">
											수량: <input type="number" id="btn_quantity" value="1" style="width: 80px">
										</div>
									</div>
									<div class="row text-left">
										<div class="col">
											총 상품금액: <span id="tot_price">${productVO.prd_price}</span>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<button type="button" class="btn btn-link" name="btn_order"
												data-prd_num="${productVO.prd_num}">구매하기</button>
										</div>
										<div class="col-md-6">
											<button type="button" class="btn btn-link" name="btn_cart_add"
												data-prd_num="${productVO.prd_num}">장바구니</button>
										</div>
									</div>
								</div>
							</div> <!-- card-deck mb-3 text-center row 닫는 태그 -->

							<div class="row">
								<div class="col-md-12">
									<div id="tabs_pro_detail">
										<ul>
											<li><a href="#tabs-prodetail">상품 설명</a></li>
											<li><a href="#tabs-proreview">상품 후기</a></li>
										</ul>
										<div id="tabs-prodetail">
											<p>${productVO.prd_content}/p>
										</div>
										<div id="tabs-proreview">
											<p>상품후기 목록</p>
										</div>
									</div>
								</div>
							</div>

							<div class="row text-center">
								<div class="col-md-12">
									<!-- <form id="actionForm">의 용도 -->
									<!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용 -->
									<!-- 2) 목록에서 상품 이미지 또는 상품명을 클릭할 때 사용 -->
									<form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
										<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" id="amount" value="${pageMaker.cri.amount}" />
										<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
										<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
										<input type="hidden" name="cg_code" id="cg_code" value="${cg_code}" />
										<input type="hidden" name="cg_name" id="cg_name" value="${cg_name}" />
									</form>
								</div>
							</div>

							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<!-- JSP 주석 -->
						<%-- <%@include file="/WEB-INF/views/comm/plugIn2.jsp" %> --%>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/category_menu.js"></script>

							<script>
								$(document).ready(function () {

									let actionForm = $("#actionForm");  // 액션폼 참조

									// [이전] 1 2 3 4 5 ... [다음] 클릭 이벤트 설정. <a> 태그
									$(".movepage").on("click", function (e) {
										e.preventDefault(); // a 태그의 href 링크 기능을 제거. href 속성에 페이지 번호를 숨겨둠

										actionForm.attr("action", "/user/product/prd_list");
										// actionForm.find("input[name='pageNum']").val(선택한 페이지 번호);
										actionForm.find("input[name='pageNum']").val($(this).attr("href"));

										actionForm.submit(); // 페이지 이동 시 actionForm이 동작
									});

									// 장바구니 추가(CartVO)
									$("button[name='btn_cart_add']").on("click", function () {
										// console.log("장바구니");
										$.ajax({
											url: '/cart/cart_add', // url: '장바구니 추가 주소', 
											type: 'post',
											// $(this).data("prd_num"): 버튼을 눌렀을 때 동작하는 장바구니 상품코드
											data: { prd_num: $(this).data("prd_num"), cart_amount: $("#btn_quantity").val() }, // mbsp_id는 스프링에서 자체 처리
											dataType: 'text',
											success: function (result) {
												if (result == "success") {
													alert("장바구니에 추가됨");
													if (confirm("장바구니로 이동하시겠습니까?")) {
														location.href = "/cart/cart_list"
													}
												}
											}
										});
									});

									// 구매하기(주문)
									$("button[name='btn_order']").on("click", function () {

										let url = `/user/order/order_ready?prd_num=$(this).data("prd_num")&cart_amount=$("#btn_quantity").val()`;
										location.href = url;
									});

									// 상품 이미지 또는 상품명 클릭 시 상세로 보내는 작업
									$(".btn_prd_img").on("click", function () {
										console.log("상품 상세 설명");

										// actionForm.attr("action", "상품 상세 주소");
										actionForm.attr("action", "/user/product/prd_detail");
										let prd_num = $(this).data("prd_num");

										actionForm.find("input[name='prd_num']").remove(); // 뒤로가기 시 
										// <input type='hidden' name='prd_num' value='상품코드'> 미리 만들어서 작성
										actionForm.append("<input type='hidden' name='prd_num' value='" + prd_num + "'>")
										actionForm.submit();
									});

									// 수량 변경 시
									$("#btn_quantity").on("change", function () {
										// parseInt(): 문자열을 정수로 변환(현재 작동에서는 정상 작동해서 불필요할 수 있음. 더하기 작업 등에 쓰임)
										let tot_price = $("#unit_price").text() * $("#btn_quantity").val();

										// 총 상품금액 표시
										$("#tot_price").text(tot_price);
									});

								}); // ready event end
							</script>
			</body>

			</html>