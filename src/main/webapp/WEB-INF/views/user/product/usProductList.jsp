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
				<title>데브데이&#58;&nbsp;상품조회</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/product/categoryMenu.css">

					<style>
						#productSearchForm select,
						#productSearchForm input[type="text"],
						#productSearchForm button {
							height: 35px;
							/* 높이 설정 */
							padding: 5px 10px;
							/* 외부 여백 설정 */
							font-size: 14px;
							/* 글자 크기 설정 */
							border: 1px solid #ccc;
							/* 테두리 설정 */
							vertical-align: middle;
							/* 수직 정렬 */
						}

						.card-deck .card {
							margin-right: 10px;
							margin-left: 10px;
							/* 내부 여백 설정 */
						}
					</style>
			</head>

			<body>

				<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/categoryMenu.jsp" %>
						<h1 class="box-title mt-5" id="productList" style="text-align: center; margin-bottom: 40px;">
							<b>상품 목록</b>
						</h1>
						<div class="container">
							<!-- 카테고리명 및 페이징/검색 처리 -->
							<p id="categoryName">1차&nbsp;&gt;&gt;&gt;&nbsp;${cg_name}</p>
							<div class="row">
								<div class="col-md-6" style="padding-left: 25px;">
									<!-- <form id="actionForm">의 용도 -->
									<!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용 -->
									<!-- 2) 목록에서 상품 이미지 또는 상품명을 클릭할 때 사용 -->
									<form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
										<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
										<input type="hidden" name="type" value="${pageMaker.cri.type}" />
										<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
										<input type="hidden" name="cg_code" value="${cg_code}" />
										<input type="hidden" name="cg_name" value="${cg_name}" />
									</form>
									<nav aria-label="...">
										<ul class="pagination">
											<!-- 맨 처음 표시 여부 -->
											<c:if test="${pageMaker.foremost}">
												<li class="page-item">
													<a href="1" class="page-link movepage">처음</a>
												</li>
											</c:if>
											<!-- 이전 표시 여부 -->
											<c:if test="${pageMaker.prev}">
												<li class="page-item">
													<a href="${pageMaker.startPage - 1}" class="page-link movepage">이전</a>
												</li>
											</c:if>
											<!-- 페이지 번호 출력 작업 -->
											<!--  1 2 3 4 5 6 7 8 9 10 [다음] -->
											<!--  [이전] 11 12 13 14 15 16 17 18 19 20 [다음] -->
											<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="number">
												<li class='page-item ${pageMaker.cri.pageNum == number ? "active" : "" }' aria-current="page">
													<a class="page-link movepage" href="${number}" data-page="${number}">${number}</a>
													<!-- 임의로 만든 클래스명 movepage는 페이지 번호와 관련 -->
												</li>
											</c:forEach>
											<!-- 다음 표시 여부 -->
											<c:if test="${pageMaker.next}">
												<li class="page-item">
													<a href="${pageMaker.endPage + 1}" class="page-link movepage">다음</a>
												</li>
											</c:if>
											<!-- 맨 끝 표시 여부 -->
											<c:if test="${pageMaker.rearmost}">
												<li class="page-item">
													<a href="${pageMaker.readEnd}" class="page-link movepage">끝</a>
												</li>
											</c:if>
										</ul>
									</nav>
								</div> 
								<div class="col-md-6 text-right" style="padding-right: 0;">
									<form action="/user/product/usProductList" method="get" id="productSearchForm">
										<select name="type" id="type">
											<option value="" selected>&#45;&#45;&#45;&nbsp;검색 조건 선택&nbsp;&#45;&#45;&#45;</option>
											<option value="N" ${pageMaker.cri.type=='N' ? 'selected' : '' }>상품명</option>
											<option value="P" ${pageMaker.cri.type=='P' ? 'selected' : '' }>저자&#47;출판사</option>
											<option value="NC" ${pageMaker.cri.type=='NP' ? 'selected' : '' }>상품명+저자&#47;출판사</option>
										</select>
										<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}"
											placeholder="검색어 입력" />
										<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
										<button type="button" class="btn btn-primary" id="btn_productSearch">검색</button>
									</form>
								</div>
							</div>
							<!-- 상품 카드 목록 -->
							<div class="card-deck mb-3 text-center row">
								<c:forEach items="${productList}" var="productVO">
									<div class="col-md-3">
										<div class="card mb-4 shadow-sm">
											<img class="btn_pd_image" data-pd_number="${productVO.pd_number}" width="100%" height="200"
												src="/user/product/imageDisplay?dateFolderName=${productVO.pd_image_folder}&fileName=${productVO.pd_image}"
												alt="" style="cursor: pointer;">
											<div class="card-body">
												<p class="card-text btn_pd_image" data-pd_number="${productVO.pd_number}"
													style="cursor: pointer;">${productVO.pd_name}</p>
												<div class="d-flex justify-content-between align-items-center">
													<div class="btn-group">
														<!-- data-변수명="" -> HTML5 속성으로 JS 처리를 위해 상품코드를 숨겨둠 -->
														<button type="button" name="btn_cartAdd" class="btn btn-sm btn-outline-secondary"
															data-pd_number="${productVO.pd_number}">장바구니</button>
														<button type="button" name="btn_purchase" class="btn btn-sm btn-outline-secondary"
															data-pd_name="${productVO.pd_name}" data-pd_number="${productVO.pd_number}">구매</button>
													</div>
													<small class="text-muted">
														<fmt:formatNumber type="currencyt" pattern="₩#,###" value="${productVO.pd_price}">
														</fmt:formatNumber>
													</small>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div> <!-- card-deck mb-3 text-center row 닫는 태그 -->
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스. resource 폴더 참조 -->
							<!-- JS 경로를 사용하려면, servlet-context.xml 파일에서 설정해야 한다. -->
							<script src="/js/user/product/categoryMenu.js"></script>

							<script>
								$(document).ready(function () {

									// 전역 변수 초기화
									let productSearchForm = $("#productSearchForm");
									let actionForm = $("#actionForm");

									// 검색 버튼 클릭 이벤트
									$("#btn_productSearch").on("click", function () {

										let type = $('#type').val();
										let keyword = $('#keyword').val();

										if (!type || type == '') {
											alert("검색 조건을 선택해 주세요.");
											$('#type').focus();
											return;
										}

										if (!keyword || keyword.trim() == '') {
											alert("검색어를 입력해 주세요.");
											$('#keyword').focus();
											return;
										}

										productSearchForm.submit();
									});

									// [이전] 1 2 3 4 5 ... [다음] 클릭 이벤트 설정. <a> 태그
									$(".movepage").on("click", function (e) {
										e.preventDefault(); // a 태그의 href 링크 기능을 제거. href 속성에 페이지 번호를 숨겨둠

										actionForm.attr("action", "/user/product/usProductList");
										// actionForm.find("input[name='pageNum']").val(선택한 페이지 번호);
										actionForm.find("input[name='pageNum']").val($(this).attr("href"));

										actionForm.submit(); // 페이지 이동 시 actionForm이 동작
									});

									// 장바구니 추가(CartVO)
									$("button[name='btn_cartAdd']").on("click", function () {
										// console.log("장바구니");
										$.ajax({
											url: '/user/cart/cart_add', // url: '장바구니 추가 주소', 
											type: 'post',
											// $(this).data("pd_number"): 버튼을 눌렀을 때 동작하는 장바구니 상품코드
											data: { pd_number: $(this).data("pd_number"), ct_amount: 1 }, // mbsp_id는 스프링에서 자체 처리
											dataType: 'text',
											success: function (result) {
												if (result == "success") {
													if (confirm("장바구니에 상품이 추가되었습니다. 장바구니로 이동하시겠습니까?")) {
														location.href = "/user/cart/cart_list"
													}
												}
											}
										});
									});

									// 구매하기(주문)
									$("button[name='btn_purchase']").on("click", function () {

										// 외부 스크립트가 아닌 이상 JSP 파일에서 템플릿 리터럴 사용 불가
										let pd_number = $(this).data("pd_number");
										let pd_name = $(this).data("pd_name");

										if (confirm("'" + pd_name + "'" + " 상품을 바로 구매하시겠습니까?")) {
											let url = "/user/order/orderReady?pd_number=" + pd_number;
											location.href = url;
										}
									});

									// 상품 이미지 또는 상품명 클릭 시 상세로 보내는 작업
									$(".btn_pd_image").on("click", function () {
										console.log("상품 상세 설명");

										// actionForm.attr("action", "상품 상세 주소");
										actionForm.attr("action", "/user/product/productDetail");
										let pd_number = $(this).data("pd_number");

										actionForm.find("input[name='pd_number']").remove(); // 뒤로가기 시 URL 내용 지우기
										// <input type='hidden' name='pd_number' value='상품코드'> 미리 만들어서 작성
										actionForm.append("<input type='hidden' name='pd_number' value='" + pd_number + "'>")
										actionForm.submit();
									});

								}); // ready event end
							</script>
			</body>

			</html>