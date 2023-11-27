<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<!doctype html>
			<html lang="en">

			<head>
				<meta charset="utf-8">
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
				<meta name="description" content="">
				<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
				<meta name="generator" content="Hugo 0.101.0">
				<title>데브데이</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/header.css">

					<style>
						.bd-placeholder-img {
							font-size: 1.125rem;
							text-anchor: middle;
							-webkit-user-select: none;
							-moz-user-select: none;
							-ms-user-select: none;
							user-select: none;
						}

						@media (min-width: 768px) {
							.bd-placeholder-img-lg {
								font-size: 3.5rem;
							}
						}

						.carousel-control-prev,
						.carousel-control-next {
							display: block;
							top: 62.5%;
							transform: translateY(-50%);
						}

						.carousel-control-prev {
							left: 0;
						}

						.carousel-control-next {
							right: 0;
						}

						.custom-btn {
							border: 2px solid black;
							background-color: rgba(192, 192, 192, 0.5);
							color: black;
							transition: background-color 0.3s ease;
						}

						.custom-btn:hover {
							background-color: black;
							color: white;
						}

						.carousel-item img {
							opacity: 0.7;
						}

						.carousel-caption h2,
						.carousel-caption p {
							text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
						}

						.horizontal-menu {
							list-style-type: none;
							padding: 0;
							display: flex;
							justify-content: center;
						}

						.horizontal-menu li {
							margin-right: 20px;
							border: 1px solid #ccc;
							border-radius: 10px;
							padding: 10px 20px;
							text-align: center;
							background-color: #f0f0f0;
							/* 배경색 설정 */
						}

						.horizontal-menu li:last-child {
							margin-right: 0;
						}

						.capitalize {
							text-transform: capitalize;
						}

						.box-title {
							font-size: 40px;
							margin-bottom: 20px;
						}

						.box-body {
							font-size: 20px;
							padding: 20px;
						}
					</style>

			</head>

			<body>

				<%@include file="/WEB-INF/views/comm/header.jsp" %>

					<br />
					<ul class="horizontal-menu">
						<li><a href="/user/board/list/total">전체 게시판</a></li>
						<li><a href="/user/board/list/notice">공지사항</a></li>
						<li><a href="/user/board/list/free">자유 게시판</a></li>
						<li><a href="/user/board/list/info">정보 공유</a></li>
						<li><a href="/user/board/list/study">스터디 모집</a></li>
						<li><a href="/user/board/list/project">프로젝트 모집</a></li>
						<li><a href="/user/board/list/inquery">문의(Q&A)</a></li>
					</ul>

					<!-- Begin page content -->
					<main role="main" class="flex-shrink-0">
						<div class="container">
							<section>
								<div class="row"> <!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
									<!-- <div class="col-해상도-숫자"></div>  -->
									<div class="col-md-12">
										<div class="box">
											<div class="box-header with-border">
												<h2 class="box-title mt-5"><b>
													<c:choose>
														<c:when test="${bd_type == 'notice'}">공지사항</c:when>
														<c:when test="${bd_type == 'free'}">자유 게시판</c:when>
														<c:when test="${bd_type == 'info'}">정보 공유</c:when>
														<c:when test="${bd_type == 'study'}">스터디 모집</c:when>
														<c:when test="${bd_type == 'project'}">프로젝트 모집</c:when>
														<c:when test="${bd_type == 'inquery'}">Q&A(문의)</c:when>
														<c:otherwise>전체 게시판</c:otherwise>
													</c:choose>
												</b></h2>
											</div>
											<div class="row" style="text-align: right;">
												<div class="col-12">
													<form action="/user/board/list" method="get">
														<select name="type">
															<option selected>검색 종류 선택</option>
															<option value="T" ${pageMaker.cri.type=='T' ? 'selected' : '' }>제목</option>
															<option value="C" ${pageMaker.cri.type=='C' ? 'selected' : '' }>내용</option>
															<option value="W" ${pageMaker.cri.type=='W' ? 'selected' : '' }>작성자</option>
															<option value="TC" ${pageMaker.cri.type=='TC' ? 'selected' : '' }>제목+내용</option>
															<option value="TW" ${pageMaker.cri.type=='TW' ? 'selected' : '' }>제목+작성자</option>
															<option value="TWC" ${pageMaker.cri.type=='TWC' ? 'selected' : '' }>제목+작성자+내용</option>
														</select>
														<input type="text" name="keyword" value="${pageMaker.cri.keyword}" />
														<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
														<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
														<button type="submit" class="btn btn-primary">검색</button>
													</form>

													<!-- <form id="actionForm">의 용도 -->
													<!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용: action="/user/board/get" 
												<!-- 2) 목록에서 제목을 클릭할 때 사용: action="/user/board/get" -->
													<form id="actionForm" action="/user/board/list" method="get">
														<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
														<input type="hidden" name="amount" id="amount" value="${pageMaker.cri.amount}" />
														<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
														<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
														<input type="hidden" name="bd_number" id="bd_number" />
														<!-- <input type="hidden" name="bd_type" id="bd_type" /> -->
													</form>
												</div>
											</div>

											<div class="box-body">
												<table class="table table-bordered">
													<tbody>
														<tr style="text-align: center; background-color: lightgray;">
															<th style="width: 7.5%">No.</th>
															<th style="width: 7.5%">구분</th>
															<th style="width: 30%">제목</th>
															<th style="width: 15%">작성자</th>
															<th style="width: 15%">등록일</th>
															<th style="width: 15%">수정일</th>
															<th style="width: 10%">조회</th>
														</tr>
														<!-- BoardController에서 작성한 이름과 동일한 이름을 items로 작성 -->
														<!-- 목록이 출력되는 부분 -->
														<c:forEach items="${list}" var="board">
															<tr style="text-align: center;">
																<td>${board.bd_number}</td>
																<th class="capitalize">${board.bd_type}</th>
																<!-- <td><a class="move" href="#" data-bd_number="${board.bd_number}" data-bd_type="${board.bd_type}">${board.bd_title}</a> -->
																<td><a class="move" href="#" data-bd_number="${board.bd_number}">${board.bd_title}</a>
																</td> <!-- 클래스명 move는 제목과 관련 -->
																<td> ${board.us_id}</td>
																<td>
																	<fmt:formatDate value="${board.bd_register_date}" pattern="yy.MM.dd." />
																</td>
																<td>
																	<fmt:formatDate value="${board.bd_update_date}" pattern="yy.MM.dd." />
																</td>
																<td>${board.bd_view_count}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>

											<div class="box-footer clearfix">
												<div class="row">
													<div class="col-10">
														<nav aria-label="...">
															<ul class="pagination">

																<!-- 맨 처음 표시 여부 -->
																<c:if test="${pageMaker.foremost}">
																	<li class="page-item">
																		<a href="/user/board/list/${bd_type}?pageNum=1" class="page-link">처음으로</a>
																	</li>
																</c:if>

																<!-- 이전 표시 여부 -->
																<c:if test="${pageMaker.prev}">
																	<li class="page-item">
																		<a href="/user/board/list/${bd_type}?pageNum=${pageMaker.startPage - 1}"
																			class="page-link">이전</a>
																	</li>
																</c:if>

																<!-- 페이지 번호 출력 작업 -->
																<!--  1 2 3 4 5 6 7 8 9 10 [다음] -->
																<!--  [이전] 11 12 13 14 15 16 17 18 19 20 [다음] -->
																<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
																	<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : "" }'
																		aria-current="page">
																		<a class="page-link movepage" href="#" data-page="${num}">${num}</a>
																		<!-- 클래스명 movepage는 페이지 번호와 관련 -->
																	</li>
																</c:forEach>

																<!-- 다음 표시 여부 -->
																<c:if test="${pageMaker.next}">
																	<li class="page-item">
																		<a href="/user/board/list/${bd_type}?pageNum=${pageMaker.endPage + 1}" class="page-link">다음</a>
																	</li>
																</c:if>

																<!-- 맨 끝 표시 여부 -->
																<c:if test="${pageMaker.rearmost}">
																	<li class="page-item">
																		<a href="/user/board/list/${bd_type}?pageNum=${pageMaker.readEnd}" class="page-link">끝으로</a>
																	</li>
																</c:if>
															</ul>
														</nav>
													</div>
													<div class="col-2" style="text-align: right;">
														<c:if test="${sessionScope.loginStatus != null}">
															<%-- 공지사항 게시판의 경우, 관리자만 글쓰기 버튼 보임 --%>
																<c:if test="${bd_type == 'notice'}">
																	<c:if test="${sessionScope.isAdmin}">
																		<a class="btn btn-primary" href="/user/board/register/notice" role="button">글쓰기</a>
																	</c:if>
																</c:if>

																<%-- 그 외 게시판은 로그인한 사용자만 글쓰기 버튼 보임 --%>
																	<c:if test="${bd_type != 'notice'}">
																		<a class="btn btn-primary" href="/user/board/register/${bd_type}"
																			role="button">글쓰기</a>
																	</c:if>
														</c:if>
													</div>
												</div>


											</div>
										</div>
									</div>
								</div>
							</section>
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div>
					</main>

					<footer class="footer mt-auto py-3">
						<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
					</footer>


					<script>

						// 폼 태그 참조
						let actionForm = document.getElementById("actionForm");

						// <form id="actionForm"> 태그를 참조하여 필요한 정보를 변경 및 사용

						// 1) 페이지 번호 클릭 시 동작되는 이벤트 설정
						// <a class="movepage">1</a><a class="movepage">2</a><a class="movepage">3</a><a class="movepage">4</a><a class="movepage">5</a> ...
						const movePages = document.getElementsByClassName("movepage");
						Array.from(movePages).forEach(function (mv_page) {
							// actionForm 폼 전송 작업
							mv_page.addEventListener("click", function (event) {
								event.preventDefault();
								// console.log("페이지 번호:", event.target.dataset.page); // data-page -> dataset.page
								document.getElementById("pageNum").value = event.target.dataset.page;

								actionForm.setAttribute("action", "/user/board/list/${bd_type}");
								actionForm.submit(); // /user/board/list로 전송
							});
						});

						// 2) 제목 클릭 시 이벤트 설정: 게시물 읽기
						// <a class="move" href="#" data-bd_number="게시물 번호"></a>
						const moves = document.getElementsByClassName("move");
						Array.from(moves).forEach(function (move) {
							// actionForm 폼 전송 작업
							move.addEventListener("click", function (event) {
								event.preventDefault();

								// bd_number 제거 작업: 목록에서 제목을 클릭 후 게시물 읽기에서 뒤로가기 버튼에 의해 목록으로 돌아가서
								// 다시 제목을 클릭하면 bd_number 파라미터가 추가되기 때문에 기존 bd_number 파라미터를 삭제해야 한다.
								document.getElementById("bd_number").remove();
								// document.getElementById("bd_type").remove();

								let bd_number = event.target.dataset.bd_number // data-bd_number -> dataset.bd_number 
								// let bd_type = event.target.dataset.bd_type // data-bd_type -> dataset.bd_type 

								// actionForm.append("<input type='hidden' name='bd_number' value='" + bd_number + "'>");
								// HTML DOM 문법
								const newNumber = document.createElement("input");
								newNumber.setAttribute("type", "hidden");
								newNumber.setAttribute("name", "bd_number");
								newNumber.setAttribute("id", "bd_number");
								newNumber.setAttribute("value", bd_number); // bd_number는 변수명
								actionForm.appendChild(newNumber);

								// actionForm.append("<input type='hidden' name='bd_type' value='" + bd_type + "'>");
								// HTML DOM 문법
								// const newType = document.createElement("input");
								// newType.setAttribute("type", "hidden");
								// newType.setAttribute("name", "bd_type");
								// newType.setAttribute("id", "bd_type");
								// newType.setAttribute("value", bd_type); // bd_type은 변수명
								// actionForm.appendChild(newType);

								actionForm.setAttribute("action", "/user/board/get/${bd_type}"); // /user/board/list -> /user/board/get 전송
								actionForm.submit();
							});
						});
					</script>

					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

			</body>

			</html>