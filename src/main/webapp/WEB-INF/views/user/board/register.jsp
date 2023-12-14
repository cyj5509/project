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
												<h2 class="box-title mt-5"><b>등록하기</b></h2>
											</div><br />
											<form role="form" id="registerForm" method="post" action="/user/board/register">
												<div class="box-body">
													<div class="form-group row">
														<c:choose>
															<c:when test="${not empty sessionScope.userStatus}">
																<%-- 회원의 경우, 작성자명은 세션의 사용자 아이디 --%>
																	<label for="us_id" class="col-2">작성자</label>
																	<div class="col-4">
																		<input type="text" class="form-control" name="us_id" id="us_id"
																			value="${sessionScope.userStatus.us_id}" readonly>
																	</div>
															</c:when>
															<c:otherwise>
																<%-- 비회원의 경우, 작성자명은 guest 또는 닉네임 --%>
																	<label for="bd_guest_nickname" class="col-2">작성자</label>
																	<div class="col-4">
																		<input type="text" class="form-control" name="bd_guest_nickname"
																			id="bd_guest_nickname" placeholder="guest">
																	</div>
															</c:otherwise>
														</c:choose>
														<label for="bd_register_date" class="col-2">작성일</label>
														<div class="col-4">
															<input type="text" class="form-control" id="bd_register_date"
																value='<fmt:formatDate value="${bd_vo.bd_register_date}" pattern="yyyy년 MM월 dd일" />'
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
															style="height: 500px; width: 100%;" placeholder="내용을 입력하세요">
													</div>
													<c:if test="${empty sessionScope.userStatus}">
														<div class="form-group row">
															<label for="guest_pw1" class="col-2">PW</label>
															<div class="col-4">
																<input type="password" class="form-control" name="bd_guest_pw" id="guest_pw1"
																	placeholder="비밀번호를 입력하세요.">
															</div>
															<label for="guest_pw2" class="col-2">PW 확인</label>
															<div class="col-4">
																<input type="password" class="form-control" id="guest_pw2"
																	placeholder="비밀번호를 다시 입력하세요.">
															</div>
														</div>
														<div class="form-group">
															<p style="color: red; font-size: 14px;">* 비회원이 작성한 게시물의 경우 비밀번호 입력 필요</p>
														</div>
													</c:if>
												</div>
												<div class="box-footer">
													<div class="form-group">
														<div style="text-align: center;">
															<!-- <input type="hidden" name="bd_type" id="bd_type" value="${bd_vo.bd_type}" /> -->
															<button type="button" id="btn_register" class="btn btn-primary">등록</button>
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

							let registerForm = $("#registerForm");

							$("#btn_register").on("click", function () {
								let bd_title = $("#bd_title").val();
								let bd_type = $("#bd_type").val();
								let bd_content = $("#bd_content").val();
								let guest_nickname = $("#bd_guest_nickname").val();
								let guest_pw1 = $("#guest_pw1").val();
								let guest_pw2 = $("#guest_pw2").val();

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
								// 비회원 닉네임이 비어 있는 경우 'guest'로 설정
								if (guest_nickname.trim() === '') {
									$("#bd_guest_nickname").val('guest');
								}
								if (guest_pw1 == "" || guest_pw2 == "") {
									alert("비밀번호가 입력되지 않았습니다.");
									return;
								}
								if (guest_pw1 != guest_pw2) {
									alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
									$("#guest_pw2").focus();
									return;
								}
								registerForm.submit();
							});

							$("#btn_list").on("click", function () {
								// console.log("취소 시 목록 페이지로 이동");
								location.href = "/user/board/list";
							});

						})
					</script>

			</body>

			</html>