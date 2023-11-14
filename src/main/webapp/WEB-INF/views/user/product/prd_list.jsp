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
					<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>

						<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
							<p>2차 카테고리: ${cg_name}</p>
						</div>

						<div class="container">
							<div class="card-deck mb-3 text-center row">
								<c:forEach items="${prd_list}" var="productVO">
									<div class="col-md-3">
										<div class="card mb-4 shadow-sm">
											<img width="100%" height="200"
												src="/user/product/imageDisplay?dateFolderName=${productVO.prd_up_folder}&fileName=${productVO.prd_img}"
												alt="">
											<div class="card-body">
												<p class="card-text">${productVO.prd_name}</p>
												<div class="d-flex justify-content-between align-items-center">
													<div class="btn-group">
														<!-- data-변수명="" -> HTML5 속성으로 JS 처리를 위해 상품코드를 숨겨둠 -->
														<button type="button" name="btn_cart_add" data-prd_num="${productVO.prd_num}"
															class="btn btn-sm btn-outline-secondary">Cart</button>
														<button type="button" name="btn_buy" class="btn btn-sm btn-outline-secondary">Buy</button>
													</div>
													<small class="text-muted">
														<fmt:formatNumber type="currencyt" pattern="₩#,###" value="${productVO.prd_price}">
														</fmt:formatNumber>
													</small>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div> <!-- card-deck mb-3 text-center row 닫는 태그 -->
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

									<nav aria-label="...">
										<ul class="pagination">
											<!-- 이전 표시 여부 -->
											<c:if test="${pageMaker.prev}">
												<li class="page-item">
													<a href="${pageMaker.startPage - 1}" class="page-link movepage">Previous</a>
												</li>
											</c:if>

											<!-- 페이지 번호 출력 작업 -->
											<!--  1 2 3 4 5 6 7 8 9 10 [다음] -->
											<!--  [이전] 11 12 13 14 15 16 17 18 19 20 [다음] -->
											<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
												<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : "" }' aria-current="page">
													<a class="page-link movepage" href="${num}" data-page="${num}">${num}</a>
													<!-- 임의로 만든 클래스명 movepage는 페이지 번호와 관련 -->
												</li>
											</c:forEach>

											<!-- 다음 표시 여부 -->
											<c:if test="${pageMaker.next}">
												<li class="page-item">
													<a href="${pageMaker.endPage + 1}" class="page-link movepage">Next</a>
												</li>
											</c:if>
										</ul>
									</nav>
								</div>
							</div>
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

							<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

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
												// $(this).data("pro_num"): 버튼을 눌렀을 때 동작하는 장바구니 상품코드
												data: { pro_num: $(this).data("pro_num"), cart_amount: 1 }, // mbsp_id는 스프링에서 자체 처리
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
									});
								</script>
			</body>

			</html>