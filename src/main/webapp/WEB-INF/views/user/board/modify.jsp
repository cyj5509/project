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
				<title>데브데이: 커뮤니티</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/board/main_text.css">

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
												<h2 class="box-title mt-5"><b>수정하기</b></h2>
											</div><br />
											<form role="form" id="modifyForm" method="post" action="/user/board/modify">
												<!-- 절대 경로: /user/board/register와 동일 -->
												<div class="box-body">
													<div class="form-group row">
														<label for="us_id" class="col-2">작성자</label>
														<div class="col-4">
															<c:choose>
																<c:when test="${not empty bd_vo.us_id}">
																	<input type="text" class="form-control" name="us_id" id="us_id" value="${bd_vo.us_id}"
																		readonly="readonly">
																</c:when>
																<c:otherwise>
																	<input type="text" class="form-control" name="bd_guest_nickname"
																		id="bd_guest_nickname" value="${bd_vo.bd_guest_nickname}" readonly="readonly">
																</c:otherwise>
															</c:choose>
														</div>
														<label for="bd_register_date" class="col-2">수정일</label>
														<div class="col-4">
															<input type="text" class="form-control" id="bd_register_date"
																value='<fmt:formatDate value="${bd_vo.bd_update_date}" pattern="yyyy년 MM월 dd일" />'
																readonly="readonly">
														</div>
													</div>
													<div class="form-group row">
														<label for="bd_title" class="col-2">제목</label>
														<div class="col-4">
															<input type="text" class="form-control" name="bd_title" id="bd_title"
																value="${bd_vo.bd_title}">
														</div>
														<label for="bd_type" class="col-2">카테고리</label>
														<div class="col-4">
															<select class="form-control" name="bd_type" id="bd_type">
																<option value="total">--- 카테고리 선택 ---</option>
																<option value="notice" ${bd_vo.bd_type=='notice' ? 'selected' : '' }
																	style="display: none;">공지사항</option>
																<option value="free" ${bd_vo.bd_type=='free' ? 'selected' : '' }>자유 게시판</option>
																<option value="info" ${bd_vo.bd_type=='info' ? 'selected' : '' }>정보 공유</option>
																<option value="study" ${bd_vo.bd_type=='study' ? 'selected' : '' }>스터디원 모집</option>
																<option value="project" ${bd_vo.bd_type=='project' ? 'selected' : '' }>플젝팀원 모집
																</option>
																<option value="inquery" ${bd_vo.bd_type=='inquery' ? 'selected' : '' }>Q&A(문의)
																</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label for="bd_content">내용</label>
														<input type="text" class="form-control" name="bd_content" id="bd_content"
															value="${bd_vo.bd_content}" style="height: 500px; width: 100%;">
													</div>
												</div>
												<div class="box-footer">
													<div class="form-group">
														<div style="text-align: center;">
															<input type="hidden" name="bd_number" id="bd_number" value="${bd_vo.bd_number}" />
															<!-- <input type="hidden" name="bd_type" id="bd_type" value="${bd_vo.bd_type}" /> -->
															<button type="button" id="btn_save" class="btn btn-primary">저장</button>
															<button type="button" id="btn_list" class="btn btn-primary">취소</button>
														</div>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
								<footer class="footer mt-auto py-3">
									<%@include file="/WEB-INF/views/comm/footer.jsp" %>
										<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>
								</footer>
							</section>
						</div>
					</main>

					<script>
						$(document).ready(function () {

							let modifyForm = $("#modifyForm");

							$("#btn_save").on("click", function () {
								let bd_title = $("#bd_title").val();
								let bd_type = $("#bd_type").val();
								let bd_content = $("#bd_content").val();

								if (bd_title == "") {
									alert("제목을 입력해 주세요.")
									$("#bd_title").focus();
									return;
								}
								if (bd_type == "total") {
									alert("카테고리를 선택해 주세요.");
									return;
								}
								if (bd_content == "") {
									alert("내용을 입력해 주세요.");
									$("#bd_content").focus();
									return;
								}
								modifyForm.submit();
							});

							$("#btn_list").on("click", function () {
								// console.log("취소 시 목록 페이지로 이동");
								location.href = "/user/board/list";
							});


						})
					</script>

			</body>

			</html>