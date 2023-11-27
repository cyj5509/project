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
												<h2 class="box-title" style="margin: 20px;">수정하기</h2>
											</div>

											<!-- form 태그는 글쓰기나 수정 폼에서 사용 -->
											<form role="form" method="post" action="/user/board/modify"> <!-- 절대 경로: /user/board/modify와 동일 -->
												<div class="box-body">
													<div class="form-group">
														<label for="bd_number">No.</label>
														<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
														<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
														<input type="hidden" name="type" id="type" value="${cri.type}" />
														<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
														<input type="text" class="form-control" name="bd_number" id="bd_number"
															value="${boardVO.bd_number}" readonly>
													</div>
													<div class="form-group">
														<label for="bd_title">제목</label>
														<!-- readonly="readonly"와 같이 속성명과 값이 같은 경우 값을 생략할 수 있다. -->
														<input type="text" class="form-control" name="bd_title" id="bd_title"
															value="${boardVO.bd_title}">
													</div>
													<div class="form-group">
														<label for="us_id">작성자</label>
														<input type="text" class="form-control" name="us_id" id="us_id" value="${boardVO.us_id}"
															readonly>
													</div>
													<div class="form-group">
														<label for="bd_content">내용</label>
														<!-- input 태그는 value 속성이 있지만, textarea 태그는 없음 -->
														<textarea class="form-control" rows="3" name="bd_content">${boardVO.bd_content}</textarea>
													</div>
													<div class="form-group">
														<label for="bd_registe_date">등록일</label>
														<input type="text" class="form-control" name="bd_registe_date" id="bd_registe_date"
															value='<fmt:formatDate value="${boardVO.bd_register_date}" pattern="yyyy/MM/dd" />' readonly>
													</div>
													<div class="form-group">
														<label for="bd_update_date">수정일</label>
														<input type="text" class="form-control" name="bd_update_date" id="bd_update_date"
															value='<fmt:formatDate value="${boardVO.bd_update_date}" pattern="yyyy/MM/dd" />' readonly>
													</div>

												</div>

												<div class="box-footer">
													<button type="submit" class="btn btn-primary">저장</button>
													<button type="reset" class="btn btn-primary">취소</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</section>
						</div>
					</main>

					<footer class="footer mt-auto py-3">
						<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
					</footer>


			</body>

			</html>