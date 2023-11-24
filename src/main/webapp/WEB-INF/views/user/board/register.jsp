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
				<title>DevDay</title>

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



					<!-- Begin page content -->
					<main role="main" class="flex-shrink-0">
						<div class="container">
							<section>
								<div class="row"> <!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
									<!-- <div class="col-해상도-숫자"></div>  -->
									<div class="col-md-12">
										<div class="box box-primary">
											<div class="box-header with-border">
												<h2 class="box-title mt-5"><b>등록하기</b></h2>
											</div><br />

											<c:choose>
												<c:when test="${empty sessionScope.loginStatus}">
													<form role="form" method="post" action="./register"> <!-- 절대 경로: /user/user/board/register와 동일 -->
														<div class="box-body">
															<div class="form-group row">
																<label for="us_id" class="col-3">작성자(비회원)</label>
																<div class="col-3">
																	<input type="text" class="form-control" name="us_id" id="us_id"
																		placeholder="닉네임을 입력하세요">
																</div>
																<label for="bd_register_date" class="col-2">작성일</label>
																<div class="col-4">
																	<input type="text" class="form-control" id="bd_register_date"
																		value='<fmt:formatDate value="${board.bd_register_date}" pattern="yyyy-MM-dd HH:mm" />'
																		readonly="readonly"> <!-- name 속성 주면 400번 에러(클라이언트 에러) 발생 -->
																</div>
															</div>
															<div class="form-group row">
																<label for="bd_title" class="col-2">제목</label>
																<div class="col-4">
																	<input type="text" class="form-control" name="bd_title" id="bd_title"
																		placeholder="제목을 입력하세요">
																</div>
																<label for="bd_type" class="col-2">카테고리</label>
																<div class="col-4">
																	<select class="form-control" name="bd_type" id="bd_type">
																		<option value="잡담">자유 게시판</option>
																		<option value="정보">정보 공유</option>
																		<option value="공부">스터디원 모집</option>
																		<option value="플젝">플젝팀원 모집</option>
																		<option value="문의">Q&A(문의)</option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label for="bd_content">내용</label>
																<input type="text" class="form-control" name="bd_content"
																	style="height: 500px; width: 100%;" placeholder="내용을 입력하세요">
															</div>
														</div>
														<input type="hidden" name="bd_type" id="bd_type" value="${board.bd_type}" />
														<div class="box-footer">
															<button type="submit" class="btn btn-primary">저장</button>
															<button type="reset" class="btn btn-primary">취소</button>
														</div>
													</form>
												</c:when>

												<c:otherwise>
													<form role="form" method="post" action="./register"> <!-- 절대 경로: /user/board/register와 동일 -->
														<div class="box-body">
															<div class="form-group row">
																<label for="us_id" class="col-2">작성자(회원)</label>
																<div class="col-4">
																	<input type="text" class="form-control" name="us_id" id="us_id"
																		value="${sessionScope.loginStatus.us_id}" readonly="readonly">
																</div>
																<label for="bd_register_date" class="col-2">작성일</label>
																<div class="col-4">
																	<input type="text" class="form-control" id="bd_register_date"
																		value='<fmt:formatDate value="${board.bd_register_date}" pattern="yyyy년 MM월 dd일" />'
																		readonly="readonly">
																</div>
															</div>
															<div class="form-group row">
																<label for="bd_title" class="col-2">제목</label>
																<div class="col-4">
																	<input type="text" class="form-control" name="bd_title" id="bd_title"
																		placeholder="제목을 입력하세요">
																</div>
																<label for="bd_type" class="col-2">카테고리</label>
																<div class="col-4">
																	<select class="form-control" name="bd_type" id="bd_type">
																		<option value="잡담">자유 게시판</option>
																		<option value="정보">정보 공유</option>
																		<option value="공부">스터디원 모집</option>
																		<option value="플젝">플젝팀원 모집</option>
																		<option value="문의">Q&A(문의)</option>
																	</select>
																</div>
															</div>
															<div class="form-group">
																<label for="bd_content">내용</label>
																<input type="text" class="form-control" name="bd_content"
																	style="height: 500px; width: 100%;" placeholder="내용을 입력하세요">
															</div>
														</div>
														<input type="hidden" name="bd_type" id="bd_type" value="${board.bd_type}" />
														<div class="box-footer">
															<button type="submit" class="btn btn-primary">저장</button>
															<button type="reset" class="btn btn-primary">취소</button>
														</div>
													</form>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</section>
						</div>
					</main>

					<footer class="footer mt-auto py-3">
						<%@include file="/WEB-INF/views/comm/footer.jsp" %>
					</footer>

					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

			</body>

			</html>