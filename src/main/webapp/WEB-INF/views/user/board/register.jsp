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
				<link rel="stylesheet" href="/css/header.css">

					<style>
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
													<form role="form" id="registerForm" method="post" action="/user/board/register"> <!-- 절대 경로: /user/board/register와 동일 -->
														<div class="box-body">
															<div class="form-group row">
																<label for="us_id_guest" class="col-2">작성자</label>
																<div class="col-4">
																	<c:choose>
																		<c:when test="${not empty sessionScope.userStatus}">
																			<%-- 로그인한 사용자의 경우 --%>
																				<input type="text" class="form-control" name="us_id" id="us_id_member" value="${sessionScope.userStatus.us_id}"
																					readonly>
																		</c:when>
																		<c:otherwise>
																			<%-- 비회원의 경우 --%>
																				<input type="text" class="form-control" name="us_id" id="us_id_guest" placeholder="guest">
																		</c:otherwise>
																	</c:choose>
																</div>
																<label for="bd_register_date" class="col-2">작성일</label>
																<div class="col-4">
																	<input type="text" class="form-control" id="bd_register_date"
																		value='<fmt:formatDate value="${boardVO.bd_register_date}" pattern="yyyy년 MM월 dd일" />'
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
																		<option	value="total">--- 카테고리 선택 ---</option>
																		<option value="notice" ${boardVO.bd_type == 'notice' ? 'selected' : ''} style="display: none;">공지사항</option>
																		<option value="free" ${boardVO.bd_type == 'free' ? 'selected' : ''}>자유 게시판</option>
																		<option value="info" ${boardVO.bd_type == 'info' ? 'selected' : ''}>정보 공유</option>
																		<option value="study" ${boardVO.bd_type == 'study' ? 'selected' : ''}>스터디원 모집</option>
																		<option value="project" ${boardVO.bd_type == 'project' ? 'selected' : ''}>플젝팀원 모집</option>
																		<option value="inquery" ${boardVO.bd_type == 'inquery' ? 'selected' : ''}>Q&A(문의)</option>
																	</select>
																</div>
															</div>
															<div class="form-group row">
																<c:if test="${empty sessionScope.userStatus}">
																	<label for="guest_pw1" class="col-2">PW</label>
																	<div class="col-4">
																		<input type="password" class="form-control" name="bd_guest_pw" id="guest_pw1" placeholder="비밀번호를 입력하세요.">
																	</div>
																	<label for="guest_pw2" class="col-2">PW 확인</label>
																	<div class="col-4">
																		<input type="password" class="form-control" name="bd_guest_pw" id="guest_pw2" placeholder="비밀번호를 다시 입력하세요.">
																	</div>
																</c:if>
															</div>
															<div class="form-group">
																<label for="bd_content">내용</label>
																<input type="text" class="form-control" name="bd_content" id="bd_content"
																	style="height: 500px; width: 100%;" placeholder="내용을 입력하세요">
															</div>
														</div>
														<!-- <input type="hidden" name="bd_type" id="bd_type" value="${boardVO.bd_type}" /> -->
														<div class="box-footer">
															<button type="button" id="btn_register" class="btn btn-primary">등록</button>
															<button type="button" id="btn_list" class="btn btn-primary">취소</button>
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


					<script>
						$(document).ready(function() {

							let registerForm = $("#registerForm"); 
							
							$("#btn_register").on("click", function() {
								let bd_title = $("#bd_title").val();
								let bd_type = $("#bd_type").val();
								let bd_content = $("#bd_content").val();
								let guest_pw1 = $("#guest_pw1").val();
								let guest_pw2 = $("#guest_pw2").val();

								if(bd_title == "") {
									alert("제목을 입력해 주세요.")
									$("#bd_title").focus();
									return;
								}
								if(bd_type == "total") {
									alert("카테고리를 선택해 주세요.");
									return;
								}
								if(guest_pw1 == "" || guest_pw2 == "") {
									alert("비밀번호가 입력되지 않았습니다.");
									return;
								}
								if(guest_pw1 != guest_pw2) {
									alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
									$("#guest_pw2").focus();
									return;
								}
								if(bd_content == "") {
									alert("내용을 입력해 주세요.");
									$("#bd_content").focus();
									return;
								}
								registerForm.submit();
							});

							$("#btn_list").on("click", function() {
								// console.log("취소 시 목록 페이지로 이동");
								location.href = "/user/board/list";
							});

						})
					</script>

			</body>

			</html>