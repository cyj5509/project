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
				<title>데브데이: 장바구니</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/product/categoryMenu.css">

					<style>
						#cartList th,
						#cartList td {
							vertical-align: middle;
							/* 셀의 내용을 수직 중앙에 정렬 */
							text-align: center;
							/* 텍스트를 가운데 정렬 */
						}

						#cartList button {
							padding: 2px 4px;
						}
					</style>
			</head>

			<body data-us_id="${sessionScope.userStatus.us_id}">

				<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/categoryMenu.jsp" %>

						<h1 class="box-title mt-5" style="text-align: center; margin-bottom: 40px;">
							<b>장바구니</b>
						</h1>
						<div class="container">
							<p style="text-align: right; color: red;">&#42;&nbsp;삭제&nbsp;1은&nbsp;AJAX용,&nbsp;삭제&nbsp;2는&nbsp;Non-AJAX용
							</p>
							<table class="table table-striped" id="cartList">
								<thead style="text-align: center;">
									<tr>
										<th scope="col" style="width: 3%;">
											<input type="checkbox" id="checkAll">
										</th>
										<th scope="col" style="width: 42%; text-align: justify;">상품명</th>
										<th scope="col" style="width: 10%;">단가</th>
										<th scope="col" style="width: 15%;">수량</th>
										<th scope="col" style="width: 10%;">합계</th>
										<th scope="col" style="width: 20%;">비고</th>
									</tr>
								</thead>
								<tbody style="text-align: center;">
									<c:forEach items="${cart_list}" var="cartDTO">
										<tr>
											<td>
												<input type="checkbox" name="ct_code" class="check" value="${cartDTO.ct_code}">
											</td>
											<td style="text-align: justify;">
												<img width="10%" height="15%"
													src="/user/product/imageDisplay?dateFolderName=${cartDTO.pd_image_folder}&fileName=${cartDTO.pd_image}"
													alt="">
												${cartDTO.pd_name}
											</td>
											<td>
												<span id="unitPrice">
													<fmt:formatNumber
														value="${Math.round(cartDTO.pd_price - (cartDTO.pd_price * cartDTO.pd_discount / 100))}"
														groupingUsed="true" />원
												</span>
											</td>
											<td>
												<input type="number" name="ct_amount" class="ct_amount" value="${cartDTO.ct_amount}"
													style="width: 50px; text-align: center;">
												<button type="button" name="btn_cartAmountChange" class="btn btn-info">변경</button>
											</td>
											<td>
												<span class="unitTotalPrice" id="unitTotalPrice">
													<fmt:formatNumber
														value="${Math.round((cartDTO.pd_price - (cartDTO.pd_price * cartDTO.pd_discount / 100)) * cartDTO.ct_amount)}"
														groupingUsed="true" />원
												</span>
											</td>
											<!-- button 태그 자체에 상품코드를 숨겨두거나 input 태그에 숨겨두는 등 방식은 다양함 -->
											<!-- <td><input type="checkbox" name="ct_code" value="${cartDTO.ct_code}"></td>-->
											<td>
												<button type="button" name="btn_ajax_cart_del" class="btn btn-danger">삭제&nbsp;1</button>
												<button type="button" name="btn_nonAjax_cart_del" class="btn btn-danger">삭제&nbsp;2</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td class="text-left" colspan="8">
											<button type="button" name="btn_selectDelete" class="btn btn-danger">선택&nbsp;삭제</button>
										</td>
									</tr>
									<tr>
										<td class="text-right" colspan="8">
											<b>최종 결제금액:
												<span id="cart_total_price">
													<fmt:formatNumber
														value="${Math.round(cart_total_price - (cart_total_price * cartDTO.pd_discount / 100))}"
														groupingUsed="true" />원
												</span>
											</b>
										</td>
									</tr>
									<tr>
										<td colspan="8" style="text-align: center;">
											<button type="button" id="btn_productList" class="btn btn-success">쇼핑&nbsp;계속하기</button>
											<button type="button" id="btn_cartEmpty" class="btn btn-danger">장바구니&nbsp;비우기</button>
											<button type="button" id="btn_order" class="btn btn-warning">주문하기</button>
										</td>
									</tr>
								</tfoot>
							</table>
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/user/product/categoryMenu.js"></script>

							<script>
								$(document).ready(function () {

									// 쇼핑 계속하기 버튼 클릭 이벤트
									$("#btn_productList").click(function () {

										// 단순히 URL 구분 없이 전체 목록으로 이동
										location.href = "/user/product/usProductList";
									});

									// 장바구니 비우기 버튼 클릭 이벤트
									$("#btn_cartEmpty").click(function () {

										let us_id = $('body').data('us_id')

										$.ajax({
											url: '/user/cart/cartEmpty',
											type: 'post',
											data: { us_id: us_id },
											dataType: 'text',
											success: function (response) {
												if (response == "success") {
													alert("장바구니를 비웠습니다. 쇼핑을 계속하시려면 상품 목록으로 돌아가 주세요.");
													$("#cartList tbody").empty();
													location.reload(); // 페이지를 새로고침하여 변경된 내용을 반영
												} else if (response == "empty") {
													alert("장바구니에 담긴 상품이 없습니다. 관심 있는 상품을 찾아 추가해 주세요.");
												}
											}
										});
									});

									// 주문하기 버튼 클릭 이벤트
									$("button#btn_order").on("click", function () {
										
										$.ajax({
											url: '/user/cart/hasItems',
											type: 'GET',
											success: function (hasItems) {
												if (hasItems) {
													// 장바구니에 상품이 있는 경우, 주문 페이지로 이동
													location.href = "/user/order/order_info";
												} else {
													// 장바구니에 상품이 없는 경우, 알림 메시지 표시
													alert("장바구니에 상품이 없습니다. 상품을 추가한 후 주문해 주세요.");
												}
											}
										});
									});

									// 전체 선택 체크박스 클릭 이벤트
									$("#checkAll").on('click', function () {
										let isChecked = $(this).prop('checked');
										// 전체 선택 체크박스와 개별 체크박스 상태 동기화
										$(".check").prop('checked', isChecked);
									});

									// 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
									$(".check").click(function () {

										// 전체 체크박스 개수와 체크된 체크박스 개수 비교
										let total = $(".check").length; // 페이지에 있는 모든 체크박스의 수
										let checked = $(".check:checked").length; // 현재 체크된 체크박스의 수

										// 개별 체크박스와 전체 선택 체크박스 상태 동기화
										let isAllChecked = total == checked;
										$("#checkAll").prop("checked", isAllChecked);
									});

									// "선택 삭제" 버튼 클릭 이벤트 핸들러
									$("button[name='btn_selectDelete']").on("click", function () {
										// 선택된 체크박스에서 ct_code 값을 배열로 수집
										let selectedCtCodes = $("input[type='checkbox'][name='ct_code']:checked").map(function () {
											return $(this).val();
										}).get();

										// 선택된 항목이 없는 경우 경고 메시지 출력
										if (selectedCtCodes.length === 0) {
											alert("장바구니에서 삭제할 항목을 선택해주세요.");
											return;
										}

										// 삭제 확인 대화상자 표시
										if (!confirm("선택한 항목을 정말로 삭제하시겠습니까?")) {
											return;
										}

										// AJAX 요청을 통해 서버에 선택 삭제 요청
										$.ajax({
											url: '/user/cart/cart_sel_delete',
											type: 'POST',
											data: { "cart_code_arr[]": selectedCtCodes },
											traditional: true, // 배열을 쿼리 스트링으로 서버로 전송할 때 필요
											success: function (response) {
												if (response === "success") {
													alert("선택한 항목이 정상적으로 삭제되었습니다.");
													location.reload(); // 페이지를 새로고침하여 변경된 내용을 반영
												}
											}
										});
									});


									// 숫자를 문자열로 변환하고, 천 단위마다 콤마를 삽입하는 함수
									function numberWithCommas(x) {

										return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
									}

									// 수량 변경에 따른 음수 방지 
									$(".ct_amount").on('change', function () {

										let quantity = parseInt($(this).val()); // 입력된 수량을 정수로 변환
										if (quantity < 1) {
											// 수량이 1 미만인 경우 1로 설정
											$(this).val(1);
										}
									});

									// 장바구니 목록에서 수량 변경 클릭 이벤트
									$("button[name='btn_cartAmountChange']").on("click", function () {

										let cur_btn_change = $(this); // name='btn_cartAmountChange' 값 저장 팔요
										let ct_amount = cur_btn_change.prev("input[name='ct_amount']").val();
										// let ct_amount = $(this).parent().find("input[name='ct_amount']").val();
										let ct_code = cur_btn_change.closest("tr").find("input[name='ct_code']").val();
										// let ct_code = $(this).parent().parent().find("input[name='ct_code']").val();

										$.ajax({
											url: '/user/cart/cartAmountChange',
											type: 'post',
											data: { ct_code: ct_code, ct_amount: ct_amount },
											dataType: 'text',
											// url이 동작하기 전 먼저 동작
											beforeSend: function (xhr) {
												xhr.setRequestHeader("AJAX", "true"); // String header = request.getHeader("AJAX");
											},
											success: function (result) {
												if (result == 'success') {

													alert("상품의 수량이 정상적으로 변경되었습니다.");
													// 합계금액 계산작업: 금액 = (판매가 - (판매가 * 할인율)) * 수량
													let unitPriceText = cur_btn_change.closest('tr').find("#unitPrice").text().replace(/[^0-9]/g, ""); // 비숫자 제거
													let unitPrice = parseInt(unitPriceText);
													// let unitDiscount = cur_btn_change.parent().parent().find("span#unitDiscount").text();

													let totalPrice = unitPrice * ct_amount;
													cur_btn_change.closest("tr").find(".unitTotalPrice").text(numberWithCommas(totalPrice) + '원'); // 합계 금액 업데이트

													// 장바구니 코드별 단위금액
													// let unitTotalPrice = cur_btn_change.parent().parent().find("span#unitTotalPrice");
													// unitTotalPrice.text((unitPrice - (unitPrice * unitDiscount)) * ct_amount); // text(): 입력 양식이 있는 경우(?)

													// 전체 주문금액 업데이트
													fn_cart_sum_price();
												}
											},
											error: function (xhr, status, error) {
												alert("로그인 페이지로 이동합니다.");
												location.href = "/member/login";
											}
										});
									});

									// 장바구니 삭제 1(AJAX 사용)
									$("button[name='btn_ajax_cart_del']").on("click", function () {

										if (!confirm("장바구니 상품을 삭제하겠습니까?")) return;

										let cur_btn_change = $(this); // 선택된 버튼 태그의 위치를 미리 참조
										let ct_code = $(this).parent().parent().find("input[name='ct_code']").val();

										// console.log("장바구니 코드", ct_code);

										$.ajax({
											url: '/user/cart/cart_list_del',
											type: 'post',
											data: { ct_code: ct_code },
											dataType: 'text',
											// 11월 30일 추가??????????????????
											beforeSend: function (xhr) {
												xhr.setRequestHeader("AJAX", "true"); // String header = request.getHeader("AJAX");
											},
											success: function (result) {
												if (result == 'success') {
													alert("상품이 정상적으로 삭제되었습니다.");

													cur_btn_change.parent().parent().remove(); // 삭제된 장바구니 데이터행 제거

													// 전체 주문 금액
													fn_cart_sum_price()
												}
											},
											error: function (xhr, status, error) {
												// alert(status); // response.sendError(400);
												alert("로그인 페이지로 이동합니다.");
												location.href = "/member/login";
											}
										});
									});

									// 장바구니 삭제 2(Non-AJAX용)
									$("button[name='btn_nonAjax_cart_del']").on("click", function () {

										if (!confirm("장바구니 상품을 삭제하겠습니까?")) return;

										let ct_code = $(this).parent().parent().find("input[name='ct_code']").val();
										// location.href = "장바구니 삭제 주소";는 GET 방식
										alert("상품이 정상적으로 삭제되었습니다.")
										location.href = "/user/cart/cart_list_del?ct_code=" + ct_code;
									});

									// 장바구니 전체 주문 금액: 수량 변경, 삭제 등 중복되는 코드라서 바깥에 작성
									function fn_cart_sum_price() {
										let sumPrice = 0;
										$(".unitTotalPrice").each(function () {
											sumPrice += Number($(this).text().replace(/[^0-9]/g, ""));
										});
										$("#cart_total_price").text(numberWithCommas(sumPrice) + '원');
									}

								}); // jQuery ready-end
							</script>
			</body>

			</html>