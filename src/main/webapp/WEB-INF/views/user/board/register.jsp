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
				<title>데브데이&#58; 커뮤니티</title>

				<%@include file="/WEB-INF/views/comm/plugIn1.jsp" %>

					<!-- CSS 파일 링크 -->
					<link rel="stylesheet" href="/css/common/header.css">
					<link rel="stylesheet" href="/css/user/board/mainText.css">

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
																			id="bd_guest_nickname" placeholder="닉네임(미입력 시 guest)">
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
																<option value="" selected>&#45;&#45;&#45; 카테고리 선택 &#45;&#45;&#45;</option>
																<c:if test="${sessionScope.userStatus.ad_check == 1}">
																	<option value="notice" ${bd_vo.bd_type=='notice' ? 'selected' : '' }>공지사항</option>
																</c:if>
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
														<textarea class="form-control" name="bd_content" id="bd_content"
															style="height: 500px; width: 100%;" placeholder="내용을 입력하세요"></textarea>
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
															<p style="color: red; font-size: 14px;">* 비회원인 경우 비밀번호 입력 필요</p>
														</div>
													</c:if>
												</div>
												<div class="box-footer">
													<div class="form-group">
														<div style="text-align: center;">
															<!-- <input type="hidden" name="bd_type" id="bd_type" value="${bd_vo.bd_type}" /> -->
															<button type="button" id="btn_register" class="btn btn-primary" style="margin-right: 5px">등록</button>
															<button type="button" id="btn_list" class="btn btn-danger">취소</button>
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

					<!-- JS 파일 링크 -->
					<script src="/bower_components/ckeditor/ckeditor.js" type="text/javascript"></script>

					<script>
						$(document).ready(function () {

							let registerForm = $("#registerForm");

							// ckeditor 환경설정. 자바스크립트 Ojbect문법
							let ckeditor_config = {
								resize_enabled: false,
								enterMode: CKEDITOR.ENTER_BR,
								shiftEnterMode: CKEDITOR.ENTER_P,
								toolbarCanCollapse: true,
								removePlugins: "elementspath",
								// 업로드 탭 기능 추가 속성. CKEditor에서 파일업로드해서 서버로 전송을 클릭하면, 이 주소가 동작된다.
								filebrowserUploadUrl: "/user/board/imageUpload"
							};

							//해당 이름으로 된 textarea에 에디터를 적용
							CKEDITOR.replace("bd_content", ckeditor_config);
							console.log("ckeditor 버전: " + CKEDITOR.version);


							$("#btn_register").on("click", function () {

								let guest_nickname = $("#bd_guest_nickname").val();
								if (!guest_nickname || guest_nickname.trim() == '') {
									// 비회원 닉네임이 비어 있는 경우 'guest'(기본값)로 설정
									$("#bd_guest_nickname").val('guest');
								}

								let bd_title = $("#bd_title").val();
								if (bd_title == "") {
									alert("제목을 입력해 주세요.")
									$("#bd_title").focus();
									return;
								}

								let bd_type = $("#bd_type").val();
								if (bd_type == '') {
									alert("카테고리를 선택해 주세요.");
									return;
								}

								let bd_content = CKEDITOR.instances.bd_content.getData();
								if (bd_content.trim() == '') {
									// CKEditor 인스턴스에서 데이터 가져오기
									alert("내용을 입력해 주세요.");
									CKEDITOR.instances.bd_content.focus();
									return;
								}

								let guest_pw1 = $("#guest_pw1").val();
								let guest_pw2 = $("#guest_pw2").val();
								if (!guest_pw1 || guest_pw1.trim() == "") {
									alert("비밀번호가 입력되지 않았습니다.");
									$("#guest_pw1").focus();
									return;
								}
								if (!guest_pw2 || guest_pw2.trim() == "") {
									alert("비밀번호가 입력되지 않았습니다.");
									$("#guest_pw2").focus();
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
								location.href = "/user/board/usBoardList";
							});

						}) // ready-end
					</script>

			</body>

			</html>