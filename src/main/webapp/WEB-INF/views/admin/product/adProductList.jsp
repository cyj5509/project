<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!-- pom.xml의 jstl 라이브러리 -->
		<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
		<html>

		<head>
			<meta charset="utf-8" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge" />
			<title>데브데이&#40;관리자&#41;&#58;&nbsp;상품조회</title>
			<!-- Tell the browser to be responsive to screen width -->
			<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
			<%@ include file="/WEB-INF/views/admin/include/plugin1.jsp" %>

			<!-- CSS 파일 링크 -->
			<link rel="stylesheet" href="/css/admin/common/mainText.css">

				<style>
					#productSearchForm select,
					#productSearchForm input[type="text"],
					#productSearchForm button {
						height: 35px;
						/* 높이 설정 */
						padding: 5px 10px;
						/* 내부 여백 설정 */
						font-size: 14px;
						/* 글자 크기 설정 */
						border: 1px solid #ccc;
						/* 테두리 설정 */
						vertical-align: middle;
						/* 수직 정렬 */
					}

					.box-body .product-table th,
					.box-body .product-table td {
						vertical-align: middle;
						/* 셀의 내용을 수직 중앙에 정렬 */
						text-align: center;
						/* 텍스트를 가운데 정렬 */
					}

					.box-body .product-table th {
						background-color: lightslategray;
						color: whitesmoke;
						font-size: 15px;
						font-weight: bold;
					}

					.box-body .product-table td {
						height: 35px;
						/* 높이 설정 */
						padding: 5px 10px;
						/* 내부 여백 설정 */
						font-size: 14px;
						/* 글자 크기 설정 */
						border: 1px solid #ccc;
						/* 테두리 설정 */
						vertical-align: middle;
					}
				</style>
		</head>
		<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->

		<body class="hold-transition skin-blue isDark sidebar-mini">
			<div class="wrapper">
				<!-- Main Header -->
				<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

					<!-- Left side column. contains the logo and sidebar -->
					<%@ include file="/WEB-INF/views/admin/include/nav.jsp" %>

						<!-- Content Wrapper. Contains page content -->
						<div class="content-wrapper">
							<!-- Content Header (Page header) -->
							<section class="content-header">
								<h1 style="font-weight: bold;">관리자 페이지&#58;&nbsp;상품 목록</h1>
								<ol class="breadcrumb">
									<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
									<li class="active">Here</li>
								</ol>
							</section>

							<!-- Main content -->
							<section class="content container-fluid">
								<div class="row">
									<!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
									<!-- <div class="col-해상도-숫자"></div>  -->
									<div class="col-md-12">
										<div class="box">
											<div class="box-header with-border">
												<h2 class="box-title">Product List</h2>
											</div>

											<div class="box-body">
												<div style="text-align: right;">
													<form action="/admin/product/adProductList" method="get" id="productSearchForm">
														<select name="type" id="type">
															<option value="" selected>&#45;&#45;&#45;&nbsp;검색 조건 선택&nbsp;&#45;&#45;&#45;</option>
															<option value="N" ${pageMaker.cri.type=='N' ? 'selected' : '' }>상품명</option>
															<option value="C" ${pageMaker.cri.type=='C' ? 'selected' : '' }>상품번호</option>
															<option value="P" ${pageMaker.cri.type=='P' ? 'selected' : '' }>저자&#47;출판사</option>
															<option value="NC" ${pageMaker.cri.type=='NP' ? 'selected' : '' }>상품명&#43;저자&#47;출판사</option>
															<option value="CP" ${pageMaker.cri.type=='CP' ? 'selected' : '' }>상품번호&#43;저자&#47;출판사</option>
															<option value="NCP" ${pageMaker.cri.type=='NP' ? 'selected' : '' }>상품명&#43;상품번호&#43;저자&#47;출판사</option>
														</select>
														<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}"
															placeholder="검색어 입력" />
														<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
														<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
														<button type="button" class="btn btn-primary" id="btn_productSearch">검색</button>
													</form>
												</div><br />
												<table class="table table-bordered product-table">
													<tbody>
														<tr>
															<th style="width: 2%"><input type="checkbox" id="checkAll"></th>
															<th style="width: 8%">상품코드</th>
															<th style="width: 50%">상품명</th>
															<th style="width: 5%">가격</th>
															<th style="width: 10%">등록일</th>
															<th style="width: 10%">판매여부</th>
															<th style="width: 15%">비고</th>
														</tr>
														<!-- BoardController에서 작성한부이름과 동일한 이름을 items로 작성 -->
														<!-- 목록이 출력되는 부분 -->
														<c:forEach items="${pd_list}" var="productVO">
															<tr>
																<td><input type="checkbox" name="check" value="${productVO.pd_number}"></td>
																<td>${productVO.pd_number}</td>
																<td style="text-align: justify;">
																	<a class="move" href="#" data-bno="${productVO.pd_number}">
																		<img
																			src="/admin/product/imageDisplay?dateFolderName=${productVO.pd_image_folder }&fileName=s_${productVO.pd_image}"></a>
																	<a class="move pd_name" href="#" style="color: black"
																		data-bno="${productVO.pd_number}">${productVO.pd_name}</a>
																</td>
																<!-- 클래스명 move는 제목과 관련 -->
																<td><input type="text" name="pd_price" value="${productVO.pd_price}"></td>
																<td>
																	<fmt:formatDate value="${productVO.pd_register_date}" pattern="yyyy-MM-dd" />
																</td>
																<td>
																	<select name="pd_buy_status" id="pd_buy_status">
																		<option value="Y" ${productVO.pd_buy_status=='Y' ? 'selected' : '' }>가능</option>
																		<option value="N" ${productVO.pd_buy_status=='N' ? 'selected' : '' }>불가능</option>
																	</select>
																</td>
																<!-- name이나 class는 두 번 이상 사용 가능 -->
																<td>
																	<button type="button" class="btn btn-success" name="btn_productEdit">수정</button>
																	<button type="button" class="btn btn-danger btn_productDelete">삭제</button>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div class="box-footer clearfix">
												<div class="row">
													<div class="col-md-6">
														<button type="button" class="btn btn-dark" id="btn_checkModify1" role="button">선택수정
															1</button>
														<button type="button" class="btn btn-secondary" id="btn_checkModify2" role="button">선택수정
															2</button>
														<!-- <form id="actionForm">의 용도 -->
														<!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용 -->
														<!-- 2) 목록에서 상품 이미지 또는 상품명을 클릭할 때 사용 -->
														<form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
															<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
															<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
															<input type="hidden" name="type" value="${pageMaker.cri.type}" />
															<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
														</form>
													</div>
													<div class="col-md-6 text-right">
														<button type="button" class="btn btn-info" id="btn_pd_insert" role="button">상품 등록</button>
													</div>
													<div style="text-align: center;">
														<nav aria-label="...">
															<ul class="pagination">
																<!-- 맨 처음 표시 여부 -->
																<c:if test="${pageMaker.foremost}">
																	<li class="page-item">
																		<a href="${pageMaker.startPage}" class="page-link movepage">처음</a>
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
																<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
																	<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : "" }'
																		aria-current="page">
																		<!--  href="${num}" data-page="${num}" 둘 중 하나 사용 -->
																		<a class="page-link movepage" href="${num}">${num}</a>
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
												</div>
											</div>
										</div>
									</div>
								</div>
							</section>

							<!--------------------------
        | Your Page Content Here |
        -------------------------->

							<!-- /.content -->
						</div>
						<!-- /.content-wrapper -->

						<!-- Main Footer -->
						<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>

							<!-- Control Sidebar -->
							<aside class="control-sidebar control-sidebar-dark">
								<!-- Create the tabs -->
								<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
									<li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i
												class="fa fa-home"></i></a></li>
									<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
								</ul>
								<!-- Tab panes -->
								<div class="tab-content">
									<!-- Home tab content -->
									<div class="tab-pane active" id="control-sidebar-home-tab">
										<h3 class="control-sidebar-heading">Recent Activity</h3>
										<ul class="control-sidebar-menu">
											<li>
												<a href="javascript:;"><i class="menu-icon fa fa-birthday-cake bg-red"></i>
													<div class="menu-info">
														<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>
														<p>Will be 23 on April 24th</p>
													</div>
												</a>
											</li>
										</ul>
										<!-- /.control-sidebar-menu -->

										<h3 class="control-sidebar-heading">Tasks Progress</h3>
										<ul class="control-sidebar-menu">
											<li>
												<a href="javascript:;">
													<h4 class="control-sidebar-subheading">Custom Template Design
														<span class="pull-right-container">
															<span class="label label-danger pull-right">70%</span>
														</span>
													</h4>
													<div class="progress progress-xxs">
														<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
													</div>
												</a>
											</li>
										</ul>
										<!-- /.control-sidebar-menu -->
									</div>
									<!-- /.tab-pane -->
									<!-- Stats tab content -->
									<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
									<!-- /.tab-pane -->
									<!-- Settings tab content -->
									<div class="tab-pane" id="control-sidebar-settings-tab">
										<form method="post">
											<h3 class="control-sidebar-heading">General Settings</h3>
											<div class="form-group">
												<label class="control-sidebar-subheading">Report panel usage
													<input type="checkbox" class="pull-right" checked />
												</label>
												<p>Some information about this general settings option</p>
											</div>
											<!-- /.form-group -->
										</form>
									</div>
									<!-- /.tab-pane -->
								</div>
							</aside>
							<!-- /.control-sidebar -->
							<!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
							<div class="control-sidebar-bg"></div>
			</div>
			<!-- ./wrapper -->

			<!-- REQUIRED JS SCRIPTS -->
			<%@ include file="/WEB-INF/views/admin/include/plugin2.jsp" %>

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

						// [이전] 1 2 3 4 5 ... [다음] 클릭 이벤트 설정.  <a class="page-link movepage" href="${num}">${num}</a>
						$(".movepage").on("click", function (e) {
							e.preventDefault(); // a 태그의 href 링크 기능을 제거. href 속성에 페이지 번호를 숨겨둠

							actionForm.attr("action", "/admin/product/adProductList");
							// actionForm.find("input[name='pageNum']").val(현재 선택한 페이지 번호);
							actionForm.find("input[name='pageNum']").val($(this).attr("href"));

							actionForm.submit(); // 페이지 이동 시 actionForm이 동작
						});

						// 상품 이미지 또는 상품명 클릭 시
						$("a.move").on("click", function (e) {
							let pd_number = $(this).parent().parent().find("input[name='check']").val();

							e.preventDefault();

							actionForm.append('<input type="hidden" name="pd_number" id="pd_number" value="' + pd_number + '" />');
							actionForm.attr("action", "/admin/product/get");
							actionForm.submit(); // 페이지 이동 시 actionForm이 동작
						});

						// 목록에서 제목행 체크박스 선택
						let isCheck = true;
						$("#checkAll").on("click", function () {
							$("input[name='check']").prop("checked", this.checked);
							isCheck = this.checked;
						});

						// 목록에서 데이터행 체크박스 선택
						$("input[name='check']").on("click", function () {
							// 제목행 체크박스 상태 변경
							$("#checkAll").prop("checked", this.checked);
							// 데이터행의 체크박스 상태를 확인해서 제목행 체크상태 변경
							$("input[name='check']").each(function () {
								if (!$(this).is(":checked")) {
									$("#checkAll").prop("checked", false);
								}
							});
						});

						// 체크박스수정 1 버튼 클릭
						$("#btn_checkModify1").on("click", function () {
							// 체크박스 유무 확인
							if ($("input[name='check']:checked").length == 0) {
								alert("수정할 상품을 선택해 주세요.")
								return;
							}

							// 배열 문법
							let pd_number_arr = []; // 체크된 상품코드 배열
							let pd_price_arr = []; // 체크된 상품가격 배열
							let pd_buy_status_arr = []; // 체크된 상품진열(판매여부) 배열

							// 데이터행에서 체크된 체크박스 선택자
							$("input[name='check']:checked").each(function () {
								pd_number_arr.push($(this).val());
								pd_price_arr.push($(this).parent().parent().find("input[name='pd_price']").val());
								pd_buy_status_arr.push($(this).parent().parent().find("select[name='pd_buy_status']").val());
							});

							// 클라이언트: 보낼 정보들을 브라우저상에서 확인한 후 아래 작업 및 서버 측 작업할 것
							console.log("상품코드", pd_number_arr);
							console.log("상품가격", pd_price_arr);
							console.log("상품진열", pd_buy_status_arr);

							$.ajax({
								url: '/admin/product/pd_checked_modify1', //'체크상품을 수정하는 스프링 매핑 주소',
								type: 'post', // get or post
								// data: {파라미터명: 값1, 파라미터명2: 값2, 파라미터명3: 값3 ...} -> 파라미터명은 임의로 설정
								data: { pd_number_arr: pd_number_arr, pd_price_arr: pd_price_arr, pd_buy_status_arr: pd_buy_status_arr },
								dataType: 'text', // "success"(String) -> 'text'. dataType에는 이외에도 html, json, xml 등이 있음
								success: function (result) {
									if (result == "success") {
										alert("선택한 상품(들)이 정상적으로 수정되었습니다.");

										// DB에서 다시 불러오는 작업 
										/*
										1) location.href = "/admin/product/pd_list";
										2) 현재 리스트 상태로 불러오는 의미
										actionForm.attr("method", "get");
										actionForm.attr("action", "/admin/product/pd_list");
										actionForm.submit();
										*/
									}
								}
							});
						});

						// 체크박스수정 2 버튼 클릭
						$("#btn_checkModify2").on("click", function () {
							// 체크박스 유무 확인
							if ($("input[name='check']:checked").length == 0) {
								alert("수정할 상품을 선택해 주세요.")
								return;
							}

							// 배열 문법
							let pd_number_arr = []; // 체크된 상품코드 배열
							let pd_price_arr = []; // 체크된 상품가격 배열
							let pd_buy_status_arr = []; // 체크된 상품진열(판매여부) 배열

							// 데이터행에서 체크된 체크박스 선택자
							$("input[name='check']:checked").each(function () {
								pd_number_arr.push($(this).val());
								pd_price_arr.push($(this).parent().parent().find("input[name='pd_price']").val());
								pd_buy_status_arr.push($(this).parent().parent().find("select[name='pd_buy_status']").val());
							});

							// 클라이언트: 보낼 정보들을 브라우저상에서 확인한 후 아래 작업 및 서버 측 작업할 것
							console.log("상품코드", pd_number_arr);
							console.log("상품가격", pd_price_arr);
							console.log("상품진열", pd_buy_status_arr);

							$.ajax({
								url: '/admin/product/pd_checked_modify2', //'체크상품을 수정하는 스프링 매핑 주소',
								type: 'post', // get or post
								// data: {파라미터명: 값1, 파라미터명2: 값2, 파라미터명3: 값3 ...} -> 파라미터명은 임의로 설정
								data: { pd_number_arr: pd_number_arr, pd_price_arr: pd_price_arr, pd_buy_status_arr: pd_buy_status_arr },
								dataType: 'text', // "success"(String) -> 'text'. dataType에는 이외에도 html, json, xml 등이 있음
								success: function (result) {
									if (result == "success") {
										alert("선택한 상품(들)이 정상적으로 수정되었습니다.");

										// DB에서 다시 불러오는 작업 
										/*
										1) location.href = "/admin/product/pd_list";
										2) 현재 리스트 상태로 불러오는 의미
										actionForm.attr("method", "get");
										actionForm.attr("action", "/admin/product/pd_list");
										actionForm.submit();
										*/
									}
								}
							});
						});

						// 상품등록
						$("#btn_pd_insert").on("click", function () {
							location.href = "/admin/product/insert";
						})

						// 상품수정
						$("button[name='btn_productEdit']").on("click", function () {

							// 수정 상품코드
							// 체크박스에 숨겨둔 상품코드
							// let 수정상품코드 = $(this).parent().parent().find("상품코드를 참조하는 태그").val()
							// let 수정상품코드 = $(this).parent("tr").find("상품코드를 참조하는 태그").val(); -> 해당 작업 오류 발생
							let pd_number = $(this).parent().parent().find("input[name='check']").val();

							console.log(pd_number);

							// 뒤로가기 클릭 후 다시 수정버튼 클릭시 코드 중복되는 부분 때문에 제거
							actionForm.find("input[name='pd_number']").remove();

							// <input type="hidden" name="pd_number" id="pd_number" value="값" />              
							actionForm.append('<input type="hidden" name="pd_number" id="pd_number" value="' + pd_number + '" />');

							actionForm.attr("method", "get");
							actionForm.attr("action", "/admin/product/edit");
							actionForm.submit();
						});

						// 상품 삭제, 화살표 함수 사용 시 상품코드 값을 읽을 수 없다.
						$(".btn_productDelete").on("click", function () {

							// <a class="move pd_name" href="#" data-bno="${productVO.pd_number}">${productVO.pd_name}</a>
							// text(): 입력양식 태그가 아닌 일반 태그의 값을 변경하거나 읽을 때 사용
							let pd_name = $(this).parent().parent().find(".pd_name").text();
							if (!confirm("'" + pd_name + "'" + " 상품을 정말로 삭제하겠습니까?")) return;

							// val()은 input, select, textarea 태그의 값을 변경하거나 읽을 때 사용
							let pd_number = $(this).parent().parent().find("input[name='check']").val(); // val()은 input, select, textarea태그일 때

							console.log("상품코드", pd_number)

							// <input type="hidden" name="pd_number" id="pd_number" value="값" />
							actionForm.append('<input type="hidden" name="pd_number" id="pd_number" value="' + pd_number + '" />');

							actionForm.attr("method", "post");
							actionForm.attr("action", "/admin/product/delete");
							actionForm.submit();
							// alert(pd_name + "상품이 정상적으로 삭제되었습니다.");
						});

					}); // ready 이벤트
				</script>
		</body>

		</html>