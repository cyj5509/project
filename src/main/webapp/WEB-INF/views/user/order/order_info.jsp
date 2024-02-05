<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

				<!doctype html>
				<html lang="en">

				<head>
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
					<meta name="description" content="">
					<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
					<meta name="generator" content="Hugo 0.101.0">
					<title>데브데이:&nbsp;주문조회</title>

					<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/product/categoryMenu.css">
					
					<style>
						#orderInfo th,
						#orderInfo td {
							vertical-align: middle;
							/* 셀의 내용을 수직 중앙에 정렬 */
							text-align: center;
							/* 텍스트를 가운데 정렬 */
						}
						
						input[readonly] {
							background-color: white !important;
						}
					</style>
				</head>

				<body>

					<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/categoryMenu.jsp" %>

						<h1 class="box-title mt-5" style="text-align: center; margin-bottom: 40px;">
							<b>주문 정보</b>
						</h1>
						<div class="container">
							<table class="table table-striped" id="orderInfo">
								<thead style="text-align: center;">
									<tr>
										<th scope="col">상품</th>
										<th scope="col">상품명</th>
										<th scope="col">단가가</th>
										<th scope="col">수량</th>
										<th scope="col">합계</th>
									</tr>
								</thead>
								<tbody style="text-align: center;">
									<c:forEach items="${order_info}" var="cartDTO" varStatus="status">
										<tr>
											<td>
												<img width="50%" height="50"
													src="/user/product/imageDisplay?dateFolderName=${cartDTO.pd_image_folder}&fileName=${cartDTO.pd_image}"
													alt="">
											</td>
											<td>${cartDTO.pd_name}</td>
											<td>
												<span id="unitPrice">
													<fmt:formatNumber
														value="${Math.round(cartDTO.pd_price - (cartDTO.pd_price * cartDTO.pd_discount / 100))}"
														groupingUsed="true" />원
												</span>
											</td>
											<td>${cartDTO.ct_amount}</td>
											<td>
												<span class="unitTotalPrice" id="unitTotalPrice">
													<fmt:formatNumber
														value="${Math.round(cartDTO.pd_price - (cartDTO.pd_price * cartDTO.pd_discount / 100) * cartDTO.ct_amount)}"
														groupingUsed="true" />원
												</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="8" style="text-align: right;">
											총&nbsp;<span id="cart_price_count">${fn:length(order_info)}건</span>
											&#47;&nbsp;주문금액:&nbsp;<span id="cart_total_price">${od_price}</span>
										</td>
									</tr>
								</tfoot>
							</table>

							<div class="box box-primary">
								<div class="box-body">
									<form role="form" id="" method="post" action="">
										<hr>
										<fieldset class="form-group border p-3">
											<legend class="w-auto px-2">주문자</legend>
											<div class="form-group row">
												<label for="b_us_name" class="col-2">성함</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_us_name" value="${userStatus.us_name}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="b_us_phone" class="col-2">전화번호</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_us_phone" value="${userStatus.us_phone}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="b_us_postcode" class="col-2">우편번호</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_us_postcode"
														value="${userStatus.us_postcode}" readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="b_us_addr_basic" class="col-2">기본주소</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_us_addr_basic" value="${userStatus.us_addr_basic}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="b_us_addr_detail" class="col-2">상세주소</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_us_addr_detail" value="${userStatus.us_addr_detail}"
														readonly>
												</div>
											</div>
										</fieldset>

										<hr>
										<fieldset class="form-group border p-3">
											<legend class="w-auto px-2">수령인</legend>

											<div class="form-group row">
												<label for="us_name" class="col-2">성함</label>
												<div class="col-8">
													<input type="text" class="form-control" name="us_name" id="us_name"
														placeholder="이름 입력">
												</div>
												<div class="col-2">
													<input type="checkbox" class="form-controel" id="same_orderer">&nbsp;주문자와 동일
												</div>
											</div>
											<div class="form-group row">
												<label for="us_phone" class="col-2">전화번호</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_phone" id="us_phone"
														placeholder="전화번호 입력">
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_postcode" class="col-2">우편번호</label>
												<div class="col-8">
													<input type="text" class="form-control" name="us_postcode" id="sample2_postcode"
														placeholder="우편번호 입력">
												</div>
												<div class="col-2">
													<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-outline-info">우편번호
														찾기</button>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_address" class="col-2">기본주소</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_addr_basic" id="sample2_address"
														placeholder="기본주소 입력">
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_detailAddress" class="col-2">상세주소</label>
												<div class="col-10">
													<input type="text" class="form-control" name="us_addr_detail" id="sample2_detailAddress"
														placeholder="상세주소 입력">
													<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
												</div>
											</div>
										</fieldset>
										<hr>
										<fieldset class="form-group border p-3">
											<legend class="w-auto px-2">결제방법</legend>
											<div class="form-group row">
												<div class="col-12">
													<input type="radio" name="pay_method" id="pay_method1" value="no_bankbook">&nbsp;무통장&nbsp;입금
													&nbsp;&nbsp;<input type="radio" name="pay_method" id="pay_method2" value="kakao_pay">
													<img src="/images/payment.png" class="img-fluid" style="width: 50px; height: 20px;"/>
												</div>
											</div>
											<div class="form-group row" id="no_bankbook_info" style="display: none;">
												<label for="us_phone" class="col-2">무통장 입금정보</label>
												<div class="col-10">
													은행명
													<select name="pm_no_bankbook_bank" id="pm_no_bankbook_bank">
														<option value="123-123-1234">하나은행</option>
														<option value="456-456-4567">국민은행</option>
														<option value="100-100-1000">신한은행</option>
														<option valie="200-200-2000">제일은행</option>
													</select><br>
													계좌번호<input type="text" name="pm_no_bankbook_account" id="pm_no_bankbook_account"><br>
													예금주<input type="text" name="pm_no_bankbook_user" id="pm_no_bankbook_user"><br>
													메모<textarea cols="50" rows="3" name="pm_memo" id="pm_memo"></textarea>
												</div>
											</div>
										</fieldset>

										<div class="form-group row text-center">
											<div class="col-12">
												<button type="button" class="btn btn-primary" id="btn_order_pay">주문 및 결제하기</button>
											</div>
										</div>
									</form>
								</div>
							</div>
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>
						<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/user/product/categoryMenu.js"></script>

							<script>
								$(document).ready(function () {

									// 주문자와 동일
									$("#same_orderer").on("click", function () {
										if ($("#same_orderer").is(":checked")) {
											// console.log("체크");

											$("#us_name").val($("#b_us_name").val());
											$("#sample2_postcode").val($("#b_us_postcode").val());
											$("#sample2_address").val($("#b_us_addr_basic").val());
											$("#sample2_detailAddress").val($("#b_us_addr_detail").val());
											$("#us_phone").val($("#b_us_phone").val());
										} else {
											$("#us_name").val("");
											$("#sample2_postcode").val("");
											$("#sample2_address").val("");
											$("#sample2_detailAddress").val("");
											$("#us_phone").val("");
										}
									});

									// 주문하기
									$("#btn_order_pay").on("click", function () {

										// 1) 주문 테이블 , 주문 상세 테이블, 결제 테이블 저장에 필요한 정보 구성
										// 2) 카카오페이 결제에 필요한 정보구성
										// 스프링에서 처리할 수 있는 부분

										console.log("pay_method", $("input[name='pay_method']:checked").val());
										console.log("od_name", $("#us_name").val());
										console.log("od_postcode", $("input[name='us_postcode']").val());
										console.log("od_addr_basic", $("input[name='us_addr_basic']").val());
										console.log("od_addr_detail", $("input[name='us_addr_detail']").val());
										console.log("od_phone", $("#us_phone").val());
										// 입력 양식이 아닌 태그들은 text() 사용
										console.log("od_total_price", $("#cart_total_price").text());
										console.log("total_price", $("#cart_total_price").text());

										let pay_method = $("input[name='pay_method']:checked").val();

										if (pay_method == 'kakao_pay') {
											// 1)에 대한 작업
											$.ajax({
												url: '/user/order/order_pay',
												type: 'get',
												data: {
													pay_method: $("input[name='pay_method']:checked").val(), // 결제방식
													od_name: $("#us_name").val(),
													od_postcode: $("input[name='us_postcode']").val(),
													od_addr_basic: $("input[name='us_addr_basic']").val(),
													od_addr_detail: $("input[name='us_addr_detail']").val(),
													od_phone: $("#us_phone").val(),
													// int totalprice, int od_price는 참조타입이 아님(null 값 없음)
													// 참조타입은 스프링에서 자동 처리
													// 실수값 처리에 대한 문제(할인율 포함)로 정상 출력되지 않음
													od_total_price: $("#cart_total_price").text(),
													total_price: $("#cart_total_price").text(),
												},
												dataType: 'json',
												success: function (response) {
													console.log("응답: " + response);

													alert(response.next_redirect_pc_url);
													location.href = response.next_redirect_pc_url;
												}
											});

										} else if (pay_method == 'no_bankbook') {
											$.ajax({
												url: '/user/order/no_bankbook',
												type: 'get',
												data: {
													pay_method: $("input[name='pay_method']:checked").val(), // 결제방식
													od_name: $("#us_name").val(),
													od_postcode: $("input[name='us_postcode']").val(),
													od_addr_basic: $("input[name='us_addr_basic']").val(),
													od_addr_detail: $("input[name='us_addr_detail']").val(),
													od_phone: $("#us_phone").val(),
													// int totalprice, int od_price는 참조타입이 아님(null 값 없음)
													// 참조타입은 스프링에서 자동 처리
													// 실수값 처리에 대한 문제(할인율 포함)로 정상 출력되지 않음
													od_total_price: $("#cart_total_price").text(),
													total_price: $("#cart_total_price").text(),

													pm_no_bankbook_user: $("#pm_no_bankbook_user").val(),
													pm_no_bankbook_bank: $("#pm_no_bankbook_bank option:selected").text(), // val()이라 하면 계좌번호, pm_no_bankbook_bank = $(this).text();
													pm_memo: $("#pm_memo").val(),
													pm_no_bankbook_account: $("#pm_no_bankbook_account").val(),
												},
												dataType: 'text',
												success: function (result) {
													console.log("응답: " + result);

													if (result == 'success') {
														alert("무통장 입금으로 주문 및 결제가 완료되었습니다.")
														location.href = '/user/order/order_complete';
													}
												}
											});
										}
									})

									
									// 무통장 선택 시 무통장 입력정보 표시하기
									$("input[name='pay_method']").on("click", function () {

										let pay_method = $("input[name='pay_method']:checked").val();

										if (pay_method == "no_bankbook") {
											$("#no_bankbook_info").show();
										} else if (pay_method == "kakao_pay") {
											$("#no_bankbook_info").hide();
										}
									})

									// 입금은행 선택 시
									$("#pm_no_bankbook_bank").on("change", function () {
										$("#pm_no_bankbook_account").val($(this).val());
									
									})

								}); // ready event end
							</script>
				</body>

				</html>