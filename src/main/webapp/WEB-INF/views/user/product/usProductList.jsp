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
						/* categoryMenu.js에서 설정한 공통 스타일 외에 나머지 스타일 */
						#categoryName {
							margin: 0 12px;
							padding-bottom: 40px;
						}

						#productSearchForm select,
						#productSearchForm input[type="text"],
						#productSearchForm button,
						#productSearchForm input[type="checkbox"] {
							height: 31.5px;
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

						#checkAction,
						#switchAction {
							padding: 10px 0;
						}

						#switchAction span {
							padding: 0 5px 2px;
							/* 외부 여백 설정 */
							font-size: 20.5px;
							/* 글자 크기 설정 */
							border: 1px solid #ccc;
							/* 테두리 설정 */
							vertical-align: middle;
							/* 수직 정렬 */
							background-color: lightpink;
							font-weight: bold;
							cursor: pointer;
						}

						#switchAction span.active {
							/* 활성화된 버튼의 스타일 */
							background-color: lightseagreen;
							color: white;
						}

						.card-deck .card {
							margin-right: 10px;
							margin-left: 10px;
							/* 내부 여백 설정 */
						}

						#productsByListView th,
						#productsByListView td {
							vertical-align: middle;
							/* 셀의 내용을 수직 중앙에 정렬 */
							text-align: center;
							/* 텍스트를 가운데 정렬 */
						}
					</style>
			</head>

			<body>

				<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/categoryMenu.jsp" %>
						<h1 class="box-title mt-5" id="productList" style="text-align: center; margin-bottom: 60px;">
							<b>상품 목록</b>
						</h1>
						<div class="container">
							<!-- 페이징 및 조건 검색 처리 -->
							<p id="categoryName"><!-- 카테고리명 동적 생성 --></p>
							<div class="row">
								<div class="col-md-6" style="padding-left: 25px;">
									<!-- <form id="actionForm">의 용도 -->
									<!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용 -->
									<!-- 2) 목록에서 상품 이미지 또는 상품명을 클릭할 때 사용 -->
									<form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
										<input type="hidden" name="cg_code" id="cg_code" value="${cg_code}" />
										<input type="hidden" name="cg_parent_name" id="cg_parent_name" value="${cg_parent_name}" />
										<input type="hidden" name="cg_name" id="cg_name" value="${cg_name}" />
										<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" id="amount" value="${pageMaker.cri.amount}" />
										<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
										<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
									</form>
									<nav aria-label="...">
										<ul class="pagination">
											<!-- 맨 처음 표시 여부 -->
											<c:if test="${pageMaker.foremost}">
												<li class="page-item">
													<a href="1" class="page-link movepage">≪</a>
												</li>
											</c:if>
											<!-- 이전 표시 여부 -->
											<c:if test="${pageMaker.prev}">
												<li class="page-item">
													<a href="${pageMaker.startPage - 1}" class="page-link movepage">&lt;</a>
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
													<a href="${pageMaker.endPage + 1}" class="page-link movepage">&gt;</a>
												</li>
											</c:if>
											<!-- 맨 끝 표시 여부 -->
											<c:if test="${pageMaker.rearmost}">
												<li class="page-item">
													<a href="${pageMaker.readEnd}" class="page-link movepage">≫</a>
												</li>
											</c:if>
										</ul>
									</nav>
								</div>
								<div class="col-md-6 text-right" style="padding-right: 0;">
									<form id="productSearchForm" action="/user/product/usProductList" method="get">
										<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
										<select name="type">
											<option value="" selected>&#45;&#45;&#45;&nbsp;검색&nbsp;조건&nbsp;선택&nbsp;&#45;&#45;&#45;</option>
											<option value="N" ${pageMaker.cri.type=='N' ? 'selected' : '' }>상품명</option>
											<option value="P" ${pageMaker.cri.type=='P' ? 'selected' : '' }>저자&#47;출판사</option>
											<option value="NC" ${pageMaker.cri.type=='NP' ? 'selected' : '' }>상품명+저자&#47;출판사</option>
										</select>
										<input type="text" name="keyword" value="${pageMaker.cri.keyword}" placeholder="검색어 입력" />
										<button type="button" class="btn btn-primary" id="btn_productSearch">검색</button>
										<div id="checkAction" style="display: inline-block">
											<input type="checkbox" id="checkAllTop" class="checkAll" style="cursor: pointer;">
											<label for="checkAllTop" style="cursor: pointer; font-size: 14px;">전체&nbsp;선택</label>
											<button type="button" class="btn btn-warning" id="btn_pickCart">선택&nbsp;장바구니</button>
											<button type="button" class="btn btn-success" id="btn_pickBuy">선택&nbsp;구매</button>
										</div>
										<!-- 뷰 전환 아이콘 -->
										<div id="switchAction" style="display: inline-block;">
											<span id="switchToCardView">𓃑</span>
											<span id="switchToListView">≣</span>
										</div>
									</form>
								</div>
							</div>
							<!-- 상품 카드뷰 -->
							<div class="card-deck mb-3 text-center row" id="productsByCardView">
								<c:forEach items="${productList}" var="pd_vo">
									<div class="col-md-3">
										<div class="card mb-4 shadow-sm">
											<input type="checkbox" name="check" value="${pd_vo.pd_number}"
												style="margin: 5px 0; cursor: pointer">
											<img class="btn_pd_image" data-pd_number="${pd_vo.pd_number}" width="100%" height="200"
												src="/user/product/imageDisplay?dateFolderName=${pd_vo.pd_image_folder}&fileName=${pd_vo.pd_image}"
												alt="" style="cursor: pointer;">
											<div class="card-body">
												<p class="card-text btn_pd_image" data-pd_number="${pd_vo.pd_number}" style="cursor: pointer;">
													${pd_vo.pd_name}</p>
												<div class="d-flex justify-content-between align-items-center">
													<div class="btn-group">
														<!-- data-변수명="" -> HTML5 속성으로 JS 처리를 위해 상품코드를 숨겨둠 -->
														<button type="button" name="btn_cartAddForCardView" class="btn btn-sm btn-outline-secondary"
															data-pd_number="${pd_vo.pd_number}">장바구니</button>
														<button type="button" name="btn_purchaseForCardView"
															class="btn btn-sm btn-outline-secondary" data-pd_name="${pd_vo.pd_name}"
															data-pd_number="${pd_vo.pd_number}">구매</button>
													</div>
													<small class="text-muted">
														<fmt:formatNumber type="currencyt" pattern="₩#,###" value="${Math.round(pd_vo.pd_price - (pd_vo.pd_price * pd_vo.pd_discount / 100))}" />
													</small>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div> <!-- card-deck mb-3 text-center row 닫는 태그 -->
							<!-- 상품 목록뷰-->
							<table class="table" id="productsByListView">
								<thead>
									<tr>
										<th scope="col" style="width: 5%">
											<input type="checkbox" id="checkAllList" class="checkAll" style="cursor: pointer">
										</th>
										<th scope="col" style="width: 65%; text-align: justify;">상품명</th>
										<th scope="col" style="width: 10%">가격</th>
										<th scope="col" style="width: 20%">비고</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${productList}" var="pd_vo">
										<tr>
											<th scope="row">
												<input type="checkbox" name="check" value="${pd_vo.pd_number}" style="cursor: pointer">
											</th>
											<td style="text-align: justify;">
												<img class="btn_pd_image"
													src="/user/product/imageDisplay?dateFolderName=${pd_vo.pd_image_folder}&fileName=${pd_vo.pd_image}"
													alt="" width="10%" height="15%" data-pd_number="${pd_vo.pd_number}" style="cursor: pointer;">
												<span class="card-text btn_pd_image" data-pd_number="${pd_vo.pd_number}"
													style="cursor: pointer;">
													${pd_vo.pd_name}의 간략한 소개
												</span>
											</td>
											<td>
												<fmt:formatNumber type="currency" pattern="₩#,###" value="${Math.round(pd_vo.pd_price - (pd_vo.pd_price * pd_vo.pd_discount / 100))}" />
											</td>
											<td>
												<button type="button" name="btn_cartAddForListView" class="btn btn-sm btn-outline-secondary"
													data-pd_number="${pd_vo.pd_number}">장바구니</button>
												<button type="button" name="btn_purchaseForListView" class="btn btn-sm btn-outline-secondary"
													data-pd_name="${pd_vo.pd_name}" data-pd_number="${pd_vo.pd_number}">구매</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 해당하는 상품이 없음을 표시하기 위해 단순 처리(미구현 상태) -->
							<p style="font-size: 18px;">&lsquo;${pageMaker.cri.keyword}&rsquo;에 대한 검색 결과가 없습니다.</p>
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

									// 저장된 뷰 모드를 기반으로 초기 뷰의 활성화된 버튼 설정
									// 일반적으로 해당 기능의 경우 sessionStorage보다는 localStorage를 사용
									let savedViewMode = localStorage.getItem('viewMode');
									if (savedViewMode == 'listView') {
										$("#productsByListView").show();
										$("#productsByCardView").hide();
										$("#switchToListView").addClass('active'); // 목록 뷰 버튼을 활성화
										$("#switchToCardView").removeClass('active'); // 카드 뷰 버튼의 활성화 해제
									} else {
										// 기본값이거나 'cardView'일 때
										$("#productsByListView").hide();
										$("#productsByCardView").show();
										$("#switchToCardView").addClass('active'); // 카드 뷰 버튼을 활성화
										$("#switchToListView").removeClass('active'); // 목록 뷰 버튼의 활성화 해제
									}

									// 카드 뷰로 전환
									$("#switchToCardView").click(function () {
										$("#productsByListView").hide(); // 목록 뷰 숨기기
										$("#productsByCardView").show(); // 카드 뷰 보이기
										localStorage.setItem('viewMode', 'cardView'); // 뷰 모드 저장
										$(this).addClass('active'); // 현재 버튼을 활성화
										$("#switchToListView").removeClass('active'); // 다른 버튼의 활성화 해제
									});

									// 목록 뷰로 전환
									$("#switchToListView").click(function () {
										$("#productsByCardView").hide(); // 카드 뷰 숨기기
										$("#productsByListView").show(); // 목록 뷰 보이기
										localStorage.setItem('viewMode', 'listView'); // 뷰 모드 저장
										$(this).addClass('active'); // 현재 버튼을 활성화
										$("#switchToCardView").removeClass('active'); // 다른 버튼의 활성화 해제
									});

									// 검색 버튼 클릭 이벤트
									$("#btn_productSearch").on("click", function () {

										console.log("검색 버튼 클릭");

										// 페이지 번호를 1로 설정
										productSearchForm.find("input[name='pageNum']").val(1);

										// 검색 조건 추출
										let type = productSearchForm.find("select[name='type']").val();
										let keyword = productSearchForm.find("input[name='keyword']").val().trim();

										// 검색 조건 유효성 검사
										if (!type) {
											alert("검색 조건을 선택해 주세요.");
											productSearchForm.find("select[name='type']").focus();
											return;
										}
										if (!keyword) {
											alert("검색어를 입력해 주세요.");
											productSearchForm.find("input[name='keyword']").focus();
											return;
										}

										// 카테고리 정보가 페이지 URL에 포함되어 있는지 확인
										const urlParams = new URLSearchParams(location.search);
										let cg_code = urlParams.get('cg_code');
										let cg_parent_name = urlParams.get('cg_parent_name');
										let cg_name = urlParams.get('cg_name');

										// 카테고리 정보가 있으면 productSearchForm에 추가, 없으면 기존 필드 제거
										if (cg_code && cg_parent_name && cg_name) {
											productSearchForm.prepend("<input type='hidden' name='cg_name' value='" + cg_name + "'>");
											productSearchForm.prepend("<input type='hidden' name='cg_parent_name' value='" + cg_parent_name + "'>");
											productSearchForm.prepend("<input type='hidden' name='cg_code' value='" + cg_code + "'>");
										} else {
											productSearchForm.find("input[name='cg_name']").remove();
											productSearchForm.find("input[name='cg_parent_name']").remove();
											productSearchForm.find("input[name='cg_code']").remove();
										}

										productSearchForm.submit(); // productSearchForm 제출
									});

									// 검색어 입력 필드에 엔터 키 이벤트 리스너 추가
									$(productSearchForm.find("input[name='keyword']")).on("keypress", function (e) {
										if (e.which == 13) { // 엔터 키의 keyCode는 13
											// 다른 이벤트 핸들러 내에서 호출된 이벤트는 각각 독립적으로 기본 동작을 가짐
											// 이에 따라 아래와 같이 명시적으로 폼 제출을 방지할 필요가 있음
											e.preventDefault();
											// 검색 버튼 클릭 이벤트와 동일한 로직 실행
											$("#btn_productSearch").click();
										}
									});

									// 페이징 처리에 대한 클릭 이벤트 설정
									// $("#actionForm")은 actionForm이라는 전역 변수로 초기화해서 사용
									$(".movepage").on("click", function (e) {

										e.preventDefault(); // <a> 태그의 href 링크 기능 제거

										let pageNum = $(this).attr("href"); // href 속성에 선택한 페이지 번호를 숨겨 이를 추출하여 사용

										// URLSearchParams를 사용해 현재 URL에서 파라미터 추출
										const urlParams = new URLSearchParams(location.search);
										let cg_code = urlParams.get('cg_code');
										let cg_parent_name = urlParams.get('cg_parent_name');
										let cg_name = urlParams.get('cg_name');
										let type = urlParams.get('type');
										let keyword = urlParams.get('keyword');

										// 공통 함수 호출
										setActionFormParams(cg_code, cg_parent_name, cg_name, type, keyword);

										// 페이지 번호 설정 및 폼 제출
										$("#pageNum").val(pageNum); // 선택한 페이지 번호 설정
										// actionForm.find("input[name='pageNum']").val(pageNum);
										actionForm.attr("action", "/user/product/usProductList");
										actionForm.submit(); // 페이지 이동 시 actionForm이 동작
									});

									// 카드 뷰에서 장바구니 추가(CartVO)
									$("button[name='btn_cartAddForCardView']").on("click", function () {

										let pd_number = $(this).data("pd_number");

										$.ajax({
											url: '/user/cart/cartAdd',
											type: 'post',
											data: { pd_number: pd_number, ct_amount: 1 }, // mbsp_id는 스프링에서 자체 처리
											dataType: 'text',
											success: function (result) {
												if (result == "success") {
													if (confirm("상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?")) {
														location.href = "/user/cart/usCartList"
													}
												}
											}
										});
									});

									// 목록 뷰에서 장바구니 추가(CartVO)
									$("button[name='btn_cartAddForListView']").on("click", function () {

										let pd_number = $(this).data("pd_number");

										$.ajax({
											url: '/user/cart/cartAdd',
											type: 'post',
											data: { pd_number: pd_number, ct_amount: 1 },
											dataType: 'text',
											success: function (result) {
												if (result == "success") {
													if (confirm("상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?")) {
														location.href = "/user/cart/usCartList"
													}
												}
											}
										});
									});

									// 카드 뷰에서 구매하기(주문)
									$("button[name='btn_purchaseForCardView']").on("click", function () {

										// 외부 스크립트가 아닌 이상 JSP 파일에서 템플릿 리터럴 사용 불가
										let pd_number = $(this).data("pd_number");
										let pd_name = $(this).data("pd_name");
										let ct_amount = 1;

										if (confirm("'" + pd_name + "'" + " 상품을 바로 구매하시겠습니까?")) {
											let url = "/user/order/orderReady?pd_number=" + pd_number + "&ct_amount=" + ct_amount;
											location.href = url;
										}
									});

									// 목록 뷰에서 구매하기(주문)
									$("button[name='btn_purchaseForListView']").on("click", function () {

										// 외부 스크립트가 아닌 이상 JSP 파일에서 템플릿 리터럴 사용 불가
										let pd_number = $(this).data("pd_number");
										let pd_name = $(this).data("pd_name");
										let ct_amount = 1;

										if (confirm("'" + pd_name + "'" + " 상품을 바로 구매하시겠습니까?")) {
											let url = "/user/order/orderReady?pd_number=" + pd_number + "&ct_amount=" + ct_amount;
											location.href = url;
										}
									});

									// 상품 이미지 또는 상품명 클릭 시 상세 페이지로 이동하는 이벤트
									$(".btn_pd_image").on("click", function () {

										console.log("상품 상세 설명");

										// URLSearchParams를 사용해 현재 URL에서 파라미터 추출
										const urlParams = new URLSearchParams(window.location.search);
										let cg_code = urlParams.get('cg_code');
										let cg_parent_name = urlParams.get('cg_parent_name');
										let cg_name = urlParams.get('cg_name');
										let type = urlParams.get('type');
										let keyword = urlParams.get('keyword');

										let pd_number = $(this).data("pd_number"); // 상품 번호 추출
										actionForm.append("<input type='hidden' name='pd_number' value='" + pd_number + "'>")

										// 공통 함수 호출
										setActionFormParams(cg_code, cg_parent_name, cg_name, type, keyword);

										// actionForm.find("input[name='pd_number']").remove(); // 뒤로가기 시 URL 내용 지우기
										actionForm.attr("action", "/user/product/productDetail");
										actionForm.submit();
									});

									// 공통 함수: URL 쿼리 파라미터 설정 및 제거
									function setActionFormParams(cg_code, cg_parent_name, cg_name, type, keyword) {

										// 카테고리 조건 설정 및 제거 
										if (cg_code) {
											$("#cg_code").val(cg_code);
										} else {
											$("#cg_code").remove();
										}
										if (cg_parent_name) {
											$("#cg_parent_name").val(cg_parent_name);
										} else {
											$("#cg_parent_name").remove();
										}
										if (cg_name) {
											$("#cg_name").val(cg_name);
										} else {
											$("#cg_name").remove();
										}

										// 검색 조건 설정 및 제거
										if (type) {
											$("#type").val(type);
										} else {
											$("#type").remove();
										}
										if (keyword) {
											$("#keyword").val(keyword);
										} else {
											$("#keyword").remove();
										}
									}

									// 전체 선택 체크박스 클릭 이벤트(상단)
									$("#checkAllTop").on('click', function () {
										let isChecked = $(this).prop('checked');
										// 목록뷰의 전체 선택 체크박스와 개별 체크박스 상태 동기화
										$("#checkAllList").prop('checked', isChecked);
										$("input[name='check']").prop('checked', isChecked);
									});

									// 전체 선택 체크박스 클릭 이벤트(목록뷰)
									$("#checkAllList").on('click', function () {
										let isChecked = $(this).prop('checked');
										// 상단의 전체 선택 체크박스와 목록 내의 개별 체크박스 상태 동기화
										$("#checkAllTop").prop('checked', isChecked);
										$("input[name='check']").prop('checked', isChecked);
									});

									// 개별 체크박스 클릭 시 전체 선택 체크박스 상태 업데이트
									$("input[name='check']").click(function () {

										let viewMode = localStorage.getItem('viewMode');
										let selectorPrefix = viewMode == 'listView' ? "#productsByListView " : "#productsByCardView ";

										// 전체 체크박스 개수와 체크된 체크박스 개수 비교
										let total = $(selectorPrefix + "input[name='check']").length; // 페이지에 있는 모든 체크박스의 수
										let checked = $(selectorPrefix + "input[name='check']:checked").length; // 현재 체크된 체크박스의 수

										// 두 전체 선택 체크박스 상태 동기화
										let isAllChecked = total == checked;
										$(".checkAll").prop("checked", isAllChecked);
									});

									// "선택 장바구니" 버튼 클릭 이벤트
									$("#btn_pickCart").click(function () {

										// 현재 보이는 뷰 모드(카드뷰 또는 목록뷰) 확인
										let viewMode = localStorage.getItem('viewMode');
										// 뷰 모드에 따라 적절한 선택자(prefix) 설정
										let selectorPrefix = viewMode == 'listView' ? "#productsByListView " : "#productsByCardView ";

										// 현재 뷰에서 체크된 상품의 번호 수집
										let selectedProducts = $(selectorPrefix + "input[name='check']:checked").map(function () {
											return $(this).val(); // 체크된 상품의 value(상품 번호) 반환
										}).get(); // jQuery 객체를 실제 JavaScript 배열로 변환, 이를 통해 배열 메서드 사용 가능

										// 선택된 상품이 없는 경우의 알림
										if (selectedProducts.length == 0) {
											alert("장바구니에 담을 상품을 선택해 주세요.");
											return;
										}

										console.log("선택된 상품 번호:", selectedProducts);

										 // 선택된 상품 각각에 대해 장바구니 추가 AJAX 요청 생성
										let requests = selectedProducts.map(pd_number => {
											// $.ajax() 호출 결과는 프로미스 객체
											return $.ajax({
												url: '/user/cart/cartAdd',
												type: 'POST',
												data: { pd_number: pd_number, ct_amount: 1 }
											});
										});

										// 모든 AJAX 요청이 완료된 후 처리($.when을 사용하여 여러 프로미스 처리)
										$.when(...requests).then(function () {
											// 모든 요청 성공 시, 장바구니 페이지 이동 여부 확인
											if (confirm("선택한 상품이 모두 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?")) {
												location.href = "/user/cart/usCartList"; // 장바구니 페이지로 이동
											}
										});
									});

									// "선택 구매" 버튼 클릭 이벤트
									$("#btn_pickBuy").click(function () {

										// 현재 보이는 뷰 모드(카드뷰 또는 목록뷰) 확인
										let viewMode = localStorage.getItem('viewMode');
										// 뷰 모드에 따라 적절한 선택자(prefix) 설정
										let selectorPrefix = viewMode == 'listView' ? "#productsByListView " : "#productsByCardView ";

										// 현재 뷰에서 체크된 상품의 번호 수집
										let selectedProducts = $(selectorPrefix + "input[name='check']:checked").map(function () {
											return $(this).val(); // 체크된 상품의 value(상품 번호) 반환
										}).get(); // get()을 사용하여 jQuery 객체에서 실제 JavaScript 배열로 변환

										// 선택된 상품이 없는 경우의 알림
										if (selectedProducts.length == 0) {
											alert("주문하거나 구매할 상품을 선택해 주세요.");
											return;
										}

										console.log("선택된 상품 번호:", selectedProducts);

										// 구매 확인 후 폼 생성 및 제출을 통해 서버에 요청
										if (confirm("선택된 상품을 바로 구매하시겠습니까?")) {
											let form = $('<form>', {
												'action': '/user/order/orderReadyMultiple',
												'method': 'POST'
											});

											// 선택된 상품 번호를 폼에 숨겨진 입력 필드로 추가
											$.each(selectedProducts, function (index, value) {
												$(form).append($('<input>', {
													'type': 'hidden',
													'name': 'pd_numbers',
													'value': value // 상품 번호
												}));
												console.log(value);
											});

											// 폼을 문서에 추가하고 제출
											// $(form).appendTo('body').submit();
											$('body').append(form);
											// console.log(form.prop('outerHTML'));
											$(form).submit();
										
										}
									});

								}); // ready-end
							</script>
			</body>

			</html>