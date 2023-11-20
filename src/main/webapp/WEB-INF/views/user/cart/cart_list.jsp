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

					<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
						<p>장바구니</p>
					</div>

					<div class="container">
						<table class="table table-striped">
							<thead style="text-align: center;">
								<tr>
									<th scope="col"><input type="checkbox" id="checkAll"></th>
									<th scope="col">상품</th>
									<th scope="col">상품명</th>
									<th scope="col">판매가</th>
									<th scope="col">수량</th>
									<th scope="col">합계</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody style="text-align: center;">
								<c:forEach items="${cart_list}" var="cartDTO">
									<tr>
										<td><input type="checkbox" name="cart_code" value="${cartDTO.cart_code}"></td>
										<td><img width="50%" height="50"
												src="/user/product/imageDisplay?dateFolderName=${cartDTO.prd_up_folder}&fileName=${cartDTO.prd_img}"
												alt="">
										</td>
										<td>${cartDTO.prd_name}</td>
										<td><span id="unitPrice">${cartDTO.prd_price}</span></td>
										<td>
											<input type="number" name="cart_amount" value="${cartDTO.cart_amount}" style="width: 45px;">
											<button type="button" name="btn_cart_amount_change" class="btn btn-info">변경</button>
										</td>
										<td><span class="unitTotalPrice" id="unitTotalPrice">${cartDTO.prd_price * cartDTO.cart_amount}</span></td>
												<!-- button 태그 자체에 상품코드를 숨겨두거나 input 태그에 숨겨두는 등 방식은 다양함 -->
												<!-- <td><input type="checkbox" name="cart_code" value="${cartDTO.cart_code}"></td>-->
										<td>
											<button type="button" name="btn_ajax_cart_del" class="btn btn-danger">삭제 1(AJAX용)</button>
											<button type="button" name="btn_nonAjax_cart_del" class="btn btn-danger">삭제 2(Non-AJAX용)</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="8"><button type="button" class="btn btn-danger">선택삭제</button></td>
								</tr>
								<tr>
									<td colspan="8" style="text-align: right;">
										최종 결제금액: <span id="cart_total_price">${cart_total_price}</span>
									</td>
								</tr>
								<tr>
									<td colspan="8" style="text-align: center;">
										<button type="button" id="btn_product" class="btn btn-primary">쇼핑 계속하기</button>
										<button type="button" id="btn_cart_empty" class="btn btn-primary">장바구니 비우기</button>
										<button type="button" id="btn_order" class="btn btn-primary">주문하기</button>
									</td>
								</tr>
							</tfoot>
						</table>
						<%@include file="/WEB-INF/views/comm/footer.jsp" %>
					</div> <!-- container 닫는 태그 -->

					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

						<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
						<script src="/js/category_menu.js"></script>

						<script>
							$(document).ready(function () {

								// 장바구니 목록에서 변경 클릭 시(name="btn_cart_amount_change" 속성 이용)
								$("button[name='btn_cart_amount_change']").on("click", function () {

									// name='btn_cart_amount_change' 값 저장 팔요
									let cur_btn_change = $(this);
									// $(this).prev(): 이전 태그를 가져오는 방식 사용할 수도 있음
									let cart_amount = $(this).parent().find("input[name='cart_amount']").val();
									// console.log("수량", cart_amount)
									let cart_code = $(this).parent().parent().find("input[name='cart_code']").val();
									// console.log("장바구니 코드", cart_code);

									$.ajax({
										url: '/user/cart/cart_amount_change',
										type: 'post',
										data: { cart_code: cart_code, cart_amount: cart_amount },
										dataType: 'text',
										success: function (result) {
											if (result == 'success') {
												
												alert("수량변경이 되었습니다.");
												// 합계금액 계산작업
												// 금액 = (판매가 - (판매가 * 할인율)) * 수량
												let unitPrice = cur_btn_change.parent().parent().find("span#unitPrice").text();
												let unitDiscount = cur_btn_change.parent().parent().find("span#unitDiscount").text();

												// 장바구니 코드별 단위금액
												let unitTotalPrice = cur_btn_change.parent().parent().find("span#unitTotalPrice");
												unitTotalPrice.text((unitPrice - (unitPrice * unitDiscount)) * cart_amount); // text(): 입력 양식이 있는 경우(?)

												// 전체 주문금액
												fn_cart_sum_price();
											}
										}
									});
								});

								// 장바구니 삭제(AJAX 사용)
								$("button[name='btn_ajax_cart_del']").on("click", function() {

									if(!confirm("장바구니 상품을 삭제하겠습니까?")) return;
									
									let cur_btn_change = $(this); // 선택된 버튼 태그의 위치를 미리 참조
									let cart_code = $(this).parent().parent().find("input[name='cart_code']").val();
									
									// console.log("장바구니 코드", cart_code);

									$.ajax({
										url: '/user/cart/cart_list_del',
										type: 'post',
										data: {cart_code: cart_code},
										dataType: 'text',
										success: function(result) {
											if(result == 'success') {
												alert("장바구니 상품이 삭제되었습니다.");

												cur_btn_change.parent().parent().remove(); // 삭제된 장바구니 데이터행 제거

												// 전체 주문 금액
												fn_cart_sum_price()
											}
										}
									});
								});

								// 장바구니 삭제(Non-AJAX용)
								$("button[name='btn_nonAjax_cart_del']").on("click", function() {

									if(!confirm("장바구니 상품을 삭제하겠습니까?")) return;

									let cart_code = $(this).parent().parent().find("input[name='cart_code']").val();
									// location.href = "장바구니 삭제 주소";는 GET 방식
									location.href = "/user/cart/cart_list_del?cart_code=" + cart_code;
								});
								
								// 주문하가
								$("button#btn_order").on("click", function() {
									// location.href = "주문하기 페이지 주소"
									location.href = "/user/order/order_info"
								});

							}); // jQuery ready-end

							// 장바구니 전체 주문 금액: 수량 변경, 삭제 등 중복되는 코드라서 바깥에 작
							function fn_cart_sum_price() {
								let sumPrice = 0;
										$(".unitTotalPrice").each(function () {
											sumPrice += Number($(this).text());
										});
										$("#cart_total_price").text(sumPrice);
							}
						</script>
			</body>

			</html>