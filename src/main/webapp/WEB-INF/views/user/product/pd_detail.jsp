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
					<!-- Handlebars(자바스크립트 템플릿 엔진): 서버에서 보내온 JSON 형태의 데이터를 사용하여 작업을 편하게 할 수 있는 특징 -->
					<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
					<script id="reviewTemplate" type="text/x-handlebars-template">
						<table class="table table-sm">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">리뷰내용</th>
									<th scope="col">평점</th>
									<th scope="col">날짜</th>th>
								</tr>
							</thead>
							<tbody>
								{{#each .}}
								<tr>
									<th scope="row">{{rv_number}}</th>
									<td>{{rv_content}}</td>
									<td>{{displayStar rv_score}}</td>
									<td>{{convertDate rv_register_date}}</td>
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
					<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>

						<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
							<p>2차 카테고리: ${cg_name}</p>
						</div>

						<div class="container">
							<div class="card-deck mb-3 text-center row">
								<div class="col-md-6"> <!-- 상품 이미지 -->
									<img class="btn_pd_image" data-pd_number="${productVO.pd_number}" width="100%" height="200"
										src="/user/product/imageDisplay?dateFolderName=${productVO.pd_image_folder}&fileName=${productVO.pd_image}"
										alt="">
								</div>

								<div class="col-md-6">
									<div class="row text-left">
										<div class="col"> <!-- 상품명 -->
											상품명: ${productVO.pd_name}
										</div>
									</div>
									<div class="row text-left">
										<div class="col"> <!-- 상품가격 -->
											가격: <span id="unit_price">${productVO.pd_price}</span>
										</div>
									</div>
									<div class="row text-left">
										<div class="col">
											수량: <input type="number" id="btn_quantity" value="1" style="width: 80px">
										</div>
									</div>
									<div class="row text-left">
										<div class="col">
											총 상품금액: <span id="tot_price">${productVO.pd_price}</span>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<button type="button" class="btn btn-link" name="btn_order"
												data-pd_number="${productVO.pd_number}">구매하기</button>
										</div>
										<div class="col-md-6">
											<button type="button" class="btn btn-link" name="btn_cart_add"
												data-pd_number="${productVO.pd_number}">장바구니</button>
										</div>
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
											<p>${productVO.pd_content}/p>
										</div>
										<div id="tabs-proreview">
											<p>상품후기 목록</p>
											<div class="row">
												<div class="col-md-12" id="review_list"> <!-- 정적 태그(이하 동적 태그) -->
													
												</div>
											</div>
											<div class="row">
												<div class="col-md-12 text-right">
													<button type="button" id="btn_review_write" class="btn btn-info">상품후기 작성</button>
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
							<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
								integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
								crossorigin="anonymous"></script>
							<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
								integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
								crossorigin="anonymous"></script>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/category_menu.js"></script>

							<script>
								$(document).ready(function () {

									let actionForm = $("#actionForm");  // 액션폼 참조

									// [이전] 1 2 3 4 5 ... [다음] 클릭 이벤트 설정. <a> 태그
									$(".movepage").on("click", function (e) {
										e.preventDefault(); // a 태그의 href 링크 기능을 제거. href 속성에 페이지 번호를 숨겨둠

										actionForm.attr("action", "/user/product/pd_list");
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
											// $(this).data("pd_number"): 버튼을 눌렀을 때 동작하는 장바구니 상품코드
											data: { pd_number: $(this).data("pd_number"), cart_amount: $("#btn_quantity").val() }, // mbsp_id는 스프링에서 자체 처리
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

										let url = `/user/order/order_ready?pd_number=$(this).data("pd_number")&cart_amount=$("#btn_quantity").val()`;
										location.href = url;
									});

									// 상품 이미지 또는 상품명 클릭 시 상세로 보내는 작업
									$(".btn_pd_image").on("click", function () {
										console.log("상품 상세 설명");

										// actionForm.attr("action", "상품 상세 주소");
										actionForm.attr("action", "/user/product/pd_detail");
										let pd_number = $(this).data("pd_number");

										actionForm.find("input[name='pd_number']").remove(); // 뒤로가기 시 
										// <input type='hidden' name='pd_number' value='상품코드'> 미리 만들어서 작성
										actionForm.append("<input type='hidden' name='pd_number' value='" + pd_number + "'>")
										actionForm.submit();
									});

									// 수량 변경 시
									$("#btn_quantity").on("change", function () {
										// parseInt(): 문자열을 정수로 변환(현재 작동에서는 정상 작동해서 불필요할 수 있음. 더하기 작업 등에 쓰임)
										let tot_price = $("#unit_price").text() * $("#btn_quantity").val();

										// 총 상품금액 표시
										$("#tot_price").text(tot_price);
									});

									// 상품후기 작성
									$("#btn_review_write").on("click", function () {
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
									let url = "/user/review/list/" + "${productVO.pd_number}" + "/" + reviewPage;

									getReviewInfo(url);

									function getReviewInfo(url) {
										$.getJSON(url, function(data) {

											// console.log("상품 후기", data.list[0].rv_content);
											// console.log("페이징 정보", data.pageMaker.total);
											// review_list

											printReviewList(data.list, $("#review_list"), $("#reviewTemplate"));
										});
									}

									// 상품후기 작업 함수
									let printReviewList = function (reviewData, target, template) {
										let templateObj = Handlebars.compile(template.html());
										let reviewHtml = templateObj(reviewData);

										// 상품후기 목록 위치를 참조하여 추가 작업
										$("#review_list").children().remove();
										target.append(reviewHtml)
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



									// 페이징 작업 함수

									// 상품후기 저장
									$("#btn_review_save").on("click", function () {
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
												"Content-Type": "application/json", "X-HTTP-Method-Override": "POST"
											},
											type: 'post',
											data: JSON.stringify(review_data), // 데이터 포맷을 Object에서 JSON으로 변환
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 등록되었습니다.")
													$('#review_modal').modal('hide'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
													// 상품평 목록 불러오는 작업
													getReviewInfo(url);
												}
											}
										});
									});

								}); // ready event end
							</script>

							<!-- 상품후기 modal -->
							<div class="modal fade" id="review_modal" tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">상품후기</h5>
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
											<button type="button" id="btn_review_save" class="btn btn-primary"
												data-pd_number="${productVO.pd_number}">상품후기 저장</button>
										</div>
									</div>
								</div>
							</div>
			</body>

			</html>