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
				<title>데브데이&#58; 상품조회</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/product/categoryMenu.css">
					<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
					<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">

					<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
					<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

					<!-- Handlebars(핸들바 템플릿 엔진): 서버에서 보내온 JSON 형태의 데이터를 사용하여 작업을 편하게 할 수 있는 특징 -->
					<script src="/js/handlebars.js"></script>
					<script id="reviewTemplate" type="text/x-handlebars-template">
						<table class="table table-sm" id="reviewList">
							<thead>
								<tr>
									<th scope="col" style="width: 7.5%;">번호</th>
									<th scope="col" style="width: 50%; text-align: justify;">내용</th>
									<th scope="col" style="width: 12.5%;">평점</th>
									<th scope="col" style="width: 10%;">날짜</th>
									<th scope="col" style="width: 20%;">비고</th>
								</tr>
							</thead>
							<tbody>
								{{#each .}}
								<tr>
									<th scope="row" class="rv_number">{{rv_number}}</th>
									<td class="rv_content" style="text-align: justify;">{{rv_content}}</td>
									<td class="rv_score">{{displayStar rv_score}}</td> <!-- displayStar 함수 -->
									<td class="rv_register_date">{{convertDate rv_register_date}}</td>  <!-- convertDate 함수 -->
									<td>{{authControlView us_id rv_number rv_score}}</td> <!-- authControlView 함수 -->
								</tr>
								{{/each}}
							</tbody>
						</table>
					</script>

					<script>
						$(function () {
							$("#tabs_pd_detail").tabs();
						});
					</script>

					<style>
						#returnList {
							/* text-decoration: none; */
							color: gray;
						}

						/* categoryMenu.js에서 설정한 공통 스타일 외에 나머지 스타일 */
						#categoryName {
							margin-top: 50px;
							margin-left: 50px;
						}

						#productName {
							text-align: center;
							margin-bottom: 40px;
						}

						.btn_pd_image {
							border: 1px solid black
						}

						#productName,
						#productCompany,
						#discountPercent {
							font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
						}

						/* 원가에 대한 스타일 */
						#originalPrice {
							font-size: 0.8em;
							/* 기본 글자 크기보다 작게 설정 */
							text-decoration: line-through;
							/* 취소선 표시. <s>태그와 동일*/
						}

						#reviewList th,
						#reviewList td {
							vertical-align: middle;
							/* 셀의 내용을 수직 중앙에 정렬 */
							text-align: center;
							/* 텍스트를 가운데 정렬 */
						}

						#reviewList button {
							padding: 2px 4px;
							margin: 5px;
						}

						/* 평점 기본선택자 */
						p#star_rv_score a.rv_score {
							font-size: 22px;
							text-decoration: none;
							color: lightgray;
						}

						/* 평점에 마우스 오버했을 경우 사용되는 CSS 선택자 */
						p#star_rv_score a.rv_score.on {
							color: red;
						}
					</style>
			</head>

			<body>

				<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/categoryMenu.jsp" %>
						<a href="" id="returnList">
							<p id="categoryName"><!-- 카테고리명 동적 생성 --></p>
						</a>
						<div class="container" style="margin-top: 80px;">
							<h3 id="productName">${pd_vo.pd_name}</h3>
							<div class="card-deck mb-3 text-center row">
								<div class="col-md-4">
									<div class="row text-center">
										<div class="col">
											<h5 id="productCompany">${pd_vo.pd_company}</h5>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<img class="btn_pd_image" data-pd_number="${pd_vo.pd_number}" width="100%" height="330"
										src="/user/product/imageDisplay?dateFolderName=${pd_vo.pd_image_folder}&fileName=${pd_vo.pd_image}"
										alt="">
									<div style="margin: 25px;">
										<div>
											<span>수량&#58;</span>
											<input type="number" id="btn_quantity" value="1" style="width: 50px; text-align: center;">
										</div>
										<div>
											<span>총&nbsp;상품금액&#58;</span>
											<span id="tot_price">
												<fmt:formatNumber
													value="${Math.round(pd_vo.pd_price - (pd_vo.pd_price * pd_vo.pd_discount / 100))}"
													groupingUsed="true" />원
											</span>
										</div>
									</div>
									<div style="margin: 25px;">
										<button type="button" class="btn btn-warning" name="btn_cartAdd" style="margin-right: 5px;"
											data-pd_number="${pd_vo.pd_number}">장바구니</button>
										<button type="button" class="btn btn-danger" name="btn_purchase" style="margin-right: 5px;"
											data-pd_number="${pd_vo.pd_number}" data-pd_name="${pd_vo.pd_name}">구매</button>
										<button type="button" class="btn btn-success" name="btn_list">목록</button>
									</div>
								</div>
								<div class="col-md-4">
									<!-- <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
										<p>2차 카테고리: ${cg_name}</p>
									</div> -->
									<div class="row text-center">
										<div class="col">
											<h5>
												<c:if test="${pd_vo.pd_discount > 0}">
													<span id="discountPercent">
														&#91;
														<fmt:formatNumber value="${pd_vo.pd_discount / 100}" type="percent" />&#93;
													</span>
												</c:if>
												<span id="discountPrice">
													<fmt:formatNumber
														value="${Math.round(pd_vo.pd_price - (pd_vo.pd_price * pd_vo.pd_discount / 100))}"
														groupingUsed="true" />원
												</span>
												<c:if test="${pd_vo.pd_discount > 0}">
													<span id="originalPrice">
														&#40;
														<fmt:formatNumber value="${pd_vo.pd_price}" groupingUsed="true" />원&#41;
													</span>
												</c:if>
											</h5>
										</div>
									</div>
									<div class="row text-left">

									</div>

								</div>
							</div> <!-- card-deck mb-3 text-center row 닫는 태그 -->

							<div class="row">
								<div class="col-md-12">
									<div id="tabs_pd_detail">
										<ul>
											<li><a href="#tabs-prodetail">상품 설명</a></li>
											<li><a href="#tabs-proreview">상품 후기</a></li>
										</ul>
										<div id="tabs-prodetail">
											<p>${pd_vo.pd_content}</p>
										</div>
										<div id="tabs-proreview">
											<div class="row">
												<div class="col-md-12" id="review_list">
													<!-- 정적 태그(이하 동적 태그) -->
												</div>
											</div>
											<div class="row">
												<div class="col-md-8 text-center" id="review_paging">
													<!-- 정적 태그(이하 동적 태그) -->
												</div>
												<div class="col-md-4 text-right">
													<button type="button" id="btn_review_write" class="btn btn-info">작성하기</button>
												</div>
											</div>
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
										<input type="hidden" name="cg_code" id="cg_code" value="${cg_code}" />
										<input type="hidden" name="cg_parent_name" id="cg_parent_name" value="${cg_parent_name}" />
										<input type="hidden" name="cg_name" id="cg_name" value="${cg_name}" />
										<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" id="amount" value="${pageMaker.cri.amount}" />
										<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
										<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
									</form>
								</div>
							</div>

							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<!-- JSP 주석 -->
						<%-- <%@include file="/WEB-INF/views/comm/plugIn2.jsp" %> --%>
							<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
								integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
								crossorigin="anonymous"></script>
							<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
								integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
								crossorigin="anonymous"></script>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/user/product/categoryMenu.js"></script>

							<script>
								$(document).ready(function () {

									let actionForm = $("#actionForm");  // 액션폼 참조

									// 장바구니 추가(CartVO)
									$("button[name='btn_cartAdd']").on("click", function () {
										// console.log("장바구니");
										$.ajax({
											url: '/user/cart/cartAdd', // url: '장바구니 추가 주소', 
											type: 'post',
											// $(this).data("pd_number"): 버튼을 눌렀을 때 동작하는 장바구니 상품코드
											data: { pd_number: $(this).data("pd_number"), ct_amount: $("#btn_quantity").val() }, // mbsp_id는 스프링에서 자체 처리
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

									// 구매하기(주문)
									$("button[name='btn_purchase']").on("click", function () {

										// 외부 스크립트가 아닌 이상 JSP 파일에서 템플릿 리터럴 사용 불가
										let pd_number = $(this).data("pd_number");
										let pd_name = $(this).data("pd_name");
										let ct_amount = $("#btn_quantity").val();
										
										if (confirm("'" + pd_name + "'" + " 상품을 바로 구매하시겠습니까?")) {
											let url = "/user/order/orderReady?pd_number=" + pd_number + "&ct_amount=" + ct_amount;
											location.href = url;
										}
									});

									// 카테고리명(또는 전체 상품) 링크 클릭 이벤트
									$("#returnList").on("click", function (e) {

										e.preventDefault(); // 기본 동작 방지

										// 쿼리 파라미터가 필요한 경우만 폼에 추가
										const urlParams = new URLSearchParams(location.search);

										// 카테고리 조건 추출 및 설정
										let cg_code = urlParams.get('cg_code');
										let cg_parent_name = urlParams.get('cg_parent_name');
										let cg_name = urlParams.get('cg_name');

										// 페이징 및 검색 조건 추출 및 설정
										let pageNum = urlParams.get('pageNum');
										let amount = urlParams.get('amount');
										let type = urlParams.get('type');
										let keyword = urlParams.get('keyword');

										// 공통 함수 호출(pageNum, amount 추가)
										setActionFormParams(cg_code, cg_parent_name, cg_name, pageNum, amount, type, keyword);

										// 폼의 액션 설정 및 제출
										actionForm.attr("action", "/user/product/usProductList");
										actionForm.submit(); // 페이지 이동 시 actionForm이 동작
									});

									// 목록 버튼 클릭 이벤트
									$("button[name='btn_list']").on("click", function () {

										// 쿼리 파라미터가 필요한 경우만 폼에 추가
										const urlParams = new URLSearchParams(location.search);

										// 카테고리 조건 추출 및 설정
										let cg_code = urlParams.get('cg_code');
										let cg_parent_name = urlParams.get('cg_parent_name');
										let cg_name = urlParams.get('cg_name');

										// 페이징 및 검색 조건 추출 및 설정
										let pageNum = urlParams.get('pageNum');
										let amount = urlParams.get('amount');
										let type = urlParams.get('type');
										let keyword = urlParams.get('keyword');

										// 공통 함수 호출(pageNum, amount 추가)
										setActionFormParams(cg_code, cg_parent_name, cg_name, pageNum, amount, type, keyword);

										// 폼의 액션 설정 및 제출
										actionForm.attr("action", "/user/product/usProductList");
										actionForm.submit(); // 페이지 이동 시 actionForm이 동작
									});

									// 공통 함수: URL 쿼리 파라미터 설정 및 제거
									function setActionFormParams(cg_code, cg_parent_name, cg_name, pageNum, amount, type, keyword) {

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

										// 페이징 및 검색 조건 설정 및 제거
										if (pageNum) {
											$("#pageNum").val(pageNum);
										} else {
											$("#pageNum").remove();
										} if (amount) {
											$("#amount").val(amount);
										} else {
											$("#amount").remove();
										}
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

									// 숫자를 문자열로 변환하고, 천 단위마다 콤마를 삽입하는 함수
									function numberWithCommas(x) {

										return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
									}

									// 수량 변경에 따른 총 가격 계산 및 음수 방지 
									$("#btn_quantity").on('change', function () {

										// 가격 정보에서 숫자가 아닌 문자 제거 및 총 가격 계산
										let unitPrice = parseInt($("#discountPrice").text().replace(/[^0-9]/g, ""));
										let quantity = parseInt($("#btn_quantity").val()); // 입력된 수량을 정수로 변환

										// 수량이 1 미만인 경우 1로 설정하고, 그 후에 총 가격을 다시 계산
										if (quantity < 1) {
											$(this).val(1); // 입력 필드의 값을 1로 업데이트
											quantity = 1; // 계산에 사용될 변수의 값을 1로 조정
										}

										let tot_price = unitPrice * quantity; // 총 상품금액 재계산

										// 총 상품금액 표시
										$("#tot_price").text(numberWithCommas(tot_price) + '원');
									});

									// 상품후기 작성 폼
									$("#btn_review_write").on("click", function () {

										$("#btn_review_modify").hide(); // 상품후기 수정하기 버튼 숨김
										$("#btn_review_save").show(); // 상품후기 수정하기 버튼 보임
										// 상품후기 수정 버튼에 후기 번호를 data-rv_number 속성으로 적용
										// $("#btn_review_modify").data("rv_number", $(this).parent().parent().find(".rv_number").text());
										$('#review_modal').modal('show')
									});

									// 평점 클릭시(평점 태그 5개 ☆☆☆☆☆) 
									$("p#star_rv_score a.rv_score").on("click", function (e) {
										e.preventDefault();

										// $(this): 클릭한 a 태그
										$(this).parent().children().removeClass("on");
										$(this).addClass("on").prevAll("a").addClass("on");
									});

									// 상품평 목록 불러오는 작업(이벤트 사용하지 않고 직접 호출)
									let reviewPage = 1; // 목록에서 첫 번째 페이지를 의미
									// @GetMapping("/list/{pd_num}/{page}")
									let url = "/user/review/list/" + "${pd_vo.pd_number}" + "/" + reviewPage;

									getReviewInfo(url);

									function getReviewInfo(url) {
										$.getJSON(url, function (data) {

											// console.log("상품 후기", data.list[0].rv_content);
											// console.log("페이징 정보", data.pageMaker.total);

											// review_list
											printReviewList(data.list, $("#review_list"), $("#reviewTemplate"));
											// review_paging
											printPaging(data.pageMaker, $("#review_paging"));
										});
									}

									// 1) 상품후기 작업 함수
									let printReviewList = function (reviewData, target, template) {
										let templateObj = Handlebars.compile(template.html());
										let reviewHtml = templateObj(reviewData);

										// 상품후기 목록 위치를 참조하여 추가 작업
										target.children().remove(); // $("#review_list").children().remove();
										target.append(reviewHtml);
									}

									// 2) 페이징 기능 작업 함수
									let printPaging = function (pageMaker, target) {

										let pagingStr = '<nav id="navigation" aria-label="Page navigation example">';
										pagingStr += '<ul class="pagination">';

										// 맨 처음 표시 여부
										if (pageMaker.foremost) {
											pagingStr += '<li class="page-item"><a class="page-link" href="1">처음</a></li>';
										}

										// 이전 표시 여부 
										if (pageMaker.prev) {
											pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startPage - 1) + '">이전</a></li>'
										}

										// 페이지 번호 출력
										for (let i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
											let className = pageMaker.cri.pageNum == i ? 'active' : '';
											pagingStr += '<li class="page-item ' + className + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
										}

										// 다음 표시 여부
										if (pageMaker.next) {
											pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.endPage + 1) + '">다음</a></li>'
										}

										// 맨 끝 표시 여부
										if (pageMaker.rearmost) {
											pagingStr += '<li class="page-item"><a class="page-link" href="' + pageMaker.readEnd + '">끝</a></li>';
										}

										pagingStr += '</ul>';
										pagingStr += '</nav>';

										target.children().remove(); // $("#review_paging").children().remove();
										target.append(pagingStr); // target 내부의 HTML을 pagingStr로 설정
									}

									// 사용자 정의 Helper(핸들바의 함수 정의)
									// 상품후기 등록일 millisecond -> 자바스크립트의 Date 객체로 변환
									Handlebars.registerHelper("convertDate", function (reviewTime) {

										const dateObj = new Date(reviewTime);
										let year = dateObj.getFullYear();
										let month = dateObj.getMonth() + 1;
										let date = dateObj.getDate();
										let hour = dateObj.getHours();
										let minute = dateObj.getMinutes();

										// 한 자리 숫자인 경우 앞에 '0'을 붙임
										month = month < 10 ? '0' + month : month;
										date = date < 10 ? '0' + date : date;
										hour = hour < 10 ? '0' + hour : hour;
										minute = minute < 10 ? '0' + minute : minute;

										return year + "/" + month + "/" + date + " " + hour + ":" + minute;
									});

									// 평점(숫자)를 별 모양으로 출력하기
									Handlebars.registerHelper("displayStar", function (rating) {
										let starStr = "";

										switch (rating) {
											case 1:
												starStr = "★☆☆☆☆";
												break;
											case 2:
												starStr = "★★☆☆☆"
												break;
											case 3:
												starStr = "★★★☆☆"
												break;
											case 4:
												starStr = "★★★★☆"
												break;
											case 5:
												starStr = "★★★★★"
												break;
										}
										return starStr;
									});

									// 상품후기 수정/삭제버튼 표시
									// 사용자 정의 Helper(핸들바의 함수 정의)
									Handlebars.registerHelper("authControlView", function (us_id, rv_number, rv_score) {
										let str = "";
										let login_id = '${sessionScope.userStatus.us_id}';

										// 로그인한 사용자와 상품후기 등록 사용자의 동일 여부 체크
										if (login_id == us_id) {
											str += '<button type="button" name="btn_review_edit" class="btn btn-warning" data-rv_score="' + rv_score + '">수정</button>';
											str += '<button type="button" name="btn_review_del" class="btn btn-danger" data-rv_number="' + rv_number + '">삭제</button>';

											console.log(str);
											// 출력 내용이 태그일 때 사용
											return new Handlebars.SafeString(str);
										}
									});

									// 상품후기 수정버튼 클릭: 상품후기 수정 폼
									$("div#review_list").on("click", "button[name='btn_review_edit']", function () {
										/*
										console.log("번호", $(this).parent().parent().find(".rv_number").text());
										console.log("내용", $(this).parent().parent().find(".rv_content").text());
										console.log("평점", $(this).parent().parent().find(".rv_score").text());
										console.log("날짜", $(this).parent().parent().find(".rv_register_date").text());
										*/

										// 평점 작업(선택자 5개)
										let rv_score = $(this).data("rv_score"); // $(this)는 수정 버튼
										console.log("평점", rv_score);
										$("#star_rv_score a.rv_score").each(function (index, item) {
											if (index < rv_score) {
												$(item).addClass("on");
											} else {
												$(item).removeClass("on");
											}
										});

										// 상품후기 내용
										$("#rv_content").text($(this).parent().parent().find(".rv_content").text());
										// 상품후기 번호
										$("#rv_number").text($(this).parent().parent().find(".rv_number").text());
										// 상품후기 등록일
										$("#rv_register_date").text($(this).parent().parent().find(".rv_register_date").text());

										$("#btn_review_save").hide(); // 추가: 상품후기 저장 버튼 숨김
										$("#btn_review_modify").show(); // 추가: 상품후기 저장 버튼 보임
										// modal() 메서드는 부트스트랩 메서드
										$('#review_modal').modal('show'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
									});

									// 상품후기 수정하기
									$("#btn_review_modify").on("click", function () {
										let rv_number = $("#rv_number").text();
										let rv_content = $("#rv_content").val();
										// 평점 
										let rv_score = 0;
										$("p#star_rv_score a.rv_score").each(function (index, item) {
											if ($(this).attr("class") == "rv_score on") {
												rv_score += 1;
											}
										});
										let review_data = { rv_number: rv_number, rv_content: rv_content, rv_score: rv_score }
										$.ajax({
											url: '/user/review/modify',
											headers: {
												"Content-Type": "application/json", "X-HTTP-Method-Override": "PUT"
											},
											type: 'put',
											data: JSON.stringify(review_data), // 데이터 포맷을 Object에서 JSON으로 변환
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 정상적으로 수정되었습니다.")
													$('#review_modal').modal('hide'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
													// 상품평 목록 불러오는 작업
													getReviewInfo(url);
												}
											}
										});
									});

									// 상품후기 수정 후 작성 클릭 시 수정내용 중복됨 clear 작업 필요

									// 상품후기 삭제버튼 클릭
									// 하단 코드는 동적으로 생성된 거라 실행되지 않음
									/*
									$("button[name='btn_review_del']").on("click", function() {
										console.log("상품후기 삭제")
									});
									*/
									$("div#review_list").on("click", "button[name='btn_review_del']", function () {

										console.log("상품평 삭제 버튼 클릭")

										if (!confirm("상품평을 정말로 삭제하겠습니까?")) return;
										let rv_number = $(this).data("rv_number");

										$.ajax({
											url: '/user/review/delete/' + rv_number,
											headers: {
												"Content-Type": "application/json", "X-HTTP-Method-Override": "DELETE"
											},
											type: 'delete',
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 정상적으로 삭제되었습니다.")

													url = "/user/review/list/" + "${pd_vo.pd_number}" + "/" + reviewPage;
													getReviewInfo(url);
												}
											}
										});
									});

									// 페이징 번호 클릭
									$("div#review_paging").on("click", "nav#navigation ul a", function (e) { // "nav ul a": 동적 태그 선택자
										e.preventDefault();
										console.log("페이지 번호");

										reviewPage = $(this).attr("href"); // 상품후기 선택 페이지 번호
										url = "/user/review/list/" + "${pd_vo.pd_number}" + "/" + reviewPage;

										getReviewInfo(url); // 스프링에서 상품후기, 페이지 번호 데이터 가져오는 함수
									});

									// 상품후기 저장
									$("#btn_review_save").off("click").on("click", function () {
										// 평점 값
										let rv_score = 0;
										let rv_content = $("#rv_content").val();

										$("p#star_rv_score a.rv_score").each(function (index, item) {
											if ($(this).attr("class") == "rv_score on") {
												rv_score += 1;
											}

											// 평점 선택 안했을 경우 체크
											if (rv_score == 0) {
												alert("평점을 선택해 주세요.");
												return;
											}

											// 후기 작성 안했을 경우
											if (rv_content == "") {
												alert("상품평을 작성해 주세요.");
												return;
											}
										});

										// AJAX를 사용하여 스프링으로 리뷰 데이터 전송 작업
										let review_data = { pd_number: $(this).data("pd_number"), rv_content: rv_content, rv_score: rv_score }

										$.ajax({
											url: '/user/review/new',
											headers: {
												"Content-Type": "application/json", "X-HTTP-Method-Override": "POST" // POST는 불필요?
											},
											type: 'post',
											data: JSON.stringify(review_data), // 데이터 포맷을 Object에서 JSON으로 변환
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 정상적으로 등록되었습니다.")
													$('#review_modal').modal('hide'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
													// 상품평 목록 불러오는 작업
													getReviewInfo(url);
												}
											}
										});
									});

								}); // ready-end
							</script>

							<!-- 상품후기 modal -->
							<div class="modal fade" id="review_modal" tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<!-- <h5 class="modal-title" id="exampleModalLabel">상품후기</h5> -->
											<b>상품후기</b>
											<span id="rv_number"></span>
											<span id="rv_register_date"></span>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form>
												<div class="form-group">
													<label for="recipient-name" class="col-form-label">평점</label>
													<p id="star_rv_score">
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
													</p>
												</div>
												<div class="form-group">
													<label for="message-text" class="col-form-label">내용</label>
													<textarea class="form-control" id="rv_content"></textarea>
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
											<button type="button" id="btn_review_save" class="btn btn-success"
												data-pd_number="${pd_vo.pd_number}">저장</button>
											<button type="button" id="btn_review_modify" class="btn btn-warning">수정</button>
										</div>
									</div>
								</div>
							</div>
			</body>

			</html>